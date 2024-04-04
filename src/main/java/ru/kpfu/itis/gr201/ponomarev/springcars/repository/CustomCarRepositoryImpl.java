package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Repository
public class CustomCarRepositoryImpl implements CustomCarRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Integer checkIfExists(Car car) {
        Query query = entityManager.createNativeQuery("SELECT * FROM cars WHERE (model_id, body, transmission, engine, drive, engine_volume, year, horsepower, left_wheel) = (?, ?, ?, ?, ?, ?, ?, ?, ?);", Car.class);
        query.setParameter(1, car.getModelId());
        query.setParameter(2, car.getBody().getBody());
        query.setParameter(3, car.getTransmission().getTransmission());
        query.setParameter(4, car.getEngine().getEngine());
        query.setParameter(5, car.getDrive().getDrive());
        query.setParameter(6, car.getEngineVolume());
        query.setParameter(7, car.getYear());
        query.setParameter(8, car.getHorsepower());
        query.setParameter(9, car.isLeftWheel());
        try {
            return ((Car) query.getSingleResult()).getId();
        } catch (NoResultException e) {
            return null;
        }
    }
}
