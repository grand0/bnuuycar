package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;

@Repository
public interface CarRepository extends JpaRepository<Car, Integer>, CustomCarRepository {
}
