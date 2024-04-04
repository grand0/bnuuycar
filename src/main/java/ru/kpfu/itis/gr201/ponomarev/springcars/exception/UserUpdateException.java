package ru.kpfu.itis.gr201.ponomarev.springcars.exception;

public class UserUpdateException extends Exception {

    public UserUpdateException() {
        super();
    }

    public UserUpdateException(String message) {
        super(message);
    }

    public UserUpdateException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserUpdateException(Throwable cause) {
        super(cause);
    }

    protected UserUpdateException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
