# 🚀 KẾ HOẠCH TRIỂN KHAI DỰ ÁN AUTOWASH PRO

> Kế hoạch triển khai tuần tự 8 giai đoạn, tuân thủ nghiêm ngặt tài liệu [AI_Developer_Guide.md](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/Docs/AI_Developer_Guide.md) và thiết kế giao diện từ StitchMCP (Project: "AutoWash Pro Design System Mobile - Desktop").

---

## 📊 Tổng quan Thiết kế từ StitchMCP

Tôi đã kết nối với StitchMCP và phân tích **25+ màn hình thiết kế**, gom thành các nhóm chức năng:

| Nhóm | Loại | Màn hình |
|------|------|----------|
| **Auth** | Mobile + Desktop | Login, Register (cả 2 phiên bản) |
| **Customer (Mobile)** | Mobile-First | Dashboard, Booking Wizard (4 bước: Chọn Xe → Chọn Ngày → Chọn Giờ → Xác nhận), My Cars, Notifications |
| **Admin (Desktop)** | Desktop | Dashboard (Chart.js), Today's Bookings, Quick Checkout, Tier Settings |
| **Desktop Sync** | Desktop | Dashboard, Booking Steps (1-3), Booking Confirmation, My Cars, Notifications |

**Design System đã xác định:**
- **Fonts**: Hanken Grotesk (heading/body) + JetBrains Mono (label/mono)
- **Icons**: Material Symbols Outlined (via Google Fonts CDN)
- **CSS**: Tailwind CSS via CDN (theo yêu cầu tài liệu)
- **Charts**: Chart.js CDN (Admin Dashboard)
- **Color Palette**: Material Design 3 tokens (primary `#000000`, secondary `#00687a`, tertiary gold, surface blues)

---

## User Review Required

> [!IMPORTANT]
> **Cấu trúc package hiện tại vs Tài liệu**: Dự án hiện có thư mục `control`, `dao`, `model`, `view` (4 folder trống) dưới `src/main/java/`. Tài liệu yêu cầu package là `com.autowash.autowashpro.controller`, `com.autowash.autowashpro.dao`, v.v... Tôi sẽ **tạo đúng cấu trúc package** theo tài liệu dưới `src/main/java/com/autowash/autowashpro/` và các thư mục cũ (`control`, `dao`, `model`, `view`) sẽ được giữ nguyên (không xóa) để tránh conflict.

> [!IMPORTANT]
> **Database SQL Server**: Tài liệu yêu cầu SQL Server. Tôi sẽ tạo file SQL script để bạn chạy trên SQL Server Management Studio (SSMS). Bạn cần đảm bảo:
> - SQL Server đang chạy trên localhost
> - Có tài khoản `sa` hoặc Windows Authentication
> - Cần cung cấp: tên database, username/password để tôi cấu hình `DBContext.java`

> [!WARNING]
> **Tailwind CSS via CDN**: Tài liệu chỉ định dùng Tailwind CSS qua CDN (`<script src="https://cdn.tailwindcss.com">`). Đây là cách phù hợp cho đồ án PRJ301 (không cần build tool), nhưng lưu ý CDN chỉ nên dùng cho development/demo, không phải production.

---

## Open Questions

> [!IMPORTANT]
> 1. **Thông tin kết nối Database**: Bạn muốn dùng tên database nào? (đề xuất: `AutoWashProDB`). Username/password SQL Server của bạn là gì? Hay dùng Windows Authentication?
> 2. **Ngôn ngữ giao diện**: Thiết kế StitchMCP dùng mix Tiếng Anh + Tiếng Việt. Bạn muốn giao diện hoàn toàn Tiếng Việt, hoàn toàn Tiếng Anh, hay giữ nguyên mix như thiết kế?
> 3. **Thư mục cũ**: Có muốn xóa các thư mục rỗng cũ (`control/`, `dao/`, `model/`, `view/` dưới `src/main/java/`) không?

---

## Proposed Changes

Triển khai tuần tự theo **8 Giai đoạn** (đúng lộ trình tài liệu Section 6):

---

### 🔷 Giai đoạn 1: Database & Config

Tạo schema SQL Server và cập nhật cấu hình Maven.

#### [NEW] [AutoWashProDB_Schema.sql](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/Docs/AutoWashProDB_Schema.sql)
- Script SQL tạo database `AutoWashProDB`
- Tạo 6 bảng: `Tiers`, `Users`, `LicensePlates`, `Bookings`, `LoyaltyTransactions`, `Notifications`
- Chèn dữ liệu cấu hình 4 hạng Tiers (MEMBER, SILVER, GOLD, PLATINUM) với Multiplier/BookingDays
- Chèn dữ liệu mẫu (1 Admin, 1 Staff, 2 Customers) để test ngay

#### [MODIFY] [pom.xml](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/pom.xml)
- Đã đủ dependencies (MSSQL JDBC, JSTL, Gson) → Không cần thay đổi
- Kiểm tra Java version (hiện `1.8` — phù hợp)

---

### 🔷 Giai đoạn 2: Model & Connection

Xây dựng lớp kết nối DB và 6 entity Model.

#### [NEW] [DBContext.java](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/src/main/java/com/autowash/autowashpro/connection/DBContext.java)
- Singleton pattern quản lý kết nối SQL Server JDBC
- Method `getConnection()` trả về `java.sql.Connection`
- Có `main()` test kết nối ngay khi chạy
- Comment tiếng Việt giải thích luồng kết nối

#### [NEW] Model Entities (6 files trong `com.autowash.autowashpro.model`)
| File | Mô tả | Mapping DB |
|------|--------|------------|
| `Tier.java` | Hạng thẻ thành viên | Bảng `Tiers` |
| `User.java` | Khách hàng/Nhân viên/Admin | Bảng `Users` |
| `LicensePlate.java` | Biển số xe | Bảng `LicensePlates` |
| `Booking.java` | Lịch đặt rửa xe | Bảng `Bookings` |
| `LoyaltyTransaction.java` | Lịch sử tích/đổi điểm | Bảng `LoyaltyTransactions` |
| `Notification.java` | Thông báo cá nhân | Bảng `Notifications` |

Mỗi Model: fields private + getter/setter + constructor đầy đủ + toString() + comment Tiếng Việt

---

### 🔷 Giai đoạn 3: DAO – Data Access Object

Lớp truy xuất dữ liệu JDBC thuần (không ORM).

#### [NEW] DAO Layer (7 files trong `com.autowash.autowashpro.dao`)
| File | Chức năng chính |
|------|----------------|
| `BaseDAO.java` | Hàm JDBC bổ trợ dùng chung (close resources, helper methods) |
| `TierDAO.java` | `getAllTiers()`, `getTierById()`, `getNextTier()` |
| `UserDAO.java` | `findByPhone()`, `findById()`, `register()`, `updateUser()`, `updateTierAndPoints()` |
| `LicensePlateDAO.java` | `getPlatesByUserId()`, `addPlate()`, `deletePlate()` |
| `BookingDAO.java` | `getBookingsByUserId()`, `getBookingsByDate()`, `createBooking()`, `updateStatus()`, `countByDateAndSlot()` |
| `LoyaltyTransactionDAO.java` | `getTransactionsByUserId()`, `insertTransaction()` |
| `NotificationDAO.java` | `getByUserId()`, `getUnreadCount()`, `markAsRead()`, `createNotification()` |

**Nguyên tắc**: Tất cả dùng `try-with-resources`, `PreparedStatement`, không SQL injection.

---

### 🔷 Giai đoạn 4: Service – Loyalty Engine

Trái tim thuật toán nghiệp vụ của dự án.

#### [NEW] [LoyaltyService.java](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/src/main/java/com/autowash/autowashpro/service/LoyaltyService.java)
- **`calculateNextRewardProgress(User user)`**: Tính % tiến trình thăng hạng (công thức P = max(p_wash, p_spent))
- **`generateProgressMessage(User user)`**: Tạo dòng thông báo động ("Bạn chỉ còn cách hạng X...")
- **`processCheckout(bookingId, billAmount, redeemPoints)`**: Database Transaction hoàn chỉnh gồm 6 bước:
  - Cập nhật Booking → COMPLETED
  - Tính toán điểm earn/redeem
  - Cập nhật PointsBalance, TotalSpent, TotalWashes
  - Chèn LoyaltyTransactions (EARN + REDEEM)
  - Kiểm tra auto-upgrade tier
  - Tạo Notification tự động
- Comment tiếng Việt giải thích **từng bước** thuật toán

#### [NEW] [BookingService.java](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/src/main/java/com/autowash/autowashpro/service/BookingService.java)
- `getAvailableSlots(date)`: Check slot còn trống
- `calculateMaxBookingDate(tierBookingDays)`: Tính ngày đặt tối đa theo hạng
- `validateAndCreateBooking(userId, plateId, date, slot)`: Validate + tạo booking

---

### 🔷 Giai đoạn 5: Authorization & Filters

#### [NEW] [AuthorizationFilter.java](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/src/main/java/com/autowash/autowashpro/filter/AuthorizationFilter.java)
- Chặn `/customer/*` → Yêu cầu role CUSTOMER
- Chặn `/admin/*` → Yêu cầu role ADMIN hoặc STAFF
- Cho phép truy cập tự do: `/login`, `/register`, `/logout`, tài nguyên tĩnh
- Redirect về trang login nếu chưa đăng nhập

#### [NEW] [web.xml](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/src/main/webapp/WEB-INF/web.xml)
- Cấu hình Filter mapping
- Welcome file → redirect đến Login
- Error page 404/500
- Session timeout config

---

### 🔷 Giai đoạn 6: Controller & View — Khách hàng (Mobile-First)

Triển khai giao diện khách hàng theo thiết kế StitchMCP (mobile 390px).

#### Controllers (Servlet) — `com.autowash.autowashpro.controller`

| File | URL Pattern | Chức năng |
|------|-------------|-----------|
| `auth/LoginServlet.java` | `/login` | GET→form, POST→xác thực phone+password |
| `auth/RegisterServlet.java` | `/register` | GET→form, POST→tạo user mới |
| `auth/LogoutServlet.java` | `/logout` | Invalidate session → redirect login |
| `customer/DashboardServlet.java` | `/customer/dashboard` | Load wallet, tier, progress, upcoming booking |
| `customer/BookingWizardServlet.java` | `/customer/booking` | Wizard 4 bước, AJAX check slots |
| `customer/MyCarsServlet.java` | `/customer/my-cars` | CRUD biển số xe + Regex validation |
| `customer/NotificationServlet.java` | `/customer/notifications` | GET list + AJAX mark as read |

#### Views (JSP) — `src/main/webapp/`

| File | Mapping Design StitchMCP | Mô tả |
|------|--------------------------|-------|
| `login.jsp` | "Mobile Login - AutoWash Pro Gateway" | Form đăng nhập, Tailwind CSS |
| `register.jsp` | "Mobile Registration - AutoWash Pro Gateway" | Form đăng ký |
| `customer/dashboard.jsp` | "Trang chủ - AutoWash Pro" | Bento grid: Reward Wallet + Progress + Upcoming Booking |
| `customer/booking.jsp` | "Chọn Xe/Ngày/Giờ/Xác nhận" (4 screens) | Wizard 4 bước single-page |
| `customer/my-cars.jsp` | "Xe của tôi - AutoWash Pro" | Danh sách xe dạng card |
| `customer/notifications.jsp` | "Thông báo - AutoWash Pro" | Danh sách thông báo |
| `components/header.jsp` | Từ design | Top app bar + notification bell |
| `components/bottom-nav.jsp` | Từ design | Bottom navigation bar (mobile) |

**Design tokens** được trích xuất từ StitchMCP:
- Tailwind config với custom colors (primary `#000000`, secondary `#00687a`, surface blues, tertiary golds)
- Font families: Hanken Grotesk + JetBrains Mono
- Spacing tokens: stack-sm(8px), stack-md(16px), stack-lg(32px), margin-mobile(16px)

---

### 🔷 Giai đoạn 7: Controller & View — Admin/Staff (Desktop)

Triển khai giao diện quản trị theo thiết kế StitchMCP (desktop 1280px).

#### Controllers (Servlet)

| File | URL Pattern | Chức năng |
|------|-------------|-----------|
| `admin/AdminDashboardServlet.java` | `/admin/dashboard` | Load thống kê, dữ liệu Chart.js |
| `admin/ManageBookingsServlet.java` | `/admin/bookings` | Danh sách booking hôm nay, filter |
| `admin/CheckoutServlet.java` | `/admin/checkout` | Modal checkout realtime |

#### Views (JSP)

| File | Mapping Design StitchMCP | Mô tả |
|------|--------------------------|-------|
| `admin/dashboard.jsp` | "Dashboard - AutoWash Pro Admin" | Sidebar + Stats cards + Revenue Chart (Bar) + Tier Chart (Doughnut) + Recent Alerts |
| `admin/bookings.jsp` | "Today's Bookings - AutoWash Pro Admin" | Bảng booking có actions |
| `admin/checkout.jsp` | "Quick Checkout - AutoWash Pro Admin" | Form checkout + Modal realtime |
| `admin/tier-settings.jsp` | "Tier Settings - AutoWash Pro Admin" | Quản lý cấu hình tiers |
| `components/sidebar.jsp` | Từ design admin | Sidebar navigation (desktop) |

---

### 🔷 Giai đoạn 8: JavaScript & AJAX Polishing

#### [NEW] JS Files trong `src/main/webapp/js/`

| File | Chức năng |
|------|-----------|
| `checkout-realtime.js` | Tính toán realtime: D = P_redeem × 100, T = max(0, A-D), P_earn = round(T/1000 × Multiplier) |
| `notification-ajax.js` | AJAX fetch → mark `IsRead = 1`, cập nhật badge count mượt mà |
| `booking-slot-check.js` | AJAX check slot availability theo ngày, disable nút "Hết chỗ" |
| `booking-wizard.js` | Điều khiển wizard 4 bước, validation regex biển số VN |

---

## Verification Plan

### Automated Tests
```
1. Chạy DBContext.main() → Xác minh kết nối SQL Server thành công
2. mvn compile → Đảm bảo toàn bộ Java code biên dịch không lỗi
3. mvn package → Build WAR file thành công
4. Deploy lên Apache Tomcat → Kiểm tra từng URL pattern
```

### Manual Verification
Quy trình test theo luồng người dùng:

1. **Luồng Auth**: Truy cập `/login` → đăng nhập → redirect đúng Dashboard theo role
2. **Luồng Customer**:
   - Dashboard hiển thị đúng Wallet/Tier/Progress/Upcoming Booking
   - Booking Wizard: Chọn xe → Chọn ngày (bị giới hạn theo tier) → Chọn giờ (AJAX check slot) → Xác nhận
   - My Cars: Thêm xe mới (regex validate biển số VN) → Hiển thị danh sách
   - Notification: Click chuông → Dropdown → Click thông báo → AJAX mark read
3. **Luồng Admin**:
   - Dashboard hiển thị Chart.js (Revenue + Tier Distribution)
   - Today's Bookings: Xem danh sách, filter
   - Quick Checkout: Nhập bill → Nhập điểm đổi → Realtime tính toán → Xác nhận → DB Transaction → Auto-upgrade tier
4. **Filter Test**: Truy cập `/customer/dashboard` khi chưa login → Redirect về `/login`

---

## 📋 Tóm tắt Files sẽ tạo

| Loại | Số lượng |
|------|----------|
| SQL Script | 1 |
| Java Model | 6 |
| Java Connection | 1 |
| Java DAO | 7 |
| Java Service | 2 |
| Java Filter | 1 |
| Java Servlet (Controller) | 10 |
| JSP Views | 12 |
| JSP Components | 3 |
| JavaScript | 4 |
| Config (web.xml) | 1 |
| **TỔNG CỘNG** | **~48 files** |

> [!TIP]
> Tôi sẽ bắt đầu từ **Giai đoạn 1** ngay sau khi bạn phê duyệt kế hoạch này. Mỗi giai đoạn sẽ được thực hiện tuần tự, và sau mỗi file tôi sẽ giải thích Data Flow bằng Tiếng Việt để bạn học ngược kiến trúc.
