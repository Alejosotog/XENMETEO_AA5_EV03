package com.xenmeteo.xenmeteo.controller;

import com.xenmeteo.xenmeteo.model.User;
import com.xenmeteo.xenmeteo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    // Registro
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody User user) {

        userRepository.save(user);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body("Usuario registrado correctamente");
    }

    // Login
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody User request) {

        Optional<User> user = userRepository.findByUsername(request.getUsername());

        if (user.isPresent() && user.get().getPassword().equals(request.getPassword())) {
            return ResponseEntity.ok("Autenticación satisfactoria");
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("Error en la autenticación");
    }
}