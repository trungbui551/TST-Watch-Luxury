package com.tstwatchluxury.controller.client;

import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.service.ProductService;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getMethodName(Model model, 
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "factory", required = false, defaultValue = "all") String factory,
            @RequestParam(name = "target", required = false, defaultValue = "all") String target,
            @RequestParam(name = "price", required = false, defaultValue = "all") String price,
            @RequestParam(name = "sort", required = false, defaultValue = "default") String sort,
            @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo) {
        
        Page<Product> productlist = this.productService.getFilteredProducts(factory, target, price, keyword, sort, pageNo);
        
        model.addAttribute("totalPages", productlist.getTotalPages());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("pros", productlist.getContent());
        
        // Pass filter states back to model for JSTL layout rendering
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedFactory", factory);
        model.addAttribute("selectedTarget", target);
        model.addAttribute("selectedPrice", price);
        model.addAttribute("selectedSort", sort);
        
        return "client/homepage/show";
    }

    /**
     * Endpoint AJAX: chỉ trả về phần sản phẩm + phân trang (không có layout).
     * Được gọi khi người dùng click số trang hoặc đổi bộ lọc, tránh reload toàn bộ trang.
     */
    @GetMapping("/products/partial")
    public String getProductsPartial(Model model, 
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "factory", required = false, defaultValue = "all") String factory,
            @RequestParam(name = "target", required = false, defaultValue = "all") String target,
            @RequestParam(name = "price", required = false, defaultValue = "all") String price,
            @RequestParam(name = "sort", required = false, defaultValue = "default") String sort,
            @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo) {
        
        Page<Product> productlist = this.productService.getFilteredProducts(factory, target, price, keyword, sort, pageNo);
        
        model.addAttribute("totalPages", productlist.getTotalPages());
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("pros", productlist.getContent());
        
        return "client/homepage/products-partial";
    }

}
