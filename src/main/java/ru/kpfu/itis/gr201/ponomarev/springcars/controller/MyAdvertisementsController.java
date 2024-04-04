package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/advertisements/my")
@RequiredArgsConstructor
public class MyAdvertisementsController {

    private final UserService userService;
    private final AdvertisementService advertisementService;
    private final AdvertisementRepository advertisementRepository;

    @GetMapping
    public String myAdvertisements(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<AdvertisementDto> advertisements = advertisementService.getAllOfUser(user.getId());
        map.put("advertisements", advertisements);
        return "myads";
    }

    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Map<String, Object> action(@RequestParam String action, @RequestParam Map<String, String> params) {
        Map<String, Object> jsonResponse = new HashMap<>();
        if (action.equals("delete")) {
            try {
                int adId = Integer.parseInt(params.get("adId"));
                advertisementRepository.deleteById(adId);
                jsonResponse.put("success", true);
            } catch (NumberFormatException | NullPointerException e) {
                jsonResponse.put("unknownError", true);
                jsonResponse.put("success", false);
            }
        }
        return jsonResponse;
    }
}
