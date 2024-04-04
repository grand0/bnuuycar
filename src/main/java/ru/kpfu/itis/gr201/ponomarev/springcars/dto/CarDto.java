package ru.kpfu.itis.gr201.ponomarev.springcars.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Body;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Drive;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Engine;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Transmission;

@Data
@AllArgsConstructor
public class CarDto {
    private int id;
    private String make;
    private String model;
    private Body body;
    private Transmission transmission;
    private Engine engine;
    private Drive drive;
    private double engineVolume;
    private int year;
    private int horsepower;
    private boolean leftWheel;

    @Override
    public String toString() {
        return make + " " + model + " (" + year + ")";
    }
}
