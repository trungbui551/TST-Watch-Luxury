<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Lấy lại mật khẩu tại TST Watch Luxury.">
    <title>Lấy Lại Mật Khẩu - TST Watch Luxury</title>

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
        <h2 style="color: var(--text-primary); font-family: var(--font-heading); font-size: 1.5rem; font-weight: 400; text-align: center; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 8px;">
            Lấy lại mật khẩu
        </h2>
        <p class="auth-subtitle-luxury">Nhập địa chỉ email đăng ký để nhận mã phục hồi đặc quyền.</p>

        <!-- Error / Warning message if passed -->
        <c:if test="${not empty error}">
            <div class="auth-error-luxury">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:out value="${error}"/>
            </div>
        </c:if>

        <form method="post" action="/handle-password">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <div class="mb-4">
                <input type="text" name="username" class="auth-input-luxury" placeholder="Địa chỉ Email của quý khách" required aria-label="Email" />
            </div>

            <button type="submit" class="btn-luxury-action mb-4">
                Lấy lại mật khẩu
            </button>
        </form>

        <div class="mt-2">
            <a href="<%=request.getContextPath() %>/login" class="auth-link-luxury">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 4px;"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg> Quay lại đăng nhập
            </a>
        </div>
    </div>
</body>

</html>
