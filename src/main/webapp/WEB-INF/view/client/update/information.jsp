<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Của Bạn - LapTopShop</title>
    
    <!-- Google Fonts Preconnect and Links for Luxury Theme -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Inter:wght@100;200;300;400;500;600;700;800;900&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

    <!-- Design System Sheet -->
    <link href="/resources/client/css/luxury-theme.css?v=1.9" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="/resources/client/css/update/information.css?v=1.5" rel="stylesheet">
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<div class="container" style="max-width: 1280px;">
    <div class="profile-container-luxury">
        <div class="profile-card-luxury">
            
            <!-- Avatar Banner Section -->
            <div class="text-center mb-5">
                <div class="profile-avatar-wrap">
                    <img src="/images/avatar/${presentUser.avatar}" alt="Avatar" class="profile-avatar-img" id="avatarPreview">
                    <label for="avatarFile" class="profile-avatar-edit-btn" title="Thay đổi ảnh đại diện">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-camera"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg>
                    </label>
                </div>
                <h4 style="font-family: var(--font-heading); font-weight: 400; text-transform: uppercase; color: var(--text-primary); margin: 0 0 4px; letter-spacing: 1px; font-size: 18px;">
                    <c:out value="${presentUser.fullName}"/>
                </h4>
                <p style="margin: 0; color: var(--text-muted); font-size: 13px; font-family: var(--font-body); font-weight: 300;">
                    Thành viên VIP &bull; <c:out value="${presentUser.email}"/>
                </p>
            </div>

            <!-- Profile Form -->
            <form:form action="/client/update" method="post" modelAttribute="presentUser" enctype="multipart/form-data">
                <form:input type="hidden" path="id"/>
                <form:input type="hidden" path="passWord"/>
                <input type="file" id="avatarFile" name="newimg" accept=".png,.jpg,.jpeg">

                <!-- Email (Disabled) -->
                <div class="mb-4">
                    <label class="checkout-label-luxury">Địa chỉ Email</label>
                    <div class="profile-input-wrapper">
                        <span class="profile-input-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                        </span>
                        <form:input type="email" class="profile-input-luxury" path="email" disabled="true"/>
                    </div>
                </div>

                <!-- Họ tên -->
                <div class="mb-4">
                    <label class="checkout-label-luxury">Họ và Tên</label>
                    <div class="profile-input-wrapper">
                        <span class="profile-input-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                        </span>
                        <form:input type="text" class="profile-input-luxury" path="fullName" required="required" placeholder="Họ và tên của bạn"/>
                    </div>
                </div>

                <!-- Số điện thoại -->
                <div class="mb-4">
                    <label class="checkout-label-luxury">Số điện thoại liên lạc</label>
                    <div class="profile-input-wrapper">
                        <span class="profile-input-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                        </span>
                        <form:input type="text" class="profile-input-luxury" path="phone" placeholder="Nhập số điện thoại"/>
                    </div>
                </div>

                <!-- Địa chỉ -->
                <div class="mb-5">
                    <label class="checkout-label-luxury">Địa chỉ giao nhận mặc định</label>
                    <div class="profile-input-wrapper">
                        <span class="profile-input-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                        </span>
                        <form:input type="text" class="profile-input-luxury" path="address" placeholder="Địa chỉ giao hàng"/>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-luxury-action">
                    Lưu Hồ Sơ
                </button>
            </form:form>

            <a href="/" class="d-block text-center mt-4 text-decoration-none" style="color: var(--text-muted); font-size: 13px; font-family: var(--font-body); font-weight: 300; letter-spacing: 1px; transition: color 0.3s ease;" onmouseover="this.style.color='var(--gold-accent)'" onmouseout="this.style.color='var(--text-muted)'">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 4px;"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg> Quay lại trang chủ
            </a>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/client/js/update/information.js?v=1.5" defer></script>
</body>
</html>
