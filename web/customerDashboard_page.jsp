<%@page import="java.util.List"%>
<%@page import="dto.Car"%>
<%@page import="dto.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // ========================================================
    // JSP chỉ đọc dữ liệu từ request attributes
    // Tất cả logic đã được DashboardController tính toán sẵn
    // ========================================================
    Customer us = (Customer) session.getAttribute("USER");
    if (us == null) {
        response.sendRedirect("login_page.jsp");
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

    // Xác định màu sắc hiển thị cho hạng hiện tại (Phần hiển thị/Visual Styling thuộc về View)
    String tierBadgeColor;
    String tierIconColor;
    if ("SILVER".equals(currentTierId)) {
        tierBadgeColor = "from-slate-300 to-slate-500";
        tierIconColor  = "text-slate-500";
    } else if ("GOLD".equals(currentTierId)) {
        tierBadgeColor = "from-amber-300 to-amber-600";
        tierIconColor  = "text-amber-500";
    } else if ("PLATINUM".equals(currentTierId)) {
        tierBadgeColor = "from-purple-400 to-indigo-600";
        tierIconColor  = "text-purple-500";
    } else { // MEMBER
        tierBadgeColor = "from-orange-400 to-orange-600";
        tierIconColor  = "text-orange-500";
    }
%>

<html class="h-full bg-slate-50 antialiased" lang="vi">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Dashboard – AutoWash Pro Loyalty Portal</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-tertiary-container":        "#b87500",
                        "tertiary-container":           "#2a1700",
                        "on-tertiary-fixed-variant":    "#653e00",
                        "inverse-surface":              "#213145",
                        "secondary-container":          "#57dffe",
                        "tertiary-fixed":               "#ffddb8",
                        "surface-container":            "#e5eeff",
                        "on-tertiary":                  "#ffffff",
                        "surface-container-lowest":     "#ffffff",
                        "on-secondary-fixed":           "#001f26",
                        "outline-variant":              "#c6c6cd",
                        "inverse-primary":              "#bec6e0",
                        "primary":                      "#000000",
                        "inverse-on-surface":           "#eaf1ff",
                        "secondary":                    "#00687a",
                        "surface-container-highest":    "#d3e4fe",
                        "on-background":                "#0b1c30",
                        "error-container":              "#ffdad6",
                        "surface-bright":               "#f8f9ff",
                        "surface-dim":                  "#cbdbf5",
                        "surface-container-high":       "#dce9ff",
                        "on-primary-fixed-variant":     "#3f465c",
                        "on-secondary-fixed-variant":   "#004e5c",
                        "surface-variant":              "#d3e4fe",
                        "surface":                      "#f8f9ff",
                        "secondary-fixed-dim":          "#4cd7f6",
                        "on-surface-variant":           "#45464d",
                        "tertiary":                     "#000000",
                        "on-surface":                   "#0b1c30",
                        "on-primary-fixed":             "#131b2e",
                        "surface-tint":                 "#565e74",
                        "on-secondary-container":       "#006172",
                        "on-error-container":           "#93000a",
                        "surface-container-low":        "#eff4ff",
                        "tertiary-fixed-dim":           "#ffb95f",
                        "outline":                      "#76777d",
                        "on-error":                     "#ffffff",
                        "primary-fixed":                "#dae2fd",
                        "on-primary-container":         "#7c839b",
                        "secondary-fixed":              "#acedff",
                        "error":                        "#ba1a1a",
                        "primary-container":            "#131b2e",
                        "on-primary":                   "#ffffff",
                        "background":                   "#f8f9ff",
                        "on-tertiary-fixed":            "#2a1700",
                        "primary-fixed-dim":            "#bec6e0",
                        "on-secondary":                 "#ffffff"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "2xl": "1rem", "full": "9999px"
                    },
                    "spacing": {
                        "sidebar-width": "280px", "gutter": "24px", "container-max-width": "1440px",
                        "margin-mobile": "16px", "margin-desktop": "32px",
                        "stack-md": "16px", "stack-sm": "8px", "stack-lg": "32px"
                    },
                    "fontFamily": {
                        "body-md": ["Hanken Grotesk"], "label-sm": ["JetBrains Mono"],
                        "headline-lg-mobile": ["Hanken Grotesk"], "label-md": ["JetBrains Mono"],
                        "display": ["Hanken Grotesk"], "headline-lg": ["Hanken Grotesk"],
                        "title-lg": ["Hanken Grotesk"], "headline-md": ["Hanken Grotesk"],
                        "body-lg": ["Hanken Grotesk"]
                    },
                    "fontSize": {
                        "body-md":           ["16px", { "lineHeight": "24px",  "fontWeight": "400" }],
                        "label-sm":          ["12px", { "lineHeight": "16px",  "letterSpacing": "0.05em", "fontWeight": "500" }],
                        "headline-lg-mobile":["24px", { "lineHeight": "32px",  "fontWeight": "600" }],
                        "label-md":          ["14px", { "lineHeight": "20px",  "letterSpacing": "0.02em","fontWeight": "500" }],
                        "display":           ["48px", { "lineHeight": "56px",  "letterSpacing": "-0.02em","fontWeight": "700" }],
                        "headline-lg":       ["32px", { "lineHeight": "40px",  "letterSpacing": "-0.01em","fontWeight": "600" }],
                        "title-lg":          ["20px", { "lineHeight": "28px",  "fontWeight": "600" }],
                        "headline-md":       ["24px", { "lineHeight": "32px",  "fontWeight": "600" }],
                        "body-lg":           ["18px", { "lineHeight": "28px",  "fontWeight": "400" }]
                    }
                }
            }
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
        @keyframes progressGlow {
            0%   { box-shadow: 0 0 6px rgba(0,104,122,0.3); }
            50%  { box-shadow: 0 0 14px rgba(0,104,122,0.7); }
            100% { box-shadow: 0 0 6px rgba(0,104,122,0.3); }
        }
        .progress-bar { animation: progressGlow 2s ease-in-out infinite; }
    </style>
</head>
<body class="bg-background text-on-background font-body-md text-body-md">

    <!-- ===================== SideNavBar ===================== -->
    <aside class="fixed left-0 top-0 h-full w-sidebar-width bg-primary-container border-r border-outline-variant shadow-md flex flex-col py-8 z-50">
        <div class="px-gutter mb-8">
            <h1 class="font-headline-md text-headline-md font-bold text-on-primary">AutoWash Pro</h1>
            <p class="font-label-sm text-label-sm text-on-primary-container">Cổng thông tin loyalty</p>
        </div>
        <nav class="flex-1 px-4 space-y-2 flex flex-col">
            <div class="flex-1 space-y-2">
                <a class="flex items-center gap-3 px-4 py-3 text-secondary-fixed border-l-4 border-secondary-fixed bg-on-primary-fixed-variant/10 rounded-r-lg cursor-pointer active:scale-95 duration-200"
                   href="MainController?action=Dashboard">
                    <span class="material-symbols-outlined fill">dashboard</span>
                    <span class="font-label-md text-label-md">Dashboard</span>
                </a>
                <a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200"
                   href="MainController?action=ViewCars">
                    <span class="material-symbols-outlined">directions_car</span>
                    <span class="font-label-md text-label-md">Xe của tôi</span>
                    <% if (carList != null && !carList.isEmpty()) { %>
                    <span class="ml-auto bg-secondary/20 text-secondary text-xs font-bold px-2 py-0.5 rounded-full"><%= carList.size() %></span>
                    <% } %>
                </a>
            </div>
            <div class="mt-auto pt-4 space-y-2 border-t border-outline-variant/20">
                <div class="px-4 py-2 text-on-primary-container/60 text-xs font-mono">
                    <%= us.getPhoneNumber() %>
                </div>
                <a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200"
                   href="MainController?action=Logout">
                    <span class="material-symbols-outlined">logout</span>
                    <span class="font-label-md text-label-md">Đăng xuất</span>
                </a>
            </div>
        </nav>
    </aside>

    <!-- ===================== TopNavBar ===================== -->
    <header class="fixed top-0 right-0 w-[calc(100%-280px)] h-16 bg-surface/80 backdrop-blur-md shadow-sm z-40 flex justify-between items-center px-gutter border-b border-outline-variant/20">
        <div class="flex items-center gap-2 text-on-surface-variant font-label-md text-label-md">
            <span class="opacity-70">Portal</span>
            <span class="material-symbols-outlined text-[16px] opacity-50">chevron_right</span>
            <span class="text-secondary font-bold">Dashboard</span>
        </div>
        <div class="flex items-center gap-3">
            <div class="hidden sm:flex items-center gap-2 text-sm text-on-surface-variant bg-surface-container px-3 py-1.5 rounded-full border border-outline-variant/40">
                <span class="material-symbols-outlined text-[16px]">phone_iphone</span>
                <span class="font-mono text-xs"><%= us.getPhoneNumber() %></span>
            </div>
            <span class="text-sm text-on-surface-variant font-semibold hidden md:inline-block"><%= us.getFullname() %></span>
            <div class="w-9 h-9 rounded-full overflow-hidden bg-surface-variant border-2 border-secondary/30 cursor-pointer hover:scale-110 transition-transform shadow-sm flex items-center justify-center">
                <div class="w-full h-full bg-gradient-to-tr from-secondary to-blue-500 flex items-center justify-center text-white text-sm font-bold uppercase">
                    <%= us.getFullname().substring(0, 1) %>
                </div>
            </div>
        </div>
    </header>

    <!-- ===================== Main Content ===================== -->
    <main class="ml-sidebar-width pt-16 min-h-screen p-margin-desktop">
        <div class="max-w-container-max-width mx-auto">
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-gutter">

                <!-- ===== Left Column (8/12) ===== -->
                <div class="lg:col-span-8 flex flex-col gap-gutter">

                    <!-- Welcome Card -->
                    <div class="relative overflow-hidden rounded-2xl bg-primary-container text-on-primary shadow-sm h-[200px] flex items-center p-8 group">
                        <div class="absolute inset-0 z-0 opacity-20 group-hover:opacity-30 transition-opacity duration-700"
                             style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAq_hagSFzyCAqyb_WqxTQchyOvkGhlmG9ZFLbNB7HhY4P7G74PfZJBgfgq6MY3I32s6hJTV4W1E9iboCALA2bfYhL60ilB2tQve0BGyWxKRsk2YVDgK7--zV3Pjv845F-0PLT63R907Y_8noFY0sJs5GhOHDu5whDynOazqxHcYoRVhMJXx_9XTc-21vBBYhmUaUFkzdGRi8pdm0gb8gxFc85WrGpiY8q3McC13DN1sD1Fy0p5wvynzm6-cu9a5KM9avjndjqJR-6s'); background-size: cover; background-position: center center;"></div>
                        <div class="absolute inset-0 z-0 bg-gradient-to-r from-primary-container via-primary-container/80 to-transparent"></div>
                        <div class="relative z-10">
                            <h2 class="font-display text-display mb-2">Chào <%= us.getFullname() %>,</h2>
                            <p class="font-body-lg text-body-lg text-primary-fixed-dim">Hệ thống đang hoạt động ổn định. Chúc bạn một ngày tốt lành!</p>
                        </div>
                    </div>

                    <!-- Tier Info Card -->
                    <div class="bg-surface rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
                        <div class="bg-gradient-to-r <%= tierBadgeColor %> p-6 flex items-center justify-between">
                            <div class="flex items-center gap-4">
                                <div class="w-14 h-14 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm">
                                    <span class="material-symbols-outlined fill text-white text-3xl">workspace_premium</span>
                                </div>
                                <div>
                                    <p class="text-white/70 text-sm font-medium">Hạng thành viên hiện tại</p>
                                    <h3 class="text-white font-bold text-2xl tracking-wide"><%= tierDisplayName.toUpperCase() %></h3>
                                </div>
                            </div>
                            <div class="text-right text-white/80">
                                <p class="text-xs">Hệ số điểm</p>
                                <p class="text-3xl font-bold">x<%= multiplier %></p>
                            </div>
                        </div>
                        <div class="p-6 grid grid-cols-2 sm:grid-cols-3 gap-4">
                            <div class="flex flex-col items-center bg-surface-container rounded-xl p-4 text-center">
                                <span class="material-symbols-outlined <%= tierIconColor %> mb-1">star</span>
                                <p class="text-xs text-on-surface-variant">Hạng thẻ</p>
                                <p class="font-semibold text-on-surface text-sm mt-0.5"><%= tierDisplayName %></p>
                            </div>
                            <div class="flex flex-col items-center bg-surface-container rounded-xl p-4 text-center">
                                <span class="material-symbols-outlined text-secondary mb-1">calendar_month</span>
                                <p class="text-xs text-on-surface-variant">Đặt lịch trước</p>
                                <p class="font-semibold text-on-surface text-sm mt-0.5"><%= bookingDays %> ngày</p>
                            </div>
                            <div class="flex flex-col items-center bg-surface-container rounded-xl p-4 text-center">
                                <span class="material-symbols-outlined text-secondary mb-1">local_car_wash</span>
                                <p class="text-xs text-on-surface-variant">Tổng lần rửa</p>
                                <p class="font-semibold text-on-surface text-sm mt-0.5"><%= currentWashes %> lần</p>
                            </div>
                        </div>
                    </div>

                    <!-- Vehicle Info Card -->
                    <div class="bg-surface rounded-2xl shadow-sm border border-slate-200 p-6 flex flex-col sm:flex-row items-center gap-6">
                        <div class="w-16 h-16 rounded-xl bg-surface-container flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-3xl text-secondary">local_car_wash</span>
                        </div>
                        <div class="flex-1 w-full text-center sm:text-left">
                            <h3 class="font-title-lg text-title-lg text-on-surface mb-1">Xe đã liên kết với <span class="text-secondary font-mono"><%= us.getPhoneNumber() %></span></h3>
                            <div class="flex flex-wrap items-center justify-center sm:justify-start gap-4 font-body-md text-on-surface-variant mt-1">
                                <% if (carList != null && !carList.isEmpty()) { %>
                                    <% for (int i = 0; i < Math.min(carList.size(), 2); i++) { %>
                                    <span class="flex items-center gap-1 bg-surface-container px-3 py-1 rounded-full text-sm">
                                        <span class="material-symbols-outlined text-[16px] text-secondary">directions_car</span>
                                        <strong class="text-on-surface font-mono"><%= carList.get(i).getLicensePlate() %></strong>
                                    </span>
                                    <% } %>
                                    <% if (carList.size() > 2) { %>
                                    <span class="text-sm text-on-surface-variant">+<%= carList.size() - 2 %> xe khác</span>
                                    <% } %>
                                <% } else { %>
                                    <span class="text-slate-400 italic">Bạn chưa đăng ký xe nào.</span>
                                <% } %>
                            </div>
                        </div>
                        <div class="shrink-0">
                            <a href="MainController?action=ViewCars" class="bg-surface-container hover:bg-surface-container-high text-secondary font-label-md text-label-md px-4 py-2 rounded-xl transition-colors flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">arrow_forward</span>
                                Quản lý xe
                            </a>
                        </div>
                    </div>
                </div>

                <!-- ===== Right Column (4/12) ===== -->
                <div class="lg:col-span-4 flex flex-col gap-gutter">

                    <!-- Reward Wallet Card -->
                    <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-6 relative overflow-hidden">
                        <div class="absolute -right-8 -top-8 w-32 h-32 bg-secondary/5 rounded-full blur-2xl pointer-events-none"></div>
                        <div class="flex justify-between items-start mb-4">
                            <h3 class="font-title-lg text-title-lg text-on-surface">Ví Điểm Thưởng</h3>
                            <span class="material-symbols-outlined fill text-secondary">account_balance_wallet</span>
                        </div>
                        <div class="mb-1 flex items-end gap-2">
                            <span class="font-headline-lg text-headline-lg text-on-surface"><%= String.format("%,d", pointsBalance) %></span>
                            <span class="font-label-md text-label-md text-on-surface-variant mb-1">Điểm</span>
                        </div>
                        <p class="font-body-md text-body-md text-on-surface-variant">
                            ≈ <strong><%= pointsValueVND %> VNĐ</strong>
                        </p>
                        <div class="mt-4 pt-4 border-t border-outline-variant/40 flex items-center gap-2 text-xs text-on-surface-variant">
                            <span class="material-symbols-outlined text-[14px]">info</span>
                            1 điểm = 100 VNĐ khi quy đổi
                        </div>
                    </div>

                    <!-- Next Reward Card -->
                    <div class="bg-surface rounded-2xl shadow-sm border border-slate-200 p-6">
                        <div class="flex justify-between items-center mb-5">
                            <h3 class="font-title-lg text-title-lg text-on-surface">Phần Thưởng Kế Tiếp</h3>
                            <span class="material-symbols-outlined fill text-secondary">emoji_events</span>
                        </div>
                        <div class="flex justify-between font-label-md text-label-md mb-3">
                            <span class="flex items-center gap-1.5 text-on-surface">
                                <span class="w-2.5 h-2.5 rounded-full bg-gradient-to-r <%= tierBadgeColor %> inline-block"></span>
                                <%= tierDisplayName %>
                            </span>
                            <% if (!"NONE".equals(nextTier)) { %>
                            <span class="text-secondary font-bold"><%= nextTierDisplay %> →</span>
                            <% } else { %>
                            <span class="text-purple-500 font-bold">🏆 Đỉnh cao</span>
                            <% } %>
                        </div>
                        <div class="h-3 w-full bg-surface-container rounded-full overflow-hidden mb-4">
                            <div class="h-full bg-gradient-to-r from-secondary to-blue-500 rounded-full progress-bar transition-all duration-700"
                                 style="width: <%= String.format("%.1f", maxProgress) %>%"></div>
                        </div>
                        <div class="flex justify-between text-xs text-on-surface-variant mb-4">
                            <span>0%</span>
                            <span class="font-bold text-secondary"><%= String.format("%.0f", maxProgress) %>%</span>
                            <span>100%</span>
                        </div>
                        <p class="font-body-md text-body-md text-on-surface-variant leading-relaxed text-sm">
                            <%= progressText %>
                        </p>
                        <% if ("PLATINUM".equals(currentTierId)) { %>
                        <button class="mt-4 w-full py-2.5 bg-gradient-to-r from-purple-500 to-indigo-500 text-white font-label-md text-label-md rounded-xl hover:opacity-90 transition-opacity shadow-sm flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">redeem</span>
                            Đổi Quà Ngay
                        </button>
                        <% } else { %>
                        <button class="mt-4 w-full py-2 border border-secondary text-secondary font-label-md text-label-md rounded-xl hover:bg-secondary/5 transition-colors flex items-center justify-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">info</span>
                            Xem quyền lợi hạng
                        </button>
                        <% } %>
                    </div>

                    <!-- Stats mini card -->
                    <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-5">
                        <h4 class="font-label-md text-label-md text-on-surface-variant uppercase mb-3">Thống kê của bạn</h4>
                        <div class="space-y-3">
                            <div class="flex justify-between items-center">
                                <span class="text-sm text-on-surface-variant flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[16px] text-secondary">local_car_wash</span> Tổng lần rửa
                                </span>
                                <span class="font-mono font-bold text-on-surface"><%= currentWashes %></span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-sm text-on-surface-variant flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[16px] text-secondary">payments</span> Tổng chi tiêu
                                </span>
                                <span class="font-mono font-bold text-on-surface"><%= spentFormatted %> đ</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-sm text-on-surface-variant flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[16px] text-secondary">directions_car</span> Xe đã đăng ký
                                </span>
                                <span class="font-mono font-bold text-on-surface"><%= carList != null ? carList.size() : 0 %></span>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>
</body>
</html>
