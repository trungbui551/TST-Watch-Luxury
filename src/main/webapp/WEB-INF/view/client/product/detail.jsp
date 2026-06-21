<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Chi tiết sản phẩm cao cấp tại LapTopShop - Bảo hành đặc quyền.">
    <title><c:out value="${pro.name}"/> - LapTopShop</title>

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

    <link href="/resources/client/css/product/detail.css?v=1.5" rel="stylesheet">
</head>

<body>

    <!-- Spinner -->
    <div id="spinner" class="w-100 vh-100 bg-black position-fixed translate-middle top-50 start-50
                              align-items-center justify-content-center" style="z-index:9999; display: flex;">
        <div class="spinner-grow" role="status" style="color: var(--gold-accent);"></div>
    </div>

    <jsp:include page="../layout/header.jsp"/>

    <!-- Breadcrumb -->
    <div class="container mt-4" style="max-width: 1280px;">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb m-0" style="font-size: 12px; letter-spacing: 1px; text-transform: uppercase;">
                <li class="breadcrumb-item"><a href="/" style="color: var(--gold-accent); text-decoration: none;">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page" style="color: var(--text-muted);">
                    <c:out value="${pro.name}"/>
                </li>
            </ol>
        </nav>
    </div>

    <!-- Product Detail -->
    <main class="container py-4" style="max-width: 1280px;">
        <div class="row g-5">

            <!-- Image Column -->
            <div class="col-md-6 d-flex flex-column gap-3">
                <div class="position-relative detail-image-zoom-container" id="watchZoomContainer" style="overflow: hidden; border: 1px solid var(--border-thin); border-radius: var(--radius-md); background: rgba(255,255,255,0.01); aspect-ratio: 1; display: flex; align-items: center; justify-content: center;">
                    <!-- Mũi tên trái -->
                    <button type="button" id="prevProductImg" class="btn-gallery-nav position-absolute start-0 top-50 translate-middle-y ms-3" aria-label="Ảnh trước">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
                    </button>
                    
                    <img src="/images/product/<c:out value='${pro.image}'/>"
                         alt="<c:out value='${pro.name}'/>"
                         id="watchZoomImage"
                         loading="eager"
                         style="transition: opacity 0.3s ease; max-width: 100%; max-height: 100%; object-fit: contain;">
                         
                    <!-- Mũi tên phải -->
                    <button type="button" id="nextProductImg" class="btn-gallery-nav position-absolute end-0 top-50 translate-middle-y me-3" aria-label="Ảnh sau">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </button>
                </div>
                
                <!-- Thumbnails -->
                <div class="product-gallery-thumbnails d-flex gap-2 overflow-x-auto py-1" style="scrollbar-width: thin;">
                    <!-- Thumbnail của ảnh chính -->
                    <div class="gallery-thumb-item active" data-img="/images/product/${pro.image}">
                        <img src="/images/product/${pro.image}" alt="Thumbnail" />
                    </div>
                    <!-- Thumbnails của ảnh phụ -->
                    <c:if test="${not empty pro.images}">
                        <c:forEach var="subImg" items="${pro.images.split(',')}">
                            <c:if test="${not empty subImg}">
                                <div class="gallery-thumb-item" data-img="/images/product/${subImg}">
                                    <img src="/images/product/${subImg}" alt="Thumbnail" />
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <!-- Info Column -->
            <div class="col-md-6">
                <div class="luxury-card h-100" style="padding: 32px !important; display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <!-- Brand/Factory -->
                        <div style="font-family: var(--font-body); font-size: 12px; font-weight: 300; letter-spacing: 2.5px; text-transform: uppercase; color: var(--gold-accent);" class="mb-2">
                            <c:out value="${pro.factory}"/>
                        </div>

                        <!-- Product Title -->
                        <h1 style="font-family: var(--font-heading) !important; font-weight: 400 !important; font-size: clamp(1.8rem, 3.5vw, 2.5rem); color: var(--text-primary); margin-bottom: 16px; text-transform: uppercase; letter-spacing: 0.5px; line-height: 1.2;">
                            <c:out value="${pro.name}"/>
                        </h1>

                        <!-- Ratings / Stars -->
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <div style="font-size: 13px;">
                                <i class="fa fa-star star-filled"></i>
                                <i class="fa fa-star star-filled"></i>
                                <i class="fa fa-star star-filled"></i>
                                <i class="fa fa-star star-filled"></i>
                                <i class="fa fa-star star-empty"></i>
                            </div>
                            <span style="color: var(--text-muted); font-size: 13px; letter-spacing: 0.5px;">(4.0 / 5)</span>
                        </div>

                        <!-- Price -->
                        <div style="font-family: var(--font-body); font-size: 1.8rem; font-weight: 300; color: var(--gold-accent); margin-bottom: 24px; letter-spacing: 0.5px;">
                            <fmt:formatNumber type="number" value="${pro.price}"/> đ
                        </div>

                        <!-- Short Description -->
                        <p style="color: var(--text-muted); line-height: 1.8; font-size: 14px; font-family: var(--font-body); font-weight: 300; text-align: justify;" class="mb-4">
                            <c:out value="${pro.shortDesc}"/>
                        </p>
                    </div>

                    <div>
                        <!-- Quantity & Add to Cart form -->
                        <form action="/add-product-to-cart/${pro.id}" method="post" class="w-100 mb-4">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                            <div class="d-flex flex-column gap-3">
                                <div>
                                    <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin-bottom: 8px;">Số lượng</div>
                                    <div class="qty-control-luxury">
                                        <button type="button" class="qty-btn-luxury" id="qtyMinus" aria-label="Giảm số lượng">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                        </button>
                                        <input type="text" class="qty-input-luxury" name="quantity" value="1"
                                               id="qtyInput" min="1" readonly aria-label="Số lượng">
                                        <button type="button" class="qty-btn-luxury" id="qtyPlus" aria-label="Tăng số lượng">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                        </button>
                                    </div>
                                </div>
                                <button type="submit" class="btn-luxury-action">
                                    Thêm vào giỏ hàng
                                </button>
                            </div>
                        </form>

                        <!-- Guarantees -->
                        <div class="d-flex gap-4 pt-4" style="border-top: 1px solid var(--border-thin); flex-wrap: wrap;">
                            <div class="d-flex align-items-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--gold-accent)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shield"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                                <span style="font-size: 13px; color: var(--text-muted); letter-spacing: 0.5px;">Bảo hành đặc quyền 24 tháng</span>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--gold-accent)" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-rotate-ccw"><polyline points="1 4 1 10 7 10"></polyline><path d="M3.51 15a9 9 0 1 0 2.13-9.36L1 10"></path></svg>
                                <span style="font-size: 13px; color: var(--text-muted); letter-spacing: 0.5px;">Đổi trả tận nơi 30 ngày</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Description Tabs -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="luxury-card" style="padding: 32px !important;">
                    <nav class="detail-tab-nav">
                        <div class="nav nav-tabs mb-4">
                            <button class="nav-link active" id="tab-desc" type="button"
                                    data-bs-toggle="tab" data-bs-target="#pane-desc"
                                    role="tab" aria-selected="true">
                                Mô tả chi tiết
                            </button>
                            <button class="nav-link" id="tab-review" type="button"
                                    data-bs-toggle="tab" data-bs-target="#pane-review"
                                    role="tab" aria-selected="false">
                                Đánh giá khách hàng
                            </button>
                        </div>
                    </nav>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="pane-desc" role="tabpanel">
                            <div style="color: var(--text-muted); line-height: 1.8; font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                                <c:out value="${pro.detailDesc}" escapeXml="false"/>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pane-review" role="tabpanel">
                            <!-- Sample review -->
                            <div class="d-flex gap-3 mb-4 pb-4" style="border-bottom: 1px solid var(--border-thin);">
                                <img src="/images/avatar/default.png" class="review-avatar" alt="Avatar">
                                <div>
                                    <div class="d-flex align-items-center gap-2 mb-1">
                                        <strong style="font-family: var(--font-heading); color: var(--text-primary);">Trần Quốc Trung</strong>
                                        <span style="font-size: 12px; color: var(--text-muted);">12 Tháng 5, 2026</span>
                                    </div>
                                    <div class="mb-2">
                                        <i class="fa fa-star star-filled"></i>
                                        <i class="fa fa-star star-filled"></i>
                                        <i class="fa fa-star star-filled"></i>
                                        <i class="fa fa-star star-filled"></i>
                                        <i class="fa fa-star star-empty"></i>
                                    </div>
                                    <p style="color: var(--text-muted); margin: 0; font-size: 14px; font-family: var(--font-body); font-weight: 300;">
                                        Đồng hồ cơ khí tinh xảo, mặt số chi tiết và giữ giờ rất tốt. Dịch vụ chăm sóc khách hàng đặc quyền của LapTopShop vô cùng chu đáo. Rất hài lòng!
                                    </p>
                                </div>
                            </div>

                            <!-- Leave a reply form -->
                            <h5 style="font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1.5px; font-size: 15px; color: var(--text-primary); margin-bottom: 24px;">
                                Gửi phản hồi của bạn
                            </h5>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="reviewName" class="form-label" style="font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted);">Họ tên</label>
                                        <input type="text" id="reviewName" class="form-control"
                                               style="background: transparent; border-radius: var(--radius-sm); border: 1px solid var(--border-thin); color: white;"
                                               placeholder="Họ tên của bạn">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="reviewEmail" class="form-label" style="font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted);">Email</label>
                                        <input type="email" id="reviewEmail" class="form-control"
                                               style="background: transparent; border-radius: var(--radius-sm); border: 1px solid var(--border-thin); color: white;"
                                               placeholder="Địa chỉ Email">
                                    </div>
                                    <div class="col-12">
                                        <label for="reviewContent" class="form-label" style="font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted);">Nội dung</label>
                                        <textarea id="reviewContent" class="form-control" rows="4"
                                                  style="background: transparent; border-radius: var(--radius-sm); border: 1px solid var(--border-thin); color: white;"
                                                  placeholder="Chia sẻ cảm nhận của bạn về sản phẩm..."></textarea>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn-luxury-action" style="width: auto; padding: 12px 32px !important;">
                                            Gửi đánh giá
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <c:if test="${not empty pros}">
        <div class="mt-5">
            <h2 style="font-family: var(--font-heading); text-transform: uppercase; letter-spacing: 1.5px; font-size: clamp(1.4rem, 2.5vw, 1.8rem); color: var(--text-primary); margin-bottom: 32px;">
                Tuyệt tác liên quan
            </h2>
            <div class="related-carousel-wrapper">
                <div class="related-carousel-track">
                    <c:forEach var="related" items="${pros}">
                        <div class="related-carousel-item">
                            <div class="luxury-card-watch d-flex flex-column h-100" style="position: relative;">
                                <div class="luxury-badge" style="position: absolute; top: 16px; left: 16px; z-index: 10;">NEW</div>
                                <a href="/product/${related.id}" class="product-img-wrap d-block mb-3">
                                    <img src="/images/product/<c:out value='${related.image}'/>"
                                         alt="<c:out value='${related.name}'/>"
                                         class="product-img-hover" loading="lazy">
                                </a>
                                <div class="mt-auto">
                                    <a href="/product/${related.id}" class="d-block mb-2 text-decoration-none">
                                        <h5 class="product-title">
                                            <c:out value="${related.name}"/>
                                        </h5>
                                    </a>
                                    <div class="d-flex align-items-center justify-content-between mt-3 pt-3"
                                         style="border-top: 1px solid var(--border-thin) !important;">
                                        <div class="product-price" style="font-size: 1.1rem !important;">
                                            <fmt:formatNumber type="number" value="${related.price}"/> đ
                                        </div>
                                        <form action="/add-product-to-cart/${related.id}" method="post" class="m-0">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button type="submit" class="btn-cart-circle"
                                                    title="Thêm vào giỏ hàng" aria-label="Thêm vào giỏ">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-cart"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- Pagination giống ở trang chủ -->
            <ul class="premium-pagination justify-content-center mt-4" id="carouselPagination"></ul>
        </div>
        </c:if>
    </main>

    <jsp:include page="../layout/feature.jsp"/>
    <jsp:include page="../layout/footer.jsp"/>

    <!-- Back to Top -->
    <a href="#" class="back-to-top" aria-label="Lên đầu trang">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-arrow-up"><line x1="12" y1="19" x2="12" y2="5"></line><polyline points="5 12 12 5 19 12"></polyline></svg>
    </a>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/client/js/product/detail.js?v=1.5" defer></script>
</body>
</html>
