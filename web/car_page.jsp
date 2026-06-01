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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/theme.css" rel="stylesheet"/>
    <link href="css/dashboard.css" rel="stylesheet"/>
    <style>
        /* Toast notification slide animation */
        @keyframes slideDown {
            from { transform: translateY(-100%); opacity: 0; }
            to   { transform: translateY(0);    opacity: 1; }
        }
        .toast-anim { animation: slideDown 0.4s ease-out; }
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
                    <a class="nav-link" href="MainController?action=Dashboard">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span>Dashboard</span>
                    </a>
                    <a class="nav-link active" href="MainController?action=ViewCars">
                        <span class="material-symbols-outlined fill">directions_car</span>
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
                    <a class="topbar-breadcrumb-link" href="MainController?action=Dashboard" style="opacity: 0.7; color: inherit;">Portal</a>
                    <span class="material-symbols-outlined" style="font-size: 16px; opacity: 0.5;">chevron_right</span>
                    <span style="color: var(--color-secondary); font-weight: bold;">Xe của tôi</span>
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

            <!-- Toast Notifications -->
            <div class="toast-container">
                <% if (carError != null) { %>
                <div id="toast-error" class="toast toast-error toast-anim">
                    <span class="material-symbols-outlined">error</span>
                    <span class="toast-message"><%= carError %></span>
                    <button onclick="document.getElementById('toast-error').remove()" class="toast-close">
                        <span class="material-symbols-outlined" style="font-size: 18px;">close</span>
                    </button>
                </div>
                <% } %>
                <% if (carSuccess != null) { %>
                <div id="toast-success" class="toast toast-success toast-anim">
                    <span class="material-symbols-outlined">check_circle</span>
                    <span class="toast-message"><%= carSuccess %></span>
                    <button onclick="document.getElementById('toast-success').remove()" class="toast-close">
                        <span class="material-symbols-outlined" style="font-size: 18px;">close</span>
                    </button>
                </div>
                <% } %>
            </div>

            <!-- ===================== Main Content ===================== -->
            <main class="main-content">
                <div class="content-container">
                    
                    <!-- Page Header Row -->
                    <div class="header-row">
                        <div class="header-title-section">
                            <h2 class="page-title">Đội xe của tôi</h2>
                            <p class="page-subtitle">Quản lý danh sách xe đã được liên kết với số điện thoại <strong style="color: var(--color-secondary);"><%= us.getPhoneNumber() %></strong>.</p>
                        </div>
                        <button onclick="openAddCarModal()" class="btn-header">
                            <span class="material-symbols-outlined" style="font-size: 18px;">add</span>
                             Đăng ký xe mới
                        </button>
                    </div>

                    <!-- Vehicle Grid -->
                    <div class="vehicle-grid">
                        <% if(carList != null && !carList.isEmpty()) {
                            for(Car car : carList) {
                        %>
                            <article class="vehicle-card">
                                <!-- Status Badge -->
                                <div class="vehicle-status-badge">
                                    <span class="vehicle-status-dot"></span>
                                    ACTIVE
                                </div>
                                <!-- Image Area -->
                                <div class="vehicle-image-wrapper">
                                    <img alt="Sleek Car" class="vehicle-image" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCjqdpi_KRm2KwxXfVbPa3FCbEKgtWUWNKlZbGgmVz_9Nq5Z_4pTg_6gpxQmimh8UrSxznDeTV5mpYjqEtNYtJjWH9F2TlHOQFlZIR6i1eFGnpXZnIazbikFSZEiouseM7RtjyHVB9RyCfz-vcrc3AKPdT1FXiGfthADJYeh2ZbKzJLu95sJ_mQFo8CSHVObP0YGzrRGVCYPwEvy2_9uIyJFUVREYK0YBa-W1b73c5owVCNWk8XEEUHm-uZf6SsMKccG4fVtHQ6kOOw">
                                    <div class="vehicle-image-overlay"></div>
                                    <div class="vehicle-image-text">
                                        <div class="vehicle-plate-label">Biển Số Xe</div>
                                        <div class="vehicle-plate-number">
                                            <%= car.getLicensePlate() %>
                                        </div>
                                    </div>
                                </div>
                                <!-- Content Area -->
                                <div class="vehicle-info-body">
                                    <div>
                                        <h3 class="vehicle-brand"><%= car.getBrand() %></h3>
                                        <% if (car.getModel() != null && !car.getModel().trim().isEmpty()) { %>
                                            <p class="vehicle-model-desc">
                                                <span class="material-symbols-outlined" style="font-size: 16px;">directions_car</span>
                                                <%= car.getModel() %> <%= (car.getColor() != null && !car.getColor().trim().isEmpty()) ? "(" + car.getColor() + ")" : "" %>
                                            </p>
                                        <% } %>
                                    </div>
                                    <div class="vehicle-link-owner">
                                        <span class="material-symbols-outlined" style="font-size: 16px;">phone_iphone</span>
                                        <span>Liên kết: <strong style="color: var(--color-secondary); font-family: var(--font-mono);"><%= us.getPhoneNumber() %></strong></span>
                                    </div>
                                </div>
                            </article>
                        <%  }
                        } else { %>
                            <div class="vehicle-empty-state">
                                <span class="material-symbols-outlined vehicle-empty-icon">directions_car</span>
                                <p class="vehicle-empty-title">Bạn chưa có biển số xe nào được liên kết!</p>
                                <p style="font-size: 0.875rem; margin-bottom: 16px;">Hãy đăng ký xe để bắt đầu đặt lịch rửa xe.</p>
                                <button onclick="openAddCarModal()" class="vehicle-empty-btn">Đăng ký xe ngay</button>
                            </div>
                        <% } %>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Modal Popup Thêm Xe Mới -->
    <div id="addCarModal" class="modal-overlay hidden" style="opacity: 0; transition: opacity 0.3s;">
        <div class="modal-card" style="transform: scale(0.95); transition: transform 0.3s;">
            <div class="modal-header">
                <h3 class="modal-title">
                    <span class="material-symbols-outlined" style="color: var(--color-secondary);">add_circle</span> Đăng ký xe mới
                </h3>
                <button onclick="closeAddCarModal()" class="modal-close-btn">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            
            <form id="addCarForm" action="MainController" method="post" onsubmit="return validateCarForm()" class="modal-form">
                <input type="hidden" name="action" value="AddCar" />
                
                <!-- Biển số xe -->
                <div class="modal-form-group">
                    <label class="modal-label" for="txtlicenseplate">Biển số xe <span style="color: var(--color-error);">*</span></label>
                    <input type="text" id="txtlicenseplate" name="txtlicenseplate"
                           placeholder="Ví dụ: 30A1-1234 hoặc 51F1-123.45"
                           class="modal-input"
                           style="text-transform: uppercase;"
                           required />
                    <p class="modal-input-desc">Theo chuẩn biển số Việt Nam. Ví dụ: <code>30A-999.99</code> hoặc <code>51F1-1234</code></p>
                    <p id="plateError" class="modal-input-error" style="display: none;">Biển số không đúng định dạng Việt Nam!</p>
                </div>
                
                <!-- Hãng xe -->
                <div class="modal-form-group">
                    <label class="modal-label" for="txtbrand">Hãng xe</label>
                    <select id="txtbrand" name="txtbrand" class="modal-select">
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
                <div class="modal-form-group">
                    <label class="modal-label" for="txtmodel">Dòng xe (Model) <span style="color: var(--color-error);">*</span></label>
                    <input type="text" id="txtmodel" name="txtmodel" placeholder="Ví dụ: Camry / Civic / CX5 / VF8"
                           class="modal-input" required />
                </div>
                
                <!-- Màu xe -->
                <div class="modal-form-group">
                    <label class="modal-label" for="txtcolor">Màu xe <span style="color: var(--color-error);">*</span></label>
                    <input type="text" id="txtcolor" name="txtcolor" placeholder="Ví dụ: Trắng / Đen / Đỏ"
                           class="modal-input" required />
                </div>
                
                <!-- Nút bấm -->
                <div class="modal-actions">
                    <button type="button" onclick="closeAddCarModal()" class="btn-modal-cancel">Hủy bỏ</button>
                    <button type="submit" class="btn-modal-submit">
                        <span class="material-symbols-outlined" style="font-size: 18px;">add_circle</span>
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
                modal.style.opacity = '1';
                modal.firstElementChild.style.transform = 'scale(1)';
            }, 10);
        }

        function closeAddCarModal() {
            const modal = document.getElementById('addCarModal');
            modal.style.opacity = '0';
            modal.firstElementChild.style.transform = 'scale(0.95)';
            setTimeout(() => {
                modal.classList.add('hidden');
            }, 300);
        }

        function validateCarForm() {
            const plateInput = document.getElementById('txtlicenseplate').value.trim().toUpperCase();
            const errorEl = document.getElementById('plateError');
            
            // Regex chuẩn biển số xe Việt Nam:
            const regex = /^\d{2}[A-Z]\d-\d{4,5}$|^\d{2}[A-Z]\d-\d{3}\.\d{2}$|^\d{2}[A-Z]-\d{4,5}$|^\d{2}[A-Z]-\d{3}\.\d{2}$/;
            
            if (!regex.test(plateInput)) {
                errorEl.style.display = 'block';
                document.getElementById('txtlicenseplate').focus();
                return false;
            }
            errorEl.style.display = 'none';
            return true;
        }

        // Auto uppercase license plate input
        document.getElementById('txtlicenseplate').addEventListener('input', function() {
            this.value = this.value.toUpperCase();
            document.getElementById('plateError').style.display = 'none';
        });
    </script>
</body>
</html>
