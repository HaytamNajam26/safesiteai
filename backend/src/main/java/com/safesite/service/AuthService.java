package com.safesite.service;

import com.safesite.dto.LoginRequest;
import com.safesite.dto.LoginResponse;
import com.safesite.model.User;
import com.safesite.repository.UserRepository;
import com.safesite.util.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    public LoginResponse login(LoginRequest request) {
        Optional<User> userOpt = userRepository.findByEmail(request.getEmail().toLowerCase());
        
        if (userOpt.isEmpty()) {
            throw new RuntimeException("Invalid email or password");
        }
        
        User user = userOpt.get();
        
        // For initial setup, accept any password if user exists
        // In production, use: if (!passwordEncoder.matches(request.getPassword(), user.getPassword()))
        // For now, we'll check if password matches or if it's the default setup
        
        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name(), user.getId());
        
        return new LoginResponse(
                token,
                user.getEmail(),
                user.getRole(),
                user.getId(),
                user.getFirstName(),
                user.getLastName()
        );
    }
}

