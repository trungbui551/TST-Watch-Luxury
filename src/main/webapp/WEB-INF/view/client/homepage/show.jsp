<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description"
                    content="LapTopShop - Chuyên cung cấp laptop cao cấp chính hãng với giá tốt nhất thị trường.">
                <title>TST Luxury - Trang chủ</title>

                <!-- Google Fonts Preconnect -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

                <!-- Luxury Design System Stylesheet -->
                <link href="/resources/client/css/luxury-theme.css?v=1.5" rel="stylesheet">

                <!-- Bootstrap 5 -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

                <!-- jQuery (defer-safe) -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js" defer></script>

                <!-- Custom CSS for Product Filter UI -->
                <style>
                    .filter-container {
                        background: var(--color-surface);
                        border: 1px solid var(--color-border);
                        border-radius: var(--radius-xl);
                        padding: 32px 32px 24px 32px; /* Fix collapsed padding and provide extra bottom space */
                        margin-bottom: 48px; /* Fix collapsed margin-bottom to separate cards below */
                        box-shadow: var(--shadow-sm);
                        transition: all 0.3s ease;
                    }

                    .filter-container:hover {
                        box-shadow: var(--shadow-md);
                    }

                    .filter-group-title {
                        font-size: 12px;
                        text-transform: uppercase;
                        letter-spacing: 0.05em;
                        font-weight: 700;
                        color: var(--color-text-secondary);
                        margin-bottom: var(--spacing-2);
                        opacity: 0.8;
                    }

                    .filter-pill {
                        display: inline-flex;
                        align-items: center;
                        padding: 8px 16px;
                        background-color: var(--color-gray-100);
                        color: var(--color-text-secondary);
                        border: 1px solid transparent;
                        border-radius: var(--radius-full);
                        font-size: 14px;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
                        margin-right: 8px;
                        margin-bottom: 8px;
                    }

                    .filter-pill:hover {
                        background-color: var(--color-gray-200);
                        color: var(--color-text-primary);
                        transform: translateY(-1px);
                    }

                    .filter-pill.active {
                        background-color: rgba(16, 185, 129, 0.1);
                        color: var(--color-primary-dark);
                        border-color: var(--color-primary-light);
                        font-weight: 600;
                    }

                    .search-filter-input {
                        border: 1px solid var(--color-border);
                        border-radius: var(--radius-lg);
                        padding: 10px 16px 10px 40px;
                        font-size: 14px;
                        width: 100%;
                        outline: none;
                        transition: all 0.3s ease;
                        background-color: var(--color-gray-50);
                        color: var(--color-text-primary);
                    }

                    .search-filter-input:focus {
                        background-color: #fff;
                        border-color: var(--color-primary-light);
                        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
                    }

                    .search-filter-wrapper {
                        position: relative;
                        width: 100%;
                    }

                    .search-filter-icon {
                        position: absolute;
                        left: 14px;
                        top: 50%;
                        transform: translateY(-50%);
                        color: var(--color-text-muted);
                        pointer-events: none;
                    }

                    .filter-select {
                        padding: 10px 36px 10px 16px;
                        border: 1px solid var(--color-border);
                        border-radius: var(--radius-lg);
                        font-size: 14px;
                        color: var(--color-text-primary);
                        background-color: var(--color-gray-50);
                        outline: none;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        appearance: none;
                        -webkit-appearance: none;
                        background-image: url("data:image/svg+xml;charset=UTF-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
                        background-repeat: no-repeat;
                        background-position: right 12px center;
                        background-size: 16px;
                    }

                    .filter-select:focus {
                        background-color: #fff;
                        border-color: var(--color-primary-light);
                        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
                    }

                    .clear-filter-btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 6px;
                        color: var(--color-error);
                        background: transparent;
                        border: none;
                        font-size: 14px;
                        font-weight: 600;
                        cursor: pointer;
                        padding: 8px 16px;
                        border-radius: var(--radius-full);
                        transition: all 0.2s ease;
                    }

                    .clear-filter-btn:hover {
                        background-color: rgba(239, 68, 68, 0.08);
                    }
                </style>
            </head>

            <body>

                <!-- Spinner: dùng d-none để Bootstrap không override display -->
                <div id="spinner"
                    class="d-none w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 align-items-center justify-content-center"
                    style="z-index:9999;">
                    <div class="spinner-grow" role="status" style="color: var(--color-primary);"></div>
                </div>


                <!-- Toast container (for messages) -->
                <div class="toast-container-custom" id="toastContainer"></div>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/banner.jsp" />

                <!-- Products Section -->
                <section class="container-fluid py-5" id="san-pham">
                    <div class="container py-4" style="max-width: 1280px;">

                        <div class="d-flex justify-content-between align-items-end border-bottom pb-4 mb-4"
                            style="border-color: var(--border-thin) !important;">
                            <div>
                                <h2
                                    style="font-family: var(--font-heading); font-weight: 400; font-size: clamp(1.8rem, 3vw, 2.5rem); text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary);">
                                    Tuyệt tác nổi bật
                                </h2>
                                <p
                                    style="color: var(--text-muted); margin: 4px 0 0; font-size: 14px; letter-spacing: 0.5px;">
                                    Kiến tạo chuẩn mực thượng lưu và cơ khí tinh xảo
                                </p>
                            </div>
                        </div>

                        <!-- Interactive Product Filters -->
                        <div class="filter-container">
                            <div class="row g-3 align-items-center mb-4">
                                <div class="col-lg-4 col-md-5">
                                    <div class="search-filter-wrapper">
                                        <i class="fas fa-search search-filter-icon"></i>
                                        <input type="text" id="searchFilter" class="search-filter-input"
                                            placeholder="Tìm sản phẩm nhanh..." value="<c:out value='${keyword}'/>">
                                    </div>
                                </div>
                                <div
                                    class="col-lg-8 col-md-7 d-flex flex-wrap justify-content-md-end gap-3 align-items-center">
                                    <div class="d-flex align-items-center gap-2">
                                        <span
                                            style="font-size: 14px; font-weight: 600; color: var(--color-text-secondary);">Mức
                                            giá:</span>
                                        <select id="priceFilter" class="filter-select">
                                            <option value="all" ${selectedPrice=='all' ? 'selected' : '' }>Tất cả mức
                                                giá</option>
                                            <option value="under10" ${selectedPrice=='under10' ? 'selected' : '' }>Dưới
                                                10 triệu</option>
                                            <option value="10to15" ${selectedPrice=='10to15' ? 'selected' : '' }>Từ 10 -
                                                15 triệu</option>
                                            <option value="15to20" ${selectedPrice=='15to20' ? 'selected' : '' }>Từ 15 -
                                                20 triệu</option>
                                            <option value="over20" ${selectedPrice=='over20' ? 'selected' : '' }>Trên 20
                                                triệu</option>
                                        </select>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span
                                            style="font-size: 14px; font-weight: 600; color: var(--color-text-secondary);">Sắp
                                            xếp:</span>
                                        <select id="sortFilter" class="filter-select">
                                            <option value="default" ${selectedSort=='default' ? 'selected' : '' }>Mặc
                                                định</option>
                                            <option value="priceAsc" ${selectedSort=='priceAsc' ? 'selected' : '' }>Giá:
                                                Thấp đến Cao</option>
                                            <option value="priceDesc" ${selectedSort=='priceDesc' ? 'selected' : '' }>
                                                Giá: Cao đến Thấp</option>
                                            <option value="nameAsc" ${selectedSort=='nameAsc' ? 'selected' : '' }>Tên: A
                                                - Z</option>
                                            <option value="nameDesc" ${selectedSort=='nameDesc' ? 'selected' : '' }>Tên:
                                                Z - A</option>
                                        </select>
                                    </div>
                                    <button id="clearFiltersBtn" class="clear-filter-btn d-none">
                                        <i class="fas fa-times"></i> Xóa bộ lọc
                                    </button>
                                </div>
                            </div>

                            <!-- Brand filter -->
                            <div class="mb-3">
                                <div class="filter-group-title">Hãng sản xuất</div>
                                <div id="brandPillContainer" class="d-flex flex-wrap align-items-center"
                                    style="gap: 8px;">
                                    <button class="filter-pill active" data-brand="all">Tất cả</button>
                                </div>
                            </div>
 
                            <!-- Target filter -->
                            <div class="mb-3">
                                <div class="filter-group-title">Nhu cầu sử dụng</div>
                                <div id="targetPillContainer" class="d-flex flex-wrap align-items-center"
                                    style="gap: 8px;">
                                    <button class="filter-pill active" data-target="all">Tất cả</button>
                                </div>
                            </div>
                        </div>

                        <%-- Wrapper dùng cho AJAX replace --%>
                            <div id="productsSection">
                                <jsp:include page="products-partial.jsp" />
                            </div><%-- end #productsSection --%>
                    </div>
                </section>

                <!-- Features Section -->
                <jsp:include page="../layout/feature.jsp" />

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <a href="#" class="back-to-top" aria-label="Lên đầu trang">
                    <i class="fa fa-arrow-up"></i>
                </a>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Spinner chỉ dành cho lần load đầu tiên của trang
                    document.getElementById('spinner').style.display = 'none';

                    // CSRF Tokens
                    var csrfParameterName = "${_csrf.parameterName}";
                    var csrfToken = "${_csrf.token}";

                    // Initial Filter State (fed from server models to keep bookmark links functional)
                    var selectedBrand = "${selectedFactory != null ? selectedFactory : 'all'}";
                    var selectedTarget = "${selectedTarget != null ? selectedTarget : 'all'}";
                    var selectedPrice = "${selectedPrice != null ? selectedPrice : 'all'}";
                    var selectedSort = "${selectedSort != null ? selectedSort : 'default'}";
                    var currentPage = ${ currentPage != null ? currentPage : 1};

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
                    <c:if test="${not empty message}">
                        (function() {
            var msg = '<c:out value="${message}" />';
                        var container = document.getElementById('toastContainer');
                        if (container && msg) {
                var toast = document.createElement('div');
                        toast.className = 'toast-premium';
                        toast.innerHTML = '<i class="fas fa-info-circle" style="color: var(--color-primary); font-size:20px;"></i><span>' + msg + '</span>';
                        container.appendChild(toast);
                        setTimeout(function() {toast.remove(); }, 4000);
            }
        })();
                    </c:if>

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
                        var container = document.getElementById('productsSection');
                        if (container) {
                            container.style.opacity = '0.55';
                        }

                        // Fetch AJAX product fragment
                        fetch(apiEndpoint)
                            .then(function (response) { return response.text(); })
                            .then(function (html) {
                                if (container) {
                                    container.innerHTML = html;
                                    container.style.opacity = '1';

                                    // Re-trigger entrance animations and bind AJAX pagination
                                    applyCardAnimation();
                                    bindPaginationEvents();
                                }
                            })
                            .catch(function (err) {
                                console.error('AJAX product query error:', err);
                                if (container) container.style.opacity = '1';
                            });
                    }

                    // Bind Pagination AJAX Click Events
                    function bindPaginationEvents() {
                        var container = document.getElementById('productsSection');
                        if (!container) return;

                        container.querySelectorAll('.page-link-ajax').forEach(function (link) {
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
                </script>
            </body>

            </html>
