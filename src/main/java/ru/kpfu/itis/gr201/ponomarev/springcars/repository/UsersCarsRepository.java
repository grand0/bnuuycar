package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface UsersCarsRepository extends org.springframework.data.repository.Repository<Car, Integer> {

    @Query(value = "SELECT * FROM users_cars uc JOIN cars c ON uc.car_id = c.id WHERE uc.user_id = :userId", nativeQuery = true)
    List<Car> getCarsOfUser(@Param("userId") int userId);

    @Query(value = "SELECT * FROM users_cars uc JOIN users u ON uc.car_id = u.id WHERE uc.car_id = :carId", nativeQuery = true)
    List<User> getUsersOfCar(@Param("carId") int carId);

    @Query(value = "SELECT * FROM users_cars uc JOIN cars c ON c.id = uc.car_id WHERE uc.user_id = :userId AND uc.car_id IN (SELECT car_id FROM advertisements WHERE seller_id = :userId)", nativeQuery = true)
    List<Car> getAdvertisedCarsOfUser(@Param("userId") int userId);

    @Query(value = "SELECT * FROM users_cars uc JOIN cars c ON c.id = uc.car_id WHERE uc.user_id = :userId AND uc.car_id NOT IN (SELECT car_id FROM advertisements WHERE seller_id = :userId)", nativeQuery = true)
    List<Car> getNotAdvertisedCarsOfUser(@Param("userId") int userId);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO users_cars (user_id, car_id) VALUES (:userId, :carId)", nativeQuery = true)
    void addCarToUser(@Param("userId") int userId, @Param("carId") int carId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM users_cars WHERE user_id = :userId AND car_id = :carId", nativeQuery = true)
    void removeCarFromUser(@Param("userId") int userId, @Param("carId") int carId);
}
