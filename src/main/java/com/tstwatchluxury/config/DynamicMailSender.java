package com.tstwatchluxury.config;

import java.util.Properties;

import org.springframework.context.annotation.Primary;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Component;

import com.tstwatchluxury.service.SystemSettingService;

import jakarta.mail.internet.MimeMessage;

@Component("mailSender")
@Primary
public class DynamicMailSender extends JavaMailSenderImpl {

    private final SystemSettingService systemSettingService;

    public DynamicMailSender(SystemSettingService systemSettingService) {
        this.systemSettingService = systemSettingService;
    }

    @Override
    public void send(MimeMessage mimeMessage) throws MailException {
        updateCredentials();
        super.send(mimeMessage);
    }

    @Override
    public void send(MimeMessage... mimeMessages) throws MailException {
        updateCredentials();
        super.send(mimeMessages);
    }

    @Override
    public void send(SimpleMailMessage simpleMessage) throws MailException {
        updateCredentials();
        super.send(simpleMessage);
    }

    @Override
    public void send(SimpleMailMessage... simpleMessages) throws MailException {
        updateCredentials();
        super.send(simpleMessages);
    }

    private void updateCredentials() {
        String host = systemSettingService.getSettingValue("EMAIL_HOST", "smtp.gmail.com");
        int port = 587;
        try {
            port = Integer.parseInt(systemSettingService.getSettingValue("EMAIL_PORT", "587"));
        } catch (NumberFormatException e) {
            // fallback
        }
        String username = systemSettingService.getSettingValue("EMAIL_USERNAME", "");
        String password = systemSettingService.getSettingValue("EMAIL_PASSWORD", "");
        String auth = systemSettingService.getSettingValue("EMAIL_SMTP_AUTH", "true");
        String starttls = systemSettingService.getSettingValue("EMAIL_STARTTLS_ENABLE", "true");

        this.setHost(host);
        this.setPort(port);
        this.setUsername(username);
        this.setPassword(password);
        this.setDefaultEncoding("UTF-8");

        Properties props = this.getJavaMailProperties();
        props.put("mail.smtp.auth", auth);
        props.put("mail.smtp.starttls.enable", starttls);
        props.put("mail.mime.charset", "UTF-8");
        props.put("mail.debug", "true");
    }
}
