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
window.addEventListener('DOMContentLoaded', calculateTotal);
