<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Quản lý Lịch hẹn VIP - TST Watch Luxury" />
    <meta name="author" content="Antigravity" />
    <title>Quản lý Lịch hẹn VIP - TST Watch Luxury</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        /* Custom Premium Gold Theme for Appointments Board */
        .card-appointment {
            background: #ffffff;
            border: 1px solid rgba(184, 148, 30, 0.25);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            color: #1e293b;
            overflow: hidden;
        }
        .table-premium {
            background-color: #ffffff !important;
            color: #1e293b !important;
            border-color: rgba(0, 0, 0, 0.08) !important;
        }
        .table-premium th {
            background-color: #f8f9fa !important;
            color: #b8941e !important;
            border-bottom: 2px solid rgba(212, 175, 55, 0.25) !important;
            text-transform: uppercase;
            font-size: 0.82rem;
            font-weight: 700;
            letter-spacing: 0.08em;
            padding: 16px 20px;
        }
        .table-premium td {
            padding: 16px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.08) !important;
            vertical-align: middle;
            color: #1e293b !important;
        }
        .table-premium tr:hover td {
            background-color: rgba(212, 175, 55, 0.03) !important;
            color: #1e293b !important;
        }
        .badge-status {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            display: inline-block;
            text-align: center;
        }
        .badge-pending {
            background: rgba(217, 119, 6, 0.08);
            color: #b45309;
            border: 1px solid rgba(217, 119, 6, 0.2);
            box-shadow: 0 0 10px rgba(217, 119, 6, 0.02);
        }
        .badge-confirmed {
            background: rgba(40, 167, 69, 0.08);
            color: #2e7d32;
            border: 1px solid rgba(40, 167, 69, 0.2);
            box-shadow: 0 0 10px rgba(40, 167, 69, 0.02);
        }
        .badge-cancelled {
            background: rgba(220, 53, 69, 0.08);
            color: #c62828;
            border: 1px solid rgba(220, 53, 69, 0.2);
            box-shadow: 0 0 10px rgba(220, 53, 69, 0.02);
        }
        .btn-gold-outline {
            color: #b8941e;
            border: 1px solid #b8941e;
            background: transparent;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-gold-outline:hover {
            color: #fff !important;
            background-color: #b8941e;
            border-color: #b8941e;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(184, 148, 30, 0.35);
        }
        .btn-cancel-outline {
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.5);
            background: transparent;
            font-weight: 600;
            font-size: 0.85rem;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-cancel-outline:hover {
            color: #fff;
            background-color: #ef4444;
            border-color: #ef4444;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.35);
        }
        .detail-item {
            font-size: 0.88rem;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
        }
        .detail-item i {
            color: #b8941e;
            width: 20px;
            margin-right: 8px;
            font-size: 0.9rem;
        }
        .text-gold {
            color: #b8941e !important;
        }
        .notes-box {
            max-width: 220px;
            white-space: normal;
            word-wrap: break-word;
            font-size: 0.82rem;
            color: #475569;
            background: rgba(0, 0, 0, 0.02);
            padding: 10px;
            border-radius: 8px;
            border: 1px solid rgba(0, 0, 0, 0.06);
            line-height: 1.4;
        }
        .breadcrumb-item a {
            color: #b8941e;
            text-decoration: none;
        }
        .breadcrumb-item.active {
            color: #64748b;
        }
        .alert-premium {
            background: rgba(40, 167, 69, 0.08);
            color: #2e7d32;
            border: 1px solid rgba(40, 167, 69, 0.2);
            border-radius: 10px;
            padding: 15px 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4 text-gold"><i class="fas fa-calendar-check me-2"></i>Quản lý Lịch hẹn VIP</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Quản lý Lịch hẹn VIP</li>
                    </ol>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-premium alert-dismissible fade show mb-4" role="alert">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle me-3 fa-lg text-success"></i>
                                <div>${successMessage}</div>
                            </div>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close" style="top: 18px; right: 20px;"></button>
                        </div>
                    </c:if>

                    <div class="card card-appointment mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border-bottom: 1px solid rgba(212, 175, 55, 0.2); padding: 18px 24px;">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-table me-2 text-gold"></i>
                                <span class="fw-bold text-gold" style="letter-spacing: 0.03em;">DANH SÁCH LỊCH HẸN VIP</span>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-premium mb-0">
                                    <thead>
                                        <tr>
                                            <th style="width: 80px;">ID</th>
                                            <th>Khách hàng</th>
                                            <th>Thời gian hẹn</th>
                                            <th>Dịch vụ & Boutique</th>
                                            <th>Ghi chú</th>
                                            <th>Trạng thái</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty appointments}">
                                                <c:forEach var="app" items="${appointments}">
                                                    <tr>
                                                        <td><span class="text-gold fw-bold">#${app.id}</span></td>
                                                        <td>
                                                            <div class="detail-item fw-bold text-white" style="font-size: 0.95rem;">${app.fullName}</div>
                                                            <div class="detail-item"><i class="fas fa-phone-alt"></i>${app.phoneNumber}</div>
                                                            <c:if test="${not empty app.email}">
                                                                <div class="detail-item"><i class="far fa-envelope"></i>${app.email}</div>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="detail-item text-white fw-bold">
                                                                <i class="far fa-clock"></i>${app.formattedAppointmentTime}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="detail-item"><span class="badge" style="background-color: rgba(212, 175, 55, 0.15); color: #d4af37; border: 1px solid rgba(212, 175, 55, 0.3); font-size: 0.8rem; font-weight: 600; padding: 5px 10px;">${app.serviceType}</span></div>
                                                            <div class="detail-item mt-2 text-muted"><i class="fas fa-map-marker-alt"></i>${app.boutique}</div>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty app.notes}">
                                                                    <div class="notes-box">${app.notes}</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted" style="font-style: italic; font-size: 0.85rem;">Không có ghi chú</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${app.status == 'Chờ xác nhận'}">
                                                                    <span class="badge-status badge-pending"><i class="fas fa-spinner fa-spin me-1"></i>Chờ xác nhận</span>
                                                                </c:when>
                                                                <c:when test="${app.status == 'Đã xác nhận'}">
                                                                    <span class="badge-status badge-confirmed"><i class="fas fa-check-double me-1"></i>Đã xác nhận</span>
                                                                </c:when>
                                                                <c:when test="${app.status == 'Đã hủy'}">
                                                                    <span class="badge-status badge-cancelled"><i class="fas fa-ban me-1"></i>Đã hủy</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-light text-dark">${app.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:if test="${app.status == 'Chờ xác nhận'}">
                                                                <div class="d-flex gap-2">
                                                                    <form action="/admin/appointment/${app.id}/confirm" method="post" class="m-0" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận lịch hẹn VIP này không? Một email thông báo sẽ được gửi cho khách hàng.')">
                                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                        <button type="submit" class="btn btn-sm btn-gold-outline" title="Xác nhận lịch hẹn">
                                                                            <i class="fas fa-check me-1"></i>Xác nhận
                                                                        </button>
                                                                    </form>
                                                                    <form action="/admin/appointment/${app.id}/cancel" method="post" class="m-0" onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch hẹn VIP này không? Một email thông báo sẽ được gửi cho khách hàng.')">
                                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                        <button type="submit" class="btn btn-sm btn-cancel-outline" title="Hủy lịch hẹn">
                                                                            <i class="fas fa-times me-1"></i>Hủy
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="7" class="text-center py-5 text-muted" style="background-color: #ffffff;">
                                                        <div class="my-4">
                                                            <i class="far fa-calendar-times fa-3x mb-3 text-gold" style="opacity: 0.5;"></i>
                                                            <p class="mb-0 fw-bold" style="font-size: 1.1rem; color: #475569;">Hiện tại chưa có yêu cầu đặt lịch hẹn VIP nào.</p>
                                                            <p class="text-muted small">Mọi lịch đặt hẹn VIP mới từ khách hàng sẽ hiển thị tại đây.</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
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
