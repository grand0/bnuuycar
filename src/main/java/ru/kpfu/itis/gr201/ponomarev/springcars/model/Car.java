package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "cars")
@Data
@NoArgsConstructor
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "model_id", nullable = false)
    private int modelId;

    @Column(name = "body", nullable = false)
    private Body body;

    @Column(name = "transmission", nullable = false)
    private Transmission transmission;

    @Column(name = "engine", nullable = false)
    private Engine engine;

    @Column(name = "drive", nullable = false)
    private Drive drive;

    @Column(name = "engine_volume", nullable = false)
    private float engineVolume;

    @Column(name = "year", nullable = false)
    private int year;

    @Column(name = "horsepower", nullable = false)
    private int horsepower;

    @Column(name = "left_wheel", nullable = false)
    private boolean leftWheel;

    public Car(int modelId, Body body, Transmission transmission, Engine engine, Drive drive, float engineVolume, int year, int horsepower, boolean leftWheel) {
        this.modelId = modelId;
        this.body = body;
        this.transmission = transmission;
        this.engine = engine;
        this.drive = drive;
        this.engineVolume = engineVolume;
        this.year = year;
        this.horsepower = horsepower;
        this.leftWheel = leftWheel;
    }
}
