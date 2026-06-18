<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Product Details - Admin</title>
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
            <main class="container-fluid px-4">
                <h1 class="mt-4">Manager Product</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin/product">Products</a></li>
                    <li class="breadcrumb-item active">Product Detail</li>
                </ol>
            </main>
            <div class="container mt-3 mb-5">
                <div class="row">
                    <div class="col-12 col-lg-10 mx-auto">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3>Product Detail</h3>
                            <div>
                                <a href="/admin/product" class="btn btn-secondary me-2">Back to List</a>
                                <a href="/admin/product/update/${id}" class="btn btn-warning">Update Product</a>
                            </div>
                        </div>

                        <hr />
                        <div class="card shadow-sm">
                            <div class="card-header bg-light d-flex align-items-center justify-content-between py-3">
                                <h5 class="m-0"><i class="fas fa-info-circle me-2"></i>Product Information</h5>
                                <c:if test="${not empty product.image}">
                                    <a class="btn btn-sm btn-outline-primary" href="/images/product/${product.image}" target="_blank">
                                        <i class="fas fa-external-link-alt me-1"></i>View Full Image
                                    </a>
                                </c:if>
                            </div>
                            <div class="row g-0">
                                <div class="col-md-4 d-flex align-items-center justify-content-center p-4 bg-light border-end">
                                    <c:choose>
                                        <c:when test="${not empty product.image}">
                                            <img class="img-fluid rounded" style="max-height: 250px; object-fit: contain;" src="/images/product/${product.image}" alt="${product.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-5 text-muted">
                                                <i class="fas fa-laptop fa-5x mb-3"></i>
                                                <p>No Image Available</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-md-8">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item py-3">
                                            <strong>ID:</strong> <span class="badge bg-secondary ms-2">${id}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Name:</strong> <span class="ms-2 fw-bold text-dark">${product.name}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Price:</strong> 
                                            <span class="ms-2 fw-bold text-success fs-5">
                                                <fmt:formatNumber type="number" value="${product.price}" /> đ
                                            </span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Factory:</strong> <span class="ms-2 badge bg-info text-dark">${product.factory}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Target:</strong> <span class="ms-2 badge bg-primary">${product.target}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Stock Quantity:</strong> <span class="ms-2 fw-bold">${product.quantity}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Sold Quantity:</strong> <span class="ms-2 text-muted">${product.sold}</span>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Short Description:</strong> 
                                            <p class="mt-2 text-secondary mb-0">${product.shortDesc}</p>
                                        </li>
                                        <li class="list-group-item py-3">
                                            <strong>Detail Description:</strong> 
                                            <p class="mt-2 text-secondary mb-0">${product.detailDesc}</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <c:if test="${not empty product.images}">
                                <div class="card-footer bg-light p-4 border-top">
                                    <h6 class="mb-3 fw-bold text-dark"><i class="fas fa-images me-2 text-primary"></i>All Product Images (Tất cả ảnh của sản phẩm):</h6>
                                    <div class="d-flex flex-wrap gap-3">
                                        <!-- Main Image -->
                                        <c:if test="${not empty product.image}">
                                            <div class="text-center">
                                                <div style="padding: 4px; border: 2px solid #ffc107; border-radius: 6px; background: white; display: inline-block;">
                                                    <img class="rounded" style="height: 110px; width: 110px; object-fit: contain;" src="/images/product/${product.image}" alt="Main Image" />
                                                </div>
                                                <div class="text-muted small mt-1 fw-bold">Main Image</div>
                                            </div>
                                        </c:if>
                                        <!-- Sub Images -->
                                        <c:forEach var="subImg" items="${product.images.split(',')}">
                                            <c:if test="${not empty subImg}">
                                                <div class="text-center">
                                                    <div style="padding: 4px; border: 1px solid #dee2e6; border-radius: 6px; background: white; display: inline-block;">
                                                        <img class="rounded" style="height: 110px; width: 110px; object-fit: contain;" src="/images/product/${subImg}" alt="Sub Image" />
                                                    </div>
                                                    <div class="text-muted small mt-1">Sub Image</div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>
