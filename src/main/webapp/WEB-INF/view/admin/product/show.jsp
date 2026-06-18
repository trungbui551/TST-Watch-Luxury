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
                <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <h1>Product Manager</h1>


                        <div class="container mt-5">
                            <!-- Form tìm kiếm đơn giản -->
                            <form method="get" action="/admin/product" class="mb-4">
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </span>
                                    <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm..."
                                        value="${param.keyword}">
                                    <button type="submit" class="btn btn-primary">
                                        Tìm kiếm
                                    </button>
                                </div>
                            </form>
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Product Table</h3>
                                        <a href="/admin/product/create" class="btn btn-primary">Add a Product</a>
                                    </div>
                                    <hr />
                                    
                                    <!-- Cảnh báo sản phẩm hết hàng -->
                                    <c:set var="hasOutOfStock" value="false" />
                                    <c:forEach var="item" items="${pros}">
                                        <c:if test="${item.quantity <= 0}">
                                            <c:set var="hasOutOfStock" value="true" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${hasOutOfStock}">
                                        <div class="alert alert-warning alert-dismissible fade show d-flex align-items-center justify-content-between" role="alert" 
                                             style="background: #fff3cd; border: 1px solid #ffeeba; color: #856404; font-size: 14px; border-radius: 6px; padding: 12px 20px; margin-bottom: 20px;">
                                            <div>
                                                <i class="fa-solid fa-triangle-exclamation me-2" style="color: #856404;"></i>
                                                <strong>Thông báo:</strong> Có sản phẩm trong danh sách dưới đây đã hết hàng! Vui lòng kiểm tra và cập nhật lại kho.
                                            </div>
                                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                        </div>
                                    </c:if>

                                    <table class="table table-hover table-bordered">
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
                                                <tr>
                                                    <td>${pro.id}</td>
                                                    <td>
                                                        ${pro.name}
                                                        <c:if test="${pro.quantity <= 0}">
                                                            <span class="badge ms-1" style="background-color: #ffe5e5; color: #d93838; border: 1px solid #ffd0d0; font-size: 10px; font-weight: 600; padding: 2px 6px; border-radius: 3px;">Hết hàng</span>
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
                                                                <span class="badge" style="background-color: #ffe5e5; color: #d93838; border: 1px solid #ffd0d0; font-size: 11px; font-weight: 600; padding: 4px 8px; border-radius: 4px;">Hết hàng</span>
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
                                                            class="btn btn-warning mx-2">Update</a>
                                                        <button type="button" class="btn btn-danger btn-delete-product" data-id="${pro.id}" data-name="${pro.name}" data-bs-toggle="modal" data-bs-target="#deleteProductModal">Delete</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <nav aria-label="Page navigation">
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
                                    <div class="modal-footer" style="background-color: #f8fafc; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px; border-top: 1px solid rgba(0,0,0,0.06);">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background: #e2e8f0; color: #475569;">Hủy bỏ</button>
                                        <form id="deleteProductForm" action="/admin/product/delete" method="post" style="margin: 0;">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="id" id="deleteProductIdInput" />
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
                    });
                </script>
            </body>

            </html>
