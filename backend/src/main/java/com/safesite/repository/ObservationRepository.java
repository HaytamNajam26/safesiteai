package com.safesite.repository;

import com.safesite.model.Observation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ObservationRepository extends JpaRepository<Observation, Long> {
    List<Observation> findBySiteId(Long siteId);
    List<Observation> findByCreatedById(Long userId);
    List<Observation> findByObservationDate(LocalDate date);
}

