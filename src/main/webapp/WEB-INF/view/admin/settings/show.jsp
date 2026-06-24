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
    <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .settings-card {
            border: 1px solid rgba(184, 148, 30, 0.25);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: #ffffff;
        }

        .settings-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
        }

        .card-header-premium {
            background: #f8f9fa;
            color: #b8941e !important;
            border-top-left-radius: 16px !important;
            border-top-right-radius: 16px !important;
            padding: 20px 24px;
            font-weight: 600;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
        }

        .card-header-premium h5,
        .card-header-premium i {
            color: #b8941e !important;
        }

        .btn-premium {
            background: linear-gradient(135deg, #d4af37 0%, #b8941e 100%);
            border: none;
            color: #ffffff !important;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(184, 148, 30, 0.25);
        }

        .btn-premium:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(184, 148, 30, 0.35);
            background: linear-gradient(135deg, #e8c84a 0%, #d4af37 100%);
            color: #ffffff !important;
        }

        .form-control-premium {
            border-radius: 8px;
            padding: 12px 16px;
            border: 1px solid rgba(212, 175, 55, 0.25);
            background-color: #ffffff;
            color: #1e293b;
            transition: all 0.3s ease;
        }

        .form-control-premium:focus {
            border-color: #b8941e;
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.15);
            background-color: #ffffff;
            color: #1e293b;
        }

        .form-switch-premium .form-check-input {
            width: 3rem;
            height: 1.5rem;
            cursor: pointer;
        }

        .input-group-text-premium {
            background: rgba(212, 175, 55, 0.05);
            border-right: none;
            cursor: pointer;
            color: #b8941e;
            border: 1px solid rgba(212, 175, 55, 0.25);
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
                           <div class="container-fluid px-4 py-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h1 class="h3 mb-0 text-gray-800">Cấu hình hệ thống</h1>
                            <ol class="breadcrumb mb-0 mt-1">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Cấu hình hệ thống</li>
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

                    <form action="/admin/settings" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        
                        <!-- Navigation Tabs (Pills style) -->
                        <ul class="nav nav-pills mb-4 gap-2" id="settingsTabs" role="tablist" style="background: rgba(212, 175, 55, 0.04); padding: 6px; border-radius: 12px; display: inline-flex; border: 1px solid rgba(212, 175, 55, 0.1);">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active px-4 py-2" id="email-tab" data-bs-toggle="pill" data-bs-target="#email-settings" type="button" role="tab" style="font-weight: 600; border-radius: 8px;">
                                    <i class="fas fa-envelope me-2"></i> Cấu hình Email
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link px-4 py-2" id="promo-tab" data-bs-toggle="pill" data-bs-target="#promo-settings" type="button" role="tab" style="font-weight: 600; border-radius: 8px;">
                                    <i class="fas fa-tags me-2"></i> Sự kiện giảm giá
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link px-4 py-2" id="banner-tab" data-bs-toggle="pill" data-bs-target="#banner-settings" type="button" role="tab" style="font-weight: 600; border-radius: 8px;">
                                    <i class="fas fa-image me-2"></i> Banner trang chủ
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link px-4 py-2" id="ai-chat-tab" data-bs-toggle="pill" data-bs-target="#ai-chat-settings" type="button" role="tab" style="font-weight: 600; border-radius: 8px;">
                                    <i class="fas fa-robot me-2"></i> AI Chatbot
                                </button>
                            </li>
                        </ul>

                        <div class="row">
                            <!-- Left Column: Settings Form fields inside Tab Panes -->
                            <div class="col-lg-8">
                                <div class="tab-content" id="settingsTabContent">
                                    
                                    <!-- TAB 1: EMAIL CONFIGURATION -->
                                    <div class="tab-pane fade show active" id="email-settings" role="tabpanel" aria-labelledby="email-tab">
                                        <div class="card settings-card">
                                            <div class="card-header card-header-premium d-flex align-items-center">
                                                <i class="fas fa-envelope-open-text me-3 fa-lg"></i>
                                                <h5 class="mb-0">Cấu hình SMTP gửi mail</h5>
                                            </div>
                                            <div class="card-body p-4">
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

                                                <div class="row g-3">
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
                                            </div>
                                        </div>
                                    </div>

                                    <!-- TAB 2: DISCOUNT EVENT CONFIGURATION -->
                                    <div class="tab-pane fade" id="promo-settings" role="tabpanel" aria-labelledby="promo-tab">
                                        <div class="card settings-card">
                                            <div class="card-header card-header-premium d-flex align-items-center">
                                                <i class="fas fa-tags me-3 fa-lg"></i>
                                                <h5 class="mb-0">Cấu hình sự kiện giảm giá</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <div class="form-check form-switch form-switch-premium d-flex align-items-center">
                                                        <input class="form-check-input me-3" type="checkbox" role="switch" id="promoActive" name="promoActive" 
                                                               <c:if test="${promoActive == 'true'}">checked</c:if>>
                                                        <label class="form-check-label fw-bold text-success" for="promoActive" style="font-size: 15px;">Kích hoạt sự kiện giảm giá toàn sàn</label>
                                                    </div>
                                                    <div class="form-text text-muted mt-2">Khi kích hoạt, toàn bộ giỏ hàng và thanh toán phía khách hàng sẽ tự động áp dụng chiết khấu %.</div>
                                                </div>

                                                <div class="mb-4">
                                                    <label for="promoDiscount" class="form-label fw-semibold">Phần trăm giảm giá (%)</label>
                                                    <div class="input-group" style="max-width: 200px;">
                                                        <input type="number" min="0" max="100" class="form-control form-control-premium" id="promoDiscount" name="promoDiscount" 
                                                               value="${promoDiscount}" required>
                                                        <span class="input-group-text fw-bold">%</span>
                                                    </div>
                                                    <div class="form-text text-muted">Nhập số nguyên từ 0 đến 100. Ví dụ: 10 nghĩa là giảm 10%.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="promoText" class="form-label fw-semibold">Nội dung chữ quảng cáo (Hiển thị ở Header)</label>
                                                    <textarea class="form-control form-control-premium" id="promoText" name="promoText" rows="3" required>${promoText}</textarea>
                                                    <div class="form-text text-muted">Chuỗi chữ thông báo chạy nổi bật trên đầu website client.</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- TAB 3: BANNER CONFIGURATION -->
                                    <div class="tab-pane fade" id="banner-settings" role="tabpanel" aria-labelledby="banner-tab">
                                        <div class="card settings-card">
                                            <div class="card-header card-header-premium d-flex align-items-center">
                                                <i class="fas fa-image me-3 fa-lg"></i>
                                                <h5 class="mb-0">Cấu hình Banner trang chủ</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <label for="bannerBadge" class="form-label fw-semibold">Nhãn phụ banner (Badge)</label>
                                                    <input type="text" class="form-control form-control-premium" id="bannerBadge" name="bannerBadge" 
                                                           value="${bannerBadge}" placeholder="e.g. Heritage Collection" required>
                                                </div>

                                                <div class="mb-4">
                                                    <label for="bannerTitle" class="form-label fw-semibold">Tiêu đề chính (Chấp nhận thẻ &lt;br/&gt; để xuống dòng)</label>
                                                    <input type="text" class="form-control form-control-premium" id="bannerTitle" name="bannerTitle" 
                                                           value="${bannerTitle}" placeholder="e.g. Kiệt tác thời gian<br/>đeo trên tay" required>
                                                </div>

                                                <div class="mb-4">
                                                    <label for="bannerSubtitle" class="form-label fw-semibold">Mô tả chi tiết banner</label>
                                                    <textarea class="form-control form-control-premium" id="bannerSubtitle" name="bannerSubtitle" rows="4" required>${bannerSubtitle}</textarea>
                                                </div>

                                                <div class="mb-4">
                                                    <label for="bannerButtonText" class="form-label fw-semibold">Chữ hiển thị trên nút bấm</label>
                                                    <input type="text" class="form-control form-control-premium" id="bannerButtonText" name="bannerButtonText" 
                                                           value="${bannerButtonText}" placeholder="e.g. Khám phá bộ sưu tập" required>
                                                </div>

                                                <div class="mb-4">
                                                    <label for="bannerImageFile" class="form-label fw-semibold">Tải lên ảnh nền banner mới</label>
                                                    <input class="form-control form-control-premium" type="file" id="bannerImageFile" accept=".png, .jpg, .jpeg, .webp" name="bannerImageFile" />
                                                    <div class="form-text text-muted mb-2">Tải lên file ảnh mới nếu bạn muốn sử dụng ảnh mới hoàn toàn.</div>
                                                </div>

                                                <div class="mb-3">
                                                    <label for="bannerImageUrl" class="form-label fw-semibold">Chọn ảnh nền từ kho ảnh đã sử dụng</label>
                                                    <select class="form-select form-select-premium" id="bannerImageUrl" name="bannerImageUrl" onchange="updateBannerPreview(this.value)" required>
                                                        <c:forEach var="banner" items="${pastBanners}">
                                                            <option value="${banner}" ${banner == bannerImageUrl ? 'selected' : ''}>
                                                                <c:choose>
                                                                    <c:when test="${banner == '/resources/client/images/luxury_watch_banner.png'}">
                                                                        Ảnh mặc định hệ thống (luxury_watch_banner.png)
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${banner.substring(banner.lastIndexOf('/') + 1)}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="form-text text-muted mb-3">Chọn một ảnh nền từ danh sách ảnh đã sử dụng hoặc ảnh mặc định.</div>

                                                    <div class="mt-2 p-3 border rounded bg-light" style="max-width: 320px; border: 1px solid rgba(212, 175, 55, 0.2) !important;">
                                                        <div class="text-secondary small mb-2 fw-semibold"><i class="fas fa-eye me-1"></i>Xem trước ảnh nền đã chọn:</div>
                                                        <div class="text-center bg-dark p-2 rounded" style="min-height: 120px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
                                                            <img id="bannerSelectPreview" src="${bannerImageUrl}" style="max-width: 100%; max-height: 140px; border-radius: 4px; object-fit: contain;" alt="Banner Preview" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- TAB 4: AI CHATBOT CONFIGURATION -->
                                    <div class="tab-pane fade" id="ai-chat-settings" role="tabpanel" aria-labelledby="ai-chat-tab">
                                        <div class="card settings-card">
                                            <div class="card-header card-header-premium d-flex align-items-center">
                                                <i class="fas fa-robot me-3 fa-lg"></i>
                                                <h5 class="mb-0">Cấu hình AI Chatbot</h5>
                                            </div>
                                            <div class="card-body p-4">
                                                <div class="mb-4">
                                                    <label for="aiChatApiKey" class="form-label fw-semibold">Google Gemini API Key</label>
                                                    <div class="input-group">
                                                        <span class="input-group-text bg-light"><i class="fas fa-key text-muted"></i></span>
                                                        <input type="password" class="form-control form-control-premium" id="aiChatApiKey" name="aiChatApiKey" 
                                                               value="${aiChatApiKey}" placeholder="Nhập Gemini API Key (chuỗi bắt đầu bằng AIzaSy...)">
                                                        <button class="btn btn-outline-secondary" type="button" id="toggleAiChatApiKeyBtn" style="border-top-right-radius: 8px; border-bottom-right-radius: 8px;">
                                                            <i class="fas fa-eye" id="aiChatEyeIcon"></i>
                                                        </button>
                                                    </div>
                                                    <div class="form-text text-muted">
                                                        API Key sẽ được dùng để kết nối trực tuyến với mô hình Gemini AI. Để trống nếu muốn chạy ở chế độ tư vấn ngoại tuyến (sử dụng dữ liệu cố định trong hệ thống).
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div> <!-- end tab-content -->
                            </div>

                            <!-- Right Column: Sidebar Instruction & Save Button -->
                            <div class="col-lg-4">
                                <div class="card settings-card mb-4" style="border-left: 4px solid #0d6efd; position: sticky; top: 80px;">
                                    <div class="card-body p-4">
                                        <h5 class="card-title text-primary mb-3">
                                            <i class="fas fa-save me-2"></i> Hành động
                                        </h5>
                                        <p class="card-text text-muted" style="font-size: 13.5px; line-height: 1.6;">
                                            Vui lòng điền đầy đủ và kiểm tra kỹ thông tin cấu hình ở tất cả các tab trước khi lưu.
                                        </p>
                                        <button type="submit" class="btn btn-premium w-100 py-3 mt-2">
                                            <i class="fas fa-save me-2"></i> Lưu toàn bộ cấu hình
                                        </button>
                                    </div>
                                </div>

                                <div class="card settings-card mb-4" style="border-left: 4px solid #ffc107;">
                                    <div class="card-body p-4">
                                        <h5 class="card-title text-warning mb-3">
                                            <i class="fas fa-info-circle me-2"></i> Hướng dẫn & Lưu ý
                                        </h5>
                                        <div class="accordion accordion-flush" id="settingsGuideAccordion">
                                            <div class="accordion-item" style="background: transparent;">
                                                <h2 class="accordion-header" id="flush-headingOne">
                                                    <button class="accordion-button collapsed px-0 bg-transparent text-dark fw-semibold" style="font-size: 13px;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne">
                                                        Cách lấy SMTP App Password
                                                    </button>
                                                </h2>
                                                <div id="flush-collapseOne" class="accordion-collapse collapse" data-bs-parent="#settingsGuideAccordion">
                                                    <div class="accordion-body px-0 text-muted" style="font-size: 12.5px; line-height: 1.5;">
                                                        1. Bật Xác minh 2 bước trong tài khoản Google.<br/>
                                                        2. Tìm phần 'Mật khẩu ứng dụng'.<br/>
                                                        3. Tạo mật khẩu cho ứng dụng 'Thư' và điền vào ô mật khẩu ứng dụng.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item" style="background: transparent;">
                                                <h2 class="accordion-header" id="flush-headingTwo">
                                                    <button class="accordion-button collapsed px-0 bg-transparent text-dark fw-semibold" style="font-size: 13px;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo">
                                                        Cách hoạt động của sự kiện giảm giá
                                                    </button>
                                                </h2>
                                                <div id="flush-collapseTwo" class="accordion-collapse collapse" data-bs-parent="#settingsGuideAccordion">
                                                    <div class="accordion-body px-0 text-muted" style="font-size: 12.5px; line-height: 1.5;">
                                                        Khi Bật, hệ thống tự động trừ % trực tiếp vào tổng đơn giá hàng khi hiển thị ở trang giỏ hàng và trang thanh toán của khách. Đồng thời, một thanh thông báo màu vàng sẽ hiển thị trên đầu header website client.
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="accordion-item" style="background: transparent;">
                                                <h2 class="accordion-header" id="flush-headingThree">
                                                    <button class="accordion-button collapsed px-0 bg-transparent text-dark fw-semibold" style="font-size: 13px;" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree">
                                                        Cách định dạng HTML cho Banner
                                                    </button>
                                                </h2>
                                                <div id="flush-collapseThree" class="accordion-collapse collapse" data-bs-parent="#settingsGuideAccordion">
                                                    <div class="accordion-body px-0 text-muted" style="font-size: 12.5px; line-height: 1.5;">
                                                        Trường tiêu đề chính cho phép nhập mã HTML đơn giản. Bạn có thể sử dụng thẻ <code>&lt;br/&gt;</code> để chỉ định ngắt dòng thủ công, ví dụ: <code>Kiệt tác thời gian&lt;br/&gt;đeo trên tay</code>.
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- closes col-lg-4 -->
                        </div> <!-- closes row -->
                    </form> <!-- closes form -->
                </div> <!-- closes container-fluid -->
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
    <script>
        function updateBannerPreview(val) {
            const previewImg = document.getElementById('bannerSelectPreview');
            if (previewImg) {
                previewImg.src = val;
            }
        }

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

        // JS Toggle AI Chatbot API Key Visibility
        const toggleAiChatApiKeyBtn = document.getElementById('toggleAiChatApiKeyBtn');
        const aiChatApiKeyInput = document.getElementById('aiChatApiKey');
        const aiChatEyeIcon = document.getElementById('aiChatEyeIcon');

        if (toggleAiChatApiKeyBtn && aiChatApiKeyInput && aiChatEyeIcon) {
            toggleAiChatApiKeyBtn.addEventListener('click', function() {
                const type = aiChatApiKeyInput.getAttribute('type') === 'password' ? 'text' : 'password';
                aiChatApiKeyInput.setAttribute('type', type);
                if (type === 'text') {
                    aiChatEyeIcon.classList.remove('fa-eye');
                    aiChatEyeIcon.classList.add('fa-eye-slash');
                } else {
                    aiChatEyeIcon.classList.remove('fa-eye-slash');
                    aiChatEyeIcon.classList.add('fa-eye');
                }
            });
        }

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
