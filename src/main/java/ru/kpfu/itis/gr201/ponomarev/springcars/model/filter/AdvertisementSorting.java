package ru.kpfu.itis.gr201.ponomarev.springcars.model.filter;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@RequiredArgsConstructor
@Getter
public enum AdvertisementSorting {
    CAR_NAME(1, "Car name"),
    MILEAGE(2, "Mileage"),
    PRICE(3, "Price"),
    PUBLICATION_TIME(4, "Publication time"),
    VIEWS(5, "Views");

    @Setter
    private boolean isDesc = true;

    private final int id;
    private final String name;

    public static AdvertisementSorting getById(int id) {
        for (AdvertisementSorting s : values()) {
            if (s.id == id) {
                return s;
            }
        }
        return null;
    }

    public static AdvertisementSorting getByName(String name) {
        for (AdvertisementSorting s : values()) {
            if (s.name.equals(name)) {
                return s;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return name;
    }
}
