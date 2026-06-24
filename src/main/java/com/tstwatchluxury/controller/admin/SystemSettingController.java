package com.tstwatchluxury.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletContext;

import com.tstwatchluxury.service.UploadService;
import com.tstwatchluxury.service.SystemSettingService;

@Controller
public class SystemSettingController {

    private final SystemSettingService systemSettingService;
    private final UploadService uploadService;
    private final ServletContext servletContext;

    public SystemSettingController(SystemSettingService systemSettingService, UploadService uploadService, ServletContext servletContext) {
        this.systemSettingService = systemSettingService;
        this.uploadService = uploadService;
        this.servletContext = servletContext;
    }

    @GetMapping("/admin/settings")
    public String getSettingsPage(Model model) {
        // Email Settings
        model.addAttribute("emailHost", systemSettingService.getSettingValue("EMAIL_HOST", "smtp.gmail.com"));
        model.addAttribute("emailPort", systemSettingService.getSettingValue("EMAIL_PORT", "587"));
        model.addAttribute("emailUsername", systemSettingService.getSettingValue("EMAIL_USERNAME", ""));
        model.addAttribute("emailPassword", systemSettingService.getSettingValue("EMAIL_PASSWORD", ""));
        model.addAttribute("emailSmtpAuth", systemSettingService.getSettingValue("EMAIL_SMTP_AUTH", "true"));
        model.addAttribute("emailStarttlsEnable", systemSettingService.getSettingValue("EMAIL_STARTTLS_ENABLE", "true"));

        // Promotion Settings
        model.addAttribute("promoActive", systemSettingService.getSettingValue("PROMO_ACTIVE", "false"));
        model.addAttribute("promoText", systemSettingService.getSettingValue("PROMO_TEXT", "SIÊU SALE MÙA HÈ - GIẢM NGAY 10% CHO TẤT CẢ ĐƠN HÀNG HÔM NAY!"));
        model.addAttribute("promoDiscount", systemSettingService.getSettingValue("PROMO_DISCOUNT", "10"));

        // Banner Settings
        model.addAttribute("bannerBadge", systemSettingService.getSettingValue("BANNER_BADGE", "Heritage Collection"));
        model.addAttribute("bannerTitle", systemSettingService.getSettingValue("BANNER_TITLE", "Kiệt tác thời gian<br/>đeo trên tay"));
        model.addAttribute("bannerSubtitle", systemSettingService.getSettingValue("BANNER_SUBTITLE", "Nơi hội tụ những tuyệt tác đồng hồ cơ khí tinh xảo nhất thế giới. Tinh tế trong từng chuyển động, khẳng định đẳng cấp và phong thái người dẫn đầu."));
        model.addAttribute("bannerButtonText", systemSettingService.getSettingValue("BANNER_BUTTON_TEXT", "Khám phá bộ sưu tập"));
        
        String bannerImageUrl = systemSettingService.getSettingValue("BANNER_IMAGE_URL", "/resources/client/images/luxury_watch_banner.png");
        model.addAttribute("bannerImageUrl", bannerImageUrl);

        // Scan folder phát triển & context runtime để lấy các ảnh nền đã từng sử dụng
        List<String> pastBanners = new ArrayList<>();
        pastBanners.add("/resources/client/images/luxury_watch_banner.png");

        String userDir = System.getProperty("user.dir");
        if (userDir != null) {
            File devBannerDir = new File(userDir + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "resources" + File.separator + "images" + File.separator + "banner");
            if (devBannerDir.exists() && devBannerDir.isDirectory()) {
                File[] files = devBannerDir.listFiles();
                if (files != null) {
                    for (File file : files) {
                        if (file.isFile() && (file.getName().endsWith(".png") || file.getName().endsWith(".jpg") || file.getName().endsWith(".jpeg") || file.getName().endsWith(".webp"))) {
                            String url = "/images/banner/" + file.getName();
                            if (!pastBanners.contains(url)) {
                                pastBanners.add(url);
                            }
                        }
                    }
                }
            }
        }

        String bannerRealPath = servletContext.getRealPath("/resources/images/banner");
        if (bannerRealPath != null) {
            File bannerDir = new File(bannerRealPath);
            if (bannerDir.exists() && bannerDir.isDirectory()) {
                File[] files = bannerDir.listFiles();
                if (files != null) {
                    for (File file : files) {
                        if (file.isFile() && (file.getName().endsWith(".png") || file.getName().endsWith(".jpg") || file.getName().endsWith(".jpeg") || file.getName().endsWith(".webp"))) {
                            String url = "/images/banner/" + file.getName();
                            if (!pastBanners.contains(url)) {
                                pastBanners.add(url);
                            }
                        }
                    }
                }
            }
        }

        // Đảm bảo ảnh hiện tại luôn có trong danh sách lựa chọn
        if (bannerImageUrl != null && !bannerImageUrl.trim().isEmpty() && !pastBanners.contains(bannerImageUrl)) {
            pastBanners.add(bannerImageUrl);
        }
        model.addAttribute("pastBanners", pastBanners);

        // AI Chatbot Settings
        model.addAttribute("aiChatApiKey", systemSettingService.getSettingValue("AI_CHAT_API_KEY", ""));

        return "admin/settings/show";
    }

    @PostMapping("/admin/settings")
    public String postUpdateSettings(
            @RequestParam("emailHost") String emailHost,
            @RequestParam("emailPort") String emailPort,
            @RequestParam("emailUsername") String emailUsername,
            @RequestParam("emailPassword") String emailPassword,
            @RequestParam(value = "emailSmtpAuth", defaultValue = "false") String emailSmtpAuth,
            @RequestParam(value = "emailStarttlsEnable", defaultValue = "false") String emailStarttlsEnable,
            
            @RequestParam(value = "promoActive", defaultValue = "false") String promoActive,
            @RequestParam("promoText") String promoText,
            @RequestParam("promoDiscount") String promoDiscount,
            
            @RequestParam("bannerBadge") String bannerBadge,
            @RequestParam("bannerTitle") String bannerTitle,
            @RequestParam("bannerSubtitle") String bannerSubtitle,
            @RequestParam("bannerButtonText") String bannerButtonText,
            @RequestParam("bannerImageUrl") String bannerImageUrl,
            @RequestParam(value = "bannerImageFile", required = false) MultipartFile bannerImageFile,
            @RequestParam("aiChatApiKey") String aiChatApiKey,
            
            RedirectAttributes redirectAttributes) {

        // Save Email Settings
        systemSettingService.saveOrUpdateSetting("EMAIL_HOST", emailHost, "SMTP Host for sending emails");
        systemSettingService.saveOrUpdateSetting("EMAIL_PORT", emailPort, "SMTP Port for sending emails");
        systemSettingService.saveOrUpdateSetting("EMAIL_USERNAME", emailUsername, "SMTP Username/Email address");
        systemSettingService.saveOrUpdateSetting("EMAIL_PASSWORD", emailPassword, "SMTP Password/App Password");
        
        String authVal = "on".equals(emailSmtpAuth) || "true".equals(emailSmtpAuth) ? "true" : "false";
        String tlsVal = "on".equals(emailStarttlsEnable) || "true".equals(emailStarttlsEnable) ? "true" : "false";
        systemSettingService.saveOrUpdateSetting("EMAIL_SMTP_AUTH", authVal, "Enable SMTP Authentication (true/false)");
        systemSettingService.saveOrUpdateSetting("EMAIL_STARTTLS_ENABLE", tlsVal, "Enable STARTTLS (true/false)");

        // Save Promotion Settings
        String promoVal = "on".equals(promoActive) || "true".equals(promoActive) ? "true" : "false";
        systemSettingService.saveOrUpdateSetting("PROMO_ACTIVE", promoVal, "Is discount event active (true/false)");
        systemSettingService.saveOrUpdateSetting("PROMO_TEXT", promoText, "Announcement bar promotion text");
        systemSettingService.saveOrUpdateSetting("PROMO_DISCOUNT", promoDiscount, "Discount percentage");

        // Save Banner Settings
        systemSettingService.saveOrUpdateSetting("BANNER_BADGE", bannerBadge, "Banner badge text");
        systemSettingService.saveOrUpdateSetting("BANNER_TITLE", bannerTitle, "Banner main title");
        systemSettingService.saveOrUpdateSetting("BANNER_SUBTITLE", bannerSubtitle, "Banner description text");
        systemSettingService.saveOrUpdateSetting("BANNER_BUTTON_TEXT", bannerButtonText, "Banner button text");
        
        String finalBannerUrl = bannerImageUrl;
        if (bannerImageFile != null && !bannerImageFile.isEmpty()) {
            String uploadedFileName = this.uploadService.handleSaverUploadFile(bannerImageFile, "banner");
            if (!uploadedFileName.isEmpty()) {
                finalBannerUrl = "/images/banner/" + uploadedFileName;
            }
        }
        systemSettingService.saveOrUpdateSetting("BANNER_IMAGE_URL", finalBannerUrl, "Banner background image URL");

        // Save AI Chatbot Settings
        systemSettingService.saveOrUpdateSetting("AI_CHAT_API_KEY", aiChatApiKey, "Google Gemini API Key for AI Chatbot");

        redirectAttributes.addFlashAttribute("successMessage", "Cấu hình hệ thống đã được cập nhật thành công!");
        return "redirect:/admin/settings";
    }
}
