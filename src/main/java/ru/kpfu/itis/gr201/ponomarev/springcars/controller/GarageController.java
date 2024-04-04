package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UsersCarsService;

import java.util.*;

@Controller
@RequestMapping("/garage")
@RequiredArgsConstructor
public class GarageController {

    private final UsersCarsService usersCarsService;
    private final AdvertisementRepository advertisementRepository;
    private final UserService userService;

    @GetMapping
    public String garage(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<CarDto> cars = usersCarsService.getCarsOfUser(user.getId());
        List<Advertisement> advertisements = advertisementRepository.findAllBySellerId(user.getId());
        Map<String, String> carAdvertisementMap = new LinkedHashMap<>();
        for (Advertisement advertisement : advertisements) {
            Optional<CarDto> optionalCar = cars.stream().filter(car -> car.getId() == advertisement.getCarId()).findFirst();
            optionalCar.ifPresent(car -> carAdvertisementMap.put(String.valueOf(car.getId()), String.valueOf(advertisement.getId())));
        }
        map.put("cars", cars);
        map.put("carAdvertisementMap", carAdvertisementMap);
        return "garage";
    }

    @ResponseBody
    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> action(@RequestParam String action, @RequestParam Map<String, String> parameters) {
        Map<String, Object> jsonResponse = new HashMap<>();
        UserDto user = userService.getAuthenticatedUser();
        if (action.equals("delete")) {
            try {
                int carId = Integer.parseInt(parameters.get("carId"));
                usersCarsService.removeCarFromUser(user.getId(), carId);
                jsonResponse.put("success", true);
            } catch (NumberFormatException | NullPointerException e) {
                jsonResponse.put("unknownError", true);
                jsonResponse.put("success", false);
            }
        }
        return jsonResponse;
    }
}
