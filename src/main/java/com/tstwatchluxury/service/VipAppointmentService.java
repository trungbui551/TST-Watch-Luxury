package com.tstwatchluxury.service;

import java.util.List;
import java.util.Optional;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.tstwatchluxury.domain.VipAppointment;
import com.tstwatchluxury.repository.VipAppointmentRepository;

import jakarta.mail.internet.MimeMessage;
import jakarta.transaction.Transactional;

@Service
public class VipAppointmentService {

    private final VipAppointmentRepository vipAppointmentRepository;
    private final JavaMailSender mailSender;
    private final SystemSettingService systemSettingService;

    public VipAppointmentService(VipAppointmentRepository vipAppointmentRepository,
                                 JavaMailSender mailSender,
                                 SystemSettingService systemSettingService) {
        this.vipAppointmentRepository = vipAppointmentRepository;
        this.mailSender = mailSender;
        this.systemSettingService = systemSettingService;
    }

    @Transactional
    public VipAppointment save(VipAppointment appointment) {
        VipAppointment saved = vipAppointmentRepository.save(appointment);
        sendNotificationEmail(saved);
        return saved;
    }

    public List<VipAppointment> findAll() {
        return vipAppointmentRepository.findAllByOrderByAppointmentTimeDesc();
    }

    public Optional<VipAppointment> findById(long id) {
        return vipAppointmentRepository.findById(id);
    }

    @Transactional
    public void updateStatus(long id, String status) {
        vipAppointmentRepository.findById(id).ifPresent(appointment -> {
            appointment.setStatus(status);
            vipAppointmentRepository.save(appointment);
            sendStatusChangeEmail(appointment);
        });
    }

    private void sendNotificationEmail(VipAppointment appointment) {
        String adminEmail = systemSettingService.getSettingValue("EMAIL_USERNAME", "");
        if (adminEmail == null || adminEmail.trim().isEmpty()) {
            return;
        }

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(adminEmail);
            helper.setSubject("[TST Watch Luxury] Yêu cầu đặt lịch hẹn VIP mới - " + appointment.getFullName());
            
            String htmlContent = String.format(
                "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #d4af37; border-radius: 8px; background-color: #06070a; color: #ffffff;'>" +
                "  <h2 style='color: #d4af37; border-bottom: 2px solid #d4af37; padding-bottom: 10px; text-transform: uppercase;'>Yêu Cầu Đặt Lịch VIP Mới</h2>" +
                "  <p><strong>Khách hàng:</strong> %s</p>" +
                "  <p><strong>Số điện thoại:</strong> %s</p>" +
                "  <p><strong>Email:</strong> %s</p>" +
                "  <p><strong>Dịch vụ yêu cầu:</strong> %s</p>" +
                "  <p><strong>Boutique lựa chọn:</strong> %s</p>" +
                "  <p><strong>Thời gian hẹn:</strong> %s</p>" +
                "  <p><strong>Ghi chú/Mẫu đồng hồ:</strong> %s</p>" +
                "  <div style='margin-top: 20px; padding: 10px; background: rgba(212, 175, 55, 0.1); border-radius: 4px; text-align: center;'>" +
                "    <a href='http://localhost:8080/admin/appointment' style='color: #d4af37; text-decoration: none; font-weight: bold;'>Quản Lý Lịch Hẹn Trên Admin</a>" +
                "  </div>" +
                "</div>",
                appointment.getFullName(),
                appointment.getPhoneNumber(),
                appointment.getEmail() != null ? appointment.getEmail() : "N/A",
                appointment.getServiceType(),
                appointment.getBoutique(),
                appointment.getFormattedAppointmentTime(),
                appointment.getNotes() != null ? appointment.getNotes() : "Không có"
            );
            
            helper.setText(htmlContent, true);
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send VIP appointment email notification. Error: " + e.getMessage());
        }
    }

    private void sendStatusChangeEmail(VipAppointment appointment) {
        if (appointment.getEmail() == null || appointment.getEmail().trim().isEmpty()) {
            return;
        }

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(appointment.getEmail());
            helper.setSubject("[TST Watch Luxury] Cập nhật trạng thái lịch hẹn VIP");
            
            String htmlContent = String.format(
                "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #d4af37; border-radius: 8px; background-color: #06070a; color: #ffffff;'>" +
                "  <h2 style='color: #d4af37; border-bottom: 2px solid #d4af37; padding-bottom: 10px; text-transform: uppercase;'>Cập Nhật Lịch Hẹn VIP</h2>" +
                "  <p>Kính chào quý khách <strong>%s</strong>,</p>" +
                "  <p>Lịch hẹn VIP của quý khách tại <strong>%s</strong> vào lúc <strong>%s</strong> đã được cập nhật sang trạng thái:</p>" +
                "  <div style='padding: 12px; margin: 15px 0; background: rgba(212, 175, 55, 0.1); border-left: 4px solid #d4af37; font-size: 1.1rem; font-weight: bold; color: #d4af37; text-align: center;'>" +
                "    %s" +
                "  </div>" +
                "  <p>Chúng tôi rất hân hạnh được tiếp đón quý khách.</p>" +
                "  <p style='color: #888; font-size: 0.9rem;'>Đội ngũ TST Watch Luxury kính gửi.</p>" +
                "</div>",
                appointment.getFullName(),
                appointment.getBoutique(),
                appointment.getFormattedAppointmentTime(),
                appointment.getStatus()
            );
            
            helper.setText(htmlContent, true);
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send status update email to VIP client. Error: " + e.getMessage());
        }
    }
}
