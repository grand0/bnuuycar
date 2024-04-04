package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.ValidateUtil;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/profile_edit")
@RequiredArgsConstructor
public class ProfileEditController {

    private final UserService userService;

    @GetMapping
    public String profileEdit(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        map.put("email", user.getEmail());
        return "profile_edit";
    }

    @ResponseBody
    @PostMapping(
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE
    )
    public Map<String, Object> update(
            @RequestPart(required = false) MultipartFile avatar,
            @RequestPart String email,
            @RequestPart(required = false) String oldPassword,
            @RequestPart(required = false) String newPassword,
            @RequestPart(required = false) String confirmPassword
    ) {
        Map<String, Object> jsonResp = new HashMap<>();
        if (avatar != null) {
            if (avatar.isEmpty() || avatar.getContentType() == null || avatar.getContentType().equals("application/octet-stream")) {
                avatar = null;
            } else if (!avatar.getContentType().startsWith("image/")) {
                jsonResp.put("avatar_unsupported_format", true);
            }
        }

        if (!ValidateUtil.validateEmail(email)) {
            jsonResp.put("email_invalid", true);
        }
        if (newPassword != null && !newPassword.isEmpty() && !ValidateUtil.validatePassword(newPassword)) {
            jsonResp.put("password_invalid", true);
        }

        if (!jsonResp.isEmpty()) {
            jsonResp.put("success", false);
            return jsonResp;
        }

        try {
            userService.tryUpdateUser(
                    avatar,
                    email,
                    oldPassword,
                    newPassword,
                    confirmPassword
            );
            jsonResp.put("success", true);
        } catch (UserUpdateException e) {
            if (e instanceof WrongOldPasswordException) {
                jsonResp.put("old_password_wrong", true);
            } else if (e instanceof WrongPasswordConfirmationException) {
                jsonResp.put("password_not_confirmed", true);
            } else {
                jsonResp.put("unknown_error", true);
            }
            jsonResp.put("success", false);
        } catch (IOException e) {
            jsonResp.put("unknown_error", true);
            jsonResp.put("success", false);
        } catch (UserSaveException e) {
            if (e instanceof EmailAlreadyRegisteredException) {
                jsonResp.put("email_not_unique", ((EmailAlreadyRegisteredException) e).getEmail());
            } else {
                jsonResp.put("unknown_error", true);
            }
            jsonResp.put("success", false);
        }
        return jsonResp;
    }
}
