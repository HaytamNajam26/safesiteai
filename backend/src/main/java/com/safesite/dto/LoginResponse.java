package com.safesite.dto;

import com.safesite.model.User;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginResponse {
    private String token;
    private String email;
    private User.UserRole role;
    private Long userId;
    private String firstName;
    private String lastName;
}

