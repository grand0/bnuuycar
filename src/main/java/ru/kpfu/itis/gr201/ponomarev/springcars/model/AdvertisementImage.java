package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "advertisement_images")
@Data
@NoArgsConstructor
public class AdvertisementImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "advertisement_id", nullable = false)
    private int advertisementId;

    @Column(name = "image_url", nullable = false, length = 512)
    private String imageUrl;

    public AdvertisementImage(int advertisementId, String imageUrl) {
        this.advertisementId = advertisementId;
        this.imageUrl = imageUrl;
    }
}
