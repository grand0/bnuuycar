package ru.kpfu.itis.gr201.ponomarev.springcars.model.converter;

import ru.kpfu.itis.gr201.ponomarev.springcars.model.Engine;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class EngineConverter implements AttributeConverter<Engine, String> {

    @Override
    public String convertToDatabaseColumn(Engine attribute) {
        if (attribute == null) return null;
        return attribute.getEngine();
    }

    @Override
    public Engine convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return Engine.getByName(dbData);
    }
}
