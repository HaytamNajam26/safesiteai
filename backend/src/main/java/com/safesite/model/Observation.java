package com.safesite.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "observations")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Observation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "observation_date", nullable = false)
    private LocalDate observationDate;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "site_id", nullable = false)
    private Site site;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by", nullable = false)
    private User createdBy;
    
    // Weather & Presence
    private Double temperature;
    private Double humidity;
    private Integer workersPresent;
    private Integer hoursWorked;
    
    // Activities
    @ElementCollection
    @CollectionTable(name = "observation_activities", joinColumns = @JoinColumn(name = "observation_id"))
    @Column(name = "activity")
    private List<String> activities = new ArrayList<>();
    
    // Safety Evaluations
    @Column(name = "epi_compliance")
    private Double epiCompliance; // 0-100
    
    @Column(name = "equipment_state")
    private Double equipmentState; // 0-10
    
    @Column(name = "site_clean")
    private Double siteClean; // 0-10
    
    @Column(name = "fatigue_level")
    private Double fatigueLevel; // 0-10
    
    // Incidents
    @Column(name = "minor_incidents")
    private Integer minorIncidents;
    
    @Column(name = "major_incidents")
    private Integer majorIncidents;
    
    // Notes & Photos
    @Column(columnDefinition = "TEXT")
    private String notes;
    
    @ElementCollection
    @CollectionTable(name = "observation_photos", joinColumns = @JoinColumn(name = "observation_id"))
    @Column(name = "photo_url")
    private List<String> photoUrls = new ArrayList<>();
    
    // AI Analysis Result
    @Column(name = "ai_analysis", columnDefinition = "TEXT")
    private String aiAnalysis;
    
    @Column(name = "risk_score")
    private Double riskScore;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (observationDate == null) {
            observationDate = LocalDate.now();
        }
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

