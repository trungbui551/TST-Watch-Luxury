package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.User;
import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);

    Cart findCartById(long id);
}
