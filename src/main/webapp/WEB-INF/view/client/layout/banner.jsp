<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="luxury-hero-section" style="background-image: url('${bannerImageUrl}');">
    <div class="luxury-hero-overlay"></div>
    <div class="container luxury-hero-content" style="max-width: 1280px;">
        <div class="row align-items-center">
            <div class="col-lg-8 text-center text-lg-start fade-in-up stagger-1 mx-auto mx-lg-0">
                <div class="luxury-badge mb-4">
                    <span class="gold-dot"></span> <c:out value="${bannerBadge}"/>
                </div>
                <h1 class="luxury-hero-title mb-4">
                    ${bannerTitle}
                </h1>
                <p class="mb-5 text-muted-luxury" style="font-size: 1.125rem; max-width: 600px; letter-spacing: 0.5px;">
                    <c:out value="${bannerSubtitle}"/>
                </p>

                <div class="d-flex flex-wrap gap-4 justify-content-center justify-content-lg-start align-items-center fade-in-up stagger-2">
                    <a href="#san-pham" class="btn-luxury">
                        <c:out value="${bannerButtonText}"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
