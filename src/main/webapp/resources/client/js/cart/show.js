function calculateTotal() {
    let subtotalEl = document.getElementById("subtotal");
    let shippingEl = document.getElementById("shipping");
    let totalEl = document.getElementById("total");
    let promoRow = document.getElementById("promo-row");
    let discountAmountEl = document.getElementById("discount-amount");
    
    if (subtotalEl && shippingEl && totalEl) {
        let subtotalText = subtotalEl.innerText;
        let shippingText = shippingEl.innerText;
        
        let subtotal = parseFloat(subtotalText.replace(/[^0-9]/g, "")) || 0;
        let shipping = parseFloat(shippingText.replace(/[^0-9]/g, "")) || 0;
        
        let isPromoActive = subtotalEl.getAttribute("data-promo-active") === "true";
        let promoDiscountPercent = parseFloat(subtotalEl.getAttribute("data-promo-discount")) || 0;
        
        let discount = 0;
        if (isPromoActive && promoDiscountPercent > 0) {
            discount = subtotal * (promoDiscountPercent / 100.0);
            if (discountAmountEl) {
                discountAmountEl.innerText = "- " + discount.toLocaleString('vi-VN') + " đ";
            }
            if (promoRow) {
                promoRow.classList.remove("d-none");
            }
        } else {
            if (promoRow) {
                promoRow.classList.add("d-none");
            }
        }
        
        let total = subtotal - discount + shipping;
        totalEl.innerText = total.toLocaleString('vi-VN') + " đ";
    }
}

$(document).ready(function() {
    calculateTotal();

    // Xử lý nút giảm số lượng
    $('.btn-minus').click(function() {
        let input = $(this).siblings('.qty-input');
        let val = parseInt(input.val(), 10) || 1;
        if (val > 1) {
            val--;
            updateQuantity(input, val);
        }
    });

    // Xử lý nút tăng số lượng
    $('.btn-plus').click(function() {
        let input = $(this).siblings('.qty-input');
        let val = parseInt(input.val(), 10) || 1;
        val++;
        updateQuantity(input, val);
    });

    function updateQuantity(inputEl, newQty) {
        inputEl.val(newQty);
        
        let price = parseFloat(inputEl.data('cart-detail-price')) || 0;
        let index = inputEl.data('cart-detail-index');
        let id = inputEl.data('cart-detail-id');
        
        // Cập nhật input ẩn trong form checkout để khi submit Spring MVC bind đúng số lượng mới
        $('input[name="cartDetails[' + index + '].quantity"]').val(newQty);
        
        // Cập nhật thành tiền của dòng sản phẩm
        let subtotalTextEl = $('span[data-cart-detail-id="' + id + '"]');
        let newSubtotal = price * newQty;
        subtotalTextEl.text(newSubtotal.toLocaleString('vi-VN') + " đ");
        
        // Tính toán lại tổng cộng giỏ hàng
        calculateCartSubtotal();
    }

    function calculateCartSubtotal() {
        let grandTotal = 0;
        $('.qty-input').each(function() {
            let qty = parseInt($(this).val(), 10) || 0;
            let price = parseFloat($(this).data('cart-detail-price')) || 0;
            grandTotal += qty * price;
        });
        
        $('#subtotal').text(grandTotal.toLocaleString('vi-VN') + " đ");
        calculateTotal(); // Cập nhật lại tổng sau phí ship
    }
});
