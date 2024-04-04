package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/error")
public class ErrorController {

    @GetMapping
    public String error(HttpServletRequest req, ModelMap map) {
        map.put("exception", req.getAttribute("javax.servlet.error.exception"));
        map.put("statusCode", req.getAttribute("javax.servlet.error.status_code"));
        map.put("requestUri", req.getAttribute("javax.servlet.error.request_uri"));
        return "error";
    }
}
