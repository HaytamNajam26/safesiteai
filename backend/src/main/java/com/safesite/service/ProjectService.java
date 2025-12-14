package com.safesite.service;

import com.safesite.model.Project;
import com.safesite.repository.ManagerRepository;
import com.safesite.repository.ProjectRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProjectService {
    
    @Autowired
    private ProjectRepository projectRepository;
    
    @Autowired
    private ManagerRepository managerRepository;
    
    public List<Project> getAllProjects() {
        return projectRepository.findAll();
    }
    
    public Optional<Project> getProjectById(Long id) {
        return projectRepository.findById(id);
    }
    
    public Project createProject(Project project) {
        if (project.getManager() != null && project.getManager().getId() != null) {
            managerRepository.findById(project.getManager().getId())
                    .ifPresent(project::setManager);
        }
        return projectRepository.save(project);
    }
    
    public Project updateProject(Long id, Project projectDetails) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));
        
        project.setName(projectDetails.getName());
        project.setLocation(projectDetails.getLocation());
        project.setDescription(projectDetails.getDescription());
        project.setStartDate(projectDetails.getStartDate());
        project.setEndDate(projectDetails.getEndDate());
        project.setEstimatedSitesCount(projectDetails.getEstimatedSitesCount());
        
        if (projectDetails.getManager() != null && projectDetails.getManager().getId() != null) {
            managerRepository.findById(projectDetails.getManager().getId())
                    .ifPresent(project::setManager);
        }
        
        return projectRepository.save(project);
    }
    
    public void deleteProject(Long id) {
        projectRepository.deleteById(id);
    }
}

