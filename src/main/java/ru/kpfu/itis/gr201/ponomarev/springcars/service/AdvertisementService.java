package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Condition;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementFilter;

import java.sql.Timestamp;
import java.util.List;

public interface AdvertisementService {
    List<AdvertisementDto> getAll();
    List<AdvertisementDto> getRecent();
    List<AdvertisementDto> getAllWithFilter(AdvertisementFilter filter);

    AdvertisementDto get(int id);
    AdvertisementDto toAdvertisementDto(Advertisement advertisement);
    List<AdvertisementDto> getAllOfUser(int userId);

    AdvertisementDto save(int carId, String description, int price, int sellerId, Timestamp publicationTs, int mileage, String carColor, Condition condition, int owners, boolean exchangeAllowed) throws SaveException;

    void incrementViewCount(int id);
}
