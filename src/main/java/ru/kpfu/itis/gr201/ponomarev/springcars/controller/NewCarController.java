package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.UserNotAuthenticatedException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.CarService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.ModelService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

@Controller
@RequestMapping("/garage/new")
@RequiredArgsConstructor
@Log
public class NewCarController {

    private final ModelService modelService;
    private final CarService carService;
    private final UserService userService;
    
    @GetMapping
    public String newCar(ModelMap map) {
        map.put("bodies", Body.values());
        map.put("transmissions", Transmission.values());
        map.put("drives", Drive.values());
        map.put("engines", Engine.values());
        return "newcar";
    }

    @ResponseBody
    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> create(
            @RequestParam String make,
            @RequestParam String model,
            @RequestParam int year,
            @RequestParam int bodyId,
            @RequestParam int transmissionId,
            @RequestParam int driveId,
            @RequestParam int engineId,
            @RequestParam int horsepower,
            @RequestParam float engineVolume,
            @RequestParam boolean leftWheel
    ) {
        Map<String, Object> jsonResp = new HashMap<>();
        
        if (make.isEmpty()) jsonResp.put("makeInvalid", true);
        if (model.isEmpty()) jsonResp.put("modelInvalid", true);
        if (year < 1900) jsonResp.put("yearInvalid", true);
        Body body = Body.getById(bodyId);
        if (body == null) jsonResp.put("bodyIdInvalid", true);
        Transmission transmission = Transmission.getById(transmissionId);
        if (transmission == null) jsonResp.put("transmissionIdInvalid", true);
        Drive drive = Drive.getById(driveId);
        if (drive == null) jsonResp.put("driveIdInvalid", true);
        Engine engine = Engine.getById(engineId);
        if (engine == null) jsonResp.put("engineIdInvalid", true);

        if (!jsonResp.isEmpty()) {
            jsonResp.put("success", false);
        } else {
            try {
                int modelId = modelService.saveIfNotExists(make, model);
                Car car = new Car(
                        modelId,
                        body,
                        transmission,
                        engine,
                        drive,
                        engineVolume,
                        year,
                        horsepower,
                        leftWheel
                );
                int carId = carService.saveIfNotExists(car);
                car.setId(carId);
                userService.addCarToCurrentUser(car);
                jsonResp.put("success", true);
            } catch (SaveException e) {
                log.log(Level.SEVERE, e.getMessage(), e);
                jsonResp.put("unknown_error", true);
                jsonResp.put("success", false);
            } catch (UserNotAuthenticatedException e) {
                jsonResp.put("unauthorized", true);
                jsonResp.put("success", false);
            }
        }
        return jsonResp;
    }
}
