<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">Hệ thống</div>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin">
                    <div class="sb-nav-link-icon"><i class="fas fa-chart-pie"></i></div>
                    Dashboard
                </a>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin/user">
                    <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                    Quản lý Users
                </a>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin/order">
                    <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                    Quản lý Đơn hàng
                </a>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin/product">
                    <div class="sb-nav-link-icon"><i class="fas fa-clock"></i></div>
                    Quản lý Sản phẩm
                </a>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin/appointment">
                    <div class="sb-nav-link-icon"><i class="fas fa-calendar-check"></i></div>
                    Quản lý Lịch hẹn VIP
                </a>
                <a class="nav-link" href="<%=request.getContextPath() %>/admin/settings">
                    <div class="sb-nav-link-icon"><i class="fas fa-cog"></i></div>
                    Cấu hình hệ thống
                </a>

                <div class="collapse" id="collapsePages" aria-labelledby="headingTwo"
                    data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                            data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                            Authentication
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                            </div>
                        </a>
                        <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne"
                            data-bs-parent="#sidenavAccordionPages">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="login.html">Login</a>
                                <a class="nav-link" href="register.html">Register</a>
                                <a class="nav-link" href="password.html">Forgot Password</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                            data-bs-target="#pagesCollapseError" aria-expanded="false"
                            aria-controls="pagesCollapseError">
                            Error
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i>
                            </div>
                        </a>
                        <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne"
                            data-bs-parent="#sidenavAccordionPages">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="401.html">401 Page</a>
                                <a class="nav-link" href="404.html">404 Page</a>
                                <a class="nav-link" href="500.html">500 Page</a>
                            </nav>
                        </div>
                    </nav>
                </div>

            </div>
        </div>
        <div class="sb-sidenav-footer">
            <div class="small">Tài khoản Admin:</div>
            <c:out value="${sessionScope.fullname}" />
        </div>
    </nav>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var currentPath = window.location.pathname;
        var navLinks = document.querySelectorAll("#sidenavAccordion .nav-link");
        navLinks.forEach(function(link) {
            var href = link.getAttribute("href");
            if (href) {
                // Remove trailing slashes for comparison
                var cleanHref = href.replace(/\/$/, "");
                var cleanPath = currentPath.replace(/\/$/, "");
                
                if (cleanHref === "/admin" || cleanHref === "<%=request.getContextPath()%>/admin") {
                    if (cleanPath === "/admin" || cleanPath === "/admin/") {
                        link.classList.add("active");
                    }
                } else if (cleanHref !== "" && cleanPath.startsWith(cleanHref)) {
                    link.classList.add("active");
                }
            }
        });
    });
</script>
