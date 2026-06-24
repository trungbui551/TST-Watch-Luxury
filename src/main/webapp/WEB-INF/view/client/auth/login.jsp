<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Đăng nhập vào hệ thống TST Watch Luxury để khám phá các tuyệt tác thời gian đặc quyền.">
    <title>Đăng Nhập - TST Watch Luxury</title>

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
</head>

<body class="auth-body-luxury">

    <div class="auth-card-luxury">
        <!-- Logo -->
        <div class="auth-logo-luxury">
            <span style="color: white; font-family: var(--font-heading);">TST Watch</span> <span style="color: var(--gold-accent); font-family: var(--font-heading);">Luxury</span>
        </div>
        <p class="auth-subtitle-luxury">Chào mừng quý khách trở lại. Vui lòng đăng nhập.</p>

        <!-- Error message -->
        <c:if test="${param.error != null}">
            <div class="auth-error-luxury">
                <i class="fas fa-exclamation-circle me-2"></i>
                Tên đăng nhập hoặc mật khẩu không chính xác.
            </div>
        </c:if>

        <!-- Login form -->
        <form method="post" action="/login" novalidate>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="mb-3">
                <input type="text" name="username" id="username"
                       class="auth-input-luxury" placeholder="Tên đăng nhập"
                       autocomplete="username" required
                       aria-label="Tên đăng nhập">
            </div>

            <div class="mb-4">
                <input type="password" name="password" id="password"
                       class="auth-input-luxury" placeholder="Mật khẩu"
                       autocomplete="current-password" required
                       aria-label="Mật khẩu">
            </div>

            <button type="submit" class="btn-luxury-action mb-4">
                Đăng nhập
            </button>
        </form>

        <div class="mt-2">
            <span style="color: var(--text-muted); font-size: 12px; font-family: var(--font-body); font-weight: 300;">Chưa có tài khoản đăng ký?</span>
            <a href="<%=request.getContextPath()%>/register" class="auth-link-luxury ms-1">Đăng ký ngay</a>
        </div>
        <div class="mt-2">
            <a href="<%=request.getContextPath()%>/forgotPassword" class="auth-link-luxury">Quên mật khẩu?</a>
        </div>
        <div class="mt-3 pt-3 border-top border-secondary border-opacity-25 text-center">
            <a href="/" class="auth-link-luxury" style="font-size: 13px; font-weight: 500;">
                <i class="fas fa-arrow-left me-1"></i> Tiếp tục xem trang chủ
            </a>
        </div>
    </div>

</body>
</html>
