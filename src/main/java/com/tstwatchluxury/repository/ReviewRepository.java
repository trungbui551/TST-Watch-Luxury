package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.tstwatchluxury.domain.Review;
import com.tstwatchluxury.domain.User;
import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByProductIdOrderByCreatedAtDesc(long productId);

    @Modifying
    @Query("update Review r set r.user = null where r.user = :user")
    void disassociateUser(@Param("user") User user);
}
