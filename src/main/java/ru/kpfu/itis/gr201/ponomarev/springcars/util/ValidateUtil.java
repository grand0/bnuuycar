package ru.kpfu.itis.gr201.ponomarev.springcars.util;

public class ValidateUtil {
    public static boolean validateName(String name) {
        final String NAME_REGEX = "^(([a-zA-Z]+-?[a-zA-Z]+)|([a-zA-Z]+))$";
        return validate(name, 1, 60, NAME_REGEX);
    }

    public static boolean validateEmail(String email) {
        final String EMAIL_REGEX = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]+$";
        return validate(email, 5, 100, EMAIL_REGEX);
    }

    public static boolean validateLogin(String login) {
        final String LOGIN_REGEX = "^[a-zA-Z0-9_.-]+$";
        return validate(login, 5, 60, LOGIN_REGEX);
    }

    public static boolean validatePassword(String password) {
        final String PASSWORD_REGEX = "^[a-zA-Z0-9!\"#$%&'()*+,-./:;<=>?@\\\\^_`{|}~]+$";
        return validate(password, 6, 64, PASSWORD_REGEX);
    }

    private static boolean validate(String s, int minLength, int maxLength, String regex) {
        return s != null && s.length() >= minLength && s.length() <= maxLength && s.matches(regex);
    }
}
