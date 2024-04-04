package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

@Entity
@Table(name = "models")
@Data
@NoArgsConstructor
public class Model {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "make_id", nullable = false)
    private int makeId;

    @Column(name = "model", nullable = false, length = 40)
    private String model;

    public Model(int makeId, String model) {
        this.makeId = makeId;
        this.model = model;
    }
}
