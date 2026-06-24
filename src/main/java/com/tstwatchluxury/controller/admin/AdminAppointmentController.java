package com.tstwatchluxury.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tstwatchluxury.domain.VipAppointment;
import com.tstwatchluxury.service.VipAppointmentService;

@Controller
public class AdminAppointmentController {

    private final VipAppointmentService vipAppointmentService;

    public AdminAppointmentController(VipAppointmentService vipAppointmentService) {
        this.vipAppointmentService = vipAppointmentService;
    }

    @GetMapping("/admin/appointment")
    public String getAppointmentsPage(Model model) {
        List<VipAppointment> list = vipAppointmentService.findAll();
        model.addAttribute("appointments", list);
        return "admin/appointment/show";
    }

    @PostMapping("/admin/appointment/{id}/confirm")
    public String confirmAppointment(@PathVariable("id") long id, RedirectAttributes redirectAttributes) {
        vipAppointmentService.updateStatus(id, "Đã xác nhận");
        redirectAttributes.addFlashAttribute("successMessage", "Lịch hẹn VIP đã được xác nhận thành công và gửi email thông báo khách hàng!");
        return "redirect:/admin/appointment";
    }

    @PostMapping("/admin/appointment/{id}/cancel")
    public String cancelAppointment(@PathVariable("id") long id, RedirectAttributes redirectAttributes) {
        vipAppointmentService.updateStatus(id, "Đã hủy");
        redirectAttributes.addFlashAttribute("successMessage", "Lịch hẹn VIP đã được hủy thành công và gửi email thông báo khách hàng!");
        return "redirect:/admin/appointment";
    }
}
