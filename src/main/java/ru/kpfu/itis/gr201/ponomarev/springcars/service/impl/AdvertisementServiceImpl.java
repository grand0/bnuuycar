package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.AdvertisementDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.AdvertisementImage;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Condition;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementFilter;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementImagesRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.AdvertisementRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.AdvertisementService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.CarService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.Constants;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdvertisementServiceImpl implements AdvertisementService {

    private final AdvertisementRepository advertisementRepository;
    private final AdvertisementImagesRepository advertisementImagesRepository;
    private final CarService carService;
    private final UserService userService;

    @Override
    public List<AdvertisementDto> getAll() {
        return advertisementRepository.findAll().stream().map(this::toAdvertisementDto).toList();
    }

    @Override
    public List<AdvertisementDto> getRecent() {
        return advertisementRepository.findRecent().stream().map(this::toAdvertisementDto).toList();
    }

    @Override
    public List<AdvertisementDto> getAllWithFilter(AdvertisementFilter filter) {
        return advertisementRepository.getAllWithFilter(filter).stream()
                .map(this::toAdvertisementDto)
                .toList();
    }

    @Override
    public AdvertisementDto get(int id) {
        Advertisement advertisement = advertisementRepository.findById(id).get();
        return toAdvertisementDto(advertisement);
    }

    @Override
    public AdvertisementDto toAdvertisementDto(Advertisement advertisement) {
        List<String> images = advertisementImagesRepository.findAllByAdvertisementId(advertisement.getId())
                .stream()
                .map(AdvertisementImage::getImageUrl)
                .toList();
        CarDto carDto = carService.get(advertisement.getCarId());
        UserDto userDto = userService.getUser(advertisement.getSellerId());
        return new AdvertisementDto(
                advertisement.getId(),
                carDto,
                advertisement.getDescription(),
                advertisement.getPrice(),
                userDto,
                advertisement.getPublicationTs().toLocalDateTime().format(Constants.DATE_TIME_FORMATTER),
                advertisement.getMileage(),
                advertisement.getCarColor(),
                advertisement.getCondition(),
                advertisement.getOwners(),
                advertisement.isExchangeAllowed(),
                advertisement.getViewCount(),
                images
        );
    }

    @Override
    public List<AdvertisementDto> getAllOfUser(int userId) {
        return advertisementRepository.findAllBySellerId(userId).stream()
                .map(this::toAdvertisementDto)
                .toList();
    }

    @Override
    public AdvertisementDto save(int carId, String description, int price, int sellerId, Timestamp publicationTs, int mileage, String carColor, Condition condition, int owners, boolean exchangeAllowed) throws SaveException {
        Advertisement advertisement = new Advertisement(
                carId,
                description,
                price,
                sellerId,
                Timestamp.valueOf(LocalDateTime.now()),
                mileage,
                carColor,
                condition,
                owners,
                exchangeAllowed
        );
        try {
            return toAdvertisementDto(
                    advertisementRepository.save(advertisement)
            );
        } catch (Exception e) {
            throw new SaveException();
        }
    }

    @Override
    public void incrementViewCount(int id) {
        advertisementRepository.incrementViewCount(id);
    }
}
