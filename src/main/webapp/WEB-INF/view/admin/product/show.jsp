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
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
                    crossorigin="anonymous">
                <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
                                        <h1 class="h3 mb-0 text-gray-800" style="padding-left: 0 !important; margin: 0 !important;">Quản lý sản phẩm</h1>
                                        <ol class="breadcrumb mb-0 mt-1">
                                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                            <li class="breadcrumb-item active">Quản lý sản phẩm</li>
                                        </ol>
                                    </div>
                                </div>

                                <!-- Form tìm kiếm đơn giản -->
                                <form method="get" action="/admin/product" class="mb-4">
                                    <div class="input-group input-group-lg" style="border-radius: 12px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.02); border: 1px solid rgba(212, 175, 55, 0.15);">
                                        <span class="input-group-text bg-white border-0 text-muted">
                                            <i class="fas fa-search"></i>
                                        </span>
                                        <input type="text" name="keyword" class="form-control border-0 px-3" placeholder="Tìm kiếm sản phẩm theo tên, hãng..."
                                            value="${param.keyword}" style="font-size: 15px;">
                                        <button type="submit" class="btn btn-primary px-4">
                                            Tìm kiếm
                                        </button>
                                    </div>
                                </form>
                                    
                                <!-- Cảnh báo sản phẩm hết hàng -->
                                <c:set var="hasOutOfStock" value="false" />
                                <c:forEach var="item" items="${pros}">
                                    <c:if test="${item.quantity <= 0}">
                                        <c:set var="hasOutOfStock" value="true" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${hasOutOfStock}">
                                    <div class="alert alert-warning alert-dismissible fade show d-flex align-items-center justify-content-between mb-4" role="alert">
                                        <div>
                                            <i class="fa-solid fa-triangle-exclamation me-2" style="color: #d97706;"></i>
                                            <strong>Thông báo:</strong> Có sản phẩm trong danh sách dưới đây đã hết hàng! Vui lòng kiểm tra và cập nhật lại kho.
                                        </div>
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <div class="card mb-4">
                                    <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border-bottom: 1px solid rgba(212, 175, 55, 0.2); padding: 18px 24px;">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-clock me-2 text-gold"></i>
                                            <span class="fw-bold text-gold" style="letter-spacing: 0.03em;">DANH SÁCH SẢN PHẨM</span>
                                        </div>
                                        <a href="/admin/product/create" class="btn btn-primary">
                                            <i class="fas fa-plus me-1"></i> Thêm sản phẩm
                                        </a>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0" style="border: none !important; border-radius: 0 !important; margin-top: 0 !important; box-shadow: none !important;">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Name</th>
                                                        <th scope="col">Price </th>
                                                        <th scope="col">Short Description</th>
                                                        <th scope="col">Factory</th>
                                                        <th scope="col">Quantity</th>
                                                        <th scope="col" style="width: 250px;">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="pro" items="${pros}">
                                                        <tr style="${!pro.active ? 'opacity: 0.55; filter: grayscale(40%); background-color: rgba(0, 0, 0, 0.02);' : ''}">
                                                            <td>${pro.id}</td>
                                                            <td>
                                                                ${pro.name}
                                                                <c:if test="${!pro.active}">
                                                                    <span class="badge ms-1" style="background-color: rgba(100, 116, 139, 0.08); color: #475569; border: 1px solid rgba(100, 116, 139, 0.2); font-size: 10px; font-weight: 600; padding: 2px 6px; border-radius: 3px;">Đã ẩn</span>
                                                                </c:if>
                                                                <c:if test="${pro.quantity <= 0}">
                                                                    <span class="badge ms-1" style="background-color: rgba(220, 38, 38, 0.08); color: #c62828; border: 1px solid rgba(220, 38, 38, 0.2); font-size: 10px; font-weight: 600; padding: 2px 6px; border-radius: 3px;">Hết hàng</span>
                                                                </c:if>
                                                            </td>
                                                            <td>
                                                                <fmt:formatNumber type="number" value="${pro.price}" /> đ
                                                            </td>
                                                            <td>${pro.shortDesc}</td>
                                                            <td>${pro.factory}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${pro.quantity <= 0}">
                                                                        <span class="badge" style="background-color: rgba(220, 38, 38, 0.08); color: #c62828; border: 1px solid rgba(220, 38, 38, 0.2); font-size: 11px; font-weight: 600; padding: 4px 8px; border-radius: 4px;">Hết hàng</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${pro.quantity}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-nowrap">
                                                                <a href="/admin/product/${pro.id}"
                                                                    class="btn btn-success">View</a>
                                                                <a href="/admin/product/update/${pro.id}"
                                                                    class="btn btn-warning text-white mx-2">Update</a>
                                                                <c:choose>
                                                                    <c:when test="${pro.active}">
                                                                        <button type="button" class="btn btn-danger btn-delete-product" data-id="${pro.id}" data-name="${pro.name}" data-bs-toggle="modal" data-bs-target="#deleteProductModal">Delete</button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button type="button" class="btn btn-info text-white btn-restore-product" data-id="${pro.id}" data-name="${pro.name}" data-bs-toggle="modal" data-bs-target="#restoreProductModal">Restore</button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-center">
                                        <!-- Nút Previous -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?pageNo=${currentPage - 1}">Previous</a>
                                            </li>
                                        </c:if>

                                        <!-- Các số trang -->
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link"
                                                    href="?${not empty keyword ? 'keyword='.concat(keyword).concat('&') : ''}pageNo=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Nút Next -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?pageNo=${currentPage + 1}">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </main>

                        <!-- Modal xác nhận xóa Product -->
                        <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                                    <div class="modal-header bg-danger text-white" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                        <h5 class="modal-title" id="deleteProductModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa sản phẩm</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <p class="mb-3">Bạn có chắc chắn muốn xóa sản phẩm này không?</p>
                                        <div class="p-3 bg-light rounded border mb-3">
                                            <strong>ID:</strong> <span id="modalProductId"></span><br/>
                                            <strong>Tên sản phẩm:</strong> <span id="modalProductName" class="text-primary fw-bold"></span>
                                        </div>
                                        <p class="text-danger mb-0 small"><i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn tác!</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                                        <form id="deleteProductForm" action="/admin/product/delete" method="post" style="margin: 0;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="id" id="deleteProductIdInput" />
                                            <button type="submit" class="btn btn-danger">Xác nhận xóa</button>
                                        </form>
                                    </div>
                        </div>
                            </div>
                        </div>

                        <!-- Modal xác nhận khôi phục Product -->
                        <div class="modal fade" id="restoreProductModal" tabindex="-1" aria-labelledby="restoreProductModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                                    <div class="modal-header bg-success text-white" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                        <h5 class="modal-title" id="restoreProductModalLabel"><i class="fas fa-undo me-2"></i>Xác nhận khôi phục sản phẩm</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-4">
                                        <p class="mb-3">Bạn có chắc chắn muốn khôi phục sản phẩm này để hiển thị lại trên giao diện người dùng không?</p>
                                        <div class="p-3 bg-light rounded border mb-3">
                                            <strong>ID:</strong> <span id="modalRestoreProductId"></span><br/>
                                            <strong>Tên sản phẩm:</strong> <span id="modalRestoreProductName" class="text-primary fw-bold"></span>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                                        <form id="restoreProductForm" action="/admin/product/restore" method="post" style="margin: 0;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="id" id="restoreProductIdInput" />
                                            <button type="submit" class="btn btn-success">Khôi phục</button>
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
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const deleteButtons = document.querySelectorAll(".btn-delete-product");
                        deleteButtons.forEach(button => {
                            button.addEventListener("click", function () {
                                const productId = this.getAttribute("data-id");
                                const productName = this.getAttribute("data-name");
                                
                                document.getElementById("modalProductId").textContent = productId;
                                document.getElementById("modalProductName").textContent = productName;
                                document.getElementById("deleteProductIdInput").value = productId;
                            });
                        });

                        const restoreButtons = document.querySelectorAll(".btn-restore-product");
                        restoreButtons.forEach(button => {
                            button.addEventListener("click", function () {
                                const productId = this.getAttribute("data-id");
                                const productName = this.getAttribute("data-name");
                                
                                document.getElementById("modalRestoreProductId").textContent = productId;
                                document.getElementById("modalRestoreProductName").textContent = productName;
                                document.getElementById("restoreProductIdInput").value = productId;
                            });
                        });
                    });
                </script>
            </body>

            </html>
