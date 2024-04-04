package ru.kpfu.itis.gr201.ponomarev.springcars.exception;

public class UserNotAuthenticatedException extends Exception {
    public UserNotAuthenticatedException() {
        super();
    }

    public UserNotAuthenticatedException(String message) {
        super(message);
    }

    public UserNotAuthenticatedException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserNotAuthenticatedException(Throwable cause) {
        super(cause);
    }

    public UserNotAuthenticatedException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
