package com.tstwatchluxury.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tstwatchluxury.domain.Product;

import com.tstwatchluxury.service.ProductService;
import com.tstwatchluxury.service.UploadService;
import jakarta.validation.Valid;

@Controller
public class ProductController {
    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @RequestMapping("/admin/product/create")
    public String getCreateProductPage(Model model, @ModelAttribute("newProduct") Product hary) {
        {
            model.addAttribute("newProduct", hary);

            return "admin/product/create";

        }

    }

    @PostMapping(value = "/admin/product/create")
    public String createProductPage(Model model, @Valid @ModelAttribute("newProduct") Product laptop,
            BindingResult newUseBindingResult,
            @RequestParam("trungImg") MultipartFile file,
            @RequestParam("subImg") MultipartFile[] subFiles,
            @RequestParam(value = "dialColorImages", required = false) MultipartFile[] dialColorFiles) {

        List<FieldError> errors = newUseBindingResult.getFieldErrors();
        for (FieldError e : errors) {
            System.out.println(">>>>>>" + e.getField() + "-" + e.getDefaultMessage());
        }
        if (newUseBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        String productImg = this.uploadService.handleSaverUploadFile(file, "product");
        laptop.setImage(productImg);

        // Lưu danh sách ảnh phụ
        StringBuilder subImagesBuilder = new StringBuilder();
        if (subFiles != null && subFiles.length > 0) {
            for (MultipartFile subFile : subFiles) {
                if (subFile != null && !subFile.isEmpty()) {
                    String subImgName = this.uploadService.handleSaverUploadFile(subFile, "product");
                    if (!subImgName.isEmpty()) {
                        if (subImagesBuilder.length() > 0) {
                            subImagesBuilder.append(",");
                        }
                        subImagesBuilder.append(subImgName);
                    }
                }
            }
        }
        laptop.setImages(subImagesBuilder.toString());

        // Lưu danh sách ảnh tương ứng màu mặt số (nếu có)
        if (dialColorFiles != null && dialColorFiles.length > 0) {
            StringBuilder dialColorsImagesBuilder = new StringBuilder();
            for (MultipartFile dialColorFile : dialColorFiles) {
                if (dialColorFile != null && !dialColorFile.isEmpty()) {
                    String imgName = this.uploadService.handleSaverUploadFile(dialColorFile, "product");
                    if (!imgName.isEmpty()) {
                        if (dialColorsImagesBuilder.length() > 0) {
                            dialColorsImagesBuilder.append(",");
                        }
                        dialColorsImagesBuilder.append(imgName);
                    }
                }
            }
            if (dialColorsImagesBuilder.length() > 0) {
                laptop.setDialColorsImages(dialColorsImagesBuilder.toString());
            }
        }

        this.productService.handleSaveProduct(laptop);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product")
    public String getProductManagerPage(Model model, @Param("keyword") String keyword,
            @RequestParam(name = "pageNo", defaultValue = "1") Integer pageNo) {
        Page<Product> pros = this.productService.getALL(pageNo);
        if (keyword != null) {
            pros = this.productService.searchProduct(keyword, pageNo);
            model.addAttribute("keyword", keyword);
        }
        int totalPages = pros.getTotalPages();
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", pageNo);

        model.addAttribute("pros", pros.getContent());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product pro = this.productService.getProductById(id);
        model.addAttribute("product", pro);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getProductUpdatePage(Model model, @Valid @PathVariable long id) {
        Product pro = this.productService.getProductById(id);
        model.addAttribute("product", pro);
        System.out.println(">>>>>>>>>>>>>>>>>>>>>" + pro.toString());
        model.addAttribute("id", id);
        return "admin/product/update";
    }

    // @PostMapping("/place-order")
    // public String handlePlaceOrder(
    // HttpServletRequest request,
    // @RequestParam("receiverName") String receiverName,
    // @RequestParam("receiverAddress") String receiverAddress,
    // @RequestParam("receiverPhone") String receiverPhone) {

    // HttpSession session = request.getSession(false);

    // return "redirect:/";
    // }

    @PostMapping("/admin/product/update")
    public String postUpdateProduct(Model model, @ModelAttribute("product") Product hoidanit,
            BindingResult newUseBindingResult,
            @RequestParam("newimg") MultipartFile file,
            @RequestParam("subImg") MultipartFile[] subFiles,
            @RequestParam(value = "dialColorImages", required = false) MultipartFile[] dialColorFiles) {
        List<FieldError> errors = newUseBindingResult.getFieldErrors();
        if (newUseBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.getProductById(hoidanit.getId());
        System.out.println(currentProduct.toString());
        if (currentProduct != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaverUploadFile(file, "product");
                currentProduct.setImage(img);
            }

            // Xử lý danh sách ảnh phụ mới (nếu được tải lên)
            if (subFiles != null && subFiles.length > 0) {
                StringBuilder subImagesBuilder = new StringBuilder();
                for (MultipartFile subFile : subFiles) {
                    if (subFile != null && !subFile.isEmpty()) {
                        String subImgName = this.uploadService.handleSaverUploadFile(subFile, "product");
                        if (!subImgName.isEmpty()) {
                            if (subImagesBuilder.length() > 0) {
                                subImagesBuilder.append(",");
                            }
                            subImagesBuilder.append(subImgName);
                        }
                    }
                }
                if (subImagesBuilder.length() > 0) {
                    currentProduct.setImages(subImagesBuilder.toString());
                }
            }

            // Lưu danh sách ảnh tương ứng màu mặt số mới (nếu có)
            if (dialColorFiles != null && dialColorFiles.length > 0) {
                StringBuilder dialColorsImagesBuilder = new StringBuilder();
                for (MultipartFile dialColorFile : dialColorFiles) {
                    if (dialColorFile != null && !dialColorFile.isEmpty()) {
                        String imgName = this.uploadService.handleSaverUploadFile(dialColorFile, "product");
                        if (!imgName.isEmpty()) {
                            if (dialColorsImagesBuilder.length() > 0) {
                                dialColorsImagesBuilder.append(",");
                            }
                            dialColorsImagesBuilder.append(imgName);
                        }
                    }
                }
                if (dialColorsImagesBuilder.length() > 0) {
                    currentProduct.setDialColorsImages(dialColorsImagesBuilder.toString());
                }
            } else {
                currentProduct.setDialColorsImages(hoidanit.getDialColorsImages());
            }

            System.out.println("---------------------------------------------------" + hoidanit.getFactory());
            currentProduct.setName(hoidanit.getName());
            currentProduct.setDetailDesc(hoidanit.getDetailDesc());
            currentProduct.setFactory(hoidanit.getFactory());
            currentProduct.setShortDesc(hoidanit.getShortDesc());
            currentProduct.setPrice((hoidanit.getPrice()));
            currentProduct.setQuantity(hoidanit.getQuantity());
            currentProduct.setSold(hoidanit.getSold());
            currentProduct.setTarget(hoidanit.getTarget());
            currentProduct.setIsUnique(hoidanit.getIsUnique());
            currentProduct.setDialColors(hoidanit.getDialColors());
            currentProduct.setStrapColors(hoidanit.getStrapColors());
            currentProduct.setSizes(hoidanit.getSizes());
            this.productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }

    @PostMapping("/admin/product/delete")
    public String deleteProduct(@RequestParam("id") long id) {
        try {
            this.productService.deleteProduct(id);
        } catch (Exception e) {
            System.err.println("Error deleting product: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }

    @PostMapping("/admin/product/restore")
    public String restoreProduct(@RequestParam("id") long id) {
        try {
            this.productService.restoreProduct(id);
        } catch (Exception e) {
            System.err.println("Error restoring product: " + e.getMessage());
        }
        return "redirect:/admin/product";
    }
}
