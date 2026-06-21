<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - LapTopShop</title>
    
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
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<div class="container py-5 mt-4" style="max-width: 1280px;">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-5">
        <ol class="breadcrumb" style="font-size: 12px; letter-spacing: 1px; text-transform: uppercase;">
            <li class="breadcrumb-item"><a href="/" style="color: var(--gold-accent); text-decoration: none;">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="/cart" style="color: var(--gold-accent); text-decoration: none;">Giỏ hàng</a></li>
            <li class="breadcrumb-item active" style="color: var(--text-muted);">Thanh toán</li>
        </ol>
    </nav>

    <h2 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary); margin-bottom: 40px;">
        Xác Nhận Thanh Toán
    </h2>

    <form:form action="/place-order" method="post" modelAttribute="cart">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="row g-5">
            <!-- Thông tin giao hàng -->
            <div class="col-lg-6">
                <div class="luxury-card" style="padding: 32px !important;">
                    <h4 style="font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1.5px; font-size: 16px; color: var(--text-primary); margin-bottom: 24px;">
                        Thông Tin Giao Nhận
                    </h4>

                    <div class="mb-4">
                        <label class="checkout-label-luxury">Họ và tên người nhận</label>
                        <input type="text" class="checkout-input-luxury" id="receiverName" name="receiverName" placeholder="Nhập họ tên đầy đủ người nhận" required>
                    </div>
                    <div class="mb-4">
                        <label class="checkout-label-luxury">Địa chỉ giao hàng</label>
                        <input type="text" class="checkout-input-luxury" id="receiverAddress" name="receiverAddress" placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành" required>
                    </div>
                    <div class="mb-4">
                        <label class="checkout-label-luxury">Số điện thoại liên lạc</label>
                        <input type="text" class="checkout-input-luxury" id="receiverPhone" name="receiverPhone" placeholder="Nhập số điện thoại di động" required>
                    </div>

                    <div style="background: rgba(212, 175, 55, 0.03); border: 1px solid var(--border-thin); border-radius: var(--radius-sm); padding: 16px; margin-top: 24px;">
                        <p style="margin: 0; font-size: 13px; color: var(--text-muted); font-family: var(--font-body); font-weight: 300; letter-spacing: 0.5px; display: flex; align-items: center; gap: 8px;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--gold-accent)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-truck"><rect x="1" y="3" width="15" height="13"></rect><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon><circle cx="5.5" cy="18.5" r="2.5"></circle><circle cx="18.5" cy="18.5" r="2.5"></circle></svg>
                            <span><strong>Hình thức thanh toán:</strong> Giao hàng nhận tiền mặt (COD Đặc Quyền)</span>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Tóm tắt đơn hàng -->
            <div class="col-lg-6">
                <div class="luxury-card" style="padding: 32px !important;">
                    <h4 style="font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1.5px; font-size: 16px; color: var(--text-primary); margin-bottom: 24px;">
                        Chi Tiết Tuyệt Tác
                    </h4>

                    <div style="max-height: 300px; overflow-y: auto; margin-bottom: 24px; padding-right: 8px;">
                        <c:forEach var="de" items="${cartDetail}" varStatus="status">
                            <div class="d-flex justify-content-between align-items-center py-3" style="border-bottom: 1px solid var(--border-thin);">
                                <div class="d-flex align-items-center gap-3">
                                    <div style="width: 48px; height: 48px; padding: 4px; border: 1px solid var(--border-thin); border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.02);">
                                        <img src="/images/product/${de.product.image}"
                                             style="max-width: 100%; max-height: 100%; object-fit: contain;"
                                             alt="${de.product.name}">
                                    </div>
                                    <div>
                                        <div style="font-weight: 400; font-size: 14px; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.5px; font-family: var(--font-heading);">${de.product.name}</div>
                                        <div style="font-size: 12px; color: var(--text-muted); font-family: var(--font-body); font-weight: 300;">Số lượng: x${de.quantity}</div>
                                    </div>
                                </div>
                                <div style="font-weight: 400; color: var(--text-primary); font-size: 14px; font-family: var(--font-body);">
                                    <fmt:formatNumber type="number" value="${de.price * de.quantity}"/> đ
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-between mb-3" style="color: var(--text-muted); font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                        <span>Tạm tính</span>
                        <span id="subtotal" data-cart-total-price="${totalPrice}" style="font-weight: 400; color: var(--text-primary);">
                            <fmt:formatNumber type="number" value="${totalPrice}"/> đ
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-4" style="color: var(--text-muted); font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                        <span>Phí giao nhận đặc quyền</span>
                        <span id="shipping" style="font-weight: 400; color: var(--text-primary);">0 đ</span>
                    </div>

                    <div class="d-flex justify-content-between py-4" style="border-top: 1px solid var(--border-thin); border-bottom: 1px solid var(--border-thin); margin-bottom: 24px;">
                        <span style="font-weight: 500; font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-primary); letter-spacing: 1.5px; text-transform: uppercase;">Tổng cộng</span>
                        <span id="total" style="font-weight: 400; font-size: 1.25rem; color: var(--gold-accent); font-family: var(--font-body);"></span>
                    </div>

                    <!-- Hidden fields -->
                    <div style="display: none;">
                        <input value="${totalPrice}" name="totalPrice"/>
                        <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                            <form:input type="text" value="${cartDetail.id}" path="cartDetails[${status.index}].id"/>
                            <form:input type="text" value="${cartDetail.quantity}" path="cartDetails[${status.index}].quantity"/>
                        </c:forEach>
                    </div>

                    <button type="submit" class="btn-luxury-action">
                        Đặt Hàng Ngay
                    </button>
                </div>
            </div>
        </div>
    </form:form>
</div>

<jsp:include page="../layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/client/js/cart/checkout.js?v=1.5" defer></script>
</body>
</html>
