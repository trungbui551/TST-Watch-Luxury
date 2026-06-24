<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Yêu cầu xác thực thất bại hoặc hết hạn - TST Watch Luxury.">
    <title>Yêu Cầu Không Hợp Lệ - TST Watch Luxury</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&family=Inter:wght@100;200;300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">

    <!-- Design System -->
    <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

    <!-- Custom CSS for Bad User Page -->
    <link href="/resources/client/css/auth/bad-user.css?v=1.5" rel="stylesheet">
</head>

<body style="margin:0; padding:0; background:#0b0c10;">

    <!-- Animated background -->
    <div class="bad-user-bg" aria-hidden="true"></div>

    <div class="bad-user-wrapper">
        <div class="bad-user-card" role="main">

            <!-- Logo -->
            <div class="bad-user-logo">
                <span class="logo-main">TST Watch</span>&nbsp;<span class="logo-accent">Luxury</span>
            </div>

            <!-- Animated warning icon -->
            <div class="error-icon-wrap" aria-hidden="true">
                <div class="error-icon-bg">
                    <!-- Warning SVG -->
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/>
                        <line x1="12" y1="9" x2="12" y2="13"/>
                        <line x1="12" y1="17" x2="12.01" y2="17"/>
                    </svg>
                </div>
            </div>

            <!-- Status badge -->
            <div>
                <span class="status-badge-error">
                    <span class="status-badge-dot-error"></span>
                    Yêu cầu thất bại
                </span>
            </div>

            <!-- Title -->
            <h1 class="bad-user-title">Không thể xác thực tài khoản</h1>

            <!-- Description -->
            <p class="bad-user-desc">
                Liên kết hoặc mã token dùng để xác nhận thao tác của quý khách đã gặp sự cố. Vui lòng xem chi tiết lỗi dưới đây.
            </p>

            <!-- Error message box -->
            <div class="error-msg-box">
                <svg class="error-msg-box-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <span class="error-msg-text">
                    <c:choose>
                        <c:when test="${not empty message}">
                            <c:out value="${message}"/>
                        </c:when>
                        <c:when test="${not empty param.message}">
                            <c:out value="${param.message}"/>
                        </c:when>
                        <c:otherwise>
                            Liên kết xác thực không hợp lệ hoặc đã hết hạn sử dụng.
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <!-- Action buttons -->
            <div class="bad-user-actions">
                <a href="${pageContext.request.contextPath}/forgotPassword" class="btn-error-primary">
                    <i class="fas fa-redo-alt me-2"></i> Gửi lại yêu cầu mới
                </a>

                <a href="${pageContext.request.contextPath}/" class="btn-error-secondary">
                    <i class="fas fa-home me-2"></i> Quay về trang chủ
                </a>
            </div>

            <!-- Footer -->
            <p class="bad-user-footer">
                Cần thêm sự trợ giúp?
                <a href="https://m.me/1172919639219485" target="_blank" rel="noopener noreferrer">Liên hệ bộ phận CSKH</a>
            </p>

        </div>
    </div>

    <!-- Entrance animations script -->
    <script src="/resources/client/js/auth/bad-user.js?v=1.5" defer></script>

</body>
</html>

