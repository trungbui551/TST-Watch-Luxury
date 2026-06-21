function calculateTotal() {
    let subtotalEl = document.getElementById("subtotal");
    let shippingEl = document.getElementById("shipping");
    let totalEl = document.getElementById("total");
    if (subtotalEl && shippingEl && totalEl) {
        let subtotalText = subtotalEl.innerText;
        let shippingText = shippingEl.innerText;
        let subtotal = parseFloat(subtotalText.replace(/[^0-9]/g, "")) || 0;
        let shipping = parseFloat(shippingText.replace(/[^0-9]/g, "")) || 0;
        totalEl.innerText = (subtotal + shipping).toLocaleString('vi-VN') + " đ";
    }
}
window.addEventListener('DOMContentLoaded', calculateTotal);
