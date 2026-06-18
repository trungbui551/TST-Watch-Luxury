package com.tstwatchluxury.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.OrderDetail;
import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.repository.CartDetailRepository;
import com.tstwatchluxury.repository.CartRepository;
import com.tstwatchluxury.repository.OrderDetailRepository;
import com.tstwatchluxury.repository.OrderRepository;
import com.tstwatchluxury.repository.ProductRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product handleSaveProduct(Product product) {
        Product newProduct = this.productRepository.save(product);
        return newProduct;
    }

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

    public Product getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void handleAddProductToCart(String email, Long proId, HttpSession session) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            // check user da co cart hay chua
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                // tao moi card
                Cart meCart = new Cart();
                meCart.setId(proId);
                meCart.setUser(user);
                meCart.setSum(0);
                cart = this.cartRepository.save(meCart);

            }

            // save card detail

            // Find productById
            Optional<Product> productOp = this.productRepository.findById(proId);
            if (productOp.isPresent()) {
                Product product = productOp.get();
                // check san pham da tung duoc them vao gio hang day hay chua
                CartDetail oldCartDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);
                if (oldCartDetail == null) {
                    oldCartDetail = new CartDetail();
                    oldCartDetail.setCart(cart);
                    oldCartDetail.setProduct(product);
                    oldCartDetail.setPrice(product.getPrice());
                    oldCartDetail.setQuantity(1);
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    this.cartDetailRepository.save(oldCartDetail);
                    session.setAttribute("sum", s);
                } else {
                    oldCartDetail.setQuantity(oldCartDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldCartDetail);
                }

            }

        }
    }

    public Cart getCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public List<CartDetail> getCartDetailsByCart(Cart cart) {
        return this.cartDetailRepository.findByCart(cart);
    }

    public Cart getCartById(long id) {
        return this.cartRepository.findCartById(id);
    }

    public void deleteCard(Cart cart) {
        this.cartRepository.delete(cart);
    }

    public void deleteCardDetail(CartDetail cartDetail) {
        this.cartDetailRepository.delete(cartDetail);
    }

    public Cart saveCart(Cart cart) {
        return this.cartRepository.save(cart);
    }

    public CartDetail getCartDetailById(long id) {
        return this.cartDetailRepository.findById(id);
    }

    public void HandleCartUpdateBeforeCheckout(List<CartDetail> cartDetails) {
        if (cartDetails == null) {
            return;
        }
        for (CartDetail cartDetail : cartDetails) {
            CartDetail cDetail = this.cartDetailRepository.findById(cartDetail.getId());
            if (cDetail != null) {
                cDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(cDetail);
            }
        }
    }

    public Order handlePlaceOrder(User user, HttpSession session, String receriverName, String receiverPhone,
            String receiverAddress, Double totalPrice) {

        Order order = null;
        // creat order detail
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> list = cart.getCartDetails();
            if (list != null) {
                // Create order

                order = new Order();
                order.setUser(user);
                LocalDateTime timeOder = (LocalDateTime) session.getAttribute("timeOrder");
                order.setOrderDate(timeOder);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverName(receriverName);
                order.setReceiverPhone(receiverPhone);
                order.setTotalPrice(totalPrice);
                order.setStatus("PENDING");
                
                String uuidPart = java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase();
                order.setOrderCode("ORD-" + uuidPart);

                order = this.orderRepository.save(order);
                for (CartDetail cartDetail : list) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setPrice(cartDetail.getPrice());
                    orderDetail.setQuantity(cartDetail.getQuantity());
                    Product product = orderDetail.getProduct();
                    product.setSold(product.getSold() + orderDetail.getQuantity());
                    long newQty = product.getQuantity() - orderDetail.getQuantity();
                    product.setQuantity(newQty < 0 ? 0 : newQty);
                    this.productRepository.save(product);
                    this.orderDetailRepository.save(orderDetail);
                }
                // Xóa cart và cart detail
                for (CartDetail cd : list) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                this.cartRepository.delete(cart);
            }
        }
        // update session
        session.setAttribute("sum", 0);
        return order;
    }

    public Page<Product> getALL(Integer pageNo) {
        Pageable pageable = PageRequest.of(pageNo - 1, 8);
        return this.productRepository.findAll(pageable);
    }

    public Page<Product> searchProduct(String keyword, Integer pageNo) {
        List<Product> list = this.productRepository.findByNameContainingIgnoreCase(keyword);
        Pageable pageable = PageRequest.of(pageNo - 1, 8);
        Integer start = (int) pageable.getOffset();
        Integer end = (int) ((pageable.getOffset() + pageable.getPageSize()) > list.size() ? list.size()
                : (pageable.getOffset() + pageable.getPageSize()));
        list = list.subList(start, end);
        return new PageImpl<Product>(list, pageable,
                this.productRepository.findByNameContainingIgnoreCase(keyword).size());
    }

    public Page<Product> getFilteredProducts(String factory, String target, String priceRange, String keyword, String sortOption, Integer pageNo) {
        Sort sort = Sort.unsorted();
        
        // Handle sorting options
        if ("priceAsc".equals(sortOption)) {
            sort = Sort.by(Sort.Direction.ASC, "price");
        } else if ("priceDesc".equals(sortOption)) {
            sort = Sort.by(Sort.Direction.DESC, "price");
        } else if ("nameAsc".equals(sortOption)) {
            sort = Sort.by(Sort.Direction.ASC, "name");
        } else if ("nameDesc".equals(sortOption)) {
            sort = Sort.by(Sort.Direction.DESC, "name");
        }
        
        Pageable pageable = PageRequest.of(pageNo - 1, 8, sort);
        
        // Standardize optional nullable parameters
        String fact = ("all".equals(factory) || factory == null || factory.trim().isEmpty()) ? null : factory.trim();
        String targ = ("all".equals(target) || target == null || target.trim().isEmpty()) ? null : target.trim();
        String kw = (keyword == null || keyword.trim().isEmpty()) ? null : keyword.trim();
        
        Double minPrice = null;
        Double maxPrice = null;
        
        if ("under10".equals(priceRange)) {
            maxPrice = 10000000.0;
        } else if ("10to15".equals(priceRange)) {
            minPrice = 10000000.0;
            maxPrice = 15000000.0;
        } else if ("15to20".equals(priceRange)) {
            minPrice = 15000000.0;
            maxPrice = 20000000.0;
        } else if ("over20".equals(priceRange)) {
            minPrice = 20000000.0;
        }

        return this.productRepository.filterProducts(fact, targ, minPrice, maxPrice, kw, pageable);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }
}
