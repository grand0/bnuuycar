package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.BookmarksService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.List;

@Controller
@RequestMapping("/bookmarks")
@RequiredArgsConstructor
public class BookmarksController {

    private final UserService userService;
    private final BookmarksService bookmarksService;

    @GetMapping
    public String bookmarks(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<AdvertisementDto> advertisements = bookmarksService.getAllOfUser(user.getId());
        map.put("advertisements", advertisements);
        return "bookmarks";
    }
}
