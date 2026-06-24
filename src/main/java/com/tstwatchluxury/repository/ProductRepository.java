package com.tstwatchluxury.repository;

import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.tstwatchluxury.domain.Product;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Product save(Product product);

    List<Product> findByNameContainingIgnoreCase(String keyword);

    Product findById(long id);

    @Query("SELECT p FROM Product p WHERE " +
           "p.active = true AND " +
           "(:factory IS NULL OR p.factory = :factory) AND " +
           "(:target IS NULL OR p.target = :target) AND " +
           "(:minPrice IS NULL OR p.price >= :minPrice) AND " +
           "(:maxPrice IS NULL OR p.price <= :maxPrice) AND " +
           "(:keyword IS NULL OR LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(p.shortDesc) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    Page<Product> filterProducts(
        @Param("factory") String factory,
        @Param("target") String target,
        @Param("minPrice") Double minPrice,
        @Param("maxPrice") Double maxPrice,
        @Param("keyword") String keyword,
        Pageable pageable
    );
}
