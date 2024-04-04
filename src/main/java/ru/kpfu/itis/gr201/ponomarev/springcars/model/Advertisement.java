package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "advertisements")
@Data
@NoArgsConstructor
public class Advertisement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "car_id", nullable = false)
    private int carId;

    @Column(name = "description", length = 2000)
    private String description;

    @Column(name = "price", nullable = false)
    private int price;

    @Column(name = "seller_id", nullable = false)
    private int sellerId;

    @Column(name = "publication_ts", nullable = false)
    private Timestamp publicationTs;

    @Column(name = "mileage", nullable = false)
    private int mileage;

    @Column(name = "car_color", nullable = false, length = 30)
    private String carColor;

    @Column(name = "condition", nullable = false)
    private Condition condition;

    @Column(name = "owners", nullable = false)
    private int owners;

    @Column(name = "exchange_allowed", nullable = false)
    private boolean exchangeAllowed;

    @Column(name = "view_count", nullable = false)
    private int viewCount;

    public Advertisement(int carId, String description, int price, int sellerId, Timestamp publicationTs, int mileage, String carColor, Condition condition, int owners, boolean exchangeAllowed) {
        this.carId = carId;
        this.description = description;
        this.price = price;
        this.sellerId = sellerId;
        this.publicationTs = publicationTs;
        this.mileage = mileage;
        this.carColor = carColor;
        this.condition = condition;
        this.owners = owners;
        this.exchangeAllowed = exchangeAllowed;
        this.viewCount = 0;
    }
}
