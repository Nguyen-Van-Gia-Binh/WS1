<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AutoWash Pro - Hệ Thống Chăm Sóc Xe Thông Minh</title>
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <!-- Custom CSS -->
    <link href="css/theme.css" rel="stylesheet"/>
    <link href="css/home.css" rel="stylesheet"/>
</head>
<body class="home-body">
    <div class="home-gradient"></div>

    <!-- Header / Navbar -->
    <header class="home-header">
        <div class="logo-container">
            <div class="logo-icon">
                <span class="material-symbols-outlined" style="font-size: 24px;">local_car_wash</span>
            </div>
            <span class="logo-text">AutoWash <span class="logo-accent">Pro</span></span>
        </div>
        <div class="nav-buttons">
            <a href="MainController?action=Login" class="btn-nav-link">Đăng Nhập</a>
            <a href="MainController?action=Register" class="btn-nav-primary">Đăng Ký</a>
        </div>
    </header>

    <!-- Hero Section -->
    <main class="hero-section">
        <div class="hero-container">
            <div class="hero-tag">
                <span class="hero-tag-dot"></span>
                Chương Trình Khách Hàng Thân Thiết Autowash
            </div>
            
            <h1 class="hero-title">
                Chăm Sóc Xế Yêu Của Bạn <br/>
                <span class="hero-title-gradient">Thông Minh & Tự Động</span>
            </h1>
            
            <p class="hero-desc">
                Hệ thống rửa xe tự động cao cấp tích hợp chương trình Loyalty. Đăng ký biển số xe để tích lũy điểm thưởng, thăng hạng thành viên và nhận vô vàn ưu đãi đặc biệt ngay hôm nay.
            </p>
            
            <div class="hero-actions">
                <a href="MainController?action=Login" class="btn-hero-cta">
                    CỔNG LOYALTY KHÁCH HÀNG
                    <span class="material-symbols-outlined">arrow_forward</span>
                </a>
                <a href="MainController?action=Register" class="btn-hero-outline">
                    ĐĂNG KÝ THÀNH VIÊN
                </a>
            </div>

            <!-- Features Grid -->
            <div class="home-features-grid">
                <div class="feature-box">
                    <span class="material-symbols-outlined feature-icon">workspace_premium</span>
                    <h3 class="feature-title">Hạng Thành Viên</h3>
                    <p class="feature-desc">Từ hạng Bạc, Vàng đến Bạch Kim với hệ số nhân điểm lên tới 1.3 lần.</p>
                </div>
                <div class="feature-box">
                    <span class="material-symbols-outlined feature-icon">account_balance_wallet</span>
                    <h3 class="feature-title">Quy Đổi Điểm Thưởng</h3>
                    <p class="feature-desc">Mỗi điểm thưởng có giá trị tương đương 100 VNĐ, giảm trực tiếp vào hóa đơn của bạn.</p>
                </div>
                <div class="feature-box">
                    <span class="material-symbols-outlined feature-icon">directions_car</span>
                    <h3 class="feature-title">Quản Lý Đội Xe</h3>
                    <p class="feature-desc">Dễ dàng thêm và quản lý nhiều biển số xe trên một tài khoản duy nhất.</p>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="home-footer">
        &copy; 2026 AutoWash Pro. Bảo lưu mọi quyền.
    </footer>

</body>
</html>
