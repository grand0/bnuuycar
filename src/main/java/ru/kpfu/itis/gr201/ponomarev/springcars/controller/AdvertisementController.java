package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementFilter;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementSorting;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.BookmarksService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/advertisements")
@RequiredArgsConstructor
public class AdvertisementController {

    private final AdvertisementService advertisementService;
    private final UserService userService;
    private final BookmarksService bookmarksService;

    @GetMapping
    public String advertisements(@RequestParam Optional<Integer> id, @RequestParam Map<String, String> parameters, ModelMap map) {
        if (id.isEmpty()) {
            allAdvertisements(map, parameters);
            return "ads";
        } else {
            advertisementById(id.get(), map, parameters);
            return "ad";
        }
    }

    @ResponseBody
    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> action(@RequestParam String action, @RequestParam Map<String, String> parameters) {
        Map<String, Object> jsonObj = new HashMap<>();
        UserDto user = userService.getAuthenticatedUser();
        if (user == null) {
            jsonObj.put("unauthorized", true);
            return jsonObj;
        }

        if (action.equals("bookmark")) {
            try {
                int adId = Integer.parseInt(parameters.get("adId"));
                boolean isBookmarked = bookmarksService.isBookmarked(user.getId(), adId);
                if (isBookmarked) {
                    bookmarksService.remove(user.getId(), adId);
                } else {
                    bookmarksService.add(user.getId(), adId);
                }
                jsonObj.put("isBookmarked", !isBookmarked);
                return jsonObj;
            } catch (NumberFormatException | NullPointerException e) {
                return jsonObj;
            }
        } else {
            return jsonObj;
        }
    }

    private void allAdvertisements(ModelMap map, Map<String, String> parameters) {
        AdvertisementFilter filter = new AdvertisementFilter();
        if (parameters.get("make") != null) {
            filter.setMake(parameters.get("make"));
        }
        if (parameters.get("model") != null) {
            filter.setModel(parameters.get("model"));
        }
        if (parameters.get("bodies") != null) {
            try {
                String[] bodyIds = parameters.get("bodies").split(",");
                List<Body> bodies = Arrays.stream(bodyIds)
                        .map(Integer::parseInt)
                        .map(Body::getById)
                        .collect(Collectors.toList());
                filter.setBodies(bodies);
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("transmissions") != null) {
            try {
                String[] transmissionIds = parameters.get("transmissions").split(",");
                List<Transmission> transmissions = Arrays.stream(transmissionIds)
                        .map(Integer::parseInt)
                        .map(Transmission::getById)
                        .collect(Collectors.toList());
                filter.setTransmissions(transmissions);
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("engines") != null) {
            try {
                String[] engineIds = parameters.get("engines").split(",");
                List<Engine> engines = Arrays.stream(engineIds)
                        .map(Integer::parseInt)
                        .map(Engine::getById)
                        .collect(Collectors.toList());
                filter.setEngines(engines);
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("drives") != null) {
            try {
                String[] driveIds = parameters.get("drives").split(",");
                List<Drive> drives = Arrays.stream(driveIds)
                        .map(Integer::parseInt)
                        .map(Drive::getById)
                        .collect(Collectors.toList());
                filter.setDrives(drives);
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("engineVolumeFrom") != null) {
            try {
                filter.setEngineVolumeFrom(Float.parseFloat(parameters.get("engineVolumeFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("engineVolumeTo") != null) {
            try {
                filter.setEngineVolumeTo(Float.parseFloat(parameters.get("engineVolumeTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("yearFrom") != null) {
            try {
                filter.setYearFrom(Integer.parseInt(parameters.get("yearFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("yearTo") != null) {
            try {
                filter.setYearTo(Integer.parseInt(parameters.get("yearTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("horsepowerFrom") != null) {
            try {
                filter.setHorsepowerFrom(Integer.parseInt(parameters.get("horsepowerFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("horsepowerTo") != null) {
            try {
                filter.setHorsepowerTo(Integer.parseInt(parameters.get("horsepowerTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("leftWheel") != null) {
            String leftWheelStr = parameters.get("leftWheel");
            if (leftWheelStr.equalsIgnoreCase("true")) {
                filter.setLeftWheel(true);
            } else if (leftWheelStr.equalsIgnoreCase("false")) {
                filter.setLeftWheel(false);
            }
        }
        if (parameters.get("priceFrom") != null) {
            try {
                filter.setPriceFrom(Integer.parseInt(parameters.get("priceFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("priceTo") != null) {
            try {
                filter.setPriceTo(Integer.parseInt(parameters.get("priceTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("mileageFrom") != null) {
            try {
                filter.setMileageFrom(Integer.parseInt(parameters.get("mileageFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("mileageTo") != null) {
            try {
                filter.setMileageTo(Integer.parseInt(parameters.get("mileageTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("ownersFrom") != null) {
            try {
                filter.setOwnersFrom(Integer.parseInt(parameters.get("ownersFrom")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("ownersTo") != null) {
            try {
                filter.setOwnersTo(Integer.parseInt(parameters.get("ownersTo")));
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("exchangeAllowed") != null) {
            String exchangeStr = parameters.get("exchangeAllowed");
            if (exchangeStr.equalsIgnoreCase("true")) {
                filter.setExchangeAllowed(true);
            } else if (exchangeStr.equalsIgnoreCase("false")) {
                filter.setExchangeAllowed(false);
            }
        }
        if (parameters.get("conditions") != null) {
            try {
                String[] conditionIds = parameters.get("conditions").split(",");
                List<Condition> conditions = Arrays.stream(conditionIds)
                        .map(Integer::parseInt)
                        .map(Condition::getById)
                        .collect(Collectors.toList());
                filter.setConditions(conditions);
            } catch (NumberFormatException ignored) {}
        }
        if (parameters.get("sorting") != null) {
            AdvertisementSorting sorting = AdvertisementSorting.getById(Integer.parseInt(parameters.get("sorting")));
            if (sorting != null) {
                if (parameters.get("desc") != null) {
                    String descStr = parameters.get("desc");
                    if (descStr.equalsIgnoreCase("false")) {
                        sorting.setDesc(false);
                    } else if (descStr.equalsIgnoreCase("true")) {
                        sorting.setDesc(true);
                    }
                }
                filter.setSorting(sorting);
            }
        }

        List<AdvertisementDto> advertisements = advertisementService.getAllWithFilter(filter);
        map.put("advertisements", advertisements);
        map.put("bodies", Body.values());
        map.put("transmissions", Transmission.values());
        map.put("engines", Engine.values());
        map.put("drives", Drive.values());
        map.put("conditions", Condition.values());
        map.put("sortings", AdvertisementSorting.values());
        map.put("filter", filter);
    }

    private void advertisementById(int id, ModelMap map, Map<String, String> parameters) {
        AdvertisementDto advertisement = advertisementService.get(id);
        UserDto user = userService.getAuthenticatedUser();
        boolean isBookmarked = false;
        boolean isMy = false;
        if (user != null) {
            isBookmarked = bookmarksService.isBookmarked(user.getId(), id);
            isMy = advertisement.getSeller().getId() == user.getId();
        }
        map.put("advertisement", advertisement);
        map.put("isBookmarked", isBookmarked);
        map.put("isMy", isMy);
        advertisementService.incrementViewCount(id);
    }
}
