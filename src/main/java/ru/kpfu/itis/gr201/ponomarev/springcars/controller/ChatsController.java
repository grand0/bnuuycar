package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.MessageService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chats")
@RequiredArgsConstructor
public class ChatsController {

    private final UserService userService;
    private final MessageService messageService;
    private final AdvertisementService advertisementService;

    @GetMapping
    public String chats(ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<AdvertisementDto> myAdvertisements = advertisementService.getAllOfUser(user.getId());
        List<List<UserDto>> users = myAdvertisements.stream()
                .map((ad) -> messageService.getAllRecipientsOfAdvertisement(ad.getId(), user.getId()))
                .toList();
        List<AdvertisementDto> otherAdvertisements = messageService.getAllAdvertisementsToWhichUserSentMessage(user.getId());

        Map<String, List<Integer>> unreadAdIdsToUserIds = new HashMap<>();
        messageService.getAdvertisementIdsAndSenderIdsWithUnreadMessages(user.getId())
                .forEach((k, v) -> unreadAdIdsToUserIds.put(String.valueOf(k), v));

        map.put("myAdvertisements", myAdvertisements);
        map.put("users", users);
        map.put("otherAdvertisements", otherAdvertisements);
        map.put("unreadMap", unreadAdIdsToUserIds);
        return "chats";
    }
}
