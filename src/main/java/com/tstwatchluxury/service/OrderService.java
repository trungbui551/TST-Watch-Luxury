package com.tstwatchluxury.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.OrderDetail;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.repository.OrderDetailRepository;
import com.tstwatchluxury.repository.OrderRepository;
import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.repository.ProductRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    public OrderService(OrderRepository orderRepository, 
                        OrderDetailRepository orderDetailRepository,
                        ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;
    }

    public List<Order> getAllOrders() {
        return this.orderRepository.findAll();
    }

    public List<OrderDetail> getOrderDetails(Order order) {
        return this.orderDetailRepository.findByOrder(order);
    }

    public Order getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void deleteOrder(long id) {
        Order order = this.orderRepository.findById(id);
        List<OrderDetail> orderDetail = this.orderDetailRepository.findByOrder(order);

        if (orderDetail != null) {
            for (OrderDetail orderDetail2 : orderDetail) {
                if (orderDetail2 != null) {
                    this.orderDetailRepository.delete(orderDetail2);
                }
            }
        }
        this.orderRepository.delete(order);
    }

    public List<Order> getOrderListByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    public List<Object[]> getRevenueByMonth() {
        List<Object[]> data = this.orderRepository.getRevenueByMonth();
        List<Object[]> result = new ArrayList<>();

        for (Object[] objects : data) {
            Number yearNum = (Number) objects[1];
            Number monthNum = (Number) objects[0];
            Number revenue = (Number) objects[2]; // có thể là Double hoặc BigDecimal
            if (monthNum == null || yearNum == null || revenue == null) {
                System.out.println("Skipping NULL record");
                continue;
            }
            int year = yearNum != null ? yearNum.intValue() : 0;
            int month = monthNum != null ? monthNum.intValue() : 0;
            double total = revenue != null ? revenue.doubleValue() : 0.0;
            String lable = "Tháng " + month + "/" + year;
            result.add(new Object[] { lable, total });
        }
        return result;
    }

    public List<Order> getListOrderForDashBoard() {
        return this.orderRepository.findAllByOrderByOrderDateDesc();
    }

    public List<Object[]> getRevenueByFactory() {
        // Dynamic self-heal loop: scan and fix products with legacy/incorrect factories (like Apple, Asus)
        List<Product> products = this.productRepository.findAll();
        for (Product p : products) {
            String nameLower = p.getName() != null ? p.getName().toLowerCase() : "";
            String shortDescLower = p.getShortDesc() != null ? p.getShortDesc().toLowerCase() : "";
            String detailDescLower = p.getDetailDesc() != null ? p.getDetailDesc().toLowerCase() : "";
            String currentFactory = p.getFactory();
            String correctFactory = null;
            
            // Check text fields for watch brands
            if (nameLower.contains("rolex") || shortDescLower.contains("rolex") || detailDescLower.contains("rolex")) {
                correctFactory = "Rolex";
            } else if (nameLower.contains("hublot") || shortDescLower.contains("hublot") || detailDescLower.contains("hublot")) {
                correctFactory = "Hublot";
            } else if (nameLower.contains("cartier") || shortDescLower.contains("cartier") || detailDescLower.contains("cartier")) {
                correctFactory = "Cartier";
            } else if (nameLower.contains("casio") || shortDescLower.contains("casio") || detailDescLower.contains("casio")) {
                correctFactory = "Casio";
            } else if (nameLower.contains("tissot") || shortDescLower.contains("tissot") || detailDescLower.contains("tissot")) {
                correctFactory = "Tissot";
            } else if (nameLower.contains("omega") || shortDescLower.contains("omega") || detailDescLower.contains("omega")) {
                correctFactory = "Omega";
            } else if (nameLower.contains("longines") || shortDescLower.contains("longines") || detailDescLower.contains("longines")) {
                correctFactory = "Longines";
            } else if (nameLower.contains("seiko") || shortDescLower.contains("seiko") || detailDescLower.contains("seiko")) {
                correctFactory = "Seiko";
            } else if (nameLower.contains("patek") || shortDescLower.contains("patek") || detailDescLower.contains("patek")) {
                correctFactory = "Patek Philippe";
            } else if (nameLower.contains("orient") || shortDescLower.contains("orient") || detailDescLower.contains("orient")) {
                correctFactory = "Orient";
            } else if (nameLower.contains("citizen") || shortDescLower.contains("citizen") || detailDescLower.contains("citizen")) {
                correctFactory = "Citizen";
            }
            
            boolean isLegacy = currentFactory == null || 
                               currentFactory.equalsIgnoreCase("Apple") || 
                               currentFactory.equalsIgnoreCase("ASUS") || 
                               currentFactory.equalsIgnoreCase("Dell") || 
                               currentFactory.equalsIgnoreCase("HP") || 
                               currentFactory.equalsIgnoreCase("Lenovo") || 
                               currentFactory.equalsIgnoreCase("Acer");
            
            if (correctFactory != null) {
                if (!correctFactory.equalsIgnoreCase(currentFactory)) {
                    System.out.println(">>> Dynamic self-heal: updating product [" + p.getName() + "] factory from [" + currentFactory + "] to [" + correctFactory + "]");
                    p.setFactory(correctFactory);
                    this.productRepository.save(p);
                }
            } else if (isLegacy) {
                // Try to match based on image name fallback
                String imgLower = p.getImage() != null ? p.getImage().toLowerCase() : "";
                if (imgLower.contains("rolex")) {
                    correctFactory = "Rolex";
                } else if (imgLower.contains("hublot")) {
                    correctFactory = "Hublot";
                } else if (imgLower.contains("cartier")) {
                    correctFactory = "Cartier";
                } else if (imgLower.contains("casio")) {
                    correctFactory = "Casio";
                } else if (imgLower.contains("tissot")) {
                    correctFactory = "Tissot";
                } else if (imgLower.contains("omega")) {
                    correctFactory = "Omega";
                } else if (imgLower.contains("longines")) {
                    correctFactory = "Longines";
                } else if (imgLower.contains("seiko")) {
                    correctFactory = "Seiko";
                } else if (imgLower.contains("patek")) {
                    correctFactory = "Patek Philippe";
                } else if (imgLower.contains("orient")) {
                    correctFactory = "Orient";
                } else if (imgLower.contains("citizen")) {
                    correctFactory = "Citizen";
                } else {
                    correctFactory = "Rolex"; // default fallback
                }
                System.out.println(">>> Dynamic self-heal fallback: updating legacy factory [" + currentFactory + "] of product [" + p.getName() + "] to [" + correctFactory + "]");
                p.setFactory(correctFactory);
                this.productRepository.save(p);
            }
        }
        return this.orderDetailRepository.getRevenueByFactory();
    }

    public List<Order> getOrdersBySearch(String search) {
        if (search == null || search.trim().isEmpty()) {
            return this.orderRepository.findAllByOrderByOrderDateDesc();
        }
        return this.orderRepository.findByOrderCodeContainingIgnoreCaseOrderByOrderDateDesc(search.trim());
    }

    public void updateOrder(Order order) {
        Order currentOrder = this.getOrderById(order.getId());
        if (currentOrder != null) {
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

}
