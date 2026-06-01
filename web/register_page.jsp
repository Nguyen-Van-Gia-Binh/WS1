<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AutoWash Pro - Đăng Ký Thành Viên</title>
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
        
        <!-- Right Column: Registration Card -->
        <div class="auth-form-section">
            <div class="auth-card">
                <!-- Header -->
                <div class="auth-header">
                    <h2 class="auth-title">Đăng Ký</h2>
                    <p class="auth-subtitle">Tạo tài khoản khách hàng mới của hệ thống AutoWash Pro.</p>
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
                <form class="auth-form" action="MainController" method="post" onsubmit="return validateRegisterForm()">
                    <input type="hidden" name="action" value="Register">
                    
                    <!-- Full Name Input -->
                    <div class="form-group">
                        <label class="form-label" for="txtfullname">Họ và tên</label>
                        <div class="input-container">
                            <span class="input-icon material-symbols-outlined">person</span>
                            <input class="auth-input" id="txtfullname" name="txtfullname" placeholder="Nguyễn Văn A" type="text" required=""/>
                        </div>
                    </div>
                    
                    <!-- Phone Number Input -->
                    <div class="form-group">
                        <label class="form-label" for="txtphone">Số điện thoại</label>
                        <div class="input-container">
                            <span class="input-icon material-symbols-outlined">phone</span>
                            <input class="auth-input" id="txtphone" name="txtphone" placeholder="Ví dụ: 0923456789" type="tel" required=""/>
                        </div>
                    </div>
                    
                    <!-- Password Input -->
                    <div class="form-group">
                        <label class="form-label" for="txtpassword">Mật khẩu</label>
                        <div class="input-container">
                            <span class="input-icon material-symbols-outlined">lock</span>
                            <input class="auth-input" id="txtpassword" name="txtpassword" placeholder="••••••••" type="password" required=""/>
                        </div>
                    </div>
                    
                    <!-- Action Button -->
                    <button class="btn-primary" type="submit">
                        ĐĂNG KÝ
                        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">how_to_reg</span>
                    </button>
                </form>
                
                <!-- Footer Links -->
                <div class="auth-footer">
                    <p class="auth-footer-text">
                        Đã có tài khoản? 
                        <a class="auth-link" href="MainController?action=Login">Đăng nhập ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- JavaScript for client-side validations -->
    <script>
        function validateRegisterForm() {
            const phone = document.getElementById('txtphone').value.trim();
            
            // Regex cho số điện thoại Việt Nam (bắt đầu bằng 0, gồm đúng 10 chữ số)
            const phoneRegex = /^0[0-9]{9}$/;
            if (!phoneRegex.test(phone)) {
                alert("Số điện thoại không hợp lệ! Phải bắt đầu bằng số 0 và có đúng 10 chữ số (ví dụ: 0923456789).");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>