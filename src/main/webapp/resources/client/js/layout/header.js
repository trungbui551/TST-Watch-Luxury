// JavaScript to toggle search input box
document.addEventListener('DOMContentLoaded', function () {
    const searchToggle = document.getElementById('navbarSearchToggle');
    const searchForm = document.getElementById('navbarSearchForm');
    if (searchToggle && searchForm) {
        searchToggle.addEventListener('click', function (e) {
            e.stopPropagation();
            searchForm.classList.toggle('active');
            if (searchForm.classList.contains('active')) {
                const searchInput = searchForm.querySelector('input');
                if (searchInput) searchInput.focus();
            }
        });

        document.addEventListener('click', function (e) {
            if (!searchForm.contains(e.target) && !searchToggle.contains(e.target)) {
                searchForm.classList.remove('active');
            }
        });
    }
});

// JavaScript for Premium Dynamic Cart Update (AJAX)
document.addEventListener('DOMContentLoaded', function () {
    const config = window.HeaderConfig || {};
    var isAuthenticated = config.isAuthenticated === true;
    
    document.addEventListener('submit', function (e) {
        var form = e.target;
        var actionUrl = form.getAttribute('action') || '';
        
        // Check if it's the post add to cart form
        if (form.method.toLowerCase() === 'post' && actionUrl.indexOf('/add-product-to-cart/') !== -1) {
            if (!isAuthenticated) {
                // Not logged in: let standard POST redirect to login page
                return;
            }
            
            e.preventDefault();
            
            var parts = actionUrl.split('/');
            var productId = parts[parts.length - 1];
            var apiUrl = '/api/add-to-cart/' + productId;
            
            var cartBtn = document.getElementById('navbarCartBtn');
            
            // Perform AJAX call with CSRF token in header
            var csrfHeader = config.csrfHeader || '';
            var csrfToken = config.csrfToken || '';
            
            if (csrfHeader && csrfToken) {
                fetch(apiUrl, {
                    method: 'POST',
                    headers: {
                        [csrfHeader]: csrfToken
                    }
                })
                .then(function (res) { return res.json(); })
                .then(function (response) {
                    if (response.success) {
                        // Update cart count badge dynamically without page reload
                        if (cartBtn) {
                            var badge = cartBtn.querySelector('.cart-badge');
                            if (badge) {
                                badge.textContent = response.newSum;
                            } else {
                                var newBadge = document.createElement('span');
                                newBadge.className = 'cart-badge';
                                newBadge.textContent = response.newSum;
                                cartBtn.appendChild(newBadge);
                            }
                        }
                    } else {
                        console.error('Add-to-cart API failed:', response.message);
                    }
                })
                .catch(function (err) {
                    console.error('Add-to-cart request error:', err);
                });
            }
        }
    });
});
