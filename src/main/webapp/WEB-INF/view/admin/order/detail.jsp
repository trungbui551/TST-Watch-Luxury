<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Dashboard</title>
                    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                        rel="stylesheet" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manager Order</h1>
                                </div>
                            </main>
                            <div class="container mt-5">
                                <div class="card mb-4 shadow-sm" style="border-radius: 8px; overflow: hidden;">
                                    <div class="card-header bg-dark text-white py-3">
                                        <h5 class="mb-0 font-monospace">Thông Tin Đơn Hàng VIP</h5>
                                    </div>
                                    <div class="card-body bg-light p-4">
                                        <div class="row g-3">
                                            <div class="col-md-6 col-lg-3 border-end">
                                                <span class="text-muted small text-uppercase d-block">Mã Đơn Hàng</span>
                                                <strong class="text-primary font-monospace" style="font-size: 16px;">${order.orderCode}</strong>
                                                <span class="text-muted small d-block mt-1">ID Hệ thống: #${order.id}</span>
                                            </div>
                                            <div class="col-md-6 col-lg-3 border-end">
                                                <span class="text-muted small text-uppercase d-block">Khách Hàng Nhận</span>
                                                <strong class="text-dark">${order.receiverName}</strong>
                                                <span class="text-muted small d-block mt-1"><i class="fas fa-phone me-1"></i> ${order.receiverPhone}</span>
                                            </div>
                                            <div class="col-md-6 col-lg-3 border-end">
                                                <span class="text-muted small text-uppercase d-block">Địa Chỉ Giao Nhận</span>
                                                <span class="text-dark" style="font-size: 14px;">${order.receiverAddress}</span>
                                            </div>
                                            <div class="col-md-6 col-lg-3">
                                                <span class="text-muted small text-uppercase d-block">Tổng Giá Trị & Trạng Thái</span>
                                                <strong class="text-danger" style="font-size: 16px;">
                                                    <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                                </strong>
                                                <span class="badge bg-warning text-dark d-inline-block ms-2">${order.status}</span>
                                                <span class="text-muted small d-block mt-1">Ngày đặt: ${order.orderDate}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h3>Sản Phẩm Trong Đơn Hàng</h3>
                                            <a href="/admin/order" class="btn btn-secondary">Quay lại danh sách</a>
                                        </div>
                                        <hr />
                                        <table class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Hình ảnh</th>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Tên sản phẩm</th>
                                                    <th scope="col">Gía tiền </th>
                                                    <th scope="col">Số lượng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="orderDetail" items="${orderDetails}">
                                                    <tr>
                                                        <td scope="row">
                                                            <div class="d-flex align-items-center">
                                                                <img src="/images/product/${orderDetail.product.image}"
                                                                    class="img-fluid me-3 rounded-circle"
                                                                    style="width: 80px; height: 80px; object-fit: cover;" alt="">
                                                            </div>
                                                        </td>
                                                        <td>${orderDetail.id}</td>
                                                        <td>${orderDetail.product.name}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${orderDetail.price}" /> đ
                                                        </td>
                                                        <td>${orderDetail.quantity}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                        crossorigin="anonymous"></script>

                </body>

                </html>
