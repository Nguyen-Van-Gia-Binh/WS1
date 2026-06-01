# AutoWash Pro — Task Tracker

## Giai đoạn 1: Database & Config
- [x] Tạo SQL Schema Script (`AutoWashProDB_Schema.sql`)
- [x] Kiểm tra pom.xml (đã đủ dependencies)

## Giai đoạn 2: Model & Connection
- [x] `DBContext.java` — Kết nối SQL Server
- [x] `Tier.java` — Model hạng thẻ
- [x] `User.java` — Model người dùng
- [x] `LicensePlate.java` — Model biển số xe
- [x] `Booking.java` — Model đặt lịch
- [x] `LoyaltyTransaction.java` — Model giao dịch điểm
- [x] `Notification.java` — Model thông báo

## Giai đoạn 3: DAO Layer
- [x] `BaseDAO.java`
- [x] `TierDAO.java`
- [x] `UserDAO.java`
- [x] `LicensePlateDAO.java`
- [x] `BookingDAO.java`
- [x] `LoyaltyTransactionDAO.java`
- [x] `NotificationDAO.java`

## Giai đoạn 4: Service — Loyalty Engine
- [x] `LoyaltyService.java`
- [x] `BookingService.java`

## Giai đoạn 5: Authorization & Filters
- [x] `AuthorizationFilter.java`
- [x] `web.xml`
- [x] **Task 4:** Rà soát và dọn dẹp mã nguồn thừa, chuẩn hóa tên biến, bình luận
    - [x] Đánh dấu file thừa để người dùng xóa thủ công (`SearchController.java`, `menu.jsp`)
    - [x] Dọn dẹp logic thêm xe thừa trong `RegisterController.java`
    - [x] Dọn dẹp các hàm thừa (`deleteCustomer`, `getCustomer(email)`) trong `CustomerDAO.java`
    - [x] Chuẩn hóa tên biến cục bộ (`d` -> `customerDAO`, `table` -> `rs`) và xóa comment NetBeans
    - [x] Clean up check `status` luôn đúng trong `LoginController.java`
- [x] **Task 5:** Loại bỏ hoàn toàn hardcode Tiers trong DashboardController (nạp động từ DB)

## Giai đoạn 6: Controller & View — Customer (Mobile)
- [x] `LoginServlet.java` + [x] `login.jsp`
- [x] `RegisterServlet.java` + [x] `register.jsp`
- [x] `LogoutServlet.java`
- [x] `DashboardServlet.java` + [x] `customer/dashboard.jsp`
- [x] `BookingWizardServlet.java` + [x] `customer/booking.jsp`
- [x] `MyCarsServlet.java` + [x] `customer/my-cars.jsp`
- [x] `NotificationServlet.java` + [x] `customer/notifications.jsp`
- [x] `components/header.jsp`
- [x] `components/bottom-nav.jsp`

## Giai đoạn 7: Controller & View — Admin (Desktop)
- [x] `AdminDashboardServlet.java` + [x] `admin/dashboard.jsp`
- [x] `ManageBookingsServlet.java` + [x] `admin/bookings.jsp`
- [x] `CheckoutServlet.java` + [x] `admin/checkout.jsp`
- [x] `components/sidebar.jsp`

## Giai đoạn 8: JavaScript & AJAX
- [x] Checkout realtime (inline trong checkout.jsp)
- [x] Notification AJAX mark-as-read (inline trong notifications.jsp)
- [x] Booking slot check (inline trong booking.jsp)
- [x] Booking wizard navigation (inline trong booking.jsp)

## Error Pages
- [x] `error/404.jsp`
- [x] `error/500.jsp`

## Verification
- [ ] `mvn compile` thành công
- [ ] `mvn package` tạo WAR thành công
- [ ] Deploy Tomcat + test luồng Auth
- [ ] Test luồng Customer
- [ ] Test luồng Admin
