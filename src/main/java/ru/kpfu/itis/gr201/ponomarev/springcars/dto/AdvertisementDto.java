package ru.kpfu.itis.gr201.ponomarev.springcars.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Condition;

import java.util.List;

@Data
@AllArgsConstructor
public class AdvertisementDto {
    private int id;
    private CarDto car;
    private String description;
    private int price;
    private UserDto seller;
    private String publicationTs;
    private int mileage;
    private String carColor;
    private Condition condition;
    private int owners;
    private boolean exchangeAllowed;
    private int viewCount;
    private List<String> imagesUrls;

    @Override
    public String toString() {
        return condition + " " + carColor + " " + car;
    }
}
