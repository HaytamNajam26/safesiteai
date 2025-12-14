package com.safesite.repository;

import com.safesite.model.Incident;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IncidentRepository extends JpaRepository<Incident, Long> {
    List<Incident> findBySiteId(Long siteId);
    List<Incident> findByReportedById(Long userId);
}

