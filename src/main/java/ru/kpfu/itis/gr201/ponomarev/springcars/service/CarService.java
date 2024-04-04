package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import ru.kpfu.itis.gr201.ponomarev.springcars.dto.CarDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.SaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;

import java.util.List;

public interface CarService {
    List<CarDto> getAll();
    CarDto get(int id);
    CarDto toCarDto(Car car);
    int saveIfNotExists(Car car) throws SaveException;
}
