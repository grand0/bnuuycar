package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UsersCarsService;

import java.util.Optional;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final UserService userService;
    private final AdvertisementService advertisementService;
    private final UsersCarsService usersCarsService;

    @GetMapping
    public String profile(@RequestParam Optional<Integer> id, ModelMap map) {
        UserDto authenticatedUser = userService.getAuthenticatedUser();
        if (authenticatedUser != null) {
            map.addAttribute("authId", authenticatedUser.getId());
        }
        UserDto profile;
        if (id.isPresent()) {
            profile = userService.getUser(id.get());
            if (profile == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No user found");
            }
        } else {
            profile = authenticatedUser;
            if (profile == null) {
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Authentication is required");
            }
        }
        map.addAttribute("profile", profile);
        map.addAttribute("advertisements", advertisementService.getAllOfUser(profile.getId()));
        map.addAttribute("cars", usersCarsService.getCarsOfUser(profile.getId()));
        return "profile";
    }
}
