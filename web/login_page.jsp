<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AutoWash Pro - Login</title>
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <!-- Custom CSS -->
    <link href="css/theme.css" rel="stylesheet"/>
    <link href="css/auth.css" rel="stylesheet"/>
</head>
<body>
    <div class="auth-wrapper">
        <!-- Left Column: Branding -->
        <div class="auth-brand-section">
            <div class="auth-brand-gradient"></div>
            <div class="auth-brand-content">
                <h1 class="auth-brand-title">AutoWash Pro</h1>
                <p class="auth-brand-subtitle">
                    Quản lý lịch rửa xe, lịch sử rửa xe và các thông tin liên quan.
                </p>
            </div>
            <div class="auth-brand-circle-sm"></div>
            <div class="auth-brand-circle-lg"></div>
        </div>
        
        <!-- Right Column: Authentication Card -->
        <div class="auth-form-section">
            <div class="auth-card">
                <!-- Header -->
                <div class="auth-header">
                    <h2 class="auth-title">Đăng Nhập</h2>
                    <p class="auth-subtitle">Nhập thông tin tài khoản để truy cập hệ thống AutoWash Pro.</p>
                </div>
                
                <!-- Error Message -->
                <%
                   String msg = (String) request.getAttribute("ERROR");
                   if(msg != null) {
                %>
                   <div class="alert-error">
                       <%= msg %>
                   </div>
                <%
                   }
                %>
                
                <!-- Form -->
                <form class="auth-form" action="MainController" method="post">
                    <input type="hidden" name="action" value="Login" />
                    
                    <!-- Phone Number Input -->
                    <div class="form-group">
                        <label class="form-label" for="phone">Số điện thoại</label>
                        <div class="input-container">
                            <span class="input-icon material-symbols-outlined">phone</span>
                            <input class="auth-input" id="phone" name="txtphone" placeholder="Ví dụ: 0923456789" type="tel" required=""/>
                        </div>
                    </div>
                    
                    <!-- Password Input -->
                    <div class="form-group">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <div class="input-container">
                            <span class="input-icon material-symbols-outlined">lock</span>
                            <input class="auth-input" id="password" name="txtpassword" placeholder="••••••••" type="password" required=""/>
                            <button class="password-toggle-btn" onclick="togglePasswordVisibility()" type="button">
                                <span class="material-symbols-outlined" id="visibility-icon">visibility_off</span>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Action Button -->
                    <button class="btn-primary" type="submit">
                        ĐĂNG NHẬP
                        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">login</span>
                    </button>
                </form>
                
                <!-- Footer Links -->
                <div class="auth-footer">
                    <p class="auth-footer-text">
                        Chưa có tài khoản? 
                        <a class="auth-link" href="MainController?action=Register">Đăng ký ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JavaScript for password toggle -->
    <script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const visibilityIcon = document.getElementById('visibility-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                visibilityIcon.textContent = 'visibility';
            } else {
                passwordInput.type = 'password';
                visibilityIcon.textContent = 'visibility_off';
            }
        }
    </script>
</body>
</html>
