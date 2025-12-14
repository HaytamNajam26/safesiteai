package com.safesite.service;

import com.safesite.model.Report;
import com.safesite.repository.ProjectRepository;
import com.safesite.repository.ReportRepository;
import com.safesite.repository.SiteRepository;
import com.safesite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReportService {
    
    @Autowired
    private ReportRepository reportRepository;
    
    @Autowired
    private ProjectRepository projectRepository;
    
    @Autowired
    private SiteRepository siteRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    public List<Report> getAllReports() {
        return reportRepository.findAll();
    }
    
    public List<Report> getReportsByProjectId(Long projectId) {
        return reportRepository.findByProjectId(projectId);
    }
    
    public List<Report> getReportsBySiteId(Long siteId) {
        return reportRepository.findBySiteId(siteId);
    }
    
    public List<Report> getReportsByUserId(Long userId) {
        return reportRepository.findByCreatedById(userId);
    }
    
    public Optional<Report> getReportById(Long id) {
        return reportRepository.findById(id);
    }
    
    public Report createReport(Report report, Long createdById) {
        if (report.getProject() != null && report.getProject().getId() != null) {
            projectRepository.findById(report.getProject().getId())
                    .ifPresent(report::setProject);
        }
        
        if (report.getSite() != null && report.getSite().getId() != null) {
            siteRepository.findById(report.getSite().getId())
                    .ifPresent(report::setSite);
        }
        
        if (createdById != null) {
            userRepository.findById(createdById)
                    .ifPresent(report::setCreatedBy);
        }
        
        return reportRepository.save(report);
    }
    
    public Report updateReport(Long id, Report reportDetails) {
        Report report = reportRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Report not found"));
        
        report.setTitle(reportDetails.getTitle());
        report.setContent(reportDetails.getContent());
        report.setReportType(reportDetails.getReportType());
        report.setReportDate(reportDetails.getReportDate());
        report.setFileUrl(reportDetails.getFileUrl());
        
        if (reportDetails.getProject() != null && reportDetails.getProject().getId() != null) {
            projectRepository.findById(reportDetails.getProject().getId())
                    .ifPresent(report::setProject);
        }
        
        if (reportDetails.getSite() != null && reportDetails.getSite().getId() != null) {
            siteRepository.findById(reportDetails.getSite().getId())
                    .ifPresent(report::setSite);
        }
        
        return reportRepository.save(report);
    }
    
    public void deleteReport(Long id) {
        reportRepository.deleteById(id);
    }
}

