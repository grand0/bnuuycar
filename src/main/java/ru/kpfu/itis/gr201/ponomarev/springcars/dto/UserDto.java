package ru.kpfu.itis.gr201.ponomarev.springcars.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import ru.kpfu.itis.gr201.ponomarev.springcars.util.CloudinaryUtil;

@Data
@AllArgsConstructor
public class UserDto {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String avatarUrl;

    public String getRoundCroppedAvatarUrl() {
        return CloudinaryUtil.getRoundCroppedImageUrl(avatarUrl);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(firstName);
        if (lastName != null) {
            sb.append(" ").append(lastName);
        }
        return sb.toString();
    }
}
