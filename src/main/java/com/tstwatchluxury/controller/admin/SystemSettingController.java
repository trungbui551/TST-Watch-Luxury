package com.tstwatchluxury.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tstwatchluxury.service.SystemSettingService;

@Controller
public class SystemSettingController {

    private final SystemSettingService systemSettingService;

    public SystemSettingController(SystemSettingService systemSettingService) {
        this.systemSettingService = systemSettingService;
    }

    @GetMapping("/admin/settings")
    public String getSettingsPage(Model model) {
        model.addAttribute("emailHost", systemSettingService.getSettingValue("EMAIL_HOST", "smtp.gmail.com"));
        model.addAttribute("emailPort", systemSettingService.getSettingValue("EMAIL_PORT", "587"));
        model.addAttribute("emailUsername", systemSettingService.getSettingValue("EMAIL_USERNAME", ""));
        model.addAttribute("emailPassword", systemSettingService.getSettingValue("EMAIL_PASSWORD", ""));
        model.addAttribute("emailSmtpAuth", systemSettingService.getSettingValue("EMAIL_SMTP_AUTH", "true"));
        model.addAttribute("emailStarttlsEnable", systemSettingService.getSettingValue("EMAIL_STARTTLS_ENABLE", "true"));
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
            RedirectAttributes redirectAttributes) {

        systemSettingService.saveOrUpdateSetting("EMAIL_HOST", emailHost, "SMTP Host for sending emails");
        systemSettingService.saveOrUpdateSetting("EMAIL_PORT", emailPort, "SMTP Port for sending emails");
        systemSettingService.saveOrUpdateSetting("EMAIL_USERNAME", emailUsername, "SMTP Username/Email address");
        systemSettingService.saveOrUpdateSetting("EMAIL_PASSWORD", emailPassword, "SMTP Password/App Password");
        
        // Chuyển đổi checkbox sang String "true" hoặc "false"
        String authVal = "on".equals(emailSmtpAuth) || "true".equals(emailSmtpAuth) ? "true" : "false";
        String tlsVal = "on".equals(emailStarttlsEnable) || "true".equals(emailStarttlsEnable) ? "true" : "false";
        
        systemSettingService.saveOrUpdateSetting("EMAIL_SMTP_AUTH", authVal, "Enable SMTP Authentication (true/false)");
        systemSettingService.saveOrUpdateSetting("EMAIL_STARTTLS_ENABLE", tlsVal, "Enable STARTTLS (true/false)");

        redirectAttributes.addFlashAttribute("successMessage", "Cấu hình gửi mail đã được cập nhật thành công!");
        return "redirect:/admin/settings";
    }
}
