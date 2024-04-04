package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface AdvertisementRepository extends JpaRepository<Advertisement, Integer>, CustomAdvertisementRepository {

    @Query(value = "SELECT * FROM advertisements a ORDER BY a.publication_ts DESC LIMIT 10", nativeQuery = true)
    List<Advertisement> findRecent();

    List<Advertisement> findAllBySellerId(int sellerId);

    @Modifying
    @Transactional
    @Query("UPDATE Advertisement a SET a.viewCount = a.viewCount + 1 WHERE a.id = :id")
    void incrementViewCount(@Param("id") int id);
}
