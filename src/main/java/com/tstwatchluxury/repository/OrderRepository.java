package com.tstwatchluxury.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.User;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Order findById(long id);

    List<Order> findByUser(User user);

    @Query("SELECT MONTH(o.orderDate) as m, YEAR(o.orderDate) as y, SUM(o.totalPrice) FROM Order o GROUP BY YEAR(o.orderDate), MONTH(o.orderDate) ORDER BY YEAR(o.orderDate), MONTH(o.orderDate)")
    List<Object[]> getRevenueByMonth();

    @Query("SELECT DAY(o.orderDate) as d, MONTH(o.orderDate) as m, YEAR(o.orderDate) as y, SUM(o.totalPrice) FROM Order o GROUP BY YEAR(o.orderDate), MONTH(o.orderDate), DAY(o.orderDate) ORDER BY YEAR(o.orderDate), MONTH(o.orderDate), DAY(o.orderDate)")
    List<Object[]> getRevenueByDay();

    List<Order> findAllByOrderByOrderDateDesc();

    List<Order> findByOrderCodeContainingIgnoreCaseOrderByOrderDateDesc(String orderCode);
}
