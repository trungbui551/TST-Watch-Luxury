<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Chi tiết người dùng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
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
                    <!-- Title & Actions Header -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h1 class="h3 mb-0 text-gray-800" style="padding-left: 0 !important; margin: 0 !important;">Chi tiết người dùng</h1>
                            <ol class="breadcrumb mb-0 mt-1">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="/admin/user">Quản lý người dùng</a></li>
                                <li class="breadcrumb-item active">Chi tiết</li>
                            </ol>
                        </div>
                        <div>
                            <a href="/admin/user" class="btn btn-secondary me-2">
                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <a href="/admin/user/update/${iuser.id}" class="btn btn-warning text-white">
                                <i class="fas fa-edit me-1"></i> Cập nhật
                            </a>
                        </div>
                    </div>

                    <hr />

                    <div class="row mt-4">
                        <!-- Left Panel: User Profile Summary -->
                        <div class="col-lg-4 mb-4">
                            <div class="card h-100 shadow-sm" style="border: 1px solid var(--color-border-gold) !important; border-radius: 16px;">
                                <div class="card-body text-center p-4">
                                    <c:set var="avatarSrc" value="${not empty iuser.avatar ? iuser.avatar : 'default-avatar.png'}" />
                                    <div class="mb-4 d-inline-block position-relative" style="width: 130px; height: 130px;">
                                        <img src="/images/avatar/${avatarSrc}" class="rounded-circle img-thumbnail" style="width: 100%; height: 100%; object-fit: cover; border: 2px solid var(--color-primary);" alt="User Avatar">
                                    </div>
                                    <h4 class="fw-bold mb-1 text-dark">${iuser.fullName}</h4>
                                    <p class="text-secondary small mb-3">${iuser.email}</p>
                                    
                                    <div class="mb-4">
                                        <span class="badge" style="background-color: rgba(212, 175, 55, 0.08); color: var(--color-text-gold); border: 1px solid var(--color-border-gold); font-size: 13px; font-weight: 600; padding: 6px 18px; border-radius: 20px;">
                                            <i class="fas fa-user-shield me-1"></i> ${iuser.role.name}
                                        </span>
                                    </div>
                                    
                                    <hr class="my-4" style="border-top: 1px dashed var(--color-border-gold);" />
                                    
                                    <a class="btn btn-outline-primary btn-sm w-100 py-2" href="/images/avatar/${avatarSrc}" target="_blank">
                                        <i class="fas fa-image me-1"></i> Xem ảnh đại diện
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Right Panel: User Information Details -->
                        <div class="col-lg-8 mb-4">
                            <div class="card h-100 shadow-sm" style="border: 1px solid var(--color-border-gold) !important; border-radius: 16px;">
                                <div class="card-header bg-light d-flex align-items-center py-3" style="border-bottom: 1px solid var(--color-border-gold);">
                                    <i class="fas fa-info-circle text-gold me-2"></i>
                                    <span class="fw-bold text-gold" style="letter-spacing: 0.03em;">THÔNG TIN CHI TIẾT</span>
                                </div>
                                <div class="card-body p-4">
                                    <div class="row g-4">
                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light p-2 rounded-circle me-3 text-gold" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: rgba(212, 175, 55, 0.05) !important;">
                                                    <i class="fas fa-fingerprint"></i>
                                                </div>
                                                <div>
                                                    <div class="text-secondary small">ID Người dùng</div>
                                                    <div class="fw-semibold text-dark mt-1">${iuser.id}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light p-2 rounded-circle me-3 text-gold" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: rgba(212, 175, 55, 0.05) !important;">
                                                    <i class="fas fa-envelope"></i>
                                                </div>
                                                <div>
                                                    <div class="text-secondary small">Địa chỉ Email</div>
                                                    <div class="fw-semibold text-dark mt-1">${iuser.email}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light p-2 rounded-circle me-3 text-gold" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: rgba(212, 175, 55, 0.05) !important;">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div>
                                                    <div class="text-secondary small">Họ và Tên</div>
                                                    <div class="fw-semibold text-dark mt-1">${iuser.fullName}</div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light p-2 rounded-circle me-3 text-gold" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: rgba(212, 175, 55, 0.05) !important;">
                                                    <i class="fas fa-phone"></i>
                                                </div>
                                                <div>
                                                    <div class="text-secondary small">Số điện thoại</div>
                                                    <div class="fw-semibold text-dark mt-1">
                                                        <c:choose>
                                                            <c:when test="${not empty iuser.phone}">
                                                                ${iuser.phone}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted font-italic">Chưa cập nhật</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <div class="d-flex align-items-start">
                                                <div class="bg-light p-2 rounded-circle me-3 text-gold" style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: rgba(212, 175, 55, 0.05) !important;">
                                                    <i class="fas fa-map-marker-alt"></i>
                                                </div>
                                                <div>
                                                    <div class="text-secondary small">Địa chỉ liên hệ</div>
                                                    <div class="fw-semibold text-dark mt-1">
                                                        <c:choose>
                                                            <c:when test="${not empty iuser.address}">
                                                                ${iuser.address}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted font-italic">Chưa cập nhật</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
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
