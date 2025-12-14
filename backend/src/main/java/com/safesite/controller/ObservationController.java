package com.safesite.controller;

import com.safesite.model.Observation;
import com.safesite.service.ObservationService;
import com.safesite.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/observations")
@CrossOrigin(origins = "*")
public class ObservationController {
    
    @Autowired
    private ObservationService observationService;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    private Long getUserIdFromRequest(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            return jwtUtil.extractUserId(token);
        }
        return null;
    }
    
    @GetMapping
    public ResponseEntity<List<Observation>> getAllObservations() {
        return ResponseEntity.ok(observationService.getAllObservations());
    }
    
    @GetMapping("/site/{siteId}")
    public ResponseEntity<List<Observation>> getObservationsBySite(@PathVariable Long siteId) {
        return ResponseEntity.ok(observationService.getObservationsBySiteId(siteId));
    }
    
    @GetMapping("/user")
    public ResponseEntity<List<Observation>> getObservationsByUser(HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        if (userId == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(observationService.getObservationsByUserId(userId));
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<Observation> getObservationById(@PathVariable Long id) {
        return observationService.getObservationById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public ResponseEntity<Observation> createObservation(@RequestBody Observation observation, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        return ResponseEntity.ok(observationService.createObservation(observation, userId));
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<Observation> updateObservation(@PathVariable Long id, @RequestBody Observation observation) {
        return ResponseEntity.ok(observationService.updateObservation(id, observation));
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteObservation(@PathVariable Long id) {
        observationService.deleteObservation(id);
        return ResponseEntity.noContent().build();
    }
}

