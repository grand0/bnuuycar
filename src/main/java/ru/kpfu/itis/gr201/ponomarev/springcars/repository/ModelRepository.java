package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Model;

import java.util.List;

@Repository
public interface ModelRepository extends JpaRepository<Model, Integer> {

    Model findByMakeIdAndModel(int makeId, String model);

    @Query("SELECT mo FROM Model mo JOIN Make ma ON mo.makeId = ma.id WHERE (:make IS NULL OR ma.make = :make) AND (lower(mo.model) LIKE lower(:query || '%'))")
    List<Model> search(@Param("make") String make, @Param("query") String query);
}
