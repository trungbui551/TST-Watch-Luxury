package com.tstwatchluxury.controller.client;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.Map;
import java.util.HashMap;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.service.ProductService;
import com.tstwatchluxury.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {
    private final ProductService productService;
    private final UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String GetItemPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id);
        List<Product> productList = this.productService.getAllProducts();
        
        // Loại bỏ sản phẩm hiện tại đang xem chi tiết khỏi danh sách liên quan
        if (productList != null) {
            productList.removeIf(p -> p.getId() == id);
            // Giới hạn chỉ lấy tối đa 8 sản phẩm
            if (productList.size() > 8) {
                productList = productList.subList(0, 8);
            }
        }
        
        model.addAttribute("pro", product);
        model.addAttribute("pros", productList);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        String email = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        if (email != null) {
            HttpSession session = request.getSession(true);
            this.productService.handleAddProductToCart(email, id, session);
        }
        return "redirect:/";
    }

    @PostMapping("/api/add-to-cart/{id}")
    @ResponseBody
    public Map<String, Object> addProductToCartApi(@PathVariable long id, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        String email = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        if (email == null) {
            response.put("success", false);
            response.put("message", "User not logged in");
            return response;
        }
        
        HttpSession session = request.getSession(true);
        this.productService.handleAddProductToCart(email, id, session);
        
        // Retrieve the updated sum from session
        Object sumObj = session.getAttribute("sum");
        int sum = (sumObj instanceof Number) ? ((Number) sumObj).intValue() : 0;
        response.put("success", true);
        response.put("newSum", sum);
        return response;
    }

    @GetMapping("/cart")
    public String getCartDetail(Model model, HttpSession session) {
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        Cart cart = this.productService.getCartByUser(user);
        List<CartDetail> listCart = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0;

        for (CartDetail cartDetail : listCart) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetail", listCart);
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-detail/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartdt_id = id;
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        CartDetail cartDetail = this.productService.getCartDetailById(cartdt_id);
        Cart cart = this.productService.getCartByUser(user);
        if (cart != null) {
            this.productService.deleteCardDetail(cartDetail);

            int newSum = cart.getSum() - 1;
            if (newSum <= 0) {
                this.productService.deleteCard(cart);
                session.setAttribute("sum", 0);
            } else {
                cart.setSum(newSum);
                this.productService.saveCart(cart);
                session.setAttribute("sum", newSum);
            }
        }

        return "redirect:/cart";
    }

    // Khi bấm vào nút check out
    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? null : cart.getCartDetails();
        if (cartDetails == null || cartDetails.isEmpty()) {
            return "redirect:/cart";
        }
        // Update số lượng
        this.productService.HandleCartUpdateBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    // Render ra giao diện checkout (form)
    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        Cart cart = this.productService.getCartByUser(currentUser);
        List<CartDetail> listCart = cart == null ? null : cart.getCartDetails();
        
        if (listCart == null || listCart.isEmpty()) {
            return "redirect:/cart";
        }
        
        double totalPrice = 0;
        for (CartDetail cartDetail : listCart) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cartDetail", listCart);
        model.addAttribute("cart", cart);
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("totalPrice") double totalPrice) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = this.userService.getUserByEmail(email);
        long id = (long) session.getAttribute("id");
        LocalDateTime time = LocalDateTime.now();
        session.setAttribute("timeOrder", time);
        user.setId(id);
        Order order = this.productService.handlePlaceOrder(user, session, receiverName, receiverPhone, receiverAddress, totalPrice);
        if (order != null && order.getOrderCode() != null) {
            return "redirect:/thanks?orderId=" + order.getOrderCode();
        }
        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThanksPage() {
        return "client/cart/thanks";
    }
}
