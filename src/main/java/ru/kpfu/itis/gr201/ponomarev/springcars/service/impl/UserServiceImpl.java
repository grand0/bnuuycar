package ru.kpfu.itis.gr201.ponomarev.springcars.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.postgresql.util.PSQLException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.gr201.ponomarev.springcars.dto.UserDto;
import ru.kpfu.itis.gr201.ponomarev.springcars.exception.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Car;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.User;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.UserRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.repository.UsersCarsRepository;
import ru.kpfu.itis.gr201.ponomarev.springcars.security.CustomUserDetails;
import ru.kpfu.itis.gr201.ponomarev.springcars.service.UserService;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.CloudinaryUtil;

import java.io.IOException;
import java.util.Optional;
import java.util.logging.Level;

@Service
@RequiredArgsConstructor
@Log
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UsersCarsRepository usersCarsRepository;

    private final PasswordEncoder passwordEncoder;
    private final AuthenticationProvider authenticationProvider;

    @Override
    public UserDto getUser(int id) {
        Optional<User> user = userRepository.findById(id);
        return user.map(this::toUserDto).orElse(null);
    }

    @Override
    public UserDto getAuthenticatedUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof CustomUserDetails) {
            User user = ((CustomUserDetails) auth.getPrincipal()).getUser();
            return toUserDto(user);
        }
        return null;
    }

    @Override
    public UserDto toUserDto(User user) {
        return new UserDto(
                user.getId(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getAvatarUrl()
        );
    }

    @Override
    public void save(User user) throws SaveException {
        // TODO
    }

    @Override
    public void addCarToCurrentUser(Car car) throws UserNotAuthenticatedException {
        UserDto userDto = getAuthenticatedUser();
        if (userDto == null) {
            throw new UserNotAuthenticatedException();
        }
        usersCarsRepository.addCarToUser(userDto.getId(), car.getId());
    }

    @Override
    public void tryUpdateUser(MultipartFile avatar, String email, String oldPassword, String newPassword, String confirmPassword) throws UserUpdateException, IOException, UserSaveException {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User oldUser = ((CustomUserDetails) auth.getPrincipal()).getUser();
        User newUser = new User(
                oldUser.getFirstName(),
                oldUser.getLastName(),
                email,
                oldUser.getAvatarUrl(),
                oldUser.getLogin(),
                null
        );
        if (oldPassword != null && !oldPassword.isEmpty() && newPassword != null && !newPassword.isEmpty()) {
//            if (!oldUser.getPassword().equals(passwordEncoder.encode(oldPassword))) {
            if (!passwordEncoder.matches(oldPassword, oldUser.getPassword())) {
                throw new WrongOldPasswordException();
            } else if (!newPassword.equals(confirmPassword)) {
                throw new WrongPasswordConfirmationException();
            } else {
                newUser.setPassword(passwordEncoder.encode(newPassword));
            }
        }
        if (avatar != null) {
            String newAvatarUrl = CloudinaryUtil.uploadPart(avatar.getInputStream());
            newUser.setAvatarUrl(newAvatarUrl);
        }
        userRepository.update(oldUser.getId(), newUser);
        User updatedUser = userRepository.findById(oldUser.getId()).get();
        CustomUserDetails principal = new CustomUserDetails(updatedUser);
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(principal, updatedUser.getPassword());
        SecurityContextHolder.getContext().setAuthentication(token);
    }

    @Override
    public void save(MultipartFile avatar, String firstName, String lastName, String email, String login, String password) throws IOException, UserSaveException {
        String avatarUrl = null;
        if (avatar != null) {
            avatarUrl = CloudinaryUtil.uploadPart(avatar.getInputStream());
        }
        User user = new User(
                firstName,
                lastName,
                email,
                avatarUrl,
                login,
                passwordEncoder.encode(password)
        );
        try {
            userRepository.save(user);
        } catch (Exception e) {
            if (e.getMessage().contains("email_unique")) {
                throw new EmailAlreadyRegisteredException(user.getEmail());
            } else if (e.getMessage().contains("login_unique")) {
                throw new LoginAlreadyTakenException(user.getLogin());
            } else {
                log.log(Level.SEVERE, "Unknown error", e);
                throw new UserSaveException();
            }
        }
    }
}
