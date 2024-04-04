package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.AdvertisementImage;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Condition;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementImagesRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UsersCarsService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.CloudinaryUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.*;
import java.util.logging.Level;

@Controller
@RequestMapping("/advertisements/new")
@RequiredArgsConstructor
@Log
public class NewAdvertisementController {

    private final UserService userService;
    private final UsersCarsService usersCarsService;
    private final AdvertisementService advertisementService;
    private final AdvertisementImagesRepository advertisementImagesRepository;

    @GetMapping
    public String newAdvertisement(@RequestParam(required = false) Integer id, ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<CarDto> cars = usersCarsService.getNotAdvertisedCarsOfUser(user.getId());
        Condition[] conditions = Condition.values();
        map.put("cars", cars);
        map.put("conditions", conditions);
        map.put("id", id);
        return "newad";
    }

    @ResponseBody
    @PostMapping(
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public Map<String, Object> create(
//            @RequestPart(name = "photos", required = false) MultipartFile[] photos,
//            @RequestPart(name = "carId", required = false) Integer carId,
//            @RequestPart(name = "description", required = false) String description,
//            @RequestPart(name = "mileage", required = false) Integer mileage,
//            @RequestPart(name = "color", required = false) String color,
//            @RequestPart(name = "conditionId", required = false) Integer conditionId,
//            @RequestPart(name = "owners", required = false) Integer owners,
//            @RequestPart(name = "exchangeAllowed", required = false) Boolean exchangeAllowed,
//            @RequestPart(name = "price", required = false) Integer price
            HttpServletRequest req
    ) {
        Map<String, Object> jsonResp = new HashMap<>();

        List<InputStream> photosStreams = new LinkedList<>();
        try {
            for (Part part : req.getParts()) {
                if (part.getSubmittedFileName() != null) {
                    if (part.getContentType() != null && (part.getContentType().endsWith("jpeg") || part.getContentType().endsWith("png"))) {
                        photosStreams.add(part.getInputStream());
                    } else {
                        jsonResp.put("photoUnsupportedFormat", true);
                        break;
                    }
                }
            }
        } catch (IOException | ServletException e) {
            jsonResp.put("unknown_error", true);
        }
        if (photosStreams.isEmpty()) {
            jsonResp.put("noPhotos", true);
        }

        UserDto user = userService.getAuthenticatedUser();

        int carId = Integer.parseInt(req.getParameter("carId"));
        String description = req.getParameter("description");
        if (description == null || description.isEmpty()) {
            jsonResp.put("descriptionInvalid", true);
        }
        int mileage = Integer.parseInt(req.getParameter("mileage"));
        if (mileage < 0) {
            jsonResp.put("mileageInvalid", true);
        }
        String color = req.getParameter("color");
        if (color == null || color.isEmpty()) {
            jsonResp.put("colorInvalid", true);
        }
        int conditionId = Integer.parseInt(req.getParameter("conditionId"));
        Condition condition = Condition.getById(conditionId);
        if (condition == null) {
            jsonResp.put("conditionIdInvalid", true);
        }
        int owners = Integer.parseInt(req.getParameter("owners"));
        if (owners <= 0) {
            jsonResp.put("ownersInvalid", true);
        }
        String exchangeAllowedStr = req.getParameter("exchangeAllowed");
        boolean exchangeAllowed = exchangeAllowedStr != null && exchangeAllowedStr.equals("true");
        int price = Integer.parseInt(req.getParameter("price"));
        if (price <= 0) {
            jsonResp.put("priceInvalid", true);
        }

        if (!jsonResp.isEmpty()) {
            jsonResp.put("success", false);
            return jsonResp;
        } else {
            try {
                AdvertisementDto ad = advertisementService.save(
                        carId,
                        description,
                        price,
                        user.getId(),
                        Timestamp.valueOf(LocalDateTime.now()),
                        mileage,
                        color,
                        condition,
                        owners,
                        exchangeAllowed
                );
                for (InputStream photoIn : photosStreams) {
                    String photoUrl = CloudinaryUtil.uploadPart(photoIn);
                    advertisementImagesRepository.save(new AdvertisementImage(
                            ad.getId(),
                            photoUrl
                    ));
                }
                jsonResp.put("success", true);
                jsonResp.put("id", ad.getId());
                return jsonResp;
            } catch (Exception e) {
                log.log(Level.SEVERE, "Couldn't save advertisement", e);
                jsonResp.put("unknown_error", true);
                jsonResp.put("success", false);
                return jsonResp;
            }
        }
    }
}
