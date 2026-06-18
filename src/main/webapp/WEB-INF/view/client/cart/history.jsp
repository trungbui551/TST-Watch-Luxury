<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Mua Hàng - LapTopShop</title>
    
    <!-- Google Fonts Preconnect and Links for Luxury Theme -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Design System -->
    <link href="/resources/client/css/luxury-theme.css?v=1.5" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <style>
        body { padding-top: 72px; }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<div class="container py-5 mt-4" style="max-width: 1280px;">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-5">
        <ol class="breadcrumb" style="font-size: 12px; letter-spacing: 1px; text-transform: uppercase;">
            <li class="breadcrumb-item"><a href="/" style="color: var(--gold-accent); text-decoration: none;">Trang chủ</a></li>
            <li class="breadcrumb-item active" style="color: var(--text-muted);">Lịch sử mua hàng</li>
        </ol>
    </nav>

    <!-- Header -->
    <div class="mb-5">
        <h2 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary);">
            Lịch Sử Mua Hàng
        </h2>
        <p style="color: var(--text-muted); font-size: 14px; font-family: var(--font-body); font-weight: 300;">Quản lý và theo dõi hành trình các tuyệt tác quý khách đã đặt mua</p>
    </div>

    <c:if test="${empty orderList}">
        <div class="text-center py-5">
            <div class="mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="var(--gold-accent)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="16.5" y1="9.4" x2="7.5" y2="4.21"></line><polygon points="12 22.08 12 12 3 6.92 3 17.08 12 22.08"></polygon><polygon points="12 22.08 21 17.08 21 6.92 12 12 12 22.08"></polygon><polygon points="12 12 21 6.92 12 1.84 3 6.92 12 12"></polygon></svg>
            </div>
            <h3 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary); margin-bottom: 16px;">Chưa có đơn hàng nào</h3>
            <p style="color: var(--text-muted); font-family: var(--font-body); font-weight: 300; margin-bottom: 32px; font-size: 14px;">Quý khách chưa thực hiện đặt mua đơn hàng nào trên hệ thống.</p>
            <a href="/" class="btn-luxury" style="font-size: 12px; padding: 12px 28px;">Khám phá bộ sưu tập</a>
        </div>
    </c:if>

    <div class="d-flex flex-column gap-4">
        <c:forEach var="order" items="${orderList}">
            <div class="luxury-card" style="padding: 24px 32px !important;">
                <!-- Order Header -->
                <div class="d-flex justify-content-between align-items-center mb-4 pb-4" style="border-bottom: 1px solid var(--border-thin);">
                    <div>
                        <h5 style="font-family: var(--font-heading); font-weight: 500; margin: 0; color: var(--text-primary); text-transform: uppercase; letter-spacing: 1px; font-size: 15px;">
                            Đơn hàng 
                            <c:choose>
                                <c:when test="${not empty order.orderCode}">
                                    <span style="color: var(--gold-accent);">${order.orderCode}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: var(--gold-accent);">#${order.id}</span>
                                </c:otherwise>
                            </c:choose>
                        </h5>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${order.status == ' Đang xử lý'}">
                                <span style="background: rgba(212, 175, 55, 0.05); color: var(--gold-accent); border: 1px solid var(--border-thin); padding: 6px 16px; border-radius: var(--radius-sm); font-size: 12px; letter-spacing: 1px; text-transform: uppercase; font-family: var(--font-body); font-weight: 400;">
                                    Đang xử lý
                                </span>
                            </c:when>
                            <c:when test="${order.status == 'Hoàn tất'}">
                                <span style="background: rgba(16,185,129,0.05); color: #10b981; border: 1px solid rgba(16,185,129,0.2); padding: 6px 16px; border-radius: var(--radius-sm); font-size: 12px; letter-spacing: 1px; text-transform: uppercase; font-family: var(--font-body); font-weight: 400;">
                                    Hoàn tất
                                </span>
                            </c:when>
                            <c:when test="${order.status == 'Đã hủy'}">
                                <span style="background: rgba(239,68,68,0.05); color: #ef4444; border: 1px solid rgba(239,68,68,0.2); padding: 6px 16px; border-radius: var(--radius-sm); font-size: 12px; letter-spacing: 1px; text-transform: uppercase; font-family: var(--font-body); font-weight: 400;">
                                    Đã hủy
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span style="background: rgba(255,255,255,0.05); color: var(--text-muted); border: 1px solid var(--border-thin); padding: 6px 16px; border-radius: var(--radius-sm); font-size: 12px; letter-spacing: 1px; text-transform: uppercase; font-family: var(--font-body); font-weight: 400;">
                                    ${order.status}
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Products -->
                <c:forEach var="p" items="${order.orderDetails}">
                    <div class="d-flex justify-content-between align-items-center py-3" style="border-bottom: 1px solid var(--border-thin);">
                        <div class="d-flex align-items-center gap-3">
                            <div style="width: 56px; height: 56px; padding: 4px; border: 1px solid var(--border-thin); border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.02);">
                                <img src="/images/product/${p.product.image}" alt="${p.product.name}"
                                     style="max-width: 100%; max-height: 100%; object-fit: contain;">
                            </div>
                            <div>
                                <div style="font-weight: 400; color: var(--text-primary); font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 0.5px; font-size: 14px;">${p.product.name}</div>
                                <div style="font-size: 12px; color: var(--text-muted); font-family: var(--font-body); font-weight: 300;">Số lượng: x${p.quantity}</div>
                            </div>
                        </div>
                        <div style="font-weight: 400; color: var(--text-primary); font-family: var(--font-body);">
                            <fmt:formatNumber type="number" value="${p.price}"/> đ
                        </div>
                    </div>
                </c:forEach>

                <!-- Order Total -->
                <div class="d-flex justify-content-between align-items-center mt-4 pt-3">
                    <span style="color: var(--text-muted); font-size: 13px; font-family: var(--font-body); font-weight: 300; text-transform: uppercase; letter-spacing: 1px;">Tổng đơn hàng</span>
                    <span style="font-weight: 400; font-size: 1.2rem; color: var(--gold-accent); font-family: var(--font-body);">
                        <fmt:formatNumber type="number" value="${order.totalPrice}"/> đ
                    </span>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="text-center mt-5">
        <a href="/" class="btn-luxury-action" style="width: auto; padding: 14px 36px !important;">
            Quay lại trang chủ
        </a>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
