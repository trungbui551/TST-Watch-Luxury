<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <footer style="background-color: #06070a; color: var(--text-muted);
               padding: 80px 0 32px 0; margin-top: 0; border-top: 1px solid var(--border-thin);">
        <div class="container" style="max-width: 1280px; padding: 0 24px;">

            <div class="row g-5 border-bottom pb-5 mb-5" style="border-color: var(--border-thin) !important;">

                <!-- Cột 1: Heritage -->
                <div class="col-lg-4">
                    <a href="/" class="text-decoration-none d-inline-block mb-4">
                        <div style="font-family: var(--font-heading); font-weight: 700;
                                color: white; font-size: 1.5rem; letter-spacing: 2px; text-transform: uppercase;">
                            TST Watch<span style="color: var(--gold-accent);"> Luxury®</span>
                        </div>
                    </a>
                    <p class="footer-desc-luxury mb-4" style="max-width: 300px;">
                        Kiến tạo từ những giá trị nguyên bản, mang đến trải nghiệm công nghệ tinh xảo và vị thế dẫn đầu
                        cho giới thượng lưu.
                    </p>
                    <div class="d-flex gap-3">
                        <a href="#" class="footer-social-btn" aria-label="Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="footer-social-btn" aria-label="Twitter">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="footer-social-btn" aria-label="Instagram">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="footer-social-btn" aria-label="YouTube">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>

                <!-- Cột 2: Collections -->
                <div class="col-lg-2 col-md-6">
                    <h5 class="footer-title-luxury mb-4">Collections</h5>
                    <ul class="list-unstyled d-flex flex-column gap-3">
                        <li><a href="#" class="footer-link">Luminas Prestige</a></li>
                        <li><a href="#" class="footer-link">Aero Signature</a></li>
                        <li><a href="#" class="footer-link">Titan Force Series</a></li>
                        <li><a href="#" class="footer-link">Visionary Pro</a></li>
                    </ul>
                </div>

                <!-- Cột 3: Services -->
                <div class="col-lg-2 col-md-6">
                    <h5 class="footer-title-luxury mb-4">Services</h5>
                    <ul class="list-unstyled d-flex flex-column gap-3">
                        <li><a href="#" class="footer-link">Bảo hành đặc quyền</a></li>
                        <li><a href="#" class="footer-link">Giao nhận tận nơi</a></li>
                        <li><a href="#" class="footer-link">Tư vấn cá nhân 24/7</a></li>
                        <li><a href="#" class="footer-link">Đặc quyền thành viên</a></li>
                    </ul>
                </div>

                <!-- Cột 4: Newsletter -->
                <div class="col-lg-4">
                    <h5 class="footer-title-luxury mb-4">Newsletter</h5>
                    <p class="footer-desc-luxury mb-4">
                        Đăng ký để nhận thông tin về các bộ sưu tập giới hạn và đặc quyền sớm nhất.
                    </p>

                    <!-- Minimalist Newsletter Form -->
                    <form class="newsletter-form-minimal mb-4">
                        <input type="email" class="newsletter-input-minimal" placeholder="EMAIL CỦA BẠN..."
                            aria-label="Email đăng ký nhận bản tin" required>
                        <button type="submit" class="newsletter-btn-minimal">
                            ĐĂNG KÝ
                        </button>
                    </form>

                    <!-- Support Hotline -->
                    <div class="d-flex align-items-center gap-3">
                        <div style="width: 40px; height: 40px; border-radius: 50%;
                                background: rgba(212, 175, 55, 0.08); display: flex;
                                align-items: center; justify-content: center; flex-shrink: 0;
                                border: 1px solid var(--border-thin);">
                            <i class="fas fa-headset" style="color: var(--gold-accent); font-size: 16px;"></i>
                        </div>
                        <div>
                            <div
                                style="color: var(--text-muted); font-size: 11px; letter-spacing: 1.5px; text-transform: uppercase;">
                                Hotline hỗ trợ 24/7</div>
                            <div class="text-white fw-bold"
                                style="font-size: 1.1rem; font-family: var(--font-heading); color: var(--gold-accent) !important;">
                                1800 6868
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bottom bar -->
            <div class="row align-items-center">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0"
                    style="color: var(--text-muted); font-size: 13px; letter-spacing: 0.5px;">
                    &copy; 2026 TST Watch Luxury® All rights reserved.
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <div
                        style="display: flex; gap: 24px; justify-content: flex-end; align-items: center; flex-wrap: wrap;">
                        <a href="#" class="footer-link" style="font-size: 13px; letter-spacing: 0.5px;">Chính sách bảo
                            mật</a>
                        <a href="#" class="footer-link" style="font-size: 13px; letter-spacing: 0.5px;">Điều khoản dịch
                            vụ</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Global Add to Cart Modal (Luxury Style) -->
    <div class="modal fade" id="globalAddCartModal" tabindex="-1" aria-labelledby="globalAddCartModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-content-luxury">
                <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title" id="globalAddCartModalLabel" style="font-family: var(--font-heading); text-transform: uppercase; color: var(--gold-accent); font-size: 18px; letter-spacing: 1.5px;">Tùy chọn tuyệt tác</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-4">
                    <!-- Product Preview -->
                    <div class="d-flex align-items-center gap-3 mb-4 p-3" style="background: rgba(255,255,255,0.02); border: 1px solid var(--border-thin); border-radius: var(--radius-sm);">
                        <div style="width: 60px; height: 60px; padding: 4px; border: 1px solid var(--border-thin); border-radius: 4px; display: flex; align-items: center; justify-content: center; background: #06070a;">
                            <img id="modalProductImg" src="" style="max-width: 100%; max-height: 100%; object-fit: contain;" alt="Product">
                        </div>
                        <div>
                            <h6 id="modalProductTitle" style="font-family: var(--font-heading); color: #ffffff; margin: 0 0 4px 0; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px;"></h6>
                            <span id="modalProductPrice" style="color: var(--gold-accent); font-family: var(--font-body); font-weight: 400; font-size: 14px;"></span>
                        </div>
                    </div>

                    <!-- Modal form that will be submitted -->
                    <form id="modalAddToCartForm" method="post" action="">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <!-- Unique Product Badge -->
                         <div id="modalUniqueBadge" class="luxury-badge mb-4 d-none" style="font-size: 11px;">Tác phẩm độc bản / Unique Piece</div>

                         <!-- Size Selection -->
                         <div class="mb-4" id="modalSizeSection">
                             <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin-bottom: 8px;">Kích thước (Đường kính)</div>
                             <div class="d-flex gap-2" id="modalSizeSelector">
                                 <!-- Will be rendered dynamically via JS -->
                             </div>
                             <div id="modalSizeError" class="size-error-msg"></div>
                             <input type="hidden" name="size" id="modalSelectedSize" value="" />
                         </div>

                         <!-- Dial Color Selection -->
                         <div class="mb-4" id="modalDialColorSection">
                             <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin-bottom: 8px;">Màu mặt số (Dial Color)</div>
                             <div class="d-flex gap-3 align-items-center" id="modalDialColorSelector">
                                 <!-- Will be rendered dynamically via JS -->
                             </div>
                             <div id="modalDialColorDisplay" style="font-size: 12px; color: var(--gold-accent); margin-top: 6px; font-weight: 300; letter-spacing: 0.5px;">Vui lòng chọn màu mặt số</div>
                             <input type="hidden" name="dialColor" id="modalSelectedDialColor" value="" />
                         </div>

                         <!-- Strap Color Selection -->
                         <div class="mb-4" id="modalStrapColorSection">
                             <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin-bottom: 8px;">Màu dây (Strap Color)</div>
                             <div class="d-flex gap-3 align-items-center" id="modalStrapColorSelector">
                                 <!-- Will be rendered dynamically via JS -->
                             </div>
                             <div id="modalStrapColorDisplay" style="font-size: 12px; color: var(--gold-accent); margin-top: 6px; font-weight: 300; letter-spacing: 0.5px;">Vui lòng chọn màu dây</div>
                             <input type="hidden" name="strapColor" id="modalSelectedStrapColor" value="" />
                         </div>

                         <!-- Combined Color Value hidden input (legacy compatibility) -->
                         <input type="hidden" name="color" id="modalSelectedColor" value="" />

                        <!-- Quantity Selection -->
                        <div class="mb-4">
                            <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1.5px; color: var(--text-muted); margin-bottom: 8px;">Số lượng</div>
                            <div class="qty-control-luxury">
                                <button type="button" class="qty-btn-luxury" id="modalQtyMinus" aria-label="Giảm số lượng">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                </button>
                                <input type="text" class="qty-input-luxury" name="quantity" value="1"
                                       id="modalQtyInput" min="1" readonly aria-label="Số lượng">
                                <button type="button" class="qty-btn-luxury" id="modalQtyPlus" aria-label="Tăng số lượng">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                </button>
                            </div>
                        </div>

                        <button type="submit" class="btn-luxury-action">
                            Xác Nhận Thêm Vào Giỏ Hàng
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== AI CHAT CONSULTANT WIDGET ===== -->
    <link href="/resources/client/css/layout/ai-chat.css" rel="stylesheet">

    <!-- Floating AI Chat Widget Trigger -->
    <button type="button" id="aiChatTrigger" aria-label="Tư vấn với AI">
        <i class="fas fa-robot"></i>
    </button>

    <!-- AI Chat Window -->
    <div id="aiChatWindow">
        <div class="ai-chat-header">
            <div class="ai-chat-title-wrap">
                <div class="ai-chat-avatar">
                    <i class="fas fa-robot"></i>
                </div>
                <div class="ai-chat-info">
                    <h6>Trợ Lý TST Luxury</h6>
                    <div class="ai-chat-status">
                        <span class="ai-chat-status-dot"></span>Trực tuyến
                    </div>
                </div>
            </div>
            <button type="button" class="ai-chat-close" id="aiChatClose">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div class="ai-chat-body" id="aiChatBody">
            <!-- Bubbles loaded dynamically -->
        </div>
        <div class="ai-chat-suggestions">
            <button type="button" class="ai-pill" data-query="Cổ tay tôi 16.5cm nên đeo size mặt số bao nhiêu?">Đo size cổ tay</button>
            <button type="button" class="ai-pill" data-query="Tư vấn đồng hồ nam thanh lịch đi làm công sở">Đồng hồ công sở</button>
            <button type="button" class="ai-pill" data-query="Gợi ý đồng hồ lặn biển chống nước tốt">Đồng hồ lặn/thể thao</button>
        </div>
        <div class="ai-chat-footer">
            <form id="aiChatForm" class="ai-chat-form">
                <input type="text" id="aiChatInput" class="ai-chat-input" placeholder="Hỏi trợ lý TST Luxury..." autocomplete="off" required>
                <button type="submit" class="ai-chat-send-btn" aria-label="Gửi">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </form>
        </div>
    </div>

    <script src="/resources/client/js/layout/ai-chat.js" defer></script>
    <!-- ===== END AI CHAT CONSULTANT WIDGET ===== -->

    <!-- ===== FACEBOOK MESSENGER CHAT PLUGIN ===== -->
    <div id="fb-root"></div>
    <script src="/resources/client/js/layout/footer.js?v=2.0" defer></script>

    <div class="fb-customerchat" attribution="biz_inbox" page_id="1172919639219485" theme_color="#d4af37"
        logged_in_greeting="Xin chào! 👋 TST Watch Luxury rất vui được hỗ trợ bạn. Bạn cần tư vấn gì?"
        logged_out_greeting="Xin chào! Bạn cần tư vấn đồng hồ cao cấp? Chat ngay với chúng tôi!">
    </div>

    <!-- Fallback Button -->
    <link href="/resources/client/css/layout/footer.css?v=1.5" rel="stylesheet">

    <a href="https://m.me/1172919639219485" target="_blank" rel="noopener noreferrer" class="messenger-fab-fallback"
        id="messengerFallbackFab" aria-label="Chat với TST Watch Luxury qua Messenger">
        <svg width="30" height="30" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
                d="M16 3C8.82 3 3 8.46 3 15.19c0 3.77 1.87 7.13 4.79 9.37V28l4.25-2.34A13.7 13.7 0 0016 26c7.18 0 13-5.46 13-12.19S23.18 3 16 3z"
                fill="white" />
            <path d="M17.07 19.26l-3.32-3.54-6.48 3.54 7.13-7.56 3.4 3.54 6.4-3.54-7.13 7.56z" fill="#d4af37" />
        </svg>
    </a>


    <!-- ===== END MESSENGER CHAT PLUGIN ===== -->
