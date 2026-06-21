document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    const orderId = urlParams.get('orderId');
    const orderIdEl = document.getElementById('orderId');
    if (orderId && orderIdEl) { 
        orderIdEl.textContent = orderId; 
    }
});
