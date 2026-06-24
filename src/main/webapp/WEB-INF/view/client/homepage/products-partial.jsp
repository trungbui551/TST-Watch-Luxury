<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose>
    <c:when test="${empty pros}">
        <div class="text-center py-5 w-100" style="min-height: 300px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
            <div class="mb-4">
                <i class="fas fa-search-minus" style="font-size: 48px; color: var(--gold-accent);"></i>
            </div>
            <h4 style="font-family: var(--font-heading); font-weight: 500; color: var(--text-primary); text-transform: uppercase; letter-spacing: 1px;">Không tìm thấy tuyệt tác nào</h4>
            <p style="color: var(--text-muted); margin-bottom: 24px; max-width: 400px; font-size: 14px;">Hãy thử điều chỉnh bộ lọc hoặc từ khóa tìm kiếm để tìm sản phẩm mong muốn.</p>
            <button class="btn-luxury" onclick="clearAllFilters()" style="padding: 10px 24px; font-size: 12px;">Xóa bộ lọc</button>
        </div>
    </c:when>
    <c:otherwise>
        <div class="product-grid" id="productGrid">
            <c:forEach var="pro" items="${pros}">
                <div class="luxury-card-watch d-flex flex-column" style="position: relative;">
                    <div class="luxury-badge" style="position: absolute; top: 16px; left: 16px; z-index: 10;">
                        NEW
                    </div>

                    <a href="/product/${pro.id}" class="product-img-wrap d-block mb-3">
                        <img src="/images/product/<c:out value='${pro.image}'/>"
                             alt="<c:out value='${pro.name}'/>"
                             class="product-img-hover"
                             loading="lazy">
                    </a>

                    <div class="mt-auto">
                        <a href="/product/${pro.id}" class="d-block mb-2 text-decoration-none">
                            <h5 class="product-title">
                                <c:out value="${pro.name}"/>
                            </h5>
                        </a>
                        <p style="color: var(--text-muted); font-size: 13px;
                                  margin-bottom: 16px;
                                  display: -webkit-box; -webkit-line-clamp: 2;
                                  -webkit-box-orient: vertical; overflow: hidden;
                                  line-height: 1.6;">
                            <c:out value="${pro.shortDesc}"/>
                        </p>

                        <div class="d-flex align-items-center justify-content-between mt-3 pt-3"
                             style="border-top: 1px solid var(--border-thin) !important;">
                            <div class="product-price">
                                <c:choose>
                                    <c:when test="${promoActive == 'true'}">
                                        <span style="text-decoration: line-through; color: var(--text-muted); font-size: 13px; margin-right: 8px; font-weight: 300;">
                                            <fmt:formatNumber type="number" value="${pro.price}"/> đ
                                        </span>
                                        <span style="color: var(--gold-accent); font-weight: 500;">
                                            <fmt:formatNumber type="number" value="${pro.price * (1.0 - (promoDiscount / 100.0))}"/> đ
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber type="number" value="${pro.price}"/> đ
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <form action="/add-product-to-cart/${pro.id}" method="post" class="m-0"
                                  data-is-unique="${pro.isUnique}"
                                  data-sizes="${pro.sizes}"
                                  data-dial-colors="${pro.dialColors}"
                                  data-strap-colors="${pro.strapColors}"
                                  data-image="${pro.image}"
                                  data-images="${pro.images}"
                                  data-dial-colors-images="${pro.dialColorsImages}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn-cart-circle" title="Thêm vào giỏ hàng"
                                        aria-label="Thêm ${pro.name} vào giỏ hàng">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-cart"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <%-- Pagination --%>
        <c:if test="${totalPages > 1}">
            <ul class="premium-pagination" id="paginationBar" data-current="${currentPage}" data-total="${totalPages}">
                <c:if test="${currentPage > 1}">
                    <li class="premium-page-item">
                        <a class="premium-page-link page-link-ajax" href="#"
                           data-page="${currentPage - 1}" aria-label="Trang trước">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-left"><polyline points="15 18 9 12 15 6"></polyline></svg>
                        </a>
                    </li>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <li class="premium-page-item ${currentPage == i ? 'active' : ''}">
                        <a class="premium-page-link page-link-ajax" href="#" data-page="${i}">${i}</a>
                    </li>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="premium-page-item">
                        <a class="premium-page-link page-link-ajax" href="#"
                           data-page="${currentPage + 1}" aria-label="Trang tiếp">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-right"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </a>
                    </li>
                </c:if>
            </ul>
        </c:if>
    </c:otherwise>
</c:choose>
