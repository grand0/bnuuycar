package ru.kpfu.itis.gr201.ponomarev.springcars.filter;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.MessageService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;

import java.util.List;

@Component
public class MessagesCheckerInterceptor implements WebRequestInterceptor {

    @Autowired
    private UserService userService;

    @Autowired
    private  MessageService messageService;

    @Override
    public void preHandle(WebRequest request) throws Exception {}

    @Override
    public void postHandle(WebRequest request, ModelMap map) throws Exception {
        UserDto user = userService.getAuthenticatedUser();
        if (user != null && map != null) {
            List<Integer> unread = messageService.getAdvertisementIdsWithUnreadMessages(user.getId());
            map.put("unread_messages_count", unread.size());
        }
    }

    @Override
    public void afterCompletion(WebRequest request, Exception ex) throws Exception {}
}
