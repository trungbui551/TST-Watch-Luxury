<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- jQuery phải load trước -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <!-- Navbar -->
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="/">TST WATCH LUXURY</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>

            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <div class="dropdown my-auto">
                    <a href="#" class="dropdown-toggle" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <i class="fas fa-user fa-2x"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-lg-end p-4" style="min-width: 250px; max-width: 90vw;"
                        aria-labelledby="dropdownMenuLink">
                        <li class="d-flex align-items-center flex-column">
                            <c:set var="headerAvatar"
                                value="${not empty sessionScope.images ? sessionScope.images : 'default-avatar.png'}" />
                            <img style="width: 150px; height: 150px; border-radius: 50%;"
                                src="/images/avatar/${headerAvatar}" />
                            <div class="text-center my-3">
                                <c:out value="${sessionScope.fullname}" />
                            </div>
                        </li>
                        <li><a class="dropdown-item" href="/client/update/${sessionScope.id}">Quản lý tài khoản</a></li>
                        <li><a class="dropdown-item" href="/client/history/${sessionScope.id}">Lịch sử mua hàng</a></li>
                        <li><a class="dropdown-item" href="/admin/settings">Cấu hình gửi mail</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <form method="post" action="/logout">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="dropdown-item">Đăng xuất</button>
                            </form>
                        </li>
                    </ul>
                </div>
            </ul>
        </nav>
