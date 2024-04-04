package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Make;

import java.util.List;

@Repository
public interface MakeRepository extends JpaRepository<Make, Integer> {

    Make findByMake(String make);

    @Query("SELECT m FROM Make m WHERE lower(m.make) LIKE lower(:query || '%')")
    List<Make> search(@Param("query") String query);
}
