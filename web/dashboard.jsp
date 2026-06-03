<%@page import="java.util.List"%>
<%@page import="dto.Car"%>
<%@page import="dto.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Customer us = (Customer) session.getAttribute("USER");
    if (us == null) {
        response.sendRedirect("MainController?action=Login");
        return;
    }

    // Đọc dữ liệu đã được Controller tính sẵn
    List<Car> carList          = (List<Car>) request.getAttribute("LISTCARS");
    String tierDisplayName     = (String)  request.getAttribute("TIER_DISPLAY");
    double multiplier          = (Double)  request.getAttribute("MULTIPLIER");
    int    bookingDays         = (Integer) request.getAttribute("BOOKING_DAYS");
    String nextTier            = (String)  request.getAttribute("NEXT_TIER");
    String nextTierDisplay     = (String)  request.getAttribute("NEXT_TIER_DISPLAY");
    int    currentWashes       = (Integer) request.getAttribute("CURRENT_WASHES");
    int    pointsBalance       = (Integer) request.getAttribute("POINTS_BALANCE");
    double maxProgress         = (Double)  request.getAttribute("MAX_PROGRESS");
    String progressText        = (String)  request.getAttribute("PROGRESS_TEXT");
    String pointsValueVND      = (String)  request.getAttribute("POINTS_VALUE_VND");
    String spentFormatted      = (String)  request.getAttribute("SPENT_FORMATTED");
    String currentTierId       = (String)  request.getAttribute("TIER_ID");
    
    if (currentTierId == null || currentTierId.trim().isEmpty()) {
        currentTierId = "MEMBER";
    }
%>

<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Dashboard – AutoWash Pro Loyalty Portal</title>
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/theme.css" rel="stylesheet"/>
    <link href="css/dashboard.css" rel="stylesheet"/>
    <style>
        /* Progress bar animation */
        @keyframes progressGlow {
            0%   { box-shadow: 0 0 6px rgba(0,104,122,0.3); }
            50%  { box-shadow: 0 0 14px rgba(0,104,122,0.7); }
            100% { box-shadow: 0 0 6px rgba(0,104,122,0.3); }
        }
        .progress-bar-glow { animation: progressGlow 2s ease-in-out infinite; }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        
        <!-- ===================== SideNavBar ===================== -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h1 class="sidebar-title">AutoWash Pro</h1>
                <p class="sidebar-subtitle">Cổng thông tin loyalty</p>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-links-wrapper">
                    <a class="nav-link active" href="MainController?action=Dashboard">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span>Dashboard</span>
                    </a>
                    <a class="nav-link" href="MainController?action=ViewCars">
                        <span class="material-symbols-outlined">directions_car</span>
                        <span>Xe của tôi</span>
                        <% if (carList != null && !carList.isEmpty()) { %>
                        <span class="nav-badge"><%= carList.size() %></span>
                        <% } %>
                    </a>
                </div>
                <div class="sidebar-footer">
                    <div class="sidebar-user-phone">
                        <%= us.getPhoneNumber() %>
                    </div>
                    <a class="nav-link" href="MainController?action=Logout">
                        <span class="material-symbols-outlined">logout</span>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </nav>
        </aside>

        <!-- ===================== Topbar & Main Canvas ===================== -->
        <div style="flex: 1; display: flex; flex-direction: column;">
            
            <!-- ===================== Topbar ===================== -->
            <header class="topbar">
                <div class="topbar-breadcrumb">
                    <span style="opacity: 0.7;">Portal</span>
                    <span class="material-symbols-outlined" style="font-size: 16px; opacity: 0.5;">chevron_right</span>
                    <span style="color: var(--color-secondary); font-weight: bold;">Dashboard</span>
                </div>
                <div class="topbar-user">
                    <div class="topbar-phone-badge">
                        <span class="material-symbols-outlined" style="font-size: 16px;">phone_iphone</span>
                        <span style="font-family: var(--font-mono); font-size: 12px;"><%= us.getPhoneNumber() %></span>
                    </div>
                    <span class="topbar-username"><%= us.getFullname() %></span>
                    <div class="topbar-avatar">
                        <%= us.getFullname().substring(0, 1) %>
                    </div>
                </div>
            </header>

            <!-- ===================== Main Content ===================== -->
            <main class="main-content">
                <div class="content-container">
                    <div class="bento-grid">
                        
                        <!-- Welcome Card -->
                        <div class="card-welcome">
                            <div class="card-welcome-bg"></div>
                            <div class="card-welcome-overlay"></div>
                            <div class="card-welcome-content">
                                <h2 class="card-welcome-title">Chào <%= us.getFullname() %>,</h2>
                                <p class="card-welcome-subtitle">Hệ thống đang hoạt động ổn định. Chúc bạn một ngày tốt lành!</p>
                            </div>
                        </div>

                        <!-- Reward Wallet Card -->
                        <div class="card-wallet">
                            <div class="card-title-row">
                                <h3 class="card-title">Ví Điểm Thưởng</h3>
                                <span class="material-symbols-outlined" style="color: var(--color-secondary);">account_balance_wallet</span>
                            </div>
                            <div class="wallet-balance-row">
                                <span class="wallet-balance"><%= String.format("%,d", pointsBalance) %></span>
                                <span style="font-size: 0.875rem; color: var(--color-on-surface-variant); margin-bottom: 6px;">Điểm</span>
                            </div>
                            <p class="wallet-desc">
                                ≈ <strong><%= pointsValueVND %> VNĐ</strong>
                            </p>
                            <div class="wallet-footer">
                                <span class="material-symbols-outlined" style="font-size: 14px;">info</span>
                                1 điểm = 100 VNĐ khi quy đổi
                            </div>
                        </div>

                        <!-- Tier Info Card -->
                        <div class="card-tier">
                            <div class="tier-badge-container tier-<%= currentTierId %>">
                                <div class="tier-badge-left">
                                    <div class="tier-icon-circle">
                                        <span class="material-symbols-outlined" style="font-size: 30px;">workspace_premium</span>
                                    </div>
                                    <div>
                                        <p class="tier-label-muted">Hạng thành viên hiện tại</p>
                                        <h3 class="tier-label-value"><%= tierDisplayName.toUpperCase() %></h3>
                                    </div>
                                </div>
                                <div class="tier-badge-right">
                                    <p class="tier-label-muted">Hệ số điểm</p>
                                    <p style="font-size: 1.875rem; font-weight: bold;">x<%= multiplier %></p>
                                </div>
                            </div>
                            <div class="tier-grid-stats">
                                <div class="tier-stat-item">
                                    <span class="material-symbols-outlined tier-stat-icon-<%= currentTierId %>">star</span>
                                    <p class="tier-stat-label">Hạng thẻ</p>
                                    <p class="tier-stat-val"><%= tierDisplayName %></p>
                                </div>
                                <div class="tier-stat-item">
                                    <span class="material-symbols-outlined" style="color: var(--color-secondary);">calendar_month</span>
                                    <p class="tier-stat-label">Đặt lịch trước</p>
                                    <p class="tier-stat-val"><%= bookingDays %> ngày</p>
                                </div>
                                <div class="tier-stat-item">
                                    <span class="material-symbols-outlined" style="color: var(--color-secondary);">local_car_wash</span>
                                    <p class="tier-stat-label">Tổng lần rửa</p>
                                    <p class="tier-stat-val"><%= currentWashes %> lần</p>
                                </div>
                            </div>
                        </div>

                        <!-- Next Reward Card -->
                        <div class="card-progress">
                            <div class="card-title-row">
                                <h3 class="card-title">Phần Thưởng Kế Tiếp</h3>
                                <span class="material-symbols-outlined" style="color: var(--color-secondary);">emoji_events</span>
                            </div>
                            <div style="display: flex; justify-content: space-between; font-size: 0.875rem; font-weight: 500; margin-bottom: 12px;">
                                <span style="display: flex; align-items: center; gap: 6px;">
                                    <span style="width: 10px; height: 10px; border-radius: 50%;" class="tier-<%= currentTierId %>"></span>
                                    <%= tierDisplayName %>
                                </span>
                                <% if (!"NONE".equals(nextTier)) { %>
                                <span style="color: var(--color-secondary); font-weight: bold;"><%= nextTierDisplay %> →</span>
                                <% } else { %>
                                <span style="color: #a855f7; font-weight: bold;">🏆 Đỉnh cao</span>
                                <% } %>
                            </div>
                            <div class="progress-bar-wrapper">
                                <div class="progress-bar progress-bar-glow" style="width: <%= String.format("%.1f", maxProgress) %>%"></div>
                            </div>
                            <div class="progress-values-row">
                                <span>0%</span>
                                <span style="font-weight: bold; color: var(--color-secondary);"><%= String.format("%.0f", maxProgress) %>%</span>
                                <span>100%</span>
                            </div>
                            <p class="progress-desc-text">
                                <%= progressText %> 
                            </p>
                            <% if ("PLATINUM".equals(currentTierId)) { %>
                            <button class="progress-btn progress-btn-solid">
                                <span class="material-symbols-outlined" style="font-size: 18px;">redeem</span>
                                Đổi Quà Ngay
                            </button>
                            <% } else { %>
                            <button class="progress-btn progress-btn-outline">
                                <span class="material-symbols-outlined" style="font-size: 18px;">info</span>
                                Xem quyền lợi hạng
                            </button>
                            <% } %>
                        </div>

                        <!-- Stats Card -->
                        <div class="card-stats">
                            <h4 style="font-size: 0.875rem; font-weight: 500; color: var(--color-on-surface-variant); text-transform: uppercase; margin-bottom: 12px;">Thống kê của bạn</h4>
                            <div class="stats-list">
                                <div class="stats-row">
                                    <span class="stats-label">
                                        <span class="material-symbols-outlined" style="font-size: 16px; color: var(--color-secondary);">local_car_wash</span> Tổng lần rửa
                                    </span>
                                    <span class="stats-val"><%= currentWashes %></span>
                                </div>
                                <div class="stats-row">
                                    <span class="stats-label">
                                        <span class="material-symbols-outlined" style="font-size: 16px; color: var(--color-secondary);">payments</span> Tổng chi tiêu
                                    </span>
                                    <span class="stats-val"><%= spentFormatted %> đ</span>
                                </div>
                                <div class="stats-row">
                                    <span class="stats-label">
                                        <span class="material-symbols-outlined" style="font-size: 16px; color: var(--color-secondary);">directions_car</span> Xe đã đăng ký
                                    </span>
                                    <span class="stats-val"><%= carList != null ? carList.size() : 0 %></span>
                                </div>
                            </div>
                        </div>

                        <!-- Vehicle Summary Link Card -->
                        <div class="card-stats" style="grid-column: span 12; display: flex; flex-direction: row; align-items: center; justify-content: space-between; padding: 24px; gap: 16px;">
                            <div style="display: flex; align-items: center; gap: 16px;">
                                <div style="width: 56px; height: 56px; border-radius: 12px; background-color: var(--color-surface-container); display: flex; align-items: center; justify-content: center;">
                                    <span class="material-symbols-outlined" style="font-size: 30px; color: var(--color-secondary);">local_car_wash</span>
                                </div>
                                <div>
                                    <h3 style="font-size: 1.25rem; font-weight: 600; color: var(--color-on-surface); margin-bottom: 4px;">Xe đã liên kết với <span style="font-family: var(--font-mono); color: var(--color-secondary);"><%= us.getPhoneNumber() %></span></h3>
                                    <div style="display: flex; flex-wrap: wrap; gap: 8px; margin-top: 4px;">
                                        <% if (carList != null && !carList.isEmpty()) { %>
                                            <% for (int i = 0; i < Math.min(carList.size(), 2); i++) { %>
                                            <span style="display: flex; align-items: center; gap: 4px; background-color: var(--color-surface-container); padding: 4px 12px; border-radius: 9999px; font-size: 0.875rem;">
                                                <span class="material-symbols-outlined" style="font-size: 16px; color: var(--color-secondary);">directions_car</span>
                                                <strong style="color: var(--color-on-surface); font-family: var(--font-mono);"><%= carList.get(i).getLicensePlate() %></strong>
                                            </span>
                                            <% } %>
                                            <% if (carList.size() > 2) { %>
                                            <span style="font-size: 0.875rem; color: var(--color-on-surface-variant); padding-top: 4px;">+<%= carList.size() - 2 %> xe khác</span>
                                            <% } %>
                                        <% } else { %>
                                            <span style="font-style: italic; color: #94a3b8; font-size: 0.875rem;">Bạn chưa đăng ký xe nào.</span>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                            <a href="MainController?action=ViewCars" class="progress-btn progress-btn-outline" style="width: auto; padding: 10px 20px; border-radius: 12px; font-weight: 600;">
                                <span class="material-symbols-outlined" style="font-size: 18px;">arrow_forward</span>
                                Quản lý xe
                            </a>
                        </div>
                        
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
