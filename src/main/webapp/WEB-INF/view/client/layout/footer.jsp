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

    <!-- ===== FACEBOOK MESSENGER CHAT PLUGIN ===== -->
    <div id="fb-root"></div>
    <script>
        window.fbAsyncInit = function () {
            FB.init({ xfbml: true, version: 'v19.0' });
        };
        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = 'https://connect.facebook.net/vi_VN/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>

    <div class="fb-customerchat" attribution="biz_inbox" page_id="1172919639219485" theme_color="#d4af37"
        logged_in_greeting="Xin chào! 👋 TST Watch Luxury rất vui được hỗ trợ bạn. Bạn cần tư vấn gì?"
        logged_out_greeting="Xin chào! Bạn cần tư vấn đồng hồ cao cấp? Chat ngay với chúng tôi!">
    </div>

    <!-- Fallback Button -->
    <style>
        .messenger-fab-fallback {
            position: fixed;
            bottom: 28px;
            right: 28px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--gold-accent) 0%, var(--gold-dark) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 8px 24px rgba(212, 175, 55, 0.3);
            z-index: 9997;
            transition: transform 0.3s, box-shadow 0.3s;
            animation: messengerPulse 2.5s infinite;
        }

        .messenger-fab-fallback:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 32px rgba(212, 175, 55, 0.5);
            animation: none;
        }

        @keyframes messengerPulse {

            0%,
            100% {
                box-shadow: 0 8px 24px rgba(212, 175, 55, 0.3);
            }

            50% {
                box-shadow: 0 8px 32px rgba(212, 175, 55, 0.5), 0 0 0 8px rgba(212, 175, 55, 0.1);
            }
        }

        .messenger-fab-fallback::before {
            content: 'Tư vấn cá nhân';
            position: absolute;
            right: 70px;
            background: #11131a;
            color: white;
            border: 1px solid var(--border-thin);
            padding: 6px 14px;
            border-radius: 4px;
            font-size: 12px;
            font-family: var(--font-body);
            white-space: nowrap;
            opacity: 0;
            pointer-events: none;
            transition: opacity 0.2s;
            box-shadow: var(--shadow-md);
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .messenger-fab-fallback:hover::before {
            opacity: 1;
        }
    </style>

    <a href="https://m.me/1172919639219485" target="_blank" rel="noopener noreferrer" class="messenger-fab-fallback"
        id="messengerFallbackFab" aria-label="Chat với TST Watch Luxury qua Messenger">
        <svg width="30" height="30" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
                d="M16 3C8.82 3 3 8.46 3 15.19c0 3.77 1.87 7.13 4.79 9.37V28l4.25-2.34A13.7 13.7 0 0016 26c7.18 0 13-5.46 13-12.19S23.18 3 16 3z"
                fill="white" />
            <path d="M17.07 19.26l-3.32-3.54-6.48 3.54 7.13-7.56 3.4 3.54 6.4-3.54-7.13 7.56z" fill="#d4af37" />
        </svg>
    </a>

    <script>
        window.addEventListener('load', function () {
            setTimeout(function () {
                const fbChat = document.querySelector('.fb_dialog');
                const fallback = document.getElementById('messengerFallbackFab');
                if (fbChat && fallback) {
                    fallback.style.display = 'none';
                }
            }, 3500);
        });
    </script>
    <!-- ===== END MESSENGER CHAT PLUGIN ===== -->
