<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta name="description"
                    content="LapTopShop - Chuyên cung cấp laptop cao cấp chính hãng với giá tốt nhất thị trường.">
                <title>TST Luxury - Trang chủ</title>

                <!-- Google Fonts Preconnect -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

                <!-- Luxury Design System Stylesheet -->
                <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">

                <!-- Bootstrap 5 -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">

                <!-- jQuery (defer-safe) -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js" defer></script>

                <!-- Custom CSS for Product Filter UI -->
                <link href="/resources/client/css/homepage/show.css?v=1.5" rel="stylesheet">
            </head>

            <body>

                <!-- Spinner: dùng d-none để Bootstrap không override display -->
                <div id="spinner"
                    class="d-none w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 align-items-center justify-content-center"
                    style="z-index:9999;">
                    <div class="spinner-grow" role="status" style="color: var(--color-primary);"></div>
                </div>


                <!-- Toast container (for messages) -->
                <div class="toast-container-custom" id="toastContainer"></div>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/banner.jsp" />

                <!-- Products Section -->
                <section class="container-fluid py-5" id="san-pham">
                    <div class="container py-4" style="max-width: 1280px;">

                        <div class="d-flex justify-content-between align-items-end border-bottom pb-4 mb-4"
                            style="border-color: var(--border-thin) !important;">
                            <div>
                                <h2
                                    style="font-family: var(--font-heading); font-weight: 400; font-size: clamp(1.8rem, 3vw, 2.5rem); text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-primary);">
                                    Tuyệt tác nổi bật
                                </h2>
                                <p
                                    style="color: var(--text-muted); margin: 4px 0 0; font-size: 14px; letter-spacing: 0.5px;">
                                    Kiến tạo chuẩn mực thượng lưu và cơ khí tinh xảo
                                </p>
                            </div>
                        </div>

                        <!-- Interactive Product Filters -->
                        <div class="filter-container">
                            <div class="row g-3 align-items-center mb-4">
                                <div class="col-lg-4 col-md-5">
                                    <div class="search-filter-wrapper">
                                        <i class="fas fa-search search-filter-icon"></i>
                                        <input type="text" id="searchFilter" class="search-filter-input"
                                            placeholder="Tìm sản phẩm nhanh..." value="<c:out value='${keyword}'/>">
                                    </div>
                                </div>
                                <div
                                    class="col-lg-8 col-md-7 d-flex flex-wrap justify-content-md-end gap-3 align-items-center">
                                    <div class="d-flex align-items-center gap-2">
                                        <span
                                            style="font-size: 14px; font-weight: 600; color: var(--color-text-secondary);">Mức
                                            giá:</span>
                                        <select id="priceFilter" class="filter-select">
                                            <option value="all" ${selectedPrice=='all' ? 'selected' : '' }>Tất cả mức
                                                giá</option>
                                            <option value="under10" ${selectedPrice=='under10' ? 'selected' : '' }>Dưới
                                                10 triệu</option>
                                            <option value="10to15" ${selectedPrice=='10to15' ? 'selected' : '' }>Từ 10 -
                                                15 triệu</option>
                                            <option value="15to20" ${selectedPrice=='15to20' ? 'selected' : '' }>Từ 15 -
                                                20 triệu</option>
                                            <option value="over20" ${selectedPrice=='over20' ? 'selected' : '' }>Trên 20
                                                triệu</option>
                                        </select>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span
                                            style="font-size: 14px; font-weight: 600; color: var(--color-text-secondary);">Sắp
                                            xếp:</span>
                                        <select id="sortFilter" class="filter-select">
                                            <option value="default" ${selectedSort=='default' ? 'selected' : '' }>Mặc
                                                định</option>
                                            <option value="priceAsc" ${selectedSort=='priceAsc' ? 'selected' : '' }>Giá:
                                                Thấp đến Cao</option>
                                            <option value="priceDesc" ${selectedSort=='priceDesc' ? 'selected' : '' }>
                                                Giá: Cao đến Thấp</option>
                                            <option value="nameAsc" ${selectedSort=='nameAsc' ? 'selected' : '' }>Tên: A
                                                - Z</option>
                                            <option value="nameDesc" ${selectedSort=='nameDesc' ? 'selected' : '' }>Tên:
                                                Z - A</option>
                                        </select>
                                    </div>
                                    <button id="clearFiltersBtn" class="clear-filter-btn d-none">
                                        <i class="fas fa-times"></i> Xóa bộ lọc
                                    </button>
                                </div>
                            </div>

                            <!-- Brand filter -->
                            <div class="mb-3">
                                <div class="filter-group-title">Hãng sản xuất</div>
                                <div id="brandPillContainer" class="d-flex flex-wrap align-items-center"
                                    style="gap: 8px;">
                                    <button class="filter-pill active" data-brand="all">Tất cả</button>
                                </div>
                            </div>
 
                            <!-- Target filter -->
                            <div class="mb-3">
                                <div class="filter-group-title">Nhu cầu sử dụng</div>
                                <div id="targetPillContainer" class="d-flex flex-wrap align-items-center"
                                    style="gap: 8px;">
                                    <button class="filter-pill active" data-target="all">Tất cả</button>
                                </div>
                            </div>
                        </div>

                        <%-- Wrapper dùng cho AJAX replace --%>
                            <div id="productsSection">
                                <jsp:include page="products-partial.jsp" />
                            </div><%-- end #productsSection --%>
                    </div>
                </section>

                <!-- Features Section -->
                <jsp:include page="../layout/feature.jsp" />

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <a href="#" class="back-to-top" aria-label="Lên đầu trang">
                    <i class="fa fa-arrow-up"></i>
                </a>

                <!-- Scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    window.AppConfig = {
                        csrfParameterName: "${_csrf.parameterName}",
                        csrfToken: "${_csrf.token}",
                        selectedBrand: "${selectedFactory != null ? selectedFactory : 'all'}",
                        selectedTarget: "${selectedTarget != null ? selectedTarget : 'all'}",
                        selectedPrice: "${selectedPrice != null ? selectedPrice : 'all'}",
                        selectedSort: "${selectedSort != null ? selectedSort : 'default'}",
                        currentPage: ${currentPage != null ? currentPage : 1},
                        message: "<c:out value='${message}' />"
                    };
                </script>
                <script src="/resources/client/js/homepage/show.js?v=1.5" defer></script>
            </body>

            </html>
