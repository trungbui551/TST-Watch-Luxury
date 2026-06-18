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
