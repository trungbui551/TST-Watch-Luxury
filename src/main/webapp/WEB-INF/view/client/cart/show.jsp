<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - LapTopShop</title>
    
    <!-- Google Fonts Preconnect and Links for Luxury Theme -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Design System -->
    <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/resources/client/css/cart/show.css?v=1.5" rel="stylesheet">
</head>

<body>

<jsp:include page="../layout/header.jsp" />

<div class="container py-5 mt-4" style="max-width: 1280px;">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-5">
        <ol class="breadcrumb" style="font-size: 12px; letter-spacing: 1px; text-transform: uppercase;">
            <li class="breadcrumb-item"><a href="/" style="color: var(--gold-accent); text-decoration: none;">Trang chủ</a></li>
            <li class="breadcrumb-item active" style="color: var(--text-muted);">Giỏ hàng</li>
        </ol>
    </nav>

    <h2 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary); margin-bottom: 40px;">
        Giỏ Hàng Của Bạn
        <c:if test="${not empty cart}">
            <span style="font-family: var(--font-body); font-size: 13px; font-weight: 300; color: var(--text-muted); letter-spacing: 1.5px; margin-left: 8px;">(${cart.sum} tuyệt tác)</span>
        </c:if>
    </h2>

    <c:if test="${not empty cart}">
        <div class="row g-5">
            <!-- Bảng sản phẩm -->
            <div class="col-lg-8">
                <div class="luxury-card p-0" style="overflow: hidden;">
                    <div class="table-responsive">
                        <table class="table cart-table mb-0" style="background: transparent;">
                            <thead>
                                <tr>
                                    <th scope="col">Hình ảnh</th>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Đơn giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="de" items="${cartDetail}" varStatus="status">
                                    <tr>
                                        <td>
                                            <div style="width: 72px; height: 72px; padding: 4px; border: 1px solid var(--border-thin); border-radius: var(--radius-sm); display: flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.02);">
                                                <img src="/images/product/${de.product.image}"
                                                     style="max-width: 100%; max-height: 100%; object-fit: contain;"
                                                     alt="${de.product.name}">
                                            </div>
                                        </td>
                                        <td>
                                            <a href="/product/${de.product.id}" class="text-decoration-none cart-product-title">
                                                <c:out value="${de.product.name}"/>
                                            </a>
                                            <div style="font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; margin-top: 4px; display: flex; gap: 12px; flex-wrap: wrap;">
                                                <span>Hãng: <c:out value="${de.product.factory}"/></span>
                                                <c:if test="${not empty de.size}">
                                                    <span style="color: var(--gold-accent);">Size: <c:out value="${de.size}"/></span>
                                                </c:if>
                                                <c:if test="${not empty de.color}">
                                                    <span style="color: var(--gold-accent);">Màu: <c:out value="${de.color}"/></span>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="color: var(--text-primary); font-family: var(--font-body); font-weight: 300;">
                                                <fmt:formatNumber type="number" value="${de.price}"/> đ
                                            </span>
                                        </td>
                                        <td>
                                            <div class="qty-control-luxury">
                                                <button type="button" class="qty-btn-luxury btn-minus" aria-label="Giảm số lượng">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                </button>
                                                <input type="text" class="qty-input-luxury qty-input" value="${de.quantity}"
                                                       data-cart-detail-id="${de.id}"
                                                       data-cart-detail-price="${de.price}"
                                                       data-cart-detail-index="${status.index}" readonly aria-label="Số lượng"
                                                       style="color: #d4af37; background: transparent;">
                                                <button type="button" class="qty-btn-luxury btn-plus" aria-label="Tăng số lượng">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                </button>
                                            </div>
                                        </td>
                                        <td>
                                            <span data-cart-detail-id="${de.id}" style="font-weight: 400; color: var(--gold-accent); font-family: var(--font-body);">
                                                <fmt:formatNumber type="number" value="${de.price*de.quantity}"/> đ
                                            </span>
                                        </td>
                                        <td>
                                            <form action="/delete-cart-detail/${de.id}" method="post" class="m-0">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="qty-btn-luxury" style="color: #ef4444;"
                                                        title="Xóa tuyệt tác khỏi giỏ">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Tóm tắt đơn hàng -->
            <div class="col-lg-4">
                <div class="luxury-card" style="padding: 32px !important;">
                    <h4 style="font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1.5px; font-size: 16px; color: var(--text-primary); margin-bottom: 24px;">Tóm tắt đơn hàng</h4>

                    <div class="d-flex justify-content-between mb-3" style="color: var(--text-muted); font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                        <span>Tạm tính</span>
                        <span id="subtotal" data-promo-active="${promoActive}" data-promo-discount="${promoDiscountPercent}" data-original-price="${originalPrice}" style="font-weight: 400; color: var(--text-primary);">
                            <fmt:formatNumber type="number" value="${originalPrice}"/> đ
                        </span>
                    </div>
                    <div id="promo-row" class="d-flex justify-content-between mb-3 ${promoActive == 'true' ? '' : 'd-none'}" style="color: var(--gold-accent); font-size: 14px; font-family: var(--font-body); font-weight: 400;">
                        <span>Khuyến mãi (${promoDiscountPercent}%)</span>
                        <span id="discount-amount">
                            - <fmt:formatNumber type="number" value="${originalPrice * promoDiscountPercent / 100}"/> đ
                        </span>
                    </div>
                    <div class="d-flex justify-content-between mb-4" style="color: var(--text-muted); font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                        <span>Phí giao nhận đặc quyền</span>
                        <span id="shipping" style="font-weight: 400; color: var(--text-primary);">0 đ</span>
                    </div>

                    <div class="d-flex justify-content-between py-4" style="border-top: 1px solid var(--border-thin); border-bottom: 1px solid var(--border-thin); margin-bottom: 24px;">
                        <span style="font-weight: 500; font-family: var(--font-heading); font-size: 1.1rem; color: var(--text-primary); letter-spacing: 1.5px; text-transform: uppercase;">Tổng cộng</span>
                        <span id="total" style="font-weight: 400; font-size: 1.25rem; color: var(--gold-accent); font-family: var(--font-body);">
                            <fmt:formatNumber type="number" value="${totalPrice}"/> đ
                        </span>
                    </div>

                    <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div style="display: none;">
                            <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                                <form:input type="text" value="${cartDetail.id}" path="cartDetails[${status.index}].id"/>
                                <form:input type="text" value="${cartDetail.quantity}" path="cartDetails[${status.index}].quantity"/>
                            </c:forEach>
                        </div>
                        <button type="submit" class="btn-luxury-action">
                            Tiến hành thanh toán
                        </button>
                    </form:form>

                    <a href="/" class="d-block text-center mt-4 text-decoration-none" style="color: var(--text-muted); font-size: 13px; font-family: var(--font-body); font-weight: 300; letter-spacing: 1px; transition: color 0.3s ease;" onmouseover="this.style.color='var(--gold-accent)'" onmouseout="this.style.color='var(--text-muted)'">
                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 4px;"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg> Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${empty cart}">
        <div class="text-center py-5">
            <div class="mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="var(--gold-accent)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
            </div>
            <h3 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary); margin-bottom: 16px;">Giỏ hàng của bạn đang trống</h3>
            <p style="color: var(--text-muted); font-family: var(--font-body); font-weight: 300; margin-bottom: 32px; font-size: 14px;">Hãy khám phá các tuyệt tác thời gian sang trọng nhất của chúng tôi!</p>
            <a href="/" class="btn-luxury" style="font-size: 12px; padding: 12px 28px;">Mua sắm ngay</a>
        </div>
    </c:if>
</div>

<jsp:include page="../layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/client/js/cart/show.js?v=1.5" defer></script>
</body>
</html>
