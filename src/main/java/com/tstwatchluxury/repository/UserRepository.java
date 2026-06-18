package com.tstwatchluxury.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import com.tstwatchluxury.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User eric);

    User findById(long id);

    List<User> findByEmail(String email);

    boolean existsByEmail(String email);

    User findOneByEmail(String email);
}
