package com.tstwatchluxury.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.*;

@Setter
@Getter
@Entity

@Table(name = "cart_detail")
public class CartDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private long quantity;
    private double price;
    @ManyToOne
    @JoinColumn(name = "card_id")
    private Cart cart;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;

    public CartDetail() {
    };

    public CartDetail(long id, long quantity, double price, Cart cart, Product product) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.cart = cart;
        this.product = product;
    }

}
