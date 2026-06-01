<%@page import="java.util.List"%>
<%@page import="dto.Car"%>
<%@page import="dto.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Customer us = (Customer) session.getAttribute("USER");
    if (us == null) {
        response.sendRedirect("login_page.jsp");
        return;
    }

    // Lấy danh sách xe của khách hàng từ request
    List<Car> carList = (List<Car>) request.getAttribute("LISTCARS");

    // Đọc thông báo lỗi/thành công từ session (do AddCarController set)
    String carError = (String) session.getAttribute("ERROR_CAR");
    String carSuccess = (String) session.getAttribute("SUCCESS_CAR");
    // Xóa khỏi session sau khi đọc (flash message pattern)
    session.removeAttribute("ERROR_CAR");
    session.removeAttribute("SUCCESS_CAR");
%>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Xe của tôi - AutoWash Pro</title>
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;600;700&family=JetBrains+Mono:wght@500&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <!-- Tailwind Configuration -->
    <script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-tertiary-container": "#b87500",
                    "tertiary-container": "#2a1700",
                    "on-tertiary-fixed-variant": "#653e00",
                    "inverse-surface": "#213145",
                    "secondary-container": "#57dffe",
                    "tertiary-fixed": "#ffddb8",
                    "surface-container": "#e5eeff",
                    "on-tertiary": "#ffffff",
                    "surface-container-lowest": "#ffffff",
                    "on-secondary-fixed": "#001f26",
                    "outline-variant": "#c6c6cd",
                    "inverse-primary": "#bec6e0",
                    "primary": "#000000",
                    "inverse-on-surface": "#eaf1ff",
                    "secondary": "#00687a",
                    "surface-container-highest": "#d3e4fe",
                    "on-background": "#0b1c30",
                    "error-container": "#ffdad6",
                    "surface-bright": "#f8f9ff",
                    "surface-dim": "#cbdbf5",
                    "surface-container-high": "#dce9ff",
                    "on-primary-fixed-variant": "#3f465c",
                    "on-secondary-fixed-variant": "#004e5c",
                    "surface-variant": "#d3e4fe",
                    "surface": "#f8f9ff",
                    "secondary-fixed-dim": "#4cd7f6",
                    "on-surface-variant": "#45464d",
                    "tertiary": "#000000",
                    "on-surface": "#0b1c30",
                    "on-primary-fixed": "#131b2e",
                    "surface-tint": "#565e74",
                    "on-secondary-container": "#006172",
                    "on-error-container": "#93000a",
                    "surface-container-low": "#eff4ff",
                    "tertiary-fixed-dim": "#ffb95f",
                    "outline": "#76777d",
                    "on-error": "#ffffff",
                    "primary-fixed": "#dae2fd",
                    "on-primary-container": "#7c839b",
                    "secondary-fixed": "#acedff",
                    "error": "#ba1a1a",
                    "primary-container": "#131b2e",
                    "on-primary": "#ffffff",
                    "background": "#f8f9ff",
                    "on-tertiary-fixed": "#2a1700",
                    "primary-fixed-dim": "#bec6e0",
                    "on-secondary": "#ffffff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px",
                    "2xl": "1rem"
            },
            "spacing": {
                    "sidebar-width": "280px",
                    "gutter": "24px",
                    "container-max-width": "1440px",
                    "margin-mobile": "16px",
                    "margin-desktop": "32px",
                    "stack-md": "16px",
                    "stack-sm": "8px",
                    "stack-lg": "32px"
            },
            "fontFamily": {
                    "body-md": ["Hanken Grotesk"],
                    "label-sm": ["JetBrains Mono"],
                    "headline-lg-mobile": ["Hanken Grotesk"],
                    "label-md": ["JetBrains Mono"],
                    "display": ["Hanken Grotesk"],
                    "headline-lg": ["Hanken Grotesk"],
                    "title-lg": ["Hanken Grotesk"],
                    "headline-md": ["Hanken Grotesk"],
                    "body-lg": ["Hanken Grotesk"]
            },
            "fontSize": {
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                    "label-sm": ["12px", {"lineHeight": "16px", "letterSpacing": "0.05em", "fontWeight": "500"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.02em", "fontWeight": "500"}],
                    "display": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                    "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                    "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}]
            }
          },
        },
      }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
        /* Toast notification animation */
        @keyframes slideDown {
            from { transform: translateY(-100%); opacity: 0; }
            to   { transform: translateY(0);    opacity: 1; }
        }
        .toast-anim { animation: slideDown 0.4s ease-out; }
    </style>
</head>
<body class="bg-background text-on-background font-body-md text-body-md antialiased min-h-screen">

    <!-- ===================== SideNavBar ===================== -->
    <aside class="fixed left-0 top-0 h-full w-sidebar-width bg-primary-container border-r border-outline-variant shadow-md flex flex-col py-8 z-50">
        <div class="px-gutter mb-8">
            <h1 class="font-headline-md text-headline-md font-bold text-on-primary">AutoWash Pro</h1>
            <p class="font-label-sm text-label-sm text-on-primary-container">Cổng thông tin loyalty</p>
        </div>
        <nav class="flex-1 px-4 space-y-2 flex flex-col">
            <div class="flex-1 space-y-2">
                <a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200"
                   href="MainController?action=Dashboard">
                    <span class="material-symbols-outlined">dashboard</span>
                    <span class="font-label-md text-label-md">Dashboard</span>
                </a>
                <a class="flex items-center gap-3 px-4 py-3 text-secondary-fixed border-l-4 border-secondary-fixed bg-on-primary-fixed-variant/10 rounded-r-lg cursor-pointer active:scale-95 duration-200"
                   href="MainController?action=ViewCars">
                    <span class="material-symbols-outlined fill">directions_car</span>
                    <span class="font-label-md text-label-md font-bold">Xe của tôi</span>
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
            <a class="hover:text-secondary transition-colors opacity-70" href="MainController?action=Dashboard">Portal</a>
            <span class="material-symbols-outlined text-[16px] opacity-50">chevron_right</span>
            <span class="text-secondary font-bold">Xe của tôi</span>
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

    <!-- Toast Notifications -->
    <% if (carError != null) { %>
    <div id="toast-error" class="toast-anim fixed top-20 right-6 z-[200] bg-red-50 border border-red-300 text-red-700 rounded-xl px-5 py-3 shadow-lg flex items-center gap-3 max-w-sm">
        <span class="material-symbols-outlined text-red-500">error</span>
        <span class="text-sm font-medium"><%= carError %></span>
        <button onclick="document.getElementById('toast-error').remove()" class="ml-auto text-red-400 hover:text-red-600">
            <span class="material-symbols-outlined text-[18px]">close</span>
        </button>
    </div>
    <% } %>
    <% if (carSuccess != null) { %>
    <div id="toast-success" class="toast-anim fixed top-20 right-6 z-[200] bg-green-50 border border-green-300 text-green-700 rounded-xl px-5 py-3 shadow-lg flex items-center gap-3 max-w-sm">
        <span class="material-symbols-outlined text-green-500">check_circle</span>
        <span class="text-sm font-medium"><%= carSuccess %></span>
        <button onclick="document.getElementById('toast-success').remove()" class="ml-auto text-green-400 hover:text-green-600">
            <span class="material-symbols-outlined text-[18px]">close</span>
        </button>
    </div>
    <% } %>

    <!-- Main Content Canvas -->
    <main class="ml-sidebar-width pt-16 min-h-screen p-margin-desktop bg-background">
        <div class="max-w-container-max-width mx-auto">
            <!-- Page Header Row -->
            <div class="flex justify-between items-end mb-8">
                <div>
                    <h2 class="font-display text-display text-on-surface">Đội xe của tôi</h2>
                    <p class="font-body-lg text-body-lg text-on-surface-variant mt-2">Quản lý danh sách xe đã được liên kết với số điện thoại <strong class="text-secondary"><%= us.getPhoneNumber() %></strong>.</p>
                </div>
                <button onclick="openAddCarModal()" class="bg-secondary text-on-secondary font-label-md text-label-md px-5 py-3 rounded-xl hover:bg-on-secondary-container hover:text-secondary-fixed transition-colors shadow-md flex items-center gap-2">
                    <span class="material-symbols-outlined text-[18px]">add</span>
                    + Đăng ký xe mới
                </button>
            </div>

            <!-- Vehicle Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-gutter">
                <% if(carList != null && !carList.isEmpty()) {
                    for(Car car : carList) {
                %>
                    <article class="bg-surface border border-outline-variant rounded-xl shadow-sm hover:shadow-md transition-shadow duration-300 overflow-hidden flex flex-col group relative">
                        <!-- Status Badge -->
                        <div class="absolute top-4 right-4 z-10 bg-primary-fixed text-on-primary-fixed px-3 py-1.5 rounded-full font-label-sm text-label-sm uppercase flex items-center gap-1.5 shadow-sm backdrop-blur-md bg-opacity-90">
                            <span class="w-2 h-2 rounded-full bg-secondary"></span>
                            ACTIVE
                        </div>
                        <!-- Image Area -->
                        <div class="relative h-56 bg-surface-variant overflow-hidden">
                            <img alt="Sleek Car" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCjqdpi_KRm2KwxXfVbPa3FCbEKgtWUWNKlZbGgmVz_9Nq5Z_4pTg_6gpxQmimh8UrSxznDeTV5mpYjqEtNYtJjWH9F2TlHOQFlZIR6i1eFGnpXZnIazbikFSZEiouseM7RtjyHVB9RyCfz-vcrc3AKPdT1FXiGfthADJYeh2ZbKzJLu95sJ_mQFo8CSHVObP0YGzrRGVCYPwEvy2_9uIyJFUVREYK0YBa-W1b73c5owVCNWk8XEEUHm-uZf6SsMKccG4fVtHQ6kOOw">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                            <div class="absolute bottom-4 left-4">
                                <div class="font-label-md text-label-md text-surface-container-highest uppercase tracking-wider mb-1">Biển Số Xe</div>
                                <div class="font-headline-md text-headline-md text-on-primary bg-primary/40 backdrop-blur-md px-3 py-1 rounded-lg border border-white/20 inline-block font-mono tracking-widest">
                                    <%= car.getLicensePlate() %>
                                </div>
                            </div>
                        </div>
                        <!-- Content Area -->
                        <div class="p-6 flex flex-col flex-1 gap-3">
                            <div>
                                <h3 class="font-title-lg text-title-lg text-on-surface mb-1"><%= car.getBrand() %></h3>
                                <% if (car.getModel() != null && !car.getModel().trim().isEmpty()) { %>
                                    <p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[16px]">directions_car</span>
                                        <%= car.getModel() %> <%= (car.getColor() != null && !car.getColor().trim().isEmpty()) ? "(" + car.getColor() + ")" : "" %>
                                    </p>
                                <% } %>
                            </div>
                            <div class="flex items-center gap-2 text-on-surface-variant text-sm pt-2 border-t border-outline-variant/30">
                                <span class="material-symbols-outlined text-[16px]">phone_iphone</span>
                                <span>Liên kết: <strong class="text-secondary font-mono"><%= us.getPhoneNumber() %></strong></span>
                            </div>
                        </div>
                    </article>
                <%  }
                } else { %>
                    <div class="col-span-full border-2 border-dashed border-slate-200 rounded-2xl p-12 text-center text-slate-400 bg-white">
                        <span class="material-symbols-outlined text-5xl mb-4 text-slate-300 block">directions_car</span>
                        <p class="text-lg font-semibold mb-2">Bạn chưa có biển số xe nào được liên kết!</p>
                        <p class="text-sm mb-4">Hãy đăng ký xe để bắt đầu đặt lịch rửa xe.</p>
                        <button onclick="openAddCarModal()" class="mt-4 inline-block bg-secondary text-on-secondary px-6 py-3 rounded-xl text-sm font-semibold hover:bg-opacity-90 transition-all shadow-md">Đăng ký xe ngay</button>
                    </div>
                <% } %>
            </div>
        </div>
    </main>

    <!-- Modal Popup Thêm Xe Mới -->
    <div id="addCarModal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-[100] flex items-center justify-center hidden opacity-0 transition-opacity duration-300">
        <div class="bg-white rounded-3xl border border-slate-200 shadow-2xl w-full max-w-lg overflow-hidden transform scale-95 transition-transform duration-300 p-8 space-y-6">
            <div class="flex justify-between items-center">
                <h3 class="text-xl font-bold text-slate-950 flex items-center gap-2">
                    <span class="material-symbols-outlined text-secondary">add_circle</span> Đăng ký xe mới
                </h3>
                <button onclick="closeAddCarModal()" class="text-slate-400 hover:text-slate-600 transition-colors w-8 h-8 rounded-full hover:bg-slate-100 flex items-center justify-center">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            
            <form id="addCarForm" action="MainController" method="post" onsubmit="return validateCarForm()" class="space-y-4">
                <input type="hidden" name="action" value="AddCar" />
                
                <!-- Biển số xe -->
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-semibold text-slate-700" for="txtlicenseplate">Biển số xe <span class="text-red-500">*</span></label>
                    <input type="text" id="txtlicenseplate" name="txtlicenseplate"
                           placeholder="Ví dụ: 30A1-1234 hoặc 51F1-123.45"
                           class="w-full px-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-white focus:ring-1 focus:ring-secondary rounded-xl font-medium text-slate-800 transition-colors outline-none uppercase"
                           required />
                    <p class="text-xs text-slate-400">Theo chuẩn biển số Việt Nam. Ví dụ: <code class="bg-slate-100 px-1 rounded">30A-999.99</code> hoặc <code class="bg-slate-100 px-1 rounded">51F1-1234</code></p>
                    <p id="plateError" class="text-xs text-red-500 hidden">Biển số không đúng định dạng Việt Nam!</p>
                </div>
                
                <!-- Hãng xe -->
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-semibold text-slate-700" for="txtbrand">Hãng xe</label>
                    <select id="txtbrand" name="txtbrand"
                            class="w-full px-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-white focus:ring-1 focus:ring-secondary rounded-xl font-medium text-slate-800 transition-colors outline-none">
                        <option value="Toyota">Toyota</option>
                        <option value="Honda">Honda</option>
                        <option value="Kia">Kia</option>
                        <option value="Hyundai">Hyundai</option>
                        <option value="Ford">Ford</option>
                        <option value="VinFast">VinFast</option>
                        <option value="Mazda">Mazda</option>
                        <option value="BMW">BMW</option>
                        <option value="Mercedes">Mercedes</option>
                        <option value="Audi">Audi</option>
                        <option value="Mitsubishi">Mitsubishi</option>
                        <option value="Nissan">Nissan</option>
                    </select>
                </div>
                
                <!-- Dòng xe -->
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-semibold text-slate-700" for="txtmodel">Dòng xe (Model) <span class="text-red-500">*</span></label>
                    <input type="text" id="txtmodel" name="txtmodel" placeholder="Ví dụ: Camry / Civic / CX5 / VF8"
                           class="w-full px-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-white focus:ring-1 focus:ring-secondary rounded-xl font-medium text-slate-800 transition-colors outline-none"
                           required />
                </div>
                
                <!-- Màu xe -->
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-semibold text-slate-700" for="txtcolor">Màu xe <span class="text-red-500">*</span></label>
                    <input type="text" id="txtcolor" name="txtcolor" placeholder="Ví dụ: Trắng / Đen / Đỏ"
                           class="w-full px-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-white focus:ring-1 focus:ring-secondary rounded-xl font-medium text-slate-800 transition-colors outline-none"
                           required />
                </div>
                
                <!-- Nút bấm -->
                <div class="flex gap-4 pt-4 border-t border-slate-100">
                    <button type="button" onclick="closeAddCarModal()" class="w-1/2 py-3.5 bg-slate-100 hover:bg-slate-200 text-slate-700 font-semibold rounded-xl transition-all">Hủy bỏ</button>
                    <button type="submit" class="w-1/2 py-3.5 bg-secondary hover:bg-on-secondary-fixed-variant text-on-secondary font-semibold rounded-xl transition-all shadow-md flex items-center justify-center gap-2">
                        <span class="material-symbols-outlined text-[18px]">add_circle</span>
                        Đăng ký xe
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Auto-dismiss toasts after 5 seconds
        setTimeout(() => {
            const errToast = document.getElementById('toast-error');
            const sucToast = document.getElementById('toast-success');
            if (errToast) errToast.remove();
            if (sucToast) sucToast.remove();
        }, 5000);

        function openAddCarModal() {
            const modal = document.getElementById('addCarModal');
            modal.classList.remove('hidden');
            setTimeout(() => {
                modal.classList.remove('opacity-0');
                modal.firstElementChild.classList.remove('scale-95');
            }, 10);
        }

        function closeAddCarModal() {
            const modal = document.getElementById('addCarModal');
            modal.classList.add('opacity-0');
            modal.firstElementChild.classList.add('scale-95');
            setTimeout(() => {
                modal.classList.add('hidden');
            }, 300);
        }

        function validateCarForm() {
            const plateInput = document.getElementById('txtlicenseplate').value.trim().toUpperCase();
            const errorEl = document.getElementById('plateError');
            
            // Regex chuẩn biển số xe Việt Nam theo SRS:
            // Dạng 1: 30A1-1234 (2 số + 1 chữ + 1 số + dấu gạch + 4-5 số)
            // Dạng 2: 51F1-123.45 (2 số + 1 chữ + 1 số + gạch + 3 số + dấu chấm + 2 số)
            // Dạng 3: 30H-12345 (2 số + 1 chữ + gạch + 4-5 số) – biển thường không có số thứ 4
            // Dạng 4: 30H-123.45
            const regex = /^\d{2}[A-Z]\d-\d{4,5}$|^\d{2}[A-Z]\d-\d{3}\.\d{2}$|^\d{2}[A-Z]-\d{4,5}$|^\d{2}[A-Z]-\d{3}\.\d{2}$/;
            
            if (!regex.test(plateInput)) {
                errorEl.classList.remove('hidden');
                document.getElementById('txtlicenseplate').focus();
                return false;
            }
            errorEl.classList.add('hidden');
            return true;
        }

        // Auto uppercase license plate input
        document.getElementById('txtlicenseplate').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
            document.getElementById('plateError').classList.add('hidden');
        });
    </script>
</body>
</html>
