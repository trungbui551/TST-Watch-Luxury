<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Cấu hình hệ thống - Gửi Mail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .settings-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: #ffffff;
        }

        .settings-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
        }

        .card-header-premium {
            background: linear-gradient(135deg, #2b3035 0%, #1a1e21 100%);
            color: #ffffff;
            border-top-left-radius: 16px !important;
            border-top-right-radius: 16px !important;
            padding: 20px 24px;
            font-weight: 600;
        }

        .btn-premium {
            background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(13, 110, 253, 0.2);
        }

        .btn-premium:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
            background: linear-gradient(135deg, #0b5ed7 0%, #084298 100%);
            color: white;
        }

        .form-control-premium {
            border-radius: 8px;
            padding: 12px 16px;
            border: 1px solid #dee2e6;
            transition: all 0.3s ease;
        }

        .form-control-premium:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.1);
        }

        .form-switch-premium .form-check-input {
            width: 3rem;
            height: 1.5rem;
            cursor: pointer;
        }

        .input-group-text-premium {
            background: #f8f9fa;
            border-right: none;
            cursor: pointer;
        }

        .alert-premium {
            border: none;
            border-radius: 12px;
            padding: 16px 24px;
            animation: slideIn 0.5s ease-out;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
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
                            <h1 class="h3 mb-0 text-gray-800">Cấu hình hệ thống</h1>
                            <ol class="breadcrumb mb-0 mt-1">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Cấu hình gửi mail</li>
                            </ol>
                        </div>
                    </div>

                    <!-- Flash Message Alert -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show alert-premium mb-4" role="alert" id="successAlert">
                            <i class="fas fa-check-circle me-2"></i> ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="row">
                        <div class="col-lg-8">
                            <div class="card settings-card">
                                <div class="card-header card-header-premium d-flex align-items-center">
                                    <i class="fas fa-envelope-open-text me-3 fa-lg"></i>
                                    <h5 class="mb-0">Cấu hình SMTP gửi mail</h5>
                                </div>
                                <div class="card-body p-4">
                                    <form action="/admin/settings" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="row g-3 mb-4">
                                            <div class="col-md-8">
                                                <label for="emailHost" class="form-label fw-semibold">SMTP Host</label>
                                                <input type="text" class="form-control form-control-premium" id="emailHost" name="emailHost" 
                                                       value="${emailHost}" placeholder="e.g. smtp.gmail.com" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="emailPort" class="form-label fw-semibold">SMTP Port</label>
                                                <input type="number" class="form-control form-control-premium" id="emailPort" name="emailPort" 
                                                       value="${emailPort}" placeholder="e.g. 587" required>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <label for="emailUsername" class="form-label fw-semibold">Tài khoản Email gửi đi</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fas fa-user text-muted"></i></span>
                                                <input type="email" class="form-control form-control-premium" id="emailUsername" name="emailUsername" 
                                                       value="${emailUsername}" placeholder="your-email@gmail.com" required>
                                            </div>
                                            <div class="form-text text-muted">Tài khoản này sẽ được dùng làm SMTP Auth để gửi thư hệ thống.</div>
                                        </div>

                                        <div class="mb-4">
                                            <label for="emailPassword" class="form-label fw-semibold">Mật khẩu ứng dụng (App Password)</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="fas fa-key text-muted"></i></span>
                                                <input type="password" class="form-control form-control-premium" id="emailPassword" name="emailPassword" 
                                                       value="${emailPassword}" placeholder="Mật khẩu ứng dụng Gmail 16 ký tự" required>
                                                <button class="btn btn-outline-secondary" type="button" id="togglePasswordBtn" style="border-top-right-radius: 8px; border-bottom-right-radius: 8px;">
                                                    <i class="fas fa-eye" id="eyeIcon"></i>
                                                </button>
                                            </div>
                                            <div class="form-text text-muted">
                                                Đối với Gmail, vui lòng sử dụng <strong>Mật khẩu ứng dụng</strong> (App Password) thay vì mật khẩu tài khoản chính.
                                            </div>
                                        </div>

                                        <hr class="my-4" style="border-top: 1px dashed #dee2e6;">

                                        <div class="row g-3 mb-4">
                                            <div class="col-md-6">
                                                <div class="form-check form-switch form-switch-premium d-flex align-items-center">
                                                    <input class="form-check-input me-3" type="checkbox" role="switch" id="emailSmtpAuth" name="emailSmtpAuth" 
                                                           <c:if test="${emailSmtpAuth == 'true'}">checked</c:if>>
                                                    <label class="form-check-label fw-semibold" for="emailSmtpAuth">Xác thực SMTP (Auth)</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-check form-switch form-switch-premium d-flex align-items-center">
                                                    <input class="form-check-input me-3" type="checkbox" role="switch" id="emailStarttlsEnable" name="emailStarttlsEnable" 
                                                           <c:if test="${emailStarttlsEnable == 'true'}">checked</c:if>>
                                                    <label class="form-check-label fw-semibold" for="emailStarttlsEnable">Kích hoạt STARTTLS</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="text-end">
                                            <button type="submit" class="btn btn-premium">
                                                <i class="fas fa-save me-2"></i> Lưu cấu hình
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4">
                            <div class="card settings-card mb-4" style="border-left: 4px solid #ffc107;">
                                <div class="card-body p-4">
                                    <h5 class="card-title text-warning mb-3">
                                        <i class="fas fa-info-circle me-2"></i> Lưu ý cấu hình
                                    </h5>
                                    <p class="card-text text-muted" style="font-size: 14px; line-height: 1.6;">
                                        Để gửi mail qua SMTP của Gmail thành công, bạn cần:
                                    </p>
                                    <ol class="ps-3 text-muted" style="font-size: 14px; line-height: 1.6;">
                                        <li>Bật <strong>Xác minh 2 bước</strong> trên tài khoản Google của bạn.</li>
                                        <li>Truy cập mục Bảo mật tài khoản Google, tìm phần <strong>Mật khẩu ứng dụng (App Passwords)</strong>.</li>
                                        <li>Tạo mật khẩu mới cho ứng dụng "Thư" và copy mã gồm 16 ký tự để điền vào trường Mật khẩu ứng dụng phía bên trái.</li>
                                    </ol>
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
    <script>
        // JS Toggle Password Visibility
        const togglePasswordBtn = document.getElementById('togglePasswordBtn');
        const emailPasswordInput = document.getElementById('emailPassword');
        const eyeIcon = document.getElementById('eyeIcon');

        togglePasswordBtn.addEventListener('click', function() {
            const type = emailPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            emailPasswordInput.setAttribute('type', type);
            if (type === 'text') {
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        });

        // Tự động ẩn thông báo thành công sau 4 giây
        const successAlert = document.getElementById('successAlert');
        if (successAlert) {
            setTimeout(() => {
                const bsAlert = new bootstrap.Alert(successAlert);
                bsAlert.close();
            }, 4000);
        }
    </script>
</body>

</html>
