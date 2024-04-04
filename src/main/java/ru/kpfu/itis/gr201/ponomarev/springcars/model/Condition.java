package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Condition {
    EXCELLENT(1, "Excellent"),
    VERY_GOOD(2, "Very good"),
    GOOD(3, "Good"),
    POOR(4, "Poor"),
    NOT_RUNNING(5, "Not running");

    private final int id;
    private final String condition;

    public static Condition getById(int id) {
        for (Condition condition : values()) {
            if (condition.id == id) return condition;
        }
        return null;
    }

    public static Condition getByName(String name) {
        for (Condition condition : values()) {
            if (condition.condition.equals(name)) return condition;
        }
        return null;
    }

    @Override
    public String toString() {
        return condition;
    }
}
