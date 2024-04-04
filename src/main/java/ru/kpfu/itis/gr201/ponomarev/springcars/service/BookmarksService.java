package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;

import java.util.List;

public interface BookmarksService {
    List<AdvertisementDto> getAllOfUser(int userId);
    boolean isBookmarked(int userId, int advertisementId);
    void add(int userId, int advertisementId);
    void remove(int userId, int advertisementId);
}
