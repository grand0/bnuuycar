package ru.kpfu.itis.gr201.ponomarev.springcars.model.converter;

import ru.kpfu.itis.gr201.ponomarev.springcars.model.Transmission;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class TransmissionConverter implements AttributeConverter<Transmission, String> {

    @Override
    public String convertToDatabaseColumn(Transmission attribute) {
        if (attribute == null) return null;
        return attribute.getTransmission();
    }

    @Override
    public Transmission convertToEntityAttribute(String dbData) {
        if (dbData == null) return null;
        return Transmission.getByName(dbData);
    }
}
