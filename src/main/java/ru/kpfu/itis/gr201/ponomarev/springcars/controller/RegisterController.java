package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.EmailAlreadyRegisteredException;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.LoginAlreadyTakenException;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.UserSaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.ValidateUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/register")
@RequiredArgsConstructor
public class RegisterController {

    private final UserService userService;

    @GetMapping
    public String register() {
        return "register";
    }

    @ResponseBody
    @PostMapping(
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public Map<String, Object> save(
            @RequestPart(required = false) MultipartFile avatar,
            @RequestPart String firstName,
            @RequestPart String lastName,
            @RequestPart String email,
            @RequestPart String login,
            @RequestPart String password,
            @RequestPart String confirmPassword
    ) {
        Map<String, Object> jsonResp = new HashMap<>();

        if (avatar != null) {
            if (avatar.isEmpty() || avatar.getContentType() == null || avatar.getContentType().equals("application/octet-stream")) {
                avatar = null;
            } else if (!avatar.getContentType().startsWith("image/")) {
                jsonResp.put("avatar_unsupported_format", true);
            }
        }

        if (!ValidateUtil.validateName(firstName)) {
            jsonResp.put("first_name_invalid", true);
        }
        if (!ValidateUtil.validateName(lastName)) {
            jsonResp.put("last_name_invalid", true);
        }
        if (!ValidateUtil.validateEmail(email)) {
            jsonResp.put("email_invalid", true);
        }
        if (!ValidateUtil.validateLogin(login)) {
            jsonResp.put("login_invalid", true);
        }
        if (!ValidateUtil.validatePassword(password)) {
            jsonResp.put("password_invalid", true);
        }

        if (!jsonResp.isEmpty()) {
            jsonResp.put("success", false);
        } else if (!password.equals(confirmPassword)) {
            jsonResp.put("password_not_confirmed", true);
            jsonResp.put("success", false);
        } else {
            try {
                userService.save(
                        avatar,
                        firstName,
                        lastName,
                        email,
                        login,
                        password
                );
                jsonResp.put("success", true);
            } catch (IOException e) {
                jsonResp.put("unknown_error", true);
                jsonResp.put("success", false);
            } catch (UserSaveException e) {
                if (e instanceof EmailAlreadyRegisteredException) {
                    jsonResp.put("email_not_unique", ((EmailAlreadyRegisteredException) e).getEmail());
                } else if (e instanceof LoginAlreadyTakenException) {
                    jsonResp.put("login_not_unique", ((LoginAlreadyTakenException) e).getLogin());
                } else {
                    jsonResp.put("unknown_error", true);
                }
                jsonResp.put("success", false);
            }
        }

        return jsonResp;
    }
}
