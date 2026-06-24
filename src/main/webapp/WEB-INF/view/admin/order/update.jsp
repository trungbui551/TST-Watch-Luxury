<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Cập Nhật Đơn Hàng - Luxury Admin</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

    <style>
        :root {
            --luxury-primary: #1a1a1a;
            --luxury-accent: #d4af37; /* Luxury Gold */
            --luxury-accent-hover: #b89327;
            --luxury-bg: #f8f9fa;
            --luxury-card-bg: #ffffff;
            --luxury-border: #e9ecef;
            --luxury-text-muted: #6c757d;
            --font-heading: 'Playfair Display', serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            font-family: var(--font-body);
            background-color: var(--luxury-bg);
            color: var(--luxury-primary);
        }

        .luxury-card {
            background-color: var(--luxury-card-bg);
            border: 1px solid var(--luxury-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .luxury-card:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
        }

        .luxury-card-header {
            background-color: var(--luxury-primary);
            border-bottom: 2px solid var(--luxury-accent);
            padding: 24px;
            color: #ffffff;
        }

        .luxury-card-header h5 {
            font-family: var(--font-heading);
            font-size: 1.25rem;
            letter-spacing: 0.5px;
        }

        .luxury-form-label {
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--luxury-text-muted);
            margin-bottom: 8px;
        }

        .luxury-input-readonly {
            background-color: #ffffff !important;
            border: 1px solid var(--luxury-border);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.95rem;
            color: var(--luxury-primary);
            font-weight: 500;
            transition: border-color 0.2s ease;
        }

        .luxury-input-readonly:focus {
            border-color: var(--luxury-accent);
            box-shadow: none;
        }

        .luxury-select {
            border: 2px solid var(--luxury-border);
            border-radius: 8px;
            padding: 12px 16px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .luxury-select:focus {
            border-color: var(--luxury-accent);
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.15);
        }

        .btn-luxury-back {
            border: 1px solid var(--luxury-primary);
            color: var(--luxury-primary);
            background: transparent;
            padding: 12px 28px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-luxury-back:hover {
            background-color: var(--luxury-primary);
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-luxury-submit {
            background-color: var(--luxury-accent);
            border: 1px solid var(--luxury-accent);
            color: var(--luxury-primary);
            padding: 12px 28px;
            font-weight: 700;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.2);
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-luxury-submit:hover {
            background-color: var(--luxury-accent-hover);
            border-color: var(--luxury-accent-hover);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.35);
        }

        .order-code-badge {
            font-family: monospace;
            background-color: rgba(212, 175, 55, 0.1);
            color: var(--luxury-accent);
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 700;
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="mb-1" style="font-family: var(--font-heading); font-weight: 600;">Cập Nhật Đơn Hàng</h2>
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb mb-0" style="font-size: 0.85rem;">
                                    <li class="breadcrumb-item"><a href="/admin/order" style="color: var(--luxury-accent); text-decoration: none;">Đơn Hàng</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Cập Nhật Trạng Thái</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                    <hr class="mb-4" style="opacity: 0.1;" />
                    
                    <div class="row">
                        <div class="col-lg-8 col-xl-6 mx-auto">
                            <div class="luxury-card mb-5">
                                <div class="luxury-card-header">
                                    <h5 class="mb-0 d-flex justify-content-between align-items-center">
                                        <span>THÔNG TIN ĐƠN HÀNG</span>
                                        <span class="order-code-badge">${order.orderCode}</span>
                                    </h5>
                                </div>
                                <div class="card-body p-4 p-md-5">
                                    <form:form action="/admin/order/update" method="POST" modelAttribute="order">
                                        <!-- Hidden field for ID -->
                                        <form:hidden path="id" />

                                        <!-- Hidden fields for other fields to prevent JPA from setting them to null -->
                                        <form:hidden path="receiverName" />
                                        <form:hidden path="receiverPhone" />
                                        <form:hidden path="receiverAddress" />
                                        <form:hidden path="totalPrice" />
                                        <form:hidden path="orderCode" />
                                        <form:hidden path="orderDate" />
                                        <form:hidden path="user.id" />

                                        <div class="mb-4">
                                            <label class="luxury-form-label d-block">Mã Đơn Hàng</label>
                                            <input type="text" class="form-control luxury-input-readonly font-monospace fw-bold text-primary" value="${order.orderCode}" readonly />
                                        </div>

                                        <div class="row g-3 mb-4">
                                            <div class="col-md-6">
                                                <label class="luxury-form-label d-block">Khách Hàng</label>
                                                <input type="text" class="form-control luxury-input-readonly" value="${order.receiverName}" readonly />
                                            </div>
                                            <div class="col-md-6">
                                                <label class="luxury-form-label d-block">Số Điện Thoại</label>
                                                <input type="text" class="form-control luxury-input-readonly" value="${order.receiverPhone}" readonly />
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <label class="luxury-form-label d-block">Tổng Giá Trị Đơn Hàng</label>
                                            <div class="input-group">
                                                <input type="text" class="form-control luxury-input-readonly text-danger fw-bold fs-5" value="<fmt:formatNumber type='number' value='${order.totalPrice}' />" readonly />
                                                <span class="input-group-text bg-white border-start-0" style="border: 1px solid var(--luxury-border); border-top-right-radius: 8px; border-bottom-right-radius: 8px;">đ</span>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <label class="luxury-form-label d-block">Địa Chỉ Giao Nhận</label>
                                            <textarea class="form-control luxury-input-readonly" rows="2" style="resize: none;" readonly>${order.receiverAddress}</textarea>
                                        </div>

                                        <div class="mb-5">
                                            <label for="statusSelect" class="luxury-form-label d-block" style="color: var(--luxury-primary);">Trạng Thái Đơn Hàng</label>
                                            <form:select class="form-select luxury-select" path="status" id="statusSelect">
                                                <form:option value="PENDING">Chờ xử lý</form:option>
                                                <form:option value="SHIPPING">Đang giao hàng</form:option>
                                                <form:option value="DELIVERED">Hoàn tất</form:option>
                                                <form:option value="CANCELLED">Đã hủy</form:option>
                                                <form:option value=" Đang xử lý">Đang xử lý</form:option>
                                                <form:option value="Hoàn tất">Hoàn tất</form:option>
                                                <form:option value="Đã hủy">Đã hủy</form:option>
                                            </form:select>
                                        </div>

                                        <div class="d-flex justify-content-between align-items-center pt-3 border-top" style="border-top: 1px solid var(--luxury-border) !important;">
                                            <a href="/admin/order" class="btn-luxury-back">
                                                <i class="fas fa-arrow-left me-2"></i> Quay lại
                                            </a>
                                            <button type="submit" class="btn-luxury-submit">
                                                <i class="fas fa-check me-2"></i> Lưu thay đổi
                                            </button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>
