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
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import jakarta.mail.internet.MimeMessage;
import java.util.Map;
import java.util.HashMap;

import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.Review;
import com.tstwatchluxury.service.ProductService;
import com.tstwatchluxury.service.UserService;
import com.tstwatchluxury.service.SystemSettingService;
import com.tstwatchluxury.service.ReviewService;
import com.tstwatchluxury.service.OrderService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {
    private final ProductService productService;
    private final UserService userService;
    private final SystemSettingService systemSettingService;
    private final JavaMailSender mailSender;
    private final ReviewService reviewService;
    private final OrderService orderService;

    public ItemController(ProductService productService, UserService userService, 
            SystemSettingService systemSettingService, JavaMailSender mailSender,
            ReviewService reviewService, OrderService orderService) {
        this.productService = productService;
        this.userService = userService;
        this.systemSettingService = systemSettingService;
        this.mailSender = mailSender;
        this.reviewService = reviewService;
        this.orderService = orderService;
    }

    @GetMapping("/product/{id}")
    public String GetItemPage(Model model, @PathVariable long id, HttpServletRequest request) {
        Product product = this.productService.getProductById(id);
        if (product == null || !product.isActive()) {
            return "redirect:/";
        }
        List<Product> productList = this.productService.getAllProducts();
        
        // Loại bỏ sản phẩm hiện tại đang xem chi tiết và các sản phẩm đã ẩn khỏi danh sách liên quan
        if (productList != null) {
            productList.removeIf(p -> p.getId() == id || !p.isActive());
            // Giới hạn chỉ lấy tối đa 8 sản phẩm
            if (productList.size() > 8) {
                productList = productList.subList(0, 8);
            }
        }
        
        // Fetch reviews for this product
        List<Review> reviews = this.reviewService.getReviewsByProductId(id);
        model.addAttribute("reviews", reviews);
        
        // Calculate average rating
        double averageRating = 0.0; // Default to 0.0
        int reviewCount = reviews != null ? reviews.size() : 0;
        if (reviewCount > 0) {
            double sum = 0;
            for (Review r : reviews) {
                sum += r.getRating();
            }
            averageRating = sum / reviewCount;
        }
        int roundedRating = (int) Math.round(averageRating);
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("roundedRating", roundedRating);
        model.addAttribute("reviewCount", reviewCount);
        
        // Check if user is logged in to pre-fill their info and check if they purchased this product
        boolean hasPurchased = false;
        String email = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        if (email != null) {
            User currentUser = this.userService.getUserByEmail(email);
            model.addAttribute("currentUser", currentUser);
            hasPurchased = this.orderService.hasUserPurchasedProduct(currentUser, product);
        }
        model.addAttribute("hasPurchased", hasPurchased);
        
        model.addAttribute("pro", product);
        model.addAttribute("pros", productList);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/product/{id}/review")
    public String addProductReview(@PathVariable long id, HttpServletRequest request,
            @RequestParam("rating") int rating,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("content") String content,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl) {
        
        Product product = this.productService.getProductById(id);
        String loggedInEmail = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        
        // Block guest reviews or unauthenticated submissions
        if (loggedInEmail == null) {
            return "redirect:/login";
        }
        
        User currentUser = this.userService.getUserByEmail(loggedInEmail);
        
        // Enforce that only verified buyers can leave a review
        boolean hasPurchased = this.orderService.hasUserPurchasedProduct(currentUser, product);
        if (!hasPurchased) {
            return "redirect:/product/" + id + "?error=not_purchased";
        }
        
        if (product != null) {
            Review review = new Review();
            review.setProduct(product);
            review.setRating(Math.max(1, Math.min(5, rating)));
            review.setContent(content);
            review.setUser(currentUser);
            review.setName(currentUser.getFullName());
            review.setEmail(currentUser.getEmail());
            
            if (redirectUrl != null && redirectUrl.contains("{userId}")) {
                redirectUrl = redirectUrl.replace("{userId}", String.valueOf(currentUser.getId()));
            }
            
            this.reviewService.saveReview(review);
        }
        
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            return "redirect:" + redirectUrl;
        }
        return "redirect:/product/" + id;
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request,
            @RequestParam(value = "size", required = false) String size,
            @RequestParam(value = "color", required = false) String color,
            @RequestParam(value = "quantity", defaultValue = "1") long quantity) {
        String email = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        if (email != null) {
            HttpSession session = request.getSession(true);
            this.productService.handleAddProductToCart(email, id, size, color, quantity, session);
        }
        return "redirect:/";
    }

    @PostMapping("/api/add-to-cart/{id}")
    @ResponseBody
    public Map<String, Object> addProductToCartApi(@PathVariable long id, HttpServletRequest request,
            @RequestParam(value = "size", required = false) String size,
            @RequestParam(value = "color", required = false) String color,
            @RequestParam(value = "quantity", defaultValue = "1") long quantity) {
        Map<String, Object> response = new HashMap<>();
        String email = request.getUserPrincipal() != null ? request.getUserPrincipal().getName() : null;
        if (email == null) {
            response.put("success", false);
            response.put("message", "User not logged in");
            return response;
        }
        
        HttpSession session = request.getSession(true);
        this.productService.handleAddProductToCart(email, id, size, color, quantity, session);
        
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
        
        double originalPrice = totalPrice;
        boolean promoActive = "true".equals(this.systemSettingService.getSettingValue("PROMO_ACTIVE", "false"));
        double promoDiscountPercent = 0;
        if (promoActive) {
            try {
                promoDiscountPercent = Double.parseDouble(this.systemSettingService.getSettingValue("PROMO_DISCOUNT", "10"));
                totalPrice = originalPrice * (1.0 - (promoDiscountPercent / 100.0));
            } catch (Exception e) {
                promoDiscountPercent = 10;
                totalPrice = originalPrice * 0.9;
            }
        }
        
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("originalPrice", originalPrice);
        model.addAttribute("promoActive", promoActive ? "true" : "false");
        model.addAttribute("promoDiscountPercent", promoDiscountPercent);
        
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
        
        double originalPrice = totalPrice;
        boolean promoActive = "true".equals(this.systemSettingService.getSettingValue("PROMO_ACTIVE", "false"));
        double promoDiscountPercent = 0;
        if (promoActive) {
            try {
                promoDiscountPercent = Double.parseDouble(this.systemSettingService.getSettingValue("PROMO_DISCOUNT", "10"));
                totalPrice = originalPrice * (1.0 - (promoDiscountPercent / 100.0));
            } catch (Exception e) {
                promoDiscountPercent = 10;
                totalPrice = originalPrice * 0.9;
            }
        }
        
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("originalPrice", originalPrice);
        model.addAttribute("promoActive", promoActive ? "true" : "false");
        model.addAttribute("promoDiscountPercent", promoDiscountPercent);
        
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
        // Recalculate total price securely on the backend to prevent client-side price tampering
        Cart cart = this.productService.getCartByUser(user);
        double calculatedTotalPrice = 0;
        if (cart != null && cart.getCartDetails() != null) {
            for (CartDetail cd : cart.getCartDetails()) {
                calculatedTotalPrice += cd.getPrice() * cd.getQuantity();
            }
        }
        boolean promoActive = "true".equals(this.systemSettingService.getSettingValue("PROMO_ACTIVE", "false"));
        if (promoActive) {
            try {
                double promoDiscountPercent = Double.parseDouble(this.systemSettingService.getSettingValue("PROMO_DISCOUNT", "10"));
                calculatedTotalPrice = calculatedTotalPrice * (1.0 - (promoDiscountPercent / 100.0));
            } catch (Exception e) {
                calculatedTotalPrice = calculatedTotalPrice * 0.9;
            }
        }
        
        // Save cart details before they are cleared by handlePlaceOrder
        List<CartDetail> cartDetails = new ArrayList<>();
        if (cart != null && cart.getCartDetails() != null) {
            cartDetails.addAll(cart.getCartDetails());
        }
        
        Order order = this.productService.handlePlaceOrder(user, session, receiverName, receiverPhone, receiverAddress, calculatedTotalPrice);
        if (order != null && order.getOrderCode() != null) {
            // Send order confirmation email asynchronously
            final double finalPrice = calculatedTotalPrice;
            final String userEmail = user.getEmail();
            final String orderCode = order.getOrderCode();
            final String recName = receiverName;
            final String recPhone = receiverPhone;
            final String recAddr = receiverAddress;
            
            new Thread(() -> {
                try {
                    sendOrderConfirmationEmail(userEmail, orderCode, recName, recPhone, recAddr, finalPrice, cartDetails);
                } catch (Exception e) {
                    System.err.println("Error sending order confirmation email: " + e.getMessage());
                    e.printStackTrace();
                }
            }).start();
            
            return "redirect:/thanks?orderId=" + order.getOrderCode();
        }
        return "redirect:/thanks";
    }

    private void sendOrderConfirmationEmail(String recipientEmail, String orderCode, String receiverName, 
            String receiverPhone, String receiverAddress, double totalPrice, List<CartDetail> cartDetails) {
        
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setTo(recipientEmail);
            helper.setSubject("[TST Watch Luxury] Xác nhận đặt hàng thành công - Đơn hàng #" + orderCode);
            
            // Build products HTML list
            StringBuilder itemsHtml = new StringBuilder();
            java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
            for (CartDetail cd : cartDetails) {
                double linePrice = cd.getPrice() * cd.getQuantity();
                
                String nameAndOptions = cd.getProduct().getName();
                List<String> options = new ArrayList<>();
                if (cd.getSize() != null && !cd.getSize().isEmpty() && !"Standard".equals(cd.getSize())) {
                    options.add("Size: " + cd.getSize());
                }
                if (cd.getColor() != null && !cd.getColor().isEmpty() && !"Standard".equals(cd.getColor())) {
                    options.add("Màu: " + cd.getColor());
                }
                if (!options.isEmpty()) {
                    nameAndOptions += " (" + String.join(", ", options) + ")";
                }

                itemsHtml.append(String.format(
                    "<tr>" +
                    "<td style='padding: 8px; border-bottom: 1px solid #e2e8f0; color: #0f172a;'>%s</td>" +
                    "<td style='padding: 8px; border-bottom: 1px solid #e2e8f0; color: #0f172a; text-align: center;'>x%d</td>" +
                    "<td style='padding: 8px; border-bottom: 1px solid #e2e8f0; color: #aa7c11; text-align: right;'>%s đ</td>" +
                    "</tr>",
                    nameAndOptions,
                    cd.getQuantity(),
                    df.format(linePrice)
                ));
            }
            
            String formattedTotal = df.format(totalPrice);
            
            String content = String.format(
                "<div style=\"font-family: 'Inter', Arial, sans-serif; max-width: 600px; margin: auto; padding: 30px; border: 1px solid #e2e8f0; border-radius: 12px; background-color: #ffffff; color: #1e293b;\">" +
                "    <div style=\"text-align: center; margin-bottom: 24px;\">" +
                "        <h2 style=\"font-family: 'Playfair Display', Georgia, serif; color: #aa7c11; margin: 0; text-transform: uppercase; letter-spacing: 2px;\">TST Watch Luxury</h2>" +
                "        <p style=\"font-size: 12px; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; margin-top: 4px;\">Kiệt tác thời gian trên tay bạn</p>" +
                "    </div>" +
                "    <hr style=\"border: none; border-top: 1px solid #f1f5f9; margin-bottom: 24px;\"/>" +
                "    <h3 style=\"color: #0f172a; margin-top: 0;\">Xác Nhận Đặt Hàng Thành Công</h3>" +
                "    <p>Kính chào Quý khách,</p>" +
                "    <p>Cảm ơn Quý khách đã tin tưởng và lựa chọn tuyệt tác thời gian tại <strong>TST Watch Luxury</strong>. Đơn hàng của Quý khách đã được tiếp nhận thành công và đang được chuẩn bị để giao nhận đặc quyền.</p>" +
                "    " +
                "    <div style=\"background-color: #f8fafc; border-radius: 8px; padding: 16px; margin: 20px 0; border: 1px solid #f1f5f9;\">" +
                "        <h4 style=\"margin-top: 0; color: #0f172a; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px;\">Thông tin giao nhận</h4>" +
                "        <table style=\"width: 100%; border-collapse: collapse; font-size: 14px;\">" +
                "            <tr>" +
                "                <td style=\"padding: 6px 0; color: #64748b; width: 140px;\">Mã đơn hàng:</td>" +
                "                <td style=\"padding: 6px 0; font-weight: bold; color: #aa7c11;\">#%s</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <td style=\"padding: 6px 0; color: #64748b;\">Người nhận:</td>" +
                "                <td style=\"padding: 6px 0; color: #0f172a;\">%s</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <td style=\"padding: 6px 0; color: #64748b;\">Số điện thoại:</td>" +
                "                <td style=\"padding: 6px 0; color: #0f172a;\">%s</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <td style=\"padding: 6px 0; color: #64748b;\">Địa chỉ giao hàng:</td>" +
                "                <td style=\"padding: 6px 0; color: #0f172a;\">%s</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <td style=\"padding: 6px 0; color: #64748b;\">Phương thức:</td>" +
                "                <td style=\"padding: 6px 0; color: #0f172a;\">Giao hàng COD Đặc Quyền</td>" +
                "            </tr>" +
                "        </table>" +
                "    </div>" +
                "    " +
                "    <div style=\"margin: 20px 0;\">" +
                "        <h4 style=\"color: #0f172a; border-bottom: 1px solid #e2e8f0; padding-bottom: 8px; margin-bottom: 12px;\">Chi tiết tuyệt tác</h4>" +
                "        <table style=\"width: 100%; border-collapse: collapse; font-size: 13px;\">" +
                "            <thead>" +
                "                <tr style=\"background-color: #f8fafc;\">" +
                "                    <th style=\"padding: 8px; text-align: left; color: #475569;\">Sản phẩm</th>" +
                "                    <th style=\"padding: 8px; text-align: center; color: #475569; width: 60px;\">SL</th>" +
                "                    <th style=\"padding: 8px; text-align: right; color: #475569; width: 100px;\">Đơn giá</th>" +
                "                </tr>" +
                "            </thead>" +
                "            <tbody>" +
                "                %s" +
                "            </tbody>" +
                "        </table>" +
                "    </div>" +
                "    " +
                "    <div style=\"margin: 20px 0; text-align: right;\">" +
                "        <span style=\"font-size: 14px; color: #64748b;\">Tổng thanh toán: </span>" +
                "        <span style=\"font-size: 18px; color: #aa7c11; font-weight: bold;\">%s đ</span>" +
                "    </div>" +
                "    " +
                "    <p style=\"font-size: 14px; line-height: 1.6; color: #475569;\">Chúng tôi sẽ liên hệ với Quý khách qua số điện thoại trên để xác nhận thời gian giao hàng trước khi vận chuyển.</p>" +
                "    <hr style=\"border: none; border-top: 1px solid #f1f5f9; margin: 24px 0;\"/>" +
                "    <div style=\"text-align: center; font-size: 12px; color: #94a3b8;\">" +
                "        <p style=\"margin: 0 0 4px 0;\">Đây là email tự động từ hệ thống TST Watch Luxury.</p>" +
                "        <p style=\"margin: 0;\">Hotline hỗ trợ đặc quyền: 1900 xxxx (24/7)</p>" +
                "    </div>" +
                "</div>",
                orderCode,
                receiverName,
                receiverPhone,
                receiverAddress,
                itemsHtml.toString(),
                formattedTotal
            );
            
            helper.setText(content, true);
            mailSender.send(mimeMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/thanks")
    public String getThanksPage() {
        return "client/cart/thanks";
    }
}
