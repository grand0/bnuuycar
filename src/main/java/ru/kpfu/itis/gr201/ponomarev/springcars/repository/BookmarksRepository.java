package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface BookmarksRepository extends org.springframework.data.repository.Repository<Advertisement, Integer> {

    @Query(value = "SELECT b.advertisement_id FROM bookmarks b WHERE b.user_id = :userId", nativeQuery = true)
    List<Integer> getAllIdsOfUser(@Param("userId") int userId);

    @Modifying
    @Transactional
    @Query(value = "INSERT INTO bookmarks (user_id, advertisement_id) VALUES (:userId, :advertisementId)", nativeQuery = true)
    void add(@Param("userId") int userId, @Param("advertisementId") int advertisementId);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM bookmarks WHERE (user_id, advertisement_id) = (:userId, :advertisementId)", nativeQuery = true)
    void remove(@Param("userId") int userId, @Param("advertisementId") int advertisementId);
}
