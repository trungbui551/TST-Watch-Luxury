package com.tstwatchluxury.controller.client;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.VipAppointment;
import com.tstwatchluxury.service.UserService;
import com.tstwatchluxury.service.VipAppointmentService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ServicesController {

    private final VipAppointmentService vipAppointmentService;
    private final UserService userService;

    public ServicesController(VipAppointmentService vipAppointmentService, UserService userService) {
        this.vipAppointmentService = vipAppointmentService;
        this.userService = userService;
    }

    @GetMapping("/services")
    public String getServicesPage(
            @RequestParam(value = "tab", defaultValue = "warranty") String tab,
            Model model,
            HttpServletRequest request) {
        
        model.addAttribute("activeTab", tab);

        // Pre-fill user data if logged in
        Principal principal = request.getUserPrincipal();
        if (principal != null) {
            String email = principal.getName();
            User user = userService.getUserByEmail(email);
            if (user != null) {
                model.addAttribute("currentUser", user);
            }
        }

        return "client/services/show";
    }

    @PostMapping("/services/appointment")
    public String postVipAppointment(
            @RequestParam("fullName") String fullName,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("email") String email,
            @RequestParam("serviceType") String serviceType,
            @RequestParam("boutique") String boutique,
            @RequestParam("appointmentTime") String appointmentTimeStr,
            @RequestParam("notes") String notes,
            RedirectAttributes redirectAttributes) {

        LocalDateTime appointmentTime;
        try {
            // HTML5 datetime-local returns: YYYY-MM-DDTHH:MM
            appointmentTime = LocalDateTime.parse(appointmentTimeStr);
        } catch (DateTimeParseException e) {
            // Fallback to now + 1 day
            appointmentTime = LocalDateTime.now().plusDays(1);
        }

        VipAppointment appointment = new VipAppointment(
            fullName, phoneNumber, email, serviceType, boutique, appointmentTime, notes
        );

        vipAppointmentService.save(appointment);

        redirectAttributes.addFlashAttribute("successMessage", 
            "Chúc mừng quý khách! Lịch hẹn VIP của quý khách đã được gửi thành công. Đội ngũ TST Watch Luxury sẽ liên hệ xác nhận cuộc gọi trong vòng 30 phút.");
        
        return "redirect:/services?tab=appointment";
    }
}
