package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;

import java.util.List;

public interface UsersCarsService {
    List<CarDto> getCarsOfUser(int userId);
    List<UserDto> getUsersOfCar(int carId);
    List<CarDto> getAdvertisedCarsOfUser(int userId);
    List<CarDto> getNotAdvertisedCarsOfUser(int userId);
    void removeCarFromUser(int userId, int carId);
}
