<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- Google Fonts Preconnect and Links for Luxury Theme -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">

        <!-- Luxury Design System Stylesheet -->
        <link href="/resources/client/css/luxury-theme.css?v=1.5" rel="stylesheet">

        <nav class="navbar navbar-expand-xl sticky-top navbar-luxury px-4 py-1" id="mainNavbar">
            <div class="container" style="max-width: 1280px;">

                <!-- Logo -->
                <a href="/" class="navbar-brand d-flex align-items-center">
                    <span class="navbar-brand-logo">TST Watch <span>Luxury®</span></span>
                </a>

                <!-- Hamburger -->
                <button class="navbar-toggler border-0 shadow-none py-1 px-2" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"
                        style="color: var(--text-primary);">
                        <line x1="3" y1="12" x2="21" y2="12"></line>
                        <line x1="3" y1="6" x2="21" y2="6"></line>
                        <line x1="3" y1="18" x2="21" y2="18"></line>
                    </svg>
                </button>

                <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                    <!-- Nav links -->
                    <div class="navbar-nav ms-auto mb-2 mb-xl-0 gap-2">
                        <a href="/" class="nav-item nav-link nav-link-premium active">Trang chủ</a>
                        <a href="/#san-pham" class="nav-item nav-link nav-link-premium">Sản Phẩm</a>
                    </div>

                    <!-- Actions -->
                    <div class="d-flex align-items-center gap-3 ms-xl-5 mt-3 mt-xl-0">

                        <!-- Search Icon & Slide-out input -->
                        <div class="search-box-container">
                            <button class="navbar-icon-btn" id="navbarSearchToggle" aria-label="Tìm kiếm">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <circle cx="11" cy="11" r="8"></circle>
                                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                </svg>
                            </button>
                            <form action="/" method="GET" class="navbar-search-form" id="navbarSearchForm">
                                <input type="text" name="keyword" placeholder="Tìm kiếm..." aria-label="Search"
                                    class="navbar-search-input">
                            </form>
                        </div>

                        <!-- Giỏ hàng -->
                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <a href="/cart" class="navbar-icon-btn" aria-label="Giỏ hàng" id="navbarCartBtn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                    <line x1="3" y1="6" x2="21" y2="6"></line>
                                    <path d="M16 10a4 4 0 0 1-8 0"></path>
                                </svg>
                                <span class="cart-badge">${sessionScope.sum}</span>
                            </a>
                        </c:if>

                        <!-- Tài khoản / Đăng nhập -->
                        <c:if test="${empty pageContext.request.userPrincipal}">
                            <a href="/login" class="navbar-icon-btn" aria-label="Đăng nhập">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </a>
                        </c:if>

                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <!-- User dropdown -->
                            <div class="dropdown">
                                <a href="#" class="navbar-icon-btn d-flex align-items-center gap-2 text-decoration-none"
                                    id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                </a>

                                <ul class="dropdown-menu dropdown-menu-end border-0 p-3 mt-2" style="border-radius: var(--radius-sm); min-width: 240px;
                                   box-shadow: var(--shadow-xl), var(--shadow-glow);" aria-labelledby="userDropdown">
                                    <li class="text-center mb-3">
                                        <img src="/images/avatar/${sessionScope.images}" alt="Avatar" style="width:64px; height:64px; border-radius:50%; object-fit:cover;
                                            border: 2px solid var(--gold-accent); margin-bottom:10px;">
                                        <div style="font-family: var(--font-heading); font-weight: 700;
                                            color: var(--text-primary); font-size: 15px;">
                                            <c:out value="${sessionScope.fullname}" />
                                        </div>
                                        <div style="font-size: 12px; color: var(--text-muted);">
                                            <c:out value="${pageContext.request.userPrincipal.name}" />
                                        </div>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider" style="border-color: var(--border-thin);">
                                    </li>
                                    <c:if test="${sessionScope.role == 'ADMIN' or pageContext.request.isUserInRole('ROLE_ADMIN')}">
                                        <li>
                                            <a class="dropdown-item py-2 fw-semibold" href="/admin"
                                                style="border-radius: var(--radius-sm); font-size: 14px; color: var(--gold-accent);">
                                                <i class="fas fa-user-shield me-2"></i>
                                                Trang quản lý
                                            </a>
                                        </li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item py-2" href="/client/update/${sessionScope.id}"
                                            style="border-radius: var(--radius-sm); font-size: 14px;">
                                            <i class="fas fa-cog me-2" style="color: var(--gold-accent);"></i>
                                            Quản lý tài khoản
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item py-2" href="/client/history/${sessionScope.id}"
                                            style="border-radius: var(--radius-sm); font-size: 14px;">
                                            <i class="fas fa-history me-2" style="color: var(--gold-accent);"></i>
                                            Lịch sử mua hàng
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider" style="border-color: var(--border-thin);">
                                    </li>
                                    <li>
                                        <form method="post" action="/logout" class="m-0">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <button class="dropdown-item py-2 text-danger"
                                                style="border-radius: var(--radius-sm); font-size: 14px; background: none; border: none; width: 100%; text-align: left;">
                                                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                                            </button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </nav>

        <script>
            window.HeaderConfig = {
                isAuthenticated: ${not empty pageContext.request.userPrincipal ? 'true' : 'false'},
                csrfHeader: "${_csrf.headerName}",
                csrfToken: "${_csrf.token}"
            };
        </script>
        <script src="/resources/client/js/layout/header.js?v=1.5" defer></script>
