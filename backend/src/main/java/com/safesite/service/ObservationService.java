package com.safesite.service;

import com.safesite.model.Observation;
import com.safesite.repository.ObservationRepository;
import com.safesite.repository.SiteRepository;
import com.safesite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ObservationService {
    
    @Autowired
    private ObservationRepository observationRepository;
    
    @Autowired
    private SiteRepository siteRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    public List<Observation> getAllObservations() {
        return observationRepository.findAll();
    }
    
    public List<Observation> getObservationsBySiteId(Long siteId) {
        return observationRepository.findBySiteId(siteId);
    }
    
    public List<Observation> getObservationsByUserId(Long userId) {
        return observationRepository.findByCreatedById(userId);
    }
    
    public Optional<Observation> getObservationById(Long id) {
        return observationRepository.findById(id);
    }
    
    public Observation createObservation(Observation observation, Long createdById) {
        if (observation.getSite() != null && observation.getSite().getId() != null) {
            siteRepository.findById(observation.getSite().getId())
                    .ifPresent(observation::setSite);
        }
        
        if (createdById != null) {
            userRepository.findById(createdById)
                    .ifPresent(observation::setCreatedBy);
        }
        
        return observationRepository.save(observation);
    }
    
    public Observation updateObservation(Long id, Observation observationDetails) {
        Observation observation = observationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Observation not found"));
        
        observation.setObservationDate(observationDetails.getObservationDate());
        observation.setTemperature(observationDetails.getTemperature());
        observation.setHumidity(observationDetails.getHumidity());
        observation.setWorkersPresent(observationDetails.getWorkersPresent());
        observation.setHoursWorked(observationDetails.getHoursWorked());
        observation.setActivities(observationDetails.getActivities());
        observation.setEpiCompliance(observationDetails.getEpiCompliance());
        observation.setEquipmentState(observationDetails.getEquipmentState());
        observation.setSiteClean(observationDetails.getSiteClean());
        observation.setFatigueLevel(observationDetails.getFatigueLevel());
        observation.setMinorIncidents(observationDetails.getMinorIncidents());
        observation.setMajorIncidents(observationDetails.getMajorIncidents());
        observation.setNotes(observationDetails.getNotes());
        observation.setPhotoUrls(observationDetails.getPhotoUrls());
        observation.setAiAnalysis(observationDetails.getAiAnalysis());
        observation.setRiskScore(observationDetails.getRiskScore());
        
        if (observationDetails.getSite() != null && observationDetails.getSite().getId() != null) {
            siteRepository.findById(observationDetails.getSite().getId())
                    .ifPresent(observation::setSite);
        }
        
        return observationRepository.save(observation);
    }
    
    public void deleteObservation(Long id) {
        observationRepository.deleteById(id);
    }
}

