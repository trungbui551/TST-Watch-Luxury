<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Tạo tài khoản TST Watch Luxury để mua sắm các tuyệt tác thời gian chính hãng.">
    <title>Đăng Ký - TST Watch Luxury</title>
    
    <!-- Google Fonts Preconnect and Links for Luxury Theme -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Design System Sheet -->
    <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

    <link href="/resources/client/css/auth/register.css?v=1.5" rel="stylesheet">
</head>

<body class="auth-body-luxury">

    <div class="auth-card-luxury" style="max-width: 520px;">
        <!-- Logo -->
        <div class="auth-logo-luxury">
            <span style="color: white; font-family: var(--font-heading);">TST Watch</span> <span style="color: var(--gold-accent); font-family: var(--font-heading);">Luxury</span>
        </div>
        <p class="auth-subtitle-luxury">Đăng ký tài khoản thành viên để nhận đặc quyền VIP</p>

        <!-- Form -->
        <form:form method="post" modelAttribute="newRegisterDTO" action="/register">
            <c:set var="errorPassword">
                <form:errors path="repeatPassword" cssClass="invalid-feedback-luxury" />
            </c:set>
            <c:set var="errorEmail">
                <form:errors path="email" cssClass="invalid-feedback-luxury" />
            </c:set>

            <!-- Họ và Tên -->
            <div class="row g-3 mb-3">
                <div class="col-6 text-start">
                    <label class="checkout-label-luxury">Tên của quý khách</label>
                    <form:input type="text" class="auth-input-luxury" path="firstName"
                        placeholder="Nhập tên" />
                </div>
                <div class="col-6 text-start">
                    <label class="checkout-label-luxury">Họ</label>
                    <form:input type="text" class="auth-input-luxury" path="lastName"
                        placeholder="Nhập họ" />
                </div>
            </div>

            <!-- Email -->
            <div class="mb-3 text-start">
                <label class="checkout-label-luxury">Địa chỉ Email</label>
                <form:input type="email"
                    class="auth-input-luxury ${not empty errorEmail ? 'is-invalid' : ''}" path="email"
                    placeholder="example@gmail.com" />
                ${errorEmail}
            </div>

            <!-- Mật khẩu -->
            <div class="mb-3 text-start">
                <label class="checkout-label-luxury">Thiết lập mật khẩu</label>
                <div style="position: relative;">
                    <form:input type="password" class="auth-input-luxury" path="password" id="password"
                        placeholder="Tạo mật khẩu mạnh" />
                    <button type="button" class="eye-toggle-luxury" id="togglePassword">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye-off" id="eyeIcon1"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                    </button>
                </div>
            </div>

            <!-- Xác nhận mật khẩu -->
            <div class="mb-4 text-start">
                <label class="checkout-label-luxury">Xác nhận mật khẩu</label>
                <div style="position: relative;">
                    <form:input type="password"
                        class="auth-input-luxury ${not empty errorPassword ? 'is-invalid' : ''}"
                        path="repeatPassword" id="repeatPassword" placeholder="Nhập lại mật khẩu" />
                    <button type="button" class="eye-toggle-luxury" id="toggleRepeatPassword">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-eye-off" id="eyeIcon2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                    </button>
                </div>
                ${errorPassword}
            </div>

            <button type="submit" class="btn-luxury-action mb-4" id="submitBtn">
                Tạo Tài Khoản
            </button>
        </form:form>

        <div class="mt-2">
            <span style="color: var(--text-muted); font-size: 12px; font-family: var(--font-body); font-weight: 300;">Đã có tài khoản đăng ký?</span>
            <a href="/login" class="auth-link-luxury ms-1">Đăng nhập ngay</a>
        </div>
        <div class="mt-3 pt-3 border-top border-secondary border-opacity-25 text-center">
            <a href="/" class="auth-link-luxury" style="font-size: 13px; font-weight: 500;">
                <i class="fas fa-arrow-left me-1"></i> Tiếp tục xem trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/client/js/auth/register.js?v=1.5" defer></script>
</body>

</html>
