<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AutoWash Pro - Hệ Thống Chăm Sóc Xe Thông Minh</title>
    <!-- Google Fonts & Tailwind -->
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
          tailwind.config = {
            darkMode: "class",
            theme: {
              extend: {
                colors: {
                  primary: "#0F172A",
                  secondary: "#00687a",
                  accent: "#00acedff",
                  "accent-dark": "#004e5c"
                }
              }
            }
          }
    </script>
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
        .hero-gradient {
            background: radial-gradient(circle at top right, rgba(0, 104, 122, 0.15) 0%, rgba(15, 23, 42, 0) 60%),
                        radial-gradient(circle at bottom left, rgba(14, 165, 233, 0.1) 0%, rgba(15, 23, 42, 0) 60%);
        }
    </style>
</head>
<body class="bg-[#0F172A] text-slate-100 min-h-screen flex flex-col justify-between overflow-x-hidden hero-gradient">

    <!-- Header / Navbar -->
    <header class="w-full max-w-7xl mx-auto px-6 py-6 flex justify-between items-center border-b border-slate-800">
        <div class="flex items-center gap-3">
            <div class="bg-secondary text-white p-2.5 rounded-xl shadow-lg shadow-secondary/20 flex items-center justify-center">
                <span class="material-symbols-outlined text-[24px]">local_car_wash</span>
            </div>
            <span class="text-xl font-bold tracking-tight text-white">AutoWash <span class="text-accent">Pro</span></span>
        </div>
        <div class="flex gap-4">
            <a href="MainController?action=LoginPage" class="text-sm font-semibold text-slate-300 hover:text-white transition-colors py-2.5 px-4 rounded-xl">Đăng Nhập</a>
            <a href="MainController?action=RegisterPage" class="bg-secondary hover:bg-accent-dark text-white text-sm font-semibold py-2.5 px-5 rounded-xl transition-all shadow-md shadow-secondary/10">Đăng Ký</a>
        </div>
    </header>

    <!-- Hero Section -->
    <main class="flex-1 flex items-center justify-center py-16 px-6">
        <div class="max-w-4xl mx-auto text-center space-y-8">
            <div class="inline-flex items-center gap-2 bg-slate-800/80 border border-slate-700/50 px-4 py-2 rounded-full text-xs font-semibold tracking-wider uppercase text-accent shadow-inner">
                <span class="w-2 h-2 rounded-full bg-accent animate-pulse"></span>
                Chương Trình Khách Hàng Thân Thiết Autowash
            </div>
            
            <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight text-white leading-tight">
                Chăm Sóc Xế Yêu Của Bạn <br/>
                <span class="bg-gradient-to-r from-accent to-emerald-400 bg-clip-text text-transparent">Thông Minh & Tự Động</span>
            </h1>
            
            <p class="text-lg text-slate-400 max-w-2xl mx-auto leading-relaxed">
                Hệ thống rửa xe tự động cao cấp tích hợp chương trình Loyalty. Đăng ký biển số xe để tích lũy điểm thưởng, thăng hạng thành viên và nhận vô vàn ưu đãi đặc biệt ngay hôm nay.
            </p>
            
            <div class="flex flex-col sm:flex-row justify-center items-center gap-4 pt-4">
                <a href="MainController?action=LoginPage" class="w-full sm:w-auto bg-gradient-to-r from-secondary to-accent-dark hover:shadow-lg hover:shadow-secondary/20 text-white font-bold text-base py-4 px-8 rounded-2xl transition-all active:scale-[0.98] flex items-center justify-center gap-2">
                    CỔNG LOYALTY KHÁCH HÀNG
                    <span class="material-symbols-outlined">arrow_forward</span>
                </a>
                <a href="MainController?action=RegisterPage" class="w-full sm:w-auto bg-slate-800/80 border border-slate-700 hover:bg-slate-800 hover:border-slate-600 text-white font-bold text-base py-4 px-8 rounded-2xl transition-all flex items-center justify-center gap-2">
                    ĐĂNG KÝ THÀNH VIÊN
                </a>
            </div>

            <!-- Features Bento -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 pt-16 text-left">
                <div class="bg-slate-850/50 border border-slate-800 p-6 rounded-2xl backdrop-blur-sm">
                    <span class="material-symbols-outlined text-accent text-3xl mb-3">workspace_premium</span>
                    <h3 class="font-bold text-lg text-white mb-2">Hạng Thành Viên</h3>
                    <p class="text-sm text-slate-400 leading-relaxed">Từ hạng Bạc, Vàng đến Bạch Kim với hệ số nhân điểm lên tới 1.3 lần.</p>
                </div>
                <div class="bg-slate-850/50 border border-slate-800 p-6 rounded-2xl backdrop-blur-sm">
                    <span class="material-symbols-outlined text-accent text-3xl mb-3">account_balance_wallet</span>
                    <h3 class="font-bold text-lg text-white mb-2">Quy Đổi Điểm Thưởng</h3>
                    <p class="text-sm text-slate-400 leading-relaxed">Mỗi điểm thưởng có giá trị tương đương 100 VNĐ, giảm trực tiếp vào hóa đơn của bạn.</p>
                </div>
                <div class="bg-slate-850/50 border border-slate-800 p-6 rounded-2xl backdrop-blur-sm">
                    <span class="material-symbols-outlined text-accent text-3xl mb-3">directions_car</span>
                    <h3 class="font-bold text-lg text-white mb-2">Quản Lý Đội Xe</h3>
                    <p class="text-sm text-slate-400 leading-relaxed">Dễ dàng thêm và quản lý nhiều biển số xe trên một tài khoản duy nhất.</p>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="w-full border-t border-slate-800 py-6 text-center text-sm text-slate-500">
        &copy; 2026 AutoWash Pro. Bảo lưu mọi quyền.
    </footer>

</body>
</html>
