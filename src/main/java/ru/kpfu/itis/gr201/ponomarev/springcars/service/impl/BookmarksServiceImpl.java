package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.BookmarksRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.BookmarksService;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BookmarksServiceImpl implements BookmarksService {

    private final BookmarksRepository bookmarksRepository;
    private final AdvertisementService advertisementService;

    @Override
    public List<AdvertisementDto> getAllOfUser(int userId) {
        return bookmarksRepository.getAllIdsOfUser(userId)
                .stream()
                .map(advertisementService::get)
                .toList();
    }

    @Override
    public boolean isBookmarked(int userId, int advertisementId) {
        return bookmarksRepository.getAllIdsOfUser(userId).contains(advertisementId);
    }

    @Override
    public void add(int userId, int advertisementId) {
        bookmarksRepository.add(userId, advertisementId);
    }

    @Override
    public void remove(int userId, int advertisementId) {
        bookmarksRepository.remove(userId, advertisementId);
    }
}
