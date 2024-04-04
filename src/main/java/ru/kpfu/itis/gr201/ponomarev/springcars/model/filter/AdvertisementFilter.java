package ru.kpfu.itis.gr201.ponomarev.springcars.model.filter;

import lombok.Data;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.*;

import java.util.List;

@Data
public class AdvertisementFilter {
    private String make;
    private String model;
    private List<Body> bodies;
    private List<Transmission> transmissions;
    private List<Engine> engines;
    private List<Drive> drives;
    private Float engineVolumeFrom;
    private Float engineVolumeTo;
    private Integer yearFrom;
    private Integer yearTo;
    private Integer horsepowerFrom;
    private Integer horsepowerTo;
    private Boolean leftWheel;
    private Integer priceFrom;
    private Integer priceTo;
    private Integer mileageFrom;
    private Integer mileageTo;
    private List<Condition> conditions;
    private Integer ownersFrom;
    private Integer ownersTo;
    private Boolean exchangeAllowed;
    private AdvertisementSorting sorting;
}
