package ru.kpfu.itis.gr201.ponomarev.springcars.model.converter;

import ru.kpfu.itis.gr201.ponomarev.springcars.model.Body;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class BodyConverter implements AttributeConverter<Body, String> {

    @Override
    public String convertToDatabaseColumn(Body attribute) {
        if (attribute == null) return null;
        return attribute.getBody();
    }

    @Override
    public Body convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return Body.getByName(dbData);
    }
}
