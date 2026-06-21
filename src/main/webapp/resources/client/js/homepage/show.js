// Spinner chỉ dành cho lần load đầu tiên của trang
var spinner = document.getElementById('spinner');
if (spinner) {
    spinner.style.display = 'none';
}

var config = window.AppConfig || {};

// CSRF Tokens
var csrfParameterName = config.csrfParameterName || '';
var csrfToken = config.csrfToken || '';

// Initial Filter State (fed from server models to keep bookmark links functional)
var selectedBrand = config.selectedBrand || 'all';
var selectedTarget = config.selectedTarget || 'all';
var selectedPrice = config.selectedPrice || 'all';
var selectedSort = config.selectedSort || 'default';
var currentPage = config.currentPage || 1;

// Static standard brand options aligning with Admin dropdown inputs
var brands = ['all', 'Rolex', 'Hublot', 'Cartier', 'Casio', 'Tissot'];
var targets = ['all', 'Nam', 'Nữ', 'Unisex'];

// Render Brand Pills
var brandContainer = document.getElementById('brandPillContainer');
if (brandContainer) {
    brandContainer.innerHTML = '';
    brands.forEach(function (b) {
        var activeClass = b === selectedBrand ? 'active' : '';
        var label = b === 'all' ? 'Tất cả' : b;
        brandContainer.innerHTML += '<button class="filter-pill ' + activeClass + '" data-brand="' + b + '">' + label + '</button>';
    });
    // Bind click events
    brandContainer.querySelectorAll('.filter-pill').forEach(function (btn) {
        btn.addEventListener('click', function () {
            brandContainer.querySelectorAll('.filter-pill').forEach(function (b) { b.classList.remove('active'); });
            this.classList.add('active');
            selectedBrand = this.getAttribute('data-brand');
            currentPage = 1;
            applyFilters();
        });
    });
}

// Render Target Pills
var targetContainer = document.getElementById('targetPillContainer');
if (targetContainer) {
    targetContainer.innerHTML = '';
    targets.forEach(function (t) {
        var activeClass = t === selectedTarget ? 'active' : '';
        var label = t === 'all' ? 'Tất cả' : t;
        targetContainer.innerHTML += '<button class="filter-pill ' + activeClass + '" data-target="' + t + '">' + label + '</button>';
    });
    // Bind click events
    targetContainer.querySelectorAll('.filter-pill').forEach(function (btn) {
        btn.addEventListener('click', function () {
            targetContainer.querySelectorAll('.filter-pill').forEach(function (t) { t.classList.remove('active'); });
            this.classList.add('active');
            selectedTarget = this.getAttribute('data-target');
            currentPage = 1;
            applyFilters();
        });
    });
}

// Search Input listeners
var searchFilterInput = document.getElementById('searchFilter');
if (searchFilterInput) {
    searchFilterInput.addEventListener('input', function () {
        currentPage = 1;
        applyFilters();
    });
}

// Dropdowns listeners
var priceFilterSelect = document.getElementById('priceFilter');
if (priceFilterSelect) {
    priceFilterSelect.addEventListener('change', function () {
        selectedPrice = this.value;
        currentPage = 1;
        applyFilters();
    });
}

var sortFilterSelect = document.getElementById('sortFilter');
if (sortFilterSelect) {
    sortFilterSelect.addEventListener('change', function () {
        selectedSort = this.value;
        currentPage = 1;
        applyFilters();
    });
}

// Card Entry Animations
function applyCardAnimation() {
    var cardObserver = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
                cardObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.luxury-card-watch').forEach(function (el, i) {
        el.style.opacity = '0';
        el.style.animation = 'fadeInUp 0.5s ease forwards';
        el.style.animationDelay = (i * 0.04) + 's';
        el.style.animationPlayState = 'paused';
        cardObserver.observe(el);
    });
}

// Product image hover (event delegation)
document.addEventListener('mouseenter', function (e) {
    if (e.target.classList.contains('product-img-hover')) {
        e.target.style.transform = 'scale(1.05)';
    }
}, true);
document.addEventListener('mouseleave', function (e) {
    if (e.target.classList.contains('product-img-hover')) {
        e.target.style.transform = 'scale(1)';
    }
}, true);

// Show toast if message exists
if (config.message && config.message.trim() !== '') {
    var container = document.getElementById('toastContainer');
    if (container) {
        var toast = document.createElement('div');
        toast.className = 'toast-premium';
        toast.innerHTML = '<i class="fas fa-info-circle" style="color: var(--color-primary); font-size:20px;"></i><span>' + config.message + '</span>';
        container.appendChild(toast);
        setTimeout(function() { toast.remove(); }, 4000);
    }
}

// Apply Filters (AJAX Query to Server)
function applyFilters() {
    var searchVal = document.getElementById('searchFilter') ? document.getElementById('searchFilter').value.trim() : '';

    // Show/hide Clear Filters Button
    var isFiltering = selectedBrand !== 'all' || selectedTarget !== 'all' || selectedPrice !== 'all' || searchVal !== '';
    var clearBtn = document.getElementById('clearFiltersBtn');
    if (clearBtn) {
        if (isFiltering) {
            clearBtn.classList.remove('d-none');
        } else {
            clearBtn.classList.add('d-none');
        }
    }

    // Sync with browser URL query string (without reloading the page) to enable copy-paste URLs!
    var queryParams = [];
    if (selectedBrand !== 'all') queryParams.push('factory=' + encodeURIComponent(selectedBrand));
    if (selectedTarget !== 'all') queryParams.push('target=' + encodeURIComponent(selectedTarget));
    if (selectedPrice !== 'all') queryParams.push('price=' + encodeURIComponent(selectedPrice));
    if (selectedSort !== 'default') queryParams.push('sort=' + encodeURIComponent(selectedSort));
    if (currentPage !== 1) queryParams.push('pageNo=' + currentPage);
    if (searchVal !== '') queryParams.push('keyword=' + encodeURIComponent(searchVal));

    var browserUrl = '/';
    if (queryParams.length > 0) {
        browserUrl += '?' + queryParams.join('&');
    }
    window.history.pushState({ path: browserUrl }, '', browserUrl);

    // Construct API Endpoint URL
    var apiEndpoint = '/products/partial?';
    apiEndpoint += 'factory=' + encodeURIComponent(selectedBrand);
    apiEndpoint += '&target=' + encodeURIComponent(selectedTarget);
    apiEndpoint += '&price=' + encodeURIComponent(selectedPrice);
    apiEndpoint += '&sort=' + encodeURIComponent(selectedSort);
    apiEndpoint += '&pageNo=' + currentPage;
    if (searchVal !== '') {
        apiEndpoint += '&keyword=' + encodeURIComponent(searchVal);
    }

    // Fade grid during AJAX fetch
    var pSection = document.getElementById('productsSection');
    if (pSection) {
        pSection.style.opacity = '0.55';
    }

    // Fetch AJAX product fragment
    fetch(apiEndpoint)
        .then(function (response) { return response.text(); })
        .then(function (html) {
            if (pSection) {
                pSection.innerHTML = html;
                pSection.style.opacity = '1';

                // Re-trigger entrance animations and bind AJAX pagination
                applyCardAnimation();
                bindPaginationEvents();
            }
        })
        .catch(function (err) {
            console.error('AJAX product query error:', err);
            if (pSection) pSection.style.opacity = '1';
        });
}

// Bind Pagination AJAX Click Events
function bindPaginationEvents() {
    var pSection = document.getElementById('productsSection');
    if (!pSection) return;

    pSection.querySelectorAll('.page-link-ajax').forEach(function (link) {
        link.addEventListener('click', function (e) {
            e.preventDefault();
            currentPage = parseInt(this.getAttribute('data-page'));
            applyFilters();

            // Smooth scroll to products section
            var productsHeader = document.getElementById('san-pham');
            if (productsHeader) {
                productsHeader.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });
}

// Clear all filters
function clearAllFilters() {
    var searchInput = document.getElementById('searchFilter');
    if (searchInput) searchInput.value = '';

    var priceSelect = document.getElementById('priceFilter');
    if (priceSelect) priceSelect.value = 'all';

    var sortSelect = document.getElementById('sortFilter');
    if (sortSelect) sortSelect.value = 'default';

    selectedPrice = 'all';
    selectedSort = 'default';
    selectedBrand = 'all';
    selectedTarget = 'all';
    currentPage = 1;

    if (brandContainer) {
        brandContainer.querySelectorAll('.filter-pill').forEach(function (btn) {
            if (btn.getAttribute('data-brand') === 'all') {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });
    }

    if (targetContainer) {
        targetContainer.querySelectorAll('.filter-pill').forEach(function (btn) {
            if (btn.getAttribute('data-target') === 'all') {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });
    }

    applyFilters();
}

// Bind clear filters button
var clearFiltersBtn = document.getElementById('clearFiltersBtn');
if (clearFiltersBtn) {
    clearFiltersBtn.addEventListener('click', clearAllFilters);
}

// Initial bind & animation load on page entry
bindPaginationEvents();
applyCardAnimation();

// Check if there are pre-selected parameters to sync clear filter visibility
var initialFiltering = selectedBrand !== 'all' || selectedTarget !== 'all' || selectedPrice !== 'all' || (searchFilterInput && searchFilterInput.value.trim() !== '');
if (clearFiltersBtn && initialFiltering) {
    clearFiltersBtn.classList.remove('d-none');
}
