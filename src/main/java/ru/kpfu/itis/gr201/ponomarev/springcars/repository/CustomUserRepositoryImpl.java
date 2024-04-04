package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import lombok.extern.java.Log;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.EmailAlreadyRegisteredException;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.LoginAlreadyTakenException;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.UserSaveException;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.logging.Level;

@Repository
@Log
public class CustomUserRepositoryImpl implements CustomUserRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void update(int id, User user) throws UserSaveException {
        try {
            Query query;
            if (user.getPassword() == null) {
                String sql = "UPDATE Users SET (first_name, last_name, email, avatar_url) = (?, ?, ?, ?) WHERE id = ?";
                query = entityManager.createNativeQuery(sql);
                query.setParameter(5, id);
            } else {
                String sql = "UPDATE Users SET (first_name, last_name, email, avatar_url, password) = (?, ?, ?, ?, ?) WHERE id = ?";
                query = entityManager.createNativeQuery(sql);
                query.setParameter(5, user.getPassword());
                query.setParameter(6, id);
            }
            query.setParameter(1, user.getFirstName());
            query.setParameter(2, user.getLastName());
            query.setParameter(3, user.getEmail());
            query.setParameter(4, user.getAvatarUrl());
            query.executeUpdate();
        } catch (Exception e) {
            if (e.getMessage().contains("email_unique")) {
                throw new EmailAlreadyRegisteredException(user.getEmail());
            } else if (e.getMessage().contains("login_unique")) {
                throw new LoginAlreadyTakenException(user.getLogin());
            } else {
                log.log(Level.SEVERE, "Unknown error", e);
                throw new UserSaveException(e);
            }
        }
    }
}
