package ru.kpfu.itis.gr201.ponomarev.springcars.model.converter;

import ru.kpfu.itis.gr201.ponomarev.springcars.model.Drive;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class DriveConverter implements AttributeConverter<Drive, String> {

    @Override
    public String convertToDatabaseColumn(Drive attribute) {
        if (attribute == null) return null;
        return attribute.getDrive();
    }

    @Override
    public Drive convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return Drive.getByName(dbData);
    }
}
