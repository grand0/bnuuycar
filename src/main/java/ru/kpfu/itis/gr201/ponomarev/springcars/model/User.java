package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "first_name", nullable = false, length = 60)
    private String firstName;

    @Column(name = "last_name", nullable = false, length = 60)
    private String lastName;

    @Column(name = "email", unique = true, nullable = false, length = 100)
    private String email;

    @Column(name = "avatar_url", length = 512)
    private String avatarUrl;

    @Column(name = "login", unique = true, nullable = false, length = 60)
    private String login;

    @Column(name = "password", nullable = false, length = 64)
    private String password;

    public User(String firstName, String lastName, String email, String avatarUrl, String login, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.avatarUrl = avatarUrl;
        this.login = login;
        this.password = password;
    }
}
