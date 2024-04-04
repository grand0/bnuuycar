package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.UserSaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;

import javax.transaction.Transactional;

@Repository
public interface CustomUserRepository {

    @Transactional
    @Modifying
    void update(int id, User user) throws UserSaveException;
}
