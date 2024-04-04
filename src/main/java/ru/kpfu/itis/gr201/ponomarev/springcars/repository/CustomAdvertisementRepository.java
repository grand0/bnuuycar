package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Advertisement;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementFilter;

import java.util.List;

@Repository
public interface CustomAdvertisementRepository {

    List<Advertisement> getAllWithFilter(AdvertisementFilter filter);
}
