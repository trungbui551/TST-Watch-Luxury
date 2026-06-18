<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Xác thực Email - Lấy lại mật khẩu</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    min-height: 100vh;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                    position: relative;
                    overflow-x: hidden;
                }

                /* Animated background particles */
                .background-animation {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                    z-index: 0;
                }

                .particle {
                    position: absolute;
                    background: rgba(255, 255, 255, 0.1);
                    border-radius: 50%;
                    animation: float 6s ease-in-out infinite;
                }

                .particle:nth-child(1) {
                    width: 80px;
                    height: 80px;
                    left: 10%;
                    animation-delay: 0s;
                }

                .particle:nth-child(2) {
                    width: 120px;
                    height: 120px;
                    left: 20%;
                    animation-delay: 2s;
                }

                .particle:nth-child(3) {
                    width: 60px;
                    height: 60px;
                    left: 60%;
                    animation-delay: 4s;
                }

                .particle:nth-child(4) {
                    width: 100px;
                    height: 100px;
                    left: 80%;
                    animation-delay: 1s;
                }

                .particle:nth-child(5) {
                    width: 40px;
                    height: 40px;
                    left: 70%;
                    animation-delay: 3s;
                }

                @keyframes float {

                    0%,
                    100% {
                        transform: translateY(0px) rotate(0deg);
                        opacity: 0.7;
                    }

                    50% {
                        transform: translateY(-100px) rotate(180deg);
                        opacity: 1;
                    }
                }

                .container {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(20px);
                    border-radius: 24px;
                    padding: 60px 40px;
                    box-shadow:
                        0 20px 40px rgba(0, 0, 0, 0.1),
                        0 0 0 1px rgba(255, 255, 255, 0.2);
                    text-align: center;
                    max-width: 600px;
                    width: 100%;
                    position: relative;
                    z-index: 1;
                    animation: slideUp 0.8s ease-out;
                }

                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .icon-container {
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 80px;
                    height: 80px;
                    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    border-radius: 50%;
                    margin-bottom: 30px;
                    animation: pulse 2s infinite;
                }

                @keyframes pulse {
                    0% {
                        transform: scale(1);
                        box-shadow: 0 0 0 0 rgba(79, 172, 254, 0.7);
                    }

                    70% {
                        transform: scale(1.05);
                        box-shadow: 0 0 0 20px rgba(79, 172, 254, 0);
                    }

                    100% {
                        transform: scale(1);
                        box-shadow: 0 0 0 0 rgba(79, 172, 254, 0);
                    }
                }

                .icon {
                    width: 40px;
                    height: 40px;
                    fill: white;
                }

                h1 {
                    font-size: 2.2rem;
                    font-weight: 600;
                    color: #2d3748;
                    margin-bottom: 20px;
                    line-height: 1.3;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .description {
                    font-size: 1.1rem;
                    color: #4a5568;
                    line-height: 1.6;
                    margin-bottom: 40px;
                    max-width: 480px;
                    margin-left: auto;
                    margin-right: auto;
                }

                .action-buttons {
                    display: flex;
                    gap: 16px;
                    justify-content: center;
                    flex-wrap: wrap;
                }

                .btn {
                    padding: 14px 28px;
                    border-radius: 12px;
                    font-weight: 500;
                    font-size: 1rem;
                    text-decoration: none;
                    transition: all 0.3s ease;
                    border: none;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                }

                .btn-primary {
                    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    color: white;
                    box-shadow: 0 8px 16px rgba(79, 172, 254, 0.3);
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 12px 24px rgba(79, 172, 254, 0.4);
                }

                .btn-secondary {
                    background: rgba(113, 128, 150, 0.1);
                    color: #4a5568;
                    border: 1px solid rgba(113, 128, 150, 0.2);
                }

                .btn-secondary:hover {
                    background: rgba(113, 128, 150, 0.15);
                    transform: translateY(-1px);
                }

                .footer-text {
                    margin-top: 30px;
                    font-size: 0.9rem;
                    color: #718096;
                }

                .footer-text a {
                    color: #4facfe;
                    text-decoration: none;
                    font-weight: 500;
                }

                .footer-text a:hover {
                    text-decoration: underline;
                }

                /* Responsive Design */
                @media (max-width: 768px) {
                    .container {
                        padding: 40px 30px;
                        margin: 10px;
                    }

                    h1 {
                        font-size: 1.8rem;
                    }

                    .description {
                        font-size: 1rem;
                    }

                    .action-buttons {
                        flex-direction: column;
                        align-items: center;
                    }

                    .btn {
                        width: 100%;
                        max-width: 280px;
                        justify-content: center;
                    }
                }

                @media (max-width: 480px) {
                    .container {
                        padding: 30px 20px;
                    }

                    h1 {
                        font-size: 1.6rem;
                    }
                }
            </style>
        </head>

        <body>
            <!-- Animated background -->
            <div class="background-animation">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>

            <div class="container">
                <div class="icon-container">
                    <svg class="icon" viewBox="0 0 24 24">
                        <path
                            d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z" />
                    </svg>
                </div>

                <h1>Email xác thực đã được gửi!</h1>

                <p class="description">
                    Chúng tôi đã gửi email xác thực đến địa chỉ của bạn.
                    Vui lòng kiểm tra hộp thư và làm theo hướng dẫn để lấy lại mật khẩu.
                </p>

                <div class="action-buttons">
                    <a href="mailto:" class="btn btn-primary">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path
                                d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z" />
                        </svg>
                        Mở Email
                    </a>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19 7v4H5.83l3.58-3.59L8 6l-6 6 6 6 1.41-1.41L5.83 13H19V7z" />
                        </svg>
                        Quay lại đăng nhập
                    </a>
                </div>

                <p class="footer-text">
                    Không nhận được email?
                    <a href="${pageContext.request.contextPath}/forgot-password">Gửi lại</a> hoặc
                    <a href="${pageContext.request.contextPath}/contact">liên hệ hỗ trợ</a>
                </p>
            </div>

            <script>
                // Add some interactive effects
                document.addEventListener('DOMContentLoaded', function () {
                    // Add click effect to buttons
                    const buttons = document.querySelectorAll('.btn');
                    buttons.forEach(button => {
                        button.addEventListener('click', function (e) {
                            // Create ripple effect
                            const ripple = document.createElement('span');
                            const rect = button.getBoundingClientRect();
                            const size = Math.max(rect.width, rect.height);
                            const x = e.clientX - rect.left - size / 2;
                            const y = e.clientY - rect.top - size / 2;

                            ripple.style.width = ripple.style.height = size + 'px';
                            ripple.style.left = x + 'px';
                            ripple.style.top = y + 'px';
                            ripple.style.position = 'absolute';
                            ripple.style.borderRadius = '50%';
                            ripple.style.background = 'rgba(255, 255, 255, 0.3)';
                            ripple.style.transform = 'scale(0)';
                            ripple.style.animation = 'ripple 600ms linear';
                            ripple.style.pointerEvents = 'none';

                            button.appendChild(ripple);

                            setTimeout(() => {
                                ripple.remove();
                            }, 600);
                        });
                    });
                });

                // Add CSS for ripple animation
                const style = document.createElement('style');
                style.textContent = `
            .btn {
                position: relative;
                overflow: hidden;
            }
            
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
                document.head.appendChild(style);
            </script>
        </body>

        </html>
