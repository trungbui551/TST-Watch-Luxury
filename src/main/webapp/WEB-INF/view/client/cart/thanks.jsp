<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cảm ơn quý khách! - LapTopShop</title>

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

    <link href="/resources/client/css/cart/thanks.css?v=1.5" rel="stylesheet">
</head>

<body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Main Content -->
    <div class="thank-you-wrapper container">
        <div class="thank-you-card">
            <!-- Icon -->
            <div class="success-icon-luxury">
                <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
            </div>

            <!-- Title -->
            <h1 class="thank-you-title">Cảm ơn quý khách!</h1>
            <p class="thank-you-subtitle">Đơn hàng của quý khách đã được thiết lập thành công trên hệ thống</p>

            <!-- Order info -->
            <div class="order-info">
                <div class="order-number-title">Mã số đơn hàng đặc quyền</div>
                <div class="order-id" id="orderId">DH-PENDING</div>

                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                        </span>
                        <div>
                            <div class="info-title">Email Xác Nhận</div>
                            <div class="info-value">Đã gửi thông tin đơn hàng</div>
                        </div>
                    </div>
                    <div class="info-item">
                        <span class="info-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
                        </span>
                        <div>
                            <div class="info-title">Vận Chuyển</div>
                            <div class="info-value">Giao nhận sau 2-3 ngày</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Steps list -->
            <div class="next-steps-card">
                <h3>Các bước tiếp theo</h3>
                <ul class="steps-list">
                    <li>
                        <div class="step-number">1</div>
                        <div>
                            <div class="step-title">Liên hệ xác nhận</div>
                            <div class="step-description">Chuyên viên chăm sóc khách hàng sẽ gọi điện xác minh thông tin đơn hàng trong 30 phút.</div>
                        </div>
                    </li>
                    <li>
                        <div class="step-number">2</div>
                        <div>
                            <div class="step-title">Đóng gói chuẩn VIP</div>
                            <div class="step-description">Tuyệt tác thời gian sẽ được kiểm tra cơ khí chi tiết, bọc đệm hộp cao cấp và đóng gói niêm phong.</div>
                        </div>
                    </li>
                    <li>
                        <div class="step-number">3</div>
                        <div>
                            <div class="step-title">Bàn giao đặc quyền</div>
                            <div class="step-description">Đơn vị vận chuyển hỏa tốc sẽ liên hệ trực tiếp để bàn giao sản phẩm tận tay quý khách.</div>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Support info -->
            <div class="contact-support">
                <h4>Hỗ trợ dịch vụ đặc quyền</h4>
                <p>Hotline hỗ trợ 24/7: <strong>1900-xxxx</strong> (Nhánh số 1)</p>
                <p>Địa chỉ Email: concierge@laptopshop.vn</p>
            </div>

            <!-- Actions -->
            <div class="d-flex flex-column flex-sm-row justify-content-center gap-3 mt-5">
                <a href="/" class="btn-luxury-action" style="width: auto; padding: 14px 32px !important;">
                    Tiếp tục mua sắm
                </a>
                <a href="/client/history/${sessionScope.id}" class="btn-luxury-action" 
                   style="width: auto; padding: 14px 32px !important; background: transparent !important; color: var(--gold-accent) !important; border: 1px solid var(--border-thin) !important;">
                    Lịch sử mua hàng
                </a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/client/js/cart/thanks.js?v=1.5" defer></script>
</body>

</html>
