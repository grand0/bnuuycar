package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Body {
    MICRO(1, "Micro"),
    SEDAN(2, "Sedan"),
    SUV(3, "SUV"),
    HATCHBACK(4, "Hatchback"),
    MINIVAN(5, "Minivan"),
    CABRIOLET(6, "Cabriolet"),
    COUPE(7, "Coupe"),
    ROADSTER(8, "Roadster"),
    SPORTCAR(9, "Sportcar"),
    PICKUP(10, "Pickup"),
    VAN(11, "Van"),
    LIMOUSINE(12, "Limousine"),
    CAMPERVAN(13, "Campervan"),
    TRUCK(14, "Truck"),
    MINI_TRUCK(15, "Mini Truck");

    private final int id;
    private final String body;

    public static Body getById(int id) {
        for (Body body : values()) {
            if (body.id == id) return body;
        }
        return null;
    }

    public static Body getByName(String name) {
        for (Body body : values()) {
            if (body.body.equals(name)) return body;
        }
        return null;
    }

    @Override
    public String toString() {
        return body;
    }
}
