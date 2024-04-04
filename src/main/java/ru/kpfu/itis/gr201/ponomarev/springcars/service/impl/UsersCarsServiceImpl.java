package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.UsersCarsRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.CarService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UsersCarsService;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UsersCarsServiceImpl implements UsersCarsService {

    private final UsersCarsRepository usersCarsRepository;
    private final CarService carService;
    private final UserService userService;

    @Override
    public List<CarDto> getCarsOfUser(int userId) {
        return usersCarsRepository.getCarsOfUser(userId)
                .stream()
                .map(carService::toCarDto)
                .toList();
    }

    @Override
    public List<UserDto> getUsersOfCar(int carId) {
        return usersCarsRepository.getUsersOfCar(carId)
                .stream()
                .map(userService::toUserDto)
                .toList();
    }

    @Override
    public List<CarDto> getAdvertisedCarsOfUser(int userId) {
        return usersCarsRepository.getAdvertisedCarsOfUser(userId)
                .stream()
                .map(carService::toCarDto)
                .toList();
    }

    @Override
    public List<CarDto> getNotAdvertisedCarsOfUser(int userId) {
        return usersCarsRepository.getNotAdvertisedCarsOfUser(userId)
                .stream()
                .map(carService::toCarDto)
                .toList();
    }

    @Override
    public void removeCarFromUser(int userId, int carId) {
        usersCarsRepository.removeCarFromUser(userId, carId);
    }
}
