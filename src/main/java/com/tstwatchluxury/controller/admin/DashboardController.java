package com.tstwatchluxury.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.service.OrderService;

@Controller
public class DashboardController {
    @Autowired
    private OrderService orderService;

    @GetMapping("/admin")
    public String getDashboardPage(Model model) {
        List<Order> list = this.orderService.getListOrderForDashBoard();
        model.addAttribute("orders", list);
        return "admin/dashboard/show";
    }

}
