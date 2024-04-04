package ru.kpfu.itis.gr201.ponomarev.springcars.service;

import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;

import java.io.IOException;

public interface UserService {
    UserDto getUser(int id);

    UserDto getAuthenticatedUser();

    UserDto toUserDto(User user);

    void save(User user) throws SaveException;

    void addCarToCurrentUser(Car car) throws UserNotAuthenticatedException;

    void tryUpdateUser(MultipartFile avatar, String email, String oldPassword, String newPassword, String confirmPassword) throws UserUpdateException, IOException, UserSaveException;

    void save(MultipartFile avatar, String firstName, String lastName, String email, String login, String password) throws IOException, UserSaveException;
}
