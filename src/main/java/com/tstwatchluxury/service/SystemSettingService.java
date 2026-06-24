package com.tstwatchluxury.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.SystemSetting;
import com.tstwatchluxury.repository.SystemSettingRepository;

import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;

@Service
public class SystemSettingService {

    private final SystemSettingRepository systemSettingRepository;

    @Value("${spring.mail.host:smtp.gmail.com}")
    private String defaultMailHost;

    @Value("${spring.mail.port:587}")
    private String defaultMailPort;

    @Value("${spring.mail.username:thapcao2005@gmail.com}")
    private String defaultMailUsername;

    @Value("${spring.mail.password:tqlgxzngxfwsruvz}")
    private String defaultMailPassword;

    @Value("${spring.mail.properties.mail.smtp.auth:true}")
    private String defaultMailSmtpAuth;

    @Value("${spring.mail.properties.mail.smtp.starttls.enable:true}")
    private String defaultMailStarttlsEnable;

    public SystemSettingService(SystemSettingRepository systemSettingRepository) {
        this.systemSettingRepository = systemSettingRepository;
    }

    public String getSettingValue(String configKey, String defaultValue) {
        return systemSettingRepository.findByConfigKey(configKey)
                .map(SystemSetting::getConfigValue)
                .orElse(defaultValue);
    }

    @Transactional
    public void saveOrUpdateSetting(String configKey, String configValue, String description) {
        Optional<SystemSetting> settingOpt = systemSettingRepository.findByConfigKey(configKey);
        SystemSetting setting;
        if (settingOpt.isPresent()) {
            setting = settingOpt.get();
            setting.setConfigValue(configValue);
            if (description != null) {
                setting.setDescription(description);
            }
        } else {
            setting = new SystemSetting(configKey, configValue, description);
        }
        systemSettingRepository.save(setting);
    }

    @PostConstruct
    public void initDefaultSettings() {
        try {
            initSettingIfNotExist("EMAIL_HOST", defaultMailHost, "SMTP Host for sending emails");
            initSettingIfNotExist("EMAIL_PORT", defaultMailPort, "SMTP Port for sending emails");
            initSettingIfNotExist("EMAIL_USERNAME", defaultMailUsername, "SMTP Username/Email address");
            initSettingIfNotExist("EMAIL_PASSWORD", defaultMailPassword, "SMTP Password/App Password");
            initSettingIfNotExist("EMAIL_SMTP_AUTH", defaultMailSmtpAuth, "Enable SMTP Authentication (true/false)");
            initSettingIfNotExist("EMAIL_STARTTLS_ENABLE", defaultMailStarttlsEnable, "Enable STARTTLS (true/false)");
            
            // Discount Settings
            initSettingIfNotExist("PROMO_ACTIVE", "false", "Is discount event active (true/false)");
            initSettingIfNotExist("PROMO_TEXT", "SIÊU SALE MÙA HÈ - GIẢM NGAY 10% CHO TẤT CẢ ĐƠN HÀNG HÔM NAY!", "Announcement bar promotion text");
            initSettingIfNotExist("PROMO_DISCOUNT", "10", "Discount percentage");
            
            // Banner Settings
            initSettingIfNotExist("BANNER_BADGE", "Heritage Collection", "Banner badge text");
            initSettingIfNotExist("BANNER_TITLE", "Kiệt tác thời gian<br/>đeo trên tay", "Banner main title");
            initSettingIfNotExist("BANNER_SUBTITLE", "Nơi hội tụ những tuyệt tác đồng hồ cơ khí tinh xảo nhất thế giới. Tinh tế trong từng chuyển động, khẳng định đẳng cấp và phong thái người dẫn đầu.", "Banner description text");
            initSettingIfNotExist("BANNER_BUTTON_TEXT", "Khám phá bộ sưu tập", "Banner button text");
            initSettingIfNotExist("BANNER_IMAGE_URL", "/resources/client/images/luxury_watch_banner.png", "Banner background image URL");
            
            // AI Chatbot Settings
            initSettingIfNotExist("AI_CHAT_API_KEY", "", "Google Gemini API Key for AI Chatbot");
        } catch (Exception e) {
            // Log warning, database might not be ready yet (e.g. during schema creation)
            System.err.println("Warning: Could not initialize default settings in database. " + e.getMessage());
        }
    }

    private void initSettingIfNotExist(String key, String defaultValue, String description) {
        if (systemSettingRepository.findByConfigKey(key).isEmpty()) {
            SystemSetting setting = new SystemSetting(key, defaultValue, description);
            systemSettingRepository.save(setting);
        }
    }
}
