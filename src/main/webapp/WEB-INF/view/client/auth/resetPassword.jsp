<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Tạo mật khẩu mới tại RoyalWatch.">
    <title>Đặt Lại Mật Khẩu - LapTopShop</title>

    <!-- Google Fonts Preconnect and Links for Luxury Theme -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Design System Sheet -->
    <link href="/resources/client/css/luxury-theme.css?v=1.5" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
</head>

<body class="auth-body-luxury">
    <div class="auth-card-luxury">
        <!-- Logo -->
        <div class="auth-logo-luxury">
            <span style="color: white; font-family: var(--font-heading);">Royal</span><span style="color: var(--gold-accent); font-family: var(--font-heading);">Watch</span>
        </div>
        <h2 style="color: var(--text-primary); font-family: var(--font-heading); font-size: 1.5rem; font-weight: 400; text-align: center; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 8px;">
            Tạo mật khẩu mới
        </h2>
        <p class="auth-subtitle-luxury">Vui lòng thiết lập mật khẩu mới có tính bảo mật cao.</p>

        <!-- Message holder for validation -->
        <div id="msg" class="auth-error-luxury d-none" style="margin-bottom: 24px;"></div>

        <form method="post" action="/resetPassword" onsubmit="return passwordChecking()">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" name="token" value="${token}" />

            <div class="mb-3">
                <input type="password" name="password" id="password" class="auth-input-luxury" placeholder="Mật khẩu mới" required aria-label="Mật khẩu mới" />
            </div>

            <div class="mb-4">
                <input type="password" name="repeatpassword" id="repeatpassword" class="auth-input-luxury" placeholder="Xác nhận lại mật khẩu" required aria-label="Xác nhận lại mật khẩu" />
            </div>

            <button type="submit" class="btn-luxury-action">
                Đổi mật khẩu
            </button>
        </form>
    </div>

    <script src="/resources/client/js/auth/reset-password.js?v=1.5" defer></script>
</body>

</html>
