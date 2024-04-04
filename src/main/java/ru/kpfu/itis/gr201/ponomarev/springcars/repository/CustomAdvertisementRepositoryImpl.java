package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import io.hypersistence.utils.hibernate.type.array.StringArrayType;
import org.hibernate.jpa.TypedParameterValue;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.*;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementFilter;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.filter.AdvertisementSorting;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.sql.Array;
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.function.Supplier;
import java.util.stream.Stream;

@Repository
public class CustomAdvertisementRepositoryImpl implements CustomAdvertisementRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Advertisement> getAllWithFilter(AdvertisementFilter filter) {
        StringBuilder sqlStringBuilder = new StringBuilder(
                "SELECT advertisements.id, car_id, description, price, seller_id, publication_ts, mileage, car_color, condition, owners, exchange_allowed, view_count " +
                "FROM advertisements " +
                "JOIN cars on advertisements.car_id = cars.id " +
                "JOIN models on cars.model_id = models.id " +
                "JOIN makes on models.make_id = makes.id " +
                "WHERE " +
                (filter.getMake() != null ? "lower(make) LIKE lower('%' || ? || '%') AND " : "") +
                (filter.getModel() != null ? "lower(model) LIKE lower('%' || ? || '%') AND " : "") +
                "(body = ANY(?)) AND " +
                "(transmission = ANY(?)) AND " +
                "(engine = ANY(?)) AND " +
                "(drive = ANY(?)) AND " +
                (filter.getEngineVolumeFrom() != null ? "engine_volume >= ? AND " : "") +
                (filter.getEngineVolumeTo() != null ? "engine_volume <= ? AND " : "") +
                (filter.getYearFrom() != null ? "year >= ? AND " : "") +
                (filter.getYearTo() != null ? "year <= ? AND " : "") +
                (filter.getHorsepowerFrom() != null ? "horsepower >= ? AND " : "") +
                (filter.getHorsepowerTo() != null ? "horsepower <= ? AND " : "") +
                (filter.getLeftWheel() != null ? "left_wheel = ? AND " : "") +
                (filter.getPriceFrom() != null ? "price >= ? AND " : "") +
                (filter.getPriceTo() != null ? "price <= ? AND " : "") +
                (filter.getMileageFrom() != null ? "mileage >= ? AND " : "") +
                (filter.getMileageTo() != null ? "mileage <= ? AND " : "") +
                (filter.getOwnersFrom() != null ? "owners >= ? AND " : "") +
                (filter.getOwnersTo() != null ? "owners <= ? AND " : "") +
                "(condition = ANY(?)) AND " +
                (filter.getExchangeAllowed() != null ? "exchange_allowed = ? AND " : "")
        );
        sqlStringBuilder.delete(sqlStringBuilder.length() - 4, sqlStringBuilder.length());
        if (filter.getSorting() == null) {
            filter.setSorting(AdvertisementSorting.PUBLICATION_TIME);
        }
        switch (filter.getSorting()) {
            case CAR_NAME:
                sqlStringBuilder.append("ORDER BY make || ' ' || model ");
                break;
            case MILEAGE:
                sqlStringBuilder.append("ORDER BY mileage ");
                break;
            case PRICE:
                sqlStringBuilder.append("ORDER BY price ");
                break;
            case PUBLICATION_TIME:
                sqlStringBuilder.append("ORDER BY publication_ts ");
                break;
            case VIEWS:
                sqlStringBuilder.append("ORDER BY view_count ");
                break;
        }
        if (filter.getSorting().isDesc()) {
            sqlStringBuilder.append("DESC;");
        } else {
            sqlStringBuilder.append("ASC;");
        }
        String sql = sqlStringBuilder.toString();
        Query query = entityManager.createNativeQuery(sql, Advertisement.class);
        int curQueryIndex = 1;
        if (filter.getMake() != null) {
            query.setParameter(curQueryIndex++, filter.getMake());
        }
        if (filter.getModel() != null) {
            query.setParameter(curQueryIndex++, filter.getModel());
        }

        Stream<Body> bodies = filter.getBodies() != null
                ? filter.getBodies().stream()
                : Arrays.stream(Body.values());
        String[] bodiesStr = bodies
                .map(Body::getBody)
                .toArray(String[]::new);
        query.setParameter(curQueryIndex++, new TypedParameterValue(StringArrayType.INSTANCE, bodiesStr));

        Stream<Transmission> transmissions = filter.getTransmissions() != null
                ? filter.getTransmissions().stream()
                : Arrays.stream(Transmission.values());
        String[] transmissionsStr = transmissions
                .map(Transmission::getTransmission)
                .toArray(String[]::new);
        query.setParameter(curQueryIndex++, new TypedParameterValue(StringArrayType.INSTANCE, transmissionsStr));

        Stream<Engine> engines = filter.getEngines() != null
                ? filter.getEngines().stream()
                : Arrays.stream(Engine.values());
        String[] enginesStr = engines
                .map(Engine::getEngine)
                .toArray(String[]::new);
        query.setParameter(curQueryIndex++, new TypedParameterValue(StringArrayType.INSTANCE, enginesStr));

        Stream<Drive> drives = filter.getDrives() != null
                ? filter.getDrives().stream()
                : Arrays.stream(Drive.values());
        String[] drivesStr = drives
                .map(Drive::getDrive)
                .toArray(String[]::new);
        query.setParameter(curQueryIndex++, new TypedParameterValue(StringArrayType.INSTANCE, drivesStr));

        if (filter.getEngineVolumeFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getEngineVolumeFrom());
        }

        if (filter.getEngineVolumeTo() != null) {
            query.setParameter(curQueryIndex++, filter.getEngineVolumeTo());
        }

        if (filter.getYearFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getYearFrom());
        }

        if (filter.getYearTo() != null) {
            query.setParameter(curQueryIndex++, filter.getYearTo());
        }

        if (filter.getHorsepowerFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getHorsepowerFrom());
        }

        if (filter.getHorsepowerTo() != null) {
            query.setParameter(curQueryIndex++, filter.getHorsepowerTo());
        }

        if (filter.getLeftWheel() != null) {
            query.setParameter(curQueryIndex++, filter.getLeftWheel());
        }

        if (filter.getPriceFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getPriceFrom());
        }

        if (filter.getPriceTo() != null) {
            query.setParameter(curQueryIndex++, filter.getPriceTo());
        }

        if (filter.getMileageFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getMileageFrom());
        }

        if (filter.getMileageTo() != null) {
            query.setParameter(curQueryIndex++, filter.getMileageTo());
        }

        if (filter.getOwnersFrom() != null) {
            query.setParameter(curQueryIndex++, filter.getOwnersFrom());
        }

        if (filter.getOwnersTo() != null) {
            query.setParameter(curQueryIndex++, filter.getOwnersTo());
        }

        Stream<Condition> conditions = filter.getConditions() != null
                ? filter.getConditions().stream()
                : Arrays.stream(Condition.values());
        String[] conditionsStr = conditions
                .map(Condition::getCondition)
                .toArray(String[]::new);
        query.setParameter(curQueryIndex++, new TypedParameterValue(StringArrayType.INSTANCE, conditionsStr));

        if (filter.getExchangeAllowed() != null) {
            query.setParameter(curQueryIndex++, filter.getExchangeAllowed());
        }

        return query.getResultList();
    }
}
