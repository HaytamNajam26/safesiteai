package com.safesite.config;

import com.safesite.model.User;
import com.safesite.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Override
    public void run(String... args) throws Exception {
        // Create Admin user if not exists
        if (!userRepository.existsByEmail("admin@safesite.ai")) {
            User admin = new User();
            admin.setEmail("admin@safesite.ai");
            admin.setPassword(passwordEncoder.encode("admin123")); // Change this in production
            admin.setRole(User.UserRole.ADMIN);
            admin.setFirstName("Admin");
            admin.setLastName("SafeSite");
            userRepository.save(admin);
            System.out.println("Admin user created: admin@safesite.ai");
        }
        
        // Create Chef user if not exists
        if (!userRepository.existsByEmail("chef@safesite.ai")) {
            User chef = new User();
            chef.setEmail("chef@safesite.ai");
            chef.setPassword(passwordEncoder.encode("chef123")); // Change this in production
            chef.setRole(User.UserRole.CHEF);
            chef.setFirstName("Chef");
            chef.setLastName("Chantier");
            userRepository.save(chef);
            System.out.println("Chef user created: chef@safesite.ai");
        }
    }
}

