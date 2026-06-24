package com.tstwatchluxury.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.OrderDetail;
import com.tstwatchluxury.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboardPage(Model model, @RequestParam(value = "search", required = false) String search) {
        List<Order> orders;
        if (search != null && !search.trim().isEmpty()) {
            orders = this.orderService.getOrdersBySearch(search);
            model.addAttribute("search", search.trim());
        } else {
            orders = this.orderService.getAllOrders();
        }
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        System.out.println("User Id= " + id);
        Order or = this.orderService.getOrderById(id);
        List<OrderDetail> ords = orderService.getOrderDetails(or);
        model.addAttribute("orderDetails", ords);
        model.addAttribute("order", or);
        return "admin/order/detail";
    }

    @PostMapping("/admin/order/delete")
    public String getDelete(Model model, @ModelAttribute("order") Order order) {
        this.orderService.deleteOrder(order.getId());
        return "redirect:/admin/order";

    }

    @GetMapping("/revenue-data")
    @ResponseBody
    public Map<String, Object> getRevenueData() {
        Map<String, Object> data = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Double> revenue = new ArrayList<>();
        List<Object[]> ob = this.orderService.getRevenueByMonth();
        for (Object[] o : ob) {
            labels.add(o[0].toString());
            revenue.add(((Number) o[1]).doubleValue());
        }
        data.put("labels", labels);
        data.put("value", revenue);
        System.out.println(data.toString());
        return data;
    }

    @GetMapping("/revenue-by-day")
    @ResponseBody
    public Map<String, Object> getRevenueByDay() {
        Map<String, Object> data = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Double> revenue = new ArrayList<>();
        List<Object[]> ob = this.orderService.getRevenueByDay();
        for (Object[] o : ob) {
            labels.add(o[0].toString());
            revenue.add(((Number) o[1]).doubleValue());
        }
        data.put("labels", labels);
        data.put("value", revenue);
        return data;
    }

    @GetMapping("/revenue-by-factory")
    @ResponseBody
    public Map<String, Object> getRevenueByFactory() {
        Map<String, Object> data = new HashMap<>();
        List<String> labels = new ArrayList<>();
        List<Double> revenue = new ArrayList<>();
        List<Object[]> ob = this.orderService.getRevenueByFactory();
        for (Object[] o : ob) {
            if (o[0] == null) continue;
            labels.add(o[0].toString());
            revenue.add(((Number) o[1]).doubleValue());
        }
        data.put("labels", labels);
        data.put("value", revenue);
        return data;
    }

    @GetMapping("/admin/order/update/{id}")
    public String getOrderUpdatePage(Model model, @PathVariable long id) {
        Order order = this.orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String postUpdateOrder(Model model, @ModelAttribute("order") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }
}

