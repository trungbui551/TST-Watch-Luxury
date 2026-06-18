package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.OrderDetail;
import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    List<OrderDetail> findByOrder(Order order);

    void delete(OrderDetail entity);

    @Query("SELECT od.product.factory, SUM(od.quantity * od.price) " +
           "FROM OrderDetail od " +
           "GROUP BY od.product.factory")
    List<Object[]> getRevenueByFactory();

    List<OrderDetail> findByProductIdOrderByOrderOrderDateDesc(long productId);

}
