package ru.kpfu.itis.gr201.ponomarev.springcars.model.converter;

import ru.kpfu.itis.gr201.ponomarev.springcars.model.Condition;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = true)
public class ConditionConverter implements AttributeConverter<Condition, String> {

    @Override
    public String convertToDatabaseColumn(Condition attribute) {
        if (attribute == null) {
            return null;
        }
        return attribute.getCondition();
    }

    @Override
    public Condition convertToEntityAttribute(String dbData) {
        if (dbData == null) {
            return null;
        }
        return Condition.getByName(dbData);
    }
}
