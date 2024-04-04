package ru.kpfu.itis.gr201.ponomarev.springcars.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.MessageDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.MessageService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController {

    private final MessageService messageService;
    private final UserService userService;
    private final AdvertisementService advertisementService;

    @GetMapping(produces = MediaType.TEXT_HTML_VALUE)
    public String chat(@RequestParam("ad_id") int adId, @RequestParam("recipient_id") int recipientId, ModelMap map) {
        UserDto user = userService.getAuthenticatedUser();
        List<MessageDto> messages = messageService.readAllOfAdvertisementAndUser(adId, user.getId(), recipientId);
        AdvertisementDto advertisement = advertisementService.get(adId);
        UserDto recipient = userService.getUser(recipientId);
        map.put("user", user);
        map.put("messages", messages);
        map.put("ad", advertisement);
        map.put("recipient", recipient);
        return "chat";
    }

    @ResponseBody
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> chatJson(@RequestParam("ad_id") int adId, @RequestParam("recipient_id") int recipientId) {
        UserDto user = userService.getAuthenticatedUser();
        List<MessageDto> messages = messageService.readAllOfAdvertisementAndUser(adId, user.getId(), recipientId);
        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("messages", messages);
        jsonResponse.put("recipientId", recipientId);
        return jsonResponse;
    }

    @ResponseBody
    @PostMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> sendMessage(@RequestParam int adId, @RequestParam int recipientId, @RequestParam String message) {
        Map<String, Object> jsonResponse = new HashMap<>();
        UserDto user = userService.getAuthenticatedUser();
        MessageDto msg = messageService.send(user.getId(), recipientId, adId, message);
        jsonResponse.put("success", true);
        jsonResponse.put("message", msg);
        return jsonResponse;
    }
}
