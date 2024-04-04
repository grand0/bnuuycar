package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.BookmarksService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class IndexController {

    private final UserService userService;
    private final AdvertisementService advertisementService;
    private final BookmarksService bookmarksService;

    @GetMapping
    public String index(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        if (user != null) {
            map.put("bookmarks", bookmarksService.getAllOfUser(user.getId()));
        }

        map.put("advertisements", advertisementService.getRecent());

        return "index";
    }
}
