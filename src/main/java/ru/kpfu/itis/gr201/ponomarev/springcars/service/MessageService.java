package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.MessageDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Message;

import java.util.List;
import java.util.Map;

public interface MessageService {
    List<UserDto> getAllRecipientsOfAdvertisement(int advertisementId, int senderId);
    List<MessageDto> readAllOfAdvertisementAndUser(int advertisementId, int senderId, int recipientId);
    List<AdvertisementDto> getAllAdvertisementsToWhichUserSentMessage(int userId);
    List<Integer> getAdvertisementIdsWithUnreadMessages(int userId);
    Map<Integer, List<Integer>> getAdvertisementIdsAndSenderIdsWithUnreadMessages(int userId);
    MessageDto send(int senderId, int recipientId, int adId, String message);

    MessageDto toMessageDto(Message message);
}
