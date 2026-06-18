<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Order Page</h1>
                            </div>
                            <hr />
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                         <div class="d-flex justify-content-between align-items-center mb-3">
                                             <h3>Order Table</h3>
                                             <form action="/admin/order" method="GET" class="d-flex" style="max-width: 400px; width: 100%;">
                                                 <div class="input-group shadow-sm" style="border-radius: 8px; overflow: hidden;">
                                                     <input type="text" class="form-control border-end-0 py-2 px-3" name="search" placeholder="Tìm kiếm theo mã đơn..." value="${search}" aria-label="Search order code" style="border-top-left-radius: 8px; border-bottom-left-radius: 8px;">
                                                     <c:if test="${not empty search}">
                                                         <a href="/admin/order" class="btn btn-light border-top border-bottom d-flex align-items-center text-muted px-2" title="Xóa tìm kiếm" style="border-left: none; border-right: none;">
                                                             <i class="fas fa-times"></i>
                                                         </a>
                                                     </c:if>
                                                     <button class="btn btn-primary px-3 py-2 fw-semibold" type="submit" style="border-top-right-radius: 8px; border-bottom-right-radius: 8px;">
                                                         <i class="fas fa-search me-1"></i> Tìm
                                                     </button>
                                                 </div>
                                             </form>
                                         </div>
                                        <hr />
                                        <table class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Mã Đơn Hàng</th>
                                                    <th scope="col">Địa Chỉ Người Nhận</th>
                                                    <th scope="col">Tên Người Nhận </th>
                                                    <th scope="col">Số Điện Thoại</th>
                                                    <th scope="col">Trạng Thái</th>
                                                    <th scope="col">Gía Trị Đơn Hàng</th>
                                                    <th scope="col" style="width: 250px;">Actions</th>
                                                </tr>

                                            </thead>
                                            <tbody>

                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>${order.id}</td>
                                                        <td class="text-primary font-monospace fw-bold">${order.orderCode}</td>
                                                        <td>${order.receiverAddress}</td>
                                                        <td>${order.receiverName}</td>
                                                        <td>${order.receiverPhone}</td>
                                                         <td>
                                                             <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                                                         </td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${order.totalPrice}" /> đ
                                                        </td>
                                                        <td class="text-nowrap">
                                                            <a href="/admin/order/${order.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/order/update/${order.id}"
                                                                class="btn btn-warning mx-2">Update</a>
                                                            <button type="button" class="btn btn-danger btn-delete-order" data-id="${order.id}" data-code="${order.orderCode}" data-bs-toggle="modal" data-bs-target="#deleteOrderModal">Delete</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty orders}">
                                                    <tr>
                                                        <td colspan="8" class="text-center py-5 text-muted bg-light">
                                                            <i class="fas fa-box-open fa-3x mb-3 d-block text-secondary"></i>
                                                            <span class="fs-6 fw-semibold">Không tìm thấy đơn hàng nào khớp với từ khóa tìm kiếm.</span>
                                                            <p class="small text-muted mb-0 mt-1">Vui lòng thử lại với mã đơn hàng khác.</p>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>

                        <!-- Modal xác nhận xóa Order -->
                        <div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                                    <div class="modal-header bg-danger text-white" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                        <h5 class="modal-title" id="deleteOrderModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa đơn hàng</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <p class="mb-3">Bạn có chắc chắn muốn xóa đơn hàng này không?</p>
                                        <div class="p-3 bg-light rounded border mb-3">
                                            <strong>ID:</strong> <span id="modalOrderId"></span><br/>
                                            <strong>Mã Đơn Hàng:</strong> <span id="modalOrderCode" class="text-primary font-monospace fw-bold"></span>
                                        </div>
                                        <p class="text-danger mb-0 small"><i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn tác!</p>
                                    </div>
                                    <div class="modal-footer" style="background-color: #f8fafc; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px; border-top: 1px solid rgba(0,0,0,0.06);">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background: #e2e8f0; color: #475569;">Hủy bỏ</button>
                                        <form id="deleteOrderForm" action="/admin/order/delete" method="post" style="margin: 0;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="id" id="deleteOrderIdInput" />
                                            <button type="submit" class="btn btn-danger" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);">Xác nhận xóa</button>
                                        </form>
                                    </div>
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
                <script src="/js/datatables-simple-demo.js"></script>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const deleteButtons = document.querySelectorAll(".btn-delete-order");
                        deleteButtons.forEach(button => {
                            button.addEventListener("click", function () {
                                const orderId = this.getAttribute("data-id");
                                const orderCode = this.getAttribute("data-code");
                                
                                document.getElementById("modalOrderId").textContent = orderId;
                                document.getElementById("modalOrderCode").textContent = orderCode;
                                document.getElementById("deleteOrderIdInput").value = orderId;
                            });
                        });
                    });
                </script>
            </body>

            </html>
