package com.xenmeteo.xenmeteo.repository;

import com.xenmeteo.xenmeteo.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsername(String username);
}