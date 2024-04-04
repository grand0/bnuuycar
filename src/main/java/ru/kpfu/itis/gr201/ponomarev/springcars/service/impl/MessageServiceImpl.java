package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.MessageDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Message;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.MessageRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.MessageService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.Constants;

import java.util.*;

@Service
@RequiredArgsConstructor
public class MessageServiceImpl implements MessageService {

    private final MessageRepository messageRepository;
    private final UserService userService;
    private final AdvertisementRepository advertisementRepository;
    private final AdvertisementService advertisementService;

    @Override
    public List<UserDto> getAllRecipientsOfAdvertisement(int advertisementId, int senderId) {
        List<Message> messages = messageRepository.findAllByAdvertisementId(advertisementId);
        Set<Integer> users = new HashSet<>();
        for (Message m : messages) {
            users.add(m.getSenderId());
            users.add(m.getRecipientId());
        }
        users.remove(senderId);
        return users.stream()
                .map(userService::getUser)
                .sorted(Comparator.comparing(UserDto::toString))
                .toList();
    }

    @Override
    public List<MessageDto> readAllOfAdvertisementAndUser(int advertisementId, int senderId, int recipientId) {
        messageRepository.setAllAsReadForAdvertisementAndRecipient(advertisementId, recipientId, senderId);
        return messageRepository.getAllOfAdvertisementAndUsers(advertisementId, senderId, recipientId)
                .stream()
                .map(this::toMessageDto)
                .toList();
    }

    @Override
    public List<AdvertisementDto> getAllAdvertisementsToWhichUserSentMessage(int userId) {
        return advertisementRepository.findAllById(
                        messageRepository.getAllAdvertisementIdsToWhichUserSentMessage(userId)
                )
                .stream()
                .map(advertisementService::toAdvertisementDto)
                .toList();
    }

    @Override
    public List<Integer> getAdvertisementIdsWithUnreadMessages(int userId) {
        return messageRepository.findAllByRecipientIdAndIsReadFalse(userId)
                .stream()
                .map(Message::getAdvertisementId)
                .distinct()
                .toList();
    }

    @Override
    public Map<Integer, List<Integer>> getAdvertisementIdsAndSenderIdsWithUnreadMessages(int userId) {
        return messageRepository.findAllByRecipientIdAndIsReadFalse(userId)
                .stream()
                .collect(
                        HashMap::new,
                        (HashMap<Integer, List<Integer>> map, Message msg) -> map.compute(
                                msg.getAdvertisementId(),
                                (k, v) -> {
                                    if (v == null) {
                                        List<Integer> list = new ArrayList<>();
                                        list.add(msg.getSenderId());
                                        return list;
                                    } else {
                                        v.add(msg.getSenderId());
                                        return v;
                                    }
                                }
                        ),
                        HashMap::putAll
                );
    }

    @Override
    public MessageDto send(int senderId, int recipientId, int adId, String message) {
        return toMessageDto(
                messageRepository.save(new Message(
                        senderId,
                        recipientId,
                        adId,
                        message
                ))
        );
    }

    @Override
    public MessageDto toMessageDto(Message message) {
        UserDto sender = userService.getUser(message.getSenderId());
        return new MessageDto(
                sender,
                message.getMessage(),
                message.getSentTs().toLocalDateTime().format(Constants.DATE_TIME_FORMATTER),
                message.isRead()
        );
    }
}
