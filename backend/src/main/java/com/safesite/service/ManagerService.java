package com.safesite.service;

import com.safesite.model.Manager;
import com.safesite.repository.ManagerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ManagerService {
    
    @Autowired
    private ManagerRepository managerRepository;
    
    public List<Manager> getAllManagers() {
        return managerRepository.findAll();
    }
    
    public Optional<Manager> getManagerById(Long id) {
        return managerRepository.findById(id);
    }
    
    public Manager createManager(Manager manager) {
        return managerRepository.save(manager);
    }
    
    public Manager updateManager(Long id, Manager managerDetails) {
        Manager manager = managerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Manager not found"));
        
        manager.setFirstName(managerDetails.getFirstName());
        manager.setLastName(managerDetails.getLastName());
        manager.setEmail(managerDetails.getEmail());
        manager.setPhone(managerDetails.getPhone());
        manager.setDepartment(managerDetails.getDepartment());
        
        return managerRepository.save(manager);
    }
    
    public void deleteManager(Long id) {
        managerRepository.deleteById(id);
    }
}

