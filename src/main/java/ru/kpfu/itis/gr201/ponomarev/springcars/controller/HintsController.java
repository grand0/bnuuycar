package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Make;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Model;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.MakeRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.ModelRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/hints")
@RequiredArgsConstructor
public class HintsController {

    private final MakeRepository makeRepository;
    private final ModelRepository modelRepository;

    @ResponseBody
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> hints(@RequestParam String action, @RequestParam Map<String, String> params) {
        if (action == null) action = "";

        Map<String, Object> jsonResponse = new HashMap<>();
        if (action.equalsIgnoreCase("getMakes")) {
            String query = params.get("query");
            if (query == null) query = "";
            List<String> makes = makeRepository.search(query)
                    .stream()
                    .map(Make::getMake)
                    .toList();
            jsonResponse.put("makes", makes);
            return jsonResponse;
        } else if (action.equalsIgnoreCase("getModels")) {
            String query = params.get("query");
            if (query == null) query = "";
            String make = params.get("make");
            if (make == null || make.isEmpty()) make = null;
            List<String> models = modelRepository.search(make, query)
                    .stream()
                    .map(Model::getModel)
                    .toList();
            jsonResponse.put("models", models);
            return jsonResponse;
        } else {
            throw new HttpClientErrorException(HttpStatus.BAD_REQUEST);
        }
    }
}
