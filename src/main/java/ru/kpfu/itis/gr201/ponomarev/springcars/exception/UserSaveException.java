package ru.kpfu.itis.gr201.ponomarev.springcars.exception;

public class UserSaveException extends SaveException {
    public UserSaveException() {
        super();
    }

    public UserSaveException(String message) {
        super(message);
    }

    public UserSaveException(String message, Throwable cause) {
        super(message, cause);
    }

    public UserSaveException(Throwable cause) {
        super(cause);
    }

    protected UserSaveException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
