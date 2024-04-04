package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer>, CustomUserRepository {

    Optional<User> findByLogin(String login);
}
