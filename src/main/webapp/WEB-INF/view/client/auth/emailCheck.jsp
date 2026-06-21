<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Email xác thực đã được gửi thành công - TST Watch Luxury.">
    <title>Email Đã Gửi - TST Watch Luxury</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&family=Inter:wght@100;200;300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">

    <!-- Design System -->
    <link href="/resources/client/css/luxury-theme.css?v=1.5" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

    <link href="/resources/client/css/auth/email-check.css?v=1.5" rel="stylesheet">
</head>

<body style="margin:0; padding:0; background:#0b0c10;">

    <!-- Animated background -->
    <div class="email-check-bg" aria-hidden="true"></div>

    <div class="email-check-wrapper">
        <div class="email-check-card" role="main">

            <!-- Logo -->
            <div class="email-check-logo">
                <span class="logo-main">TST</span>&nbsp;<span class="logo-accent">Watch</span>
            </div>

            <!-- Animated email icon with check badge -->
            <div class="email-icon-wrap" aria-hidden="true">
                <div class="email-icon-bg">
                    <!-- Envelope SVG -->
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="2" y="4" width="20" height="16" rx="2"/>
                        <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/>
                    </svg>
                </div>
                <!-- Check badge -->
                <div class="email-icon-badge">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"/>
                    </svg>
                </div>
            </div>

            <!-- Status badge -->
            <div>
                <span class="status-badge">
                    <span class="status-badge-dot"></span>
                    Đã gửi thành công
                </span>
            </div>

            <!-- Gold divider -->
            <div class="gold-divider" aria-hidden="true"></div>

            <!-- Title -->
            <h1 class="email-check-title">Email xác thực đã được gửi</h1>

            <!-- Description -->
            <p class="email-check-desc">
                Chúng tôi vừa gửi liên kết đặt lại mật khẩu đến hộp thư của quý khách.<br>
                Vui lòng kiểm tra email và làm theo hướng dẫn để <strong>khôi phục tài khoản</strong>.
            </p>

            <!-- Info tip box -->
            <div class="email-info-box">
                <!-- Info icon -->
                <svg class="email-info-box-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/>
                    <path d="M12 16v-4M12 8h.01"/>
                </svg>
                <span class="email-info-box-text">
                    Nếu không thấy email, vui lòng kiểm tra thư mục <strong style="color: rgba(212,175,55,0.8);">Spam / Thư rác</strong>.
                    Liên kết có hiệu lực trong <strong style="color: rgba(212,175,55,0.8);">24 giờ</strong> kể từ khi gửi.
                </span>
            </div>

            <!-- Countdown timer -->
            <div class="countdown-block" id="countdownBlock">
                <p class="countdown-label">Thời gian còn hiệu lực</p>
                <div class="countdown-digits" id="countdownDigits" aria-live="polite" aria-label="Đếm ngược thời gian hiệu lực">
                    <div class="countdown-unit">
                        <div class="countdown-box" id="cdHours">00</div>
                        <span class="countdown-unit-label">Giờ</span>
                    </div>
                    <span class="countdown-sep" aria-hidden="true">:</span>
                    <div class="countdown-unit">
                        <div class="countdown-box" id="cdMinutes">00</div>
                        <span class="countdown-unit-label">Phút</span>
                    </div>
                    <span class="countdown-sep" aria-hidden="true">:</span>
                    <div class="countdown-unit">
                        <div class="countdown-box" id="cdSeconds">00</div>
                        <span class="countdown-unit-label">Giây</span>
                    </div>
                </div>
                <p class="countdown-expired" id="countdownExpired">
                    ⚠ Liên kết đã hết hiệu lực. Vui lòng gửi lại email.
                </p>
            </div>

            <!-- Action buttons -->
            <div class="email-check-actions">
                <a href="https://mail.google.com" target="_blank" rel="noopener noreferrer"
                   class="btn-email-primary" id="btnOpenMail">
                    <!-- Mail open icon -->
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21.2 8.4c.5.38.8.97.8 1.6v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V10a2 2 0 0 1 .8-1.6l8-6a2 2 0 0 1 2.4 0l8 6Z"/>
                        <path d="m22 10-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 10"/>
                    </svg>
                    Mở hộp thư email
                </a>

                <a href="${pageContext.request.contextPath}/login" class="btn-email-secondary" id="btnBackLogin">
                    <!-- Arrow left icon -->
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="m12 19-7-7 7-7"/>
                        <path d="M19 12H5"/>
                    </svg>
                    Quay lại đăng nhập
                </a>
            </div>

            <!-- Footer -->
            <p class="email-check-footer">
                Không nhận được email?
                <a href="${pageContext.request.contextPath}/forgotPassword">Gửi lại</a>
                &nbsp;·&nbsp;
                <a href="https://m.me/1172919639219485" target="_blank" rel="noopener noreferrer">Liên hệ hỗ trợ</a>
            </p>

        </div>
    </div>

    <script>
        window.AppConfig = {
            tokenExpiryEpoch: "${tokenExpiryEpoch}"
        };
    </script>
    <script src="/resources/client/js/auth/email-check.js?v=1.5" defer></script>

</body>
</html>
