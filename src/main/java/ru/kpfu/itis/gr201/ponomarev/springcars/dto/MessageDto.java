package ru.kpfu.itis.gr201.ponomarev.springcars.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MessageDto {
    private UserDto sender;
    private String message;
    private String sentDateTime;
    private boolean isRead;

    @Override
    public String toString() {
        return message;
    }
}
