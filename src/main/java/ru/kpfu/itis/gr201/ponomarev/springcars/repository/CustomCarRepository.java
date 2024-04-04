package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;

@Repository
public interface CustomCarRepository {

    Integer checkIfExists(Car car);
}
