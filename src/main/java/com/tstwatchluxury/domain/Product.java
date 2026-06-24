package com.tstwatchluxury.domain;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @NotBlank(message = "Vui long nhap ten san phamr")
    private String name;
    @NotNull(message = "Phần giá không được để trống")
    @DecimalMin(value = "1.0", message = "Please Enter a valid Deposit Amount")
    private double price;
    private String image;
    @Column(columnDefinition = "MEDIUMTEXT")
    private String images;
    @NotBlank(message = "Không để trống mục này")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;
    @NotBlank(message = "Không để trống mục này")
    private String shortDesc;
    @Min(value = 0, message = "Vui lòng nhập giá trị hợp lệ")
    private long quantity;

    public List<CartDetail> getCartDetail() {
        return cartDetail;
    }

    public void setCartDetail(List<CartDetail> cartDetail) {
        this.cartDetail = cartDetail;
    }

    @Min(value = 0, message = "Vui lòng nhập giá trị hợp lệ")
    private long sold;

    public Product(@Min(value = 0, message = "Vui lòng nhập giá trị hợp lệ") long sold, List<CartDetail> cartDetail) {
        this.sold = sold;
        this.cartDetail = cartDetail;
    }

    private String factory;
    private String target;

    @Column(name = "is_unique")
    private Boolean isUnique = false;

    private String dialColors;
    private String strapColors;
    private String sizes;
    private String dialColorsImages;

    @Column(name = "active", nullable = false, columnDefinition = "bit(1) default 1")
    private boolean active = true;

    @OneToMany(mappedBy = "product")
    private List<CartDetail> cartDetail;
    @OneToMany(mappedBy = "product")
    private List<OrderDetail> orderDetails;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public long getSold() {
        return sold;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", detailDesc="
                + detailDesc + ", shortDesc=" + shortDesc + ", quantity=" + quantity + ", sold=" + sold + ", factory="
                + factory + ", target=" + target + "]";
    }

    public Product(long id, String name, double price, String image, String detailDesc, String shortDesc, long quantity,
            long sold, String factory, String target) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.detailDesc = detailDesc;
        this.shortDesc = shortDesc;
        this.quantity = quantity;
        this.sold = sold;
        this.factory = factory;
        this.target = target;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public Product() {
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public boolean getIsUnique() {
        return isUnique != null && isUnique;
    }

    public void setIsUnique(Boolean isUnique) {
        this.isUnique = isUnique;
    }

    public String getDialColors() {
        if (dialColors == null || dialColors.trim().isEmpty()) {
            return "Gold,Silver,Rose Gold,Black";
        }
        return dialColors;
    }

    public void setDialColors(String dialColors) {
        this.dialColors = dialColors;
    }

    public String getStrapColors() {
        if (strapColors == null || strapColors.trim().isEmpty()) {
            return "Gold,Silver,Rose Gold,Black";
        }
        return strapColors;
    }

    public void setStrapColors(String strapColors) {
        this.strapColors = strapColors;
    }

    public String getSizes() {
        if (sizes == null || sizes.trim().isEmpty()) {
            return "40mm,42mm,38mm,36mm";
        }
        return sizes;
    }

    public void setSizes(String sizes) {
        this.sizes = sizes;
    }

    public String getDialColorsImages() {
        return dialColorsImages;
    }

    public void setDialColorsImages(String dialColorsImages) {
        this.dialColorsImages = dialColorsImages;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
