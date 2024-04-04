package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Drive {
    FRONT(1, "Front"),
    BACK(2, "Back"),
    FULL(3, "Full");

    private final int id;
    private final String drive;

    public static Drive getById(int id) {
        for (Drive drive : values()) {
            if (drive.id == id) return drive;
        }
        return null;
    }

    public static Drive getByName(String name) {
        for (Drive drive : values()) {
            if (drive.drive.equals(name)) return drive;
        }
        return null;
    }

    @Override
    public String toString() {
        return drive;
    }
}
