package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VerificationToken;

public interface VerificationTokenRepository
        extends JpaRepository<VerificationToken, Long> {

    VerificationToken findByToken(String token);

    VerificationToken findByUser(User user);
}
