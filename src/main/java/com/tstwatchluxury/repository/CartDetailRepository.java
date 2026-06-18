package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.domain.Product;
import java.util.List;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findById(long id);

    List<CartDetail> findByCart(Cart cart);

    CartDetail findByCartAndProduct(Cart cart, Product product);
}
