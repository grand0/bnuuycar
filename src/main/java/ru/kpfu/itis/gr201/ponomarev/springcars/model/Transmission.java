package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Transmission {
    MANUAL(1, "Manual"),
    HYDRAULIC(2, "Hydraulic Automatic"),
    CVT(3, "CVT"),
    AMT(4, "AMT"),
    DCT(5, "DCT");

    private final int id;
    private final String transmission;

    public static Transmission getById(int id) {
        for (Transmission transmission : values()) {
            if (transmission.id == id) return transmission;
        }
        return null;
    }

    public static Transmission getByName(String name) {
        for (Transmission transmission : values()) {
            if (transmission.transmission.equals(name)) return transmission;
        }
        return null;
    }

    @Override
    public String toString() {
        return transmission;
    }
}
