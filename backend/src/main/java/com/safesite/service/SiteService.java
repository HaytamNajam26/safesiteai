package com.safesite.service;

import com.safesite.model.Site;
import com.safesite.repository.ProjectRepository;
import com.safesite.repository.SiteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SiteService {
    
    @Autowired
    private SiteRepository siteRepository;
    
    @Autowired
    private ProjectRepository projectRepository;
    
    public List<Site> getAllSites() {
        return siteRepository.findAll();
    }
    
    public List<Site> getSitesByProjectId(Long projectId) {
        return siteRepository.findByProjectId(projectId);
    }
    
    public Optional<Site> getSiteById(Long id) {
        return siteRepository.findById(id);
    }
    
    public Site createSite(Site site) {
        if (site.getProject() != null && site.getProject().getId() != null) {
            projectRepository.findById(site.getProject().getId())
                    .ifPresent(site::setProject);
        }
        return siteRepository.save(site);
    }
    
    public Site updateSite(Long id, Site siteDetails) {
        Site site = siteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Site not found"));
        
        site.setName(siteDetails.getName());
        site.setSiteType(siteDetails.getSiteType());
        site.setDescription(siteDetails.getDescription());
        site.setPhotoUrls(siteDetails.getPhotoUrls());
        site.setRiskScore(siteDetails.getRiskScore());
        
        if (siteDetails.getProject() != null && siteDetails.getProject().getId() != null) {
            projectRepository.findById(siteDetails.getProject().getId())
                    .ifPresent(site::setProject);
        }
        
        return siteRepository.save(site);
    }
    
    public void deleteSite(Long id) {
        siteRepository.deleteById(id);
    }
}

