package ru.kpfu.itis.gr201.ponomarev.springcars.exception;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
@NoArgsConstructor(force = true)
public class LoginAlreadyTakenException extends UserSaveException {
    private final String login;
}
