package com.tstwatchluxury.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.AnonymousAuthenticationToken;

import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.service.SystemSettingService;
import com.tstwatchluxury.service.UserService;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class GlobalControllerAdvice {

    private final SystemSettingService systemSettingService;
    private final UserService userService;

    public GlobalControllerAdvice(SystemSettingService systemSettingService, UserService userService) {
        this.systemSettingService = systemSettingService;
        this.userService = userService;
    }

    @ModelAttribute
    public void addGlobalAttributes(Model model, HttpSession session) {
        // Banner Settings
        model.addAttribute("bannerBadge", systemSettingService.getSettingValue("BANNER_BADGE", "Heritage Collection"));
        model.addAttribute("bannerTitle", systemSettingService.getSettingValue("BANNER_TITLE", "Kiệt tác thời gian<br/>đeo trên tay"));
        model.addAttribute("bannerSubtitle", systemSettingService.getSettingValue("BANNER_SUBTITLE", "Nơi hội tụ những tuyệt tác đồng hồ cơ khí tinh xảo nhất thế giới. Tinh tế trong từng chuyển động, khẳng định đẳng cấp và phong thái người dẫn đầu."));
        model.addAttribute("bannerButtonText", systemSettingService.getSettingValue("BANNER_BUTTON_TEXT", "Khám phá bộ sưu tập"));
        model.addAttribute("bannerImageUrl", systemSettingService.getSettingValue("BANNER_IMAGE_URL", "/resources/client/images/luxury_watch_banner.png"));

        // Discount Settings
        model.addAttribute("promoActive", systemSettingService.getSettingValue("PROMO_ACTIVE", "false"));
        model.addAttribute("promoText", systemSettingService.getSettingValue("PROMO_TEXT", "SIÊU SALE MÙA HÈ - GIẢM NGAY 10% CHO TẤT CẢ ĐƠN HÀNG HÔM NAY!"));
        model.addAttribute("promoDiscount", systemSettingService.getSettingValue("PROMO_DISCOUNT", "10"));

        // Auto-initialize session attributes if the user is authenticated but the session attributes are missing (e.g. Remember Me)
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
            if (session.getAttribute("id") == null) {
                String email = auth.getName();
                User user = this.userService.getUserByEmail(email);
                if (user != null) {
                    session.setAttribute("fullname", user.getFullName());
                    session.setAttribute("images", user.getAvatar());
                    session.setAttribute("email", user.getEmail());
                    session.setAttribute("id", user.getId());
                    if (user.getRole() != null) {
                        session.setAttribute("role", user.getRole().getName());
                    }
                    int sum = user.getCart() == null ? 0 : user.getCart().getSum();
                    session.setAttribute("sum", sum);
                }
            }
        }
    }
}
