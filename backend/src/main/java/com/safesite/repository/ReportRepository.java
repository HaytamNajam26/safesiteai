package com.safesite.repository;

import com.safesite.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportRepository extends JpaRepository<Report, Long> {
    List<Report> findByProjectId(Long projectId);
    List<Report> findBySiteId(Long siteId);
    List<Report> findByCreatedById(Long userId);
}

