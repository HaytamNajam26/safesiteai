package com.safesite.service;

import com.safesite.model.Incident;
import com.safesite.model.User;
import com.safesite.repository.IncidentRepository;
import com.safesite.repository.SiteRepository;
import com.safesite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class IncidentService {
    
    @Autowired
    private IncidentRepository incidentRepository;
    
    @Autowired
    private SiteRepository siteRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    public List<Incident> getAllIncidents() {
        return incidentRepository.findAll();
    }
    
    public List<Incident> getIncidentsBySiteId(Long siteId) {
        return incidentRepository.findBySiteId(siteId);
    }
    
    public List<Incident> getIncidentsByUserId(Long userId) {
        return incidentRepository.findByReportedById(userId);
    }
    
    public Optional<Incident> getIncidentById(Long id) {
        return incidentRepository.findById(id);
    }
    
    public Incident createIncident(Incident incident, Long reportedById) {
        if (incident.getSite() != null && incident.getSite().getId() != null) {
            siteRepository.findById(incident.getSite().getId())
                    .ifPresent(incident::setSite);
        }
        
        if (reportedById != null) {
            userRepository.findById(reportedById)
                    .ifPresent(incident::setReportedBy);
        }
        
        return incidentRepository.save(incident);
    }
    
    public Incident updateIncident(Long id, Incident incidentDetails) {
        Incident incident = incidentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Incident not found"));
        
        incident.setType(incidentDetails.getType());
        incident.setDescription(incidentDetails.getDescription());
        incident.setSeverity(incidentDetails.getSeverity());
        incident.setLocation(incidentDetails.getLocation());
        incident.setPhotoUrl(incidentDetails.getPhotoUrl());
        
        if (incidentDetails.getSite() != null && incidentDetails.getSite().getId() != null) {
            siteRepository.findById(incidentDetails.getSite().getId())
                    .ifPresent(incident::setSite);
        }
        
        return incidentRepository.save(incident);
    }
    
    public void deleteIncident(Long id) {
        incidentRepository.deleteById(id);
    }
}

