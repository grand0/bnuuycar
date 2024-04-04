package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.AdvertisementImage;

import java.util.List;

@Repository
public interface AdvertisementImagesRepository extends JpaRepository<AdvertisementImage, Integer> {

    List<AdvertisementImage> findAllByAdvertisementId(int advertisementId);
}
