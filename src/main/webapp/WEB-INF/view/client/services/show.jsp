<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dịch Vụ Cao Cấp - TST Watch Luxury</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <!-- Luxury Design System -->
    <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">

    <style>
        body {
            background-color: #06070a;
            color: #ffffff;
            font-family: var(--font-body);
        }

        .services-header {
            padding: 80px 0 40px 0;
            background: linear-gradient(180deg, #0b0c10 0%, #06070a 100%);
            text-align: center;
        }

        .services-title {
            font-family: var(--font-heading);
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: #ffffff;
            margin-bottom: 16px;
        }

        .services-subtitle {
            font-family: var(--font-body);
            color: var(--text-muted);
            font-weight: 300;
            max-width: 600px;
            margin: 0 auto;
            font-size: 15px;
        }

        /* Premium Nav Tabs */
        .services-nav {
            background: rgba(15, 23, 42, 0.3);
            border: 1px solid var(--border-thin);
            padding: 8px;
            border-radius: 12px;
            display: inline-flex;
            gap: 8px;
            margin-bottom: 48px;
            backdrop-filter: blur(10px);
        }

        .services-nav-btn {
            background: transparent;
            border: none;
            color: var(--text-muted);
            padding: 12px 28px;
            font-family: var(--font-body);
            font-weight: 500;
            font-size: 13.5px;
            letter-spacing: 1px;
            text-transform: uppercase;
            border-radius: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
        }

        .services-nav-btn:hover {
            color: #ffffff;
        }

        .services-nav-btn.active {
            background: var(--gold-accent);
            color: #06070a !important;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.25);
        }

        /* Glass Cards */
        .glass-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid var(--border-thin);
            border-radius: 16px;
            padding: 32px;
            height: 100%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(212, 175, 55, 0.05);
            border-color: rgba(212, 175, 55, 0.3);
        }

        .card-icon {
            font-size: 32px;
            color: var(--gold-accent);
            margin-bottom: 24px;
        }

        .card-title-gold {
            font-family: var(--font-heading);
            font-size: 1.25rem;
            color: var(--gold-accent);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 16px;
        }

        .card-desc {
            font-family: var(--font-body);
            color: var(--text-muted);
            font-weight: 300;
            font-size: 13.5px;
            line-height: 1.7;
        }

        /* Pricing Catalog List */
        .pricing-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .pricing-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid var(--border-thin);
        }

        .pricing-item:last-child {
            border-bottom: none;
        }

        .pricing-name {
            font-family: var(--font-body);
            font-weight: 400;
            color: #ffffff;
            font-size: 14px;
        }

        .pricing-price {
            font-family: var(--font-body);
            color: var(--gold-accent);
            font-weight: 500;
            font-size: 14px;
        }

        /* VIP Form Styles */
        .vip-form-control {
            background-color: rgba(255, 255, 255, 0.02) !important;
            border: 1px solid var(--border-thin) !important;
            color: #ffffff !important;
            border-radius: 8px !important;
            padding: 12px 16px !important;
            font-size: 14px !important;
            font-family: var(--font-body) !important;
            transition: all 0.3s ease !important;
        }

        .vip-form-control:focus {
            border-color: var(--gold-accent) !important;
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.15) !important;
            background-color: rgba(255, 255, 255, 0.04) !important;
        }

        /* Style for Select Dropdowns to restore and customize the gold arrow */
        select.vip-form-control {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23d4af37' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e") !important;
            background-position: right 16px center !important;
            background-size: 16px 12px !important;
            background-repeat: no-repeat !important;
            padding-right: 40px !important;
            appearance: none !important;
            -webkit-appearance: none !important;
            -moz-appearance: none !important;
        }

        /* Style for Option Items inside dark dropdowns */
        .vip-form-control option {
            background-color: #11141a;
            color: #ffffff;
        }

        /* Style for Date/Time picker calendar icon in webkit browsers */
        .vip-form-control::-webkit-calendar-picker-indicator {
            filter: invert(72%) sepia(54%) saturate(415%) hue-rotate(354deg) brightness(92%) contrast(89%); /* Gold calendar icon */
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.2s ease;
        }

        .vip-form-control::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
        }

        .vip-form-label {
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-muted);
            margin-bottom: 8px;
            font-weight: 500;
        }

        .alert-vip {
            background: rgba(212, 175, 55, 0.08);
            border: 1px solid var(--gold-accent);
            color: #ffffff;
            border-radius: 12px;
            padding: 20px 24px;
        }
    </style>
</head>
<body>

    <jsp:include page="../layout/header.jsp" />

    <!-- Services Header Banner -->
    <header class="services-header">
        <div class="container">
            <h1 class="services-title">Tuyệt tác dịch vụ đặc quyền</h1>
            <p class="services-subtitle">TST Watch Luxury cam kết mang đến những đặc quyền chăm sóc và spa đồng hồ đẳng cấp Thụy Sĩ dành riêng cho giới thượng lưu.</p>
        </div>
    </header>

    <div class="container text-center pb-5">
        
        <!-- Services Navigation Tabs -->
        <div class="services-nav" id="servicesTabs" role="tablist">
            <button class="services-nav-btn ${activeTab == 'warranty' ? 'active' : ''}" id="warranty-tab" data-bs-toggle="tab" data-bs-target="#warranty-content" type="button" role="tab" data-tab-name="warranty">
                <i class="fas fa-shield-alt me-2"></i> Bảo hành đặc quyền
            </button>
            <button class="services-nav-btn ${activeTab == 'spa' ? 'active' : ''}" id="spa-tab" data-bs-toggle="tab" data-bs-target="#spa-content" type="button" role="tab" data-tab-name="spa">
                <i class="fas fa-magic me-2"></i> Spa đồng hồ
            </button>
            <button class="services-nav-btn ${activeTab == 'appointment' ? 'active' : ''}" id="appointment-tab" data-bs-toggle="tab" data-bs-target="#appointment-content" type="button" role="tab" data-tab-name="appointment">
                <i class="fas fa-calendar-check me-2"></i> Đặt lịch VIP
            </button>
        </div>

        <!-- Tab Content Panes -->
        <div class="tab-content text-start" id="servicesTabContent">
            
            <!-- TAB 1: WARRANTY DETAILS -->
            <div class="tab-pane fade ${activeTab == 'warranty' ? 'show active' : ''}" id="warranty-content" role="tabpanel" aria-labelledby="warranty-tab">
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="glass-card">
                            <div class="card-icon"><i class="fas fa-award"></i></div>
                            <h3 class="card-title-gold">Bảo hành 5 năm toàn cầu</h3>
                            <p class="card-desc">Tất cả tuyệt tác đồng hồ được cung cấp bởi TST Watch Luxury đều được áp dụng gói bảo hành đặc quyền 5 năm toàn diện, bao gồm cả lỗi người dùng (theo điều khoản).</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="glass-card">
                            <div class="card-icon"><i class="fas fa-truck-moving"></i></div>
                            <h3 class="card-title-gold">Giao nhận tại gia miễn phí</h3>
                            <p class="card-desc">Hệ thống TST Luxury cung cấp dịch vụ giao và nhận đồng hồ bảo dưỡng ngay tại tư gia của quý khách. An toàn tuyệt đối với đội ngũ bảo an riêng biệt.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="glass-card">
                            <div class="card-icon"><i class="fas fa-tools"></i></div>
                            <h3 class="card-title-gold">Linh kiện Thụy Sĩ chính hãng</h3>
                            <p class="card-desc">Chúng tôi chỉ sử dụng linh phụ kiện chính hãng, nhập khẩu trực tiếp từ các nhà sản xuất Thụy Sĩ. Mọi quy trình sửa chữa được lưu vết số hóa 100%.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TAB 2: SPA SERVICES CATALOG -->
            <div class="tab-pane fade ${activeTab == 'spa' ? 'show active' : ''}" id="spa-content" role="tabpanel" aria-labelledby="spa-tab">
                <div class="row g-5">
                    <div class="col-lg-6">
                        <h3 class="card-title-gold mb-4" style="font-size: 1.5rem;"><i class="fas fa-sparkles me-2"></i> Spa bảo dưỡng đồng hồ</h3>
                        <p class="card-desc mb-4" style="font-size: 14.5px;">Bảo dưỡng đồng hồ định kỳ là yếu tố cốt lõi để giữ cho cỗ máy cơ khí hoạt động chính xác qua nhiều thập kỷ. Tại TST Luxury, chúng tôi vận hành phòng lab tiêu chuẩn phòng sạch quốc tế, đầy đủ trang thiết bị chuyên dụng.</p>
                        <div class="glass-card p-4" style="height: auto;">
                            <h4 class="card-title-gold" style="font-size: 16px;"><i class="fas fa-check-circle me-2"></i> Quy trình Spa chuẩn 9 bước:</h4>
                            <ol class="card-desc" style="line-height: 2;">
                                <li>Kiểm tra thẩm mỹ tổng quan trước khi tháo rời.</li>
                                <li>Kiểm tra sai số máy cơ khí bằng thiết bị chuyên dụng.</li>
                                <li>Tháo rời toàn bộ chi tiết máy và vệ sinh siêu âm.</li>
                                <li>Tẩy dầu cũ, chấm dầu mới chuẩn hãng Thụy Sĩ.</li>
                                <li>Vệ sinh, đánh bóng vỏ và dây kim loại.</li>
                                <li>Thay gioăng chống nước cao su mới.</li>
                                <li>Lắp ráp máy và căn chỉnh độ chính xác.</li>
                                <li>Kiểm tra áp suất chống nước trong buồng khí chân không.</li>
                                <li>Theo dõi trữ cót và sai số liên tục trong 48 tiếng.</li>
                            </ol>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="glass-card">
                            <h3 class="card-title-gold mb-4 text-center" style="font-size: 1.4rem;">Bảng giá Spa Đồng Hồ Tham Khảo</h3>
                            <ul class="pricing-list">
                                <li class="pricing-item">
                                    <span class="pricing-name">Đánh bóng mặt kính / Vỏ máy cao cấp</span>
                                    <span class="pricing-price">Từ 800.000 đ</span>
                                </li>
                                <li class="pricing-item">
                                    <span class="pricing-name">Lau dầu & Bảo dưỡng máy Quartz (Pin)</span>
                                    <span class="pricing-price">Từ 1.200.000 đ</span>
                                </li>
                                <li class="pricing-item">
                                    <span class="pricing-name">Lau dầu & Căn chỉnh máy Automatic (Cơ)</span>
                                    <span class="pricing-price">Từ 2.500.000 đ</span>
                                </li>
                                <li class="pricing-item">
                                    <span class="pricing-name">Lau dầu máy phức tạp (Chronograph/Moonphase)</span>
                                    <span class="pricing-price">Từ 4.500.000 đ</span>
                                </li>
                                <li class="pricing-item">
                                    <span class="pricing-name">Thay pin đồng hồ cao cấp (Bảo hành 2 năm)</span>
                                    <span class="pricing-price">Đồng giá 500.000 đ</span>
                                </li>
                                <li class="pricing-item">
                                    <span class="pricing-name">Thay gioăng chống nước & Thử áp suất nước</span>
                                    <span class="pricing-price">Từ 400.000 đ</span>
                                </li>
                            </ul>
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-outline-warning btn-sm" onclick="showBookingTab()">
                                    Đặt lịch hẹn ngay
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TAB 3: VIP BOOKING FORM -->
            <div class="tab-pane fade ${activeTab == 'appointment' ? 'show active' : ''}" id="appointment-content" role="tabpanel" aria-labelledby="appointment-tab">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="glass-card">
                            <h3 class="card-title-gold text-center mb-2" style="font-size: 1.5rem;">Đặc quyền đặt lịch hẹn VIP</h3>
                            <p class="card-desc text-center mb-5">Vui lòng điền thông tin dưới đây. Đội ngũ chuyên viên TST Luxury sẽ chuẩn bị không gian tiếp đón riêng tư cùng trà/rượu vang hảo hạng dành riêng cho bạn.</p>

                            <!-- Success Banner -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-vip alert-dismissible fade show mb-4" role="alert">
                                    <div class="d-flex align-items-center gap-3">
                                        <i class="fas fa-check-circle fa-2x text-warning"></i>
                                        <div>
                                            <h5 class="alert-heading text-warning mb-1" style="font-family: var(--font-heading); text-transform: uppercase;">Đặt lịch thành công</h5>
                                            <p class="mb-0 small" style="font-weight: 300;">${successMessage}</p>
                                        </div>
                                    </div>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <form action="/services/appointment" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <label for="fullName" class="vip-form-label">Họ và tên quý khách</label>
                                        <input type="text" class="form-control vip-form-control" id="fullName" name="fullName" 
                                               value="${not empty currentUser ? currentUser.fullName : ''}" placeholder="e.g. Nguyễn Văn A" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phoneNumber" class="vip-form-label">Số điện thoại liên hệ</label>
                                        <input type="tel" class="form-control vip-form-control" id="phoneNumber" name="phoneNumber" 
                                               value="${not empty currentUser ? currentUser.phone : ''}" placeholder="e.g. 0901234567" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="email" class="vip-form-label">Địa chỉ Email (Để nhận thông tin xác nhận)</label>
                                    <input type="email" class="form-control vip-form-control" id="email" name="email" 
                                           value="${not empty currentUser ? currentUser.email : ''}" placeholder="e.g. client@example.com" required>
                                </div>

                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <label for="serviceType" class="vip-form-label">Dịch vụ quý khách yêu cầu</label>
                                        <select class="form-select vip-form-control" id="serviceType" name="serviceType" required>
                                            <option value="Spa & Lau dầu đồng hồ">Spa & Lau dầu bảo dưỡng đồng hồ</option>
                                            <option value="Bảo hành đặc quyền">Dịch vụ Bảo hành đặc quyền</option>
                                            <option value="Tư vấn mua đồng hồ VIP">Tư vấn mua sắm đồng hồ (B boutique tiếp đón riêng)</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="boutique" class="vip-form-label">Chọn địa điểm Boutique</label>
                                        <select class="form-select vip-form-control" id="boutique" name="boutique" required>
                                            <option value="Boutique Hoàn Kiếm, Hà Nội">Boutique Hoàn Kiếm - Hà Nội</option>
                                            <option value="Boutique Quận 1, TP. Hồ Chí Minh">Boutique Quận 1 - TP. Hồ Chí Minh</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label for="appointmentTime" class="vip-form-label">Thời gian mong muốn (Ngày & Giờ)</label>
                                    <input type="datetime-local" class="form-control vip-form-control" id="appointmentTime" name="appointmentTime" required>
                                </div>

                                <div class="mb-5">
                                    <label for="notes" class="vip-form-label">Ghi chú thêm (Dòng sản phẩm quý khách mang theo / Yêu cầu đặc biệt)</label>
                                    <textarea class="form-control vip-form-control" id="notes" name="notes" rows="4" placeholder="Ví dụ: Rolex Datejust 126333 mặt số Champagne cần lau dầu, yêu cầu chuẩn bị phòng VIP..."></textarea>
                                </div>

                                <button type="submit" class="btn-luxury-action py-3 w-100 fw-bold">
                                    XÁC NHẬN ĐẶT LỊCH HẸN VIP
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>

    <jsp:include page="../layout/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Activating correct tab based on query param
            const urlParams = new URLSearchParams(window.location.search);
            const activeTabParam = urlParams.get('tab');
            
            if (activeTabParam) {
                const tabEl = document.querySelector(`#servicesTabs button[data-tab-name="${activeTabParam}"]`);
                if (tabEl) {
                    const bsTab = new bootstrap.Tab(tabEl);
                    bsTab.show();
                }
            }
        });

        function showBookingTab() {
            const appointmentTabEl = document.getElementById('appointment-tab');
            if (appointmentTabEl) {
                const bsTab = new bootstrap.Tab(appointmentTabEl);
                bsTab.show();
            }
        }
    </script>
</body>
</html>
