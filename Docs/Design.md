# TÀI LIỆU ĐẶC TẢ THIẾT KẾ GIAO DIỆN NGƯỜI DÙNG (UI/UX SPECIFICATION)

## HỆ THỐNG QUẢN LÝ RỬA XE TỰ ĐỘNG THÔNG MINH (AUTOWASH PRO)

## 1. HỆ THỐNG NHẬN DIỆN THƯƠNG HIỆU & HƯỚNG DẪN THIẾT KẾ (DESIGN SYSTEM)

Để mang lại cảm giác công nghệ, sạch sẽ và tối ưu hóa trải nghiệm trên các thiết bị di động cũng như máy tính, hệ thống tuân thủ nghiêm ngặt các nguyên tắc thiết kế thống nhất dưới đây:

### 1.1. Bảng màu chủ đạo (Color Palette)

Hệ thống sử dụng các mã màu hiện đại nhằm làm nổi bật dịch vụ chăm sóc và làm sạch xe:

- **Màu chủ đạo chính (Primary - Deep Blue):** `#0F172A` (Slate 900) hoặc `#1E3A8A` (Blue 900) - Đại diện cho sự uy tín, chuyên nghiệp và vững chắc.
- **Màu nhấn công nghệ (Accent - Cyan Blue):** `#06B6D4` (Cyan 500) hoặc `#0EA5E9` (Sky 500) - Tạo cảm giác hiện đại, dòng chảy nước sạch và chuyển động số hóa.
- **Màu nền phụ (Background - Soft Gray/White):** `#F8FAFC` (Slate 50) kết hợp với các khung thẻ màu trắng `#FFFFFF`.
- **Màu phân hạng thành viên (Tier Branding Colors):**
    - **Member:** `#64748B` (Slate 500 - Màu xám bạc tối giản).
    - **Silver:** `#94A3B8` (Slate 400 - Màu bạc óng ánh nhẹ).
    - **Gold:** `#F59E0B` (Amber 500 - Màu vàng hổ phách sang trọng).
    - **Platinum:** `#38BDF8` (Sky 300 - Màu xanh bạch kim thời thượng).

### 1.2. Bo góc & Hiệu ứng chiều sâu (Border Radius & Shadow)

- **Bo góc (Rounded corners):** Áp dụng bo góc lớn chuẩn thiết kế ứng dụng di động hiện đại (`rounded-2xl` - `16px` cho các thẻ thông tin và `rounded-xl` - `12px` cho các nút bấm, ô nhập liệu).
- **Chiều sâu (Shadows):** Sử dụng đổ bóng mờ nhẹ (`shadow-sm` và `shadow-md` của Tailwind) để tạo cảm giác các khối nổi nhẹ lên trên bề mặt nền xám nhạt, tạo chiều sâu thị giác tốt.

## 2. GIAO DIỆN KHÁCH HÀNG (CUSTOMER PORTAL - MOBILE OPTIMIZED)

Giao diện khách hàng được thiết kế ưu tiên hiển thị trên điện thoại di động (Mobile-First) với thanh điều hướng nằm ở đáy màn hình như một ứng dụng Native thực sự.

### 2.1. Cấu trúc Thanh điều hướng đáy (Bottom Navigation Bar)

Cố định ở dưới cùng màn hình điện thoại (`position: fixed; bottom: 0; left: 0; right: 0;`). Thanh điều hướng bao gồm 4 tab chính:

```
+-------------------------------------------------------------+
|    [Trang chủ]      [Đặt lịch]     [Xe của tôi]    [Thông báo]  |
|     (Home Icon)    (Calendar)       (Car Icon)       (Bell)     |
+-------------------------------------------------------------+
```

- **Trang chủ (Dashboard):** Xem hạng, số điểm, tiến trình "Next Reward" và lịch đặt hôm nay.
- **Đặt lịch (Booking):** Quy trình đặt lịch 4 bước (Wizard).
- **Xe của tôi (My Cars):** Đăng ký, quản lý danh sách biển số xe cá nhân.
- **Thông báo (Notifications):** Hộp thư nhận thông tin từ hệ thống.

### 2.2. Chi tiết Màn hình Trang chủ (Customer Dashboard)

### Sơ đồ bố cục giao diện (Wireframe)

```
+-------------------------------------------------------------+
| [Avatar] Chào Bình,                                 (Bell)  |  <- Header (Bell có dropdown thông báo)
| Hạng hiện tại: GOLD (Màu vàng Amber)                        |
+-------------------------------------------------------------+
| VÍ ĐIỂM THƯỞNG                                              |
| 1.500 Điểm ~ quy đổi: 150.000 VNĐ                           |
+-------------------------------------------------------------+
| TIẾN TRÌNH THĂNG HẠNG (Next Reward Progress)                |
| Bạn chỉ còn cách hạng Platinum 15 lượt rửa hoặc 9M VNĐ nữa! |
| [=================== Progressive Bar 50% =================] |
+-------------------------------------------------------------+
| LỊCH HẸN SẮP TỚI                                            |
| Biển số: 30A-999.99 | Ngày: Ngày mai | Khung giờ: 09:00     |
| Trạng thái: [ Đang chờ tiếp đón (Pending) ]                 |
+-------------------------------------------------------------+
```

### Thiết kế chi tiết cấu phần "Next Reward Progress"

Thanh tiến trình hiển thị động dựa trên hạng thẻ của khách hàng:

- **Phần trăm hoàn thành (**$P$**):** Được tính bằng công thức:$$P = \min\left(100\%, \frac{\text{Số lần rửa hiện tại}}{\text{Số lần rửa tiêu chuẩn của hạng kế tiếp}} \times 100\%\right)$$
- **Giao diện:** Một dải màu Gradient chuyển sắc từ xanh Cyan sang Deep Blue tượng trưng cho nước chảy sạch sẽ, chạy từ trái qua phải. Con số mục tiêu hiển thị rõ ràng dưới dạng số lần rửa còn lại hoặc số tiền còn lại.

### 2.3. Quy trình Đặt lịch từng bước (Booking Wizard UI)

Để đơn giản hóa và tăng tính chuẩn xác, quy trình đặt lịch được chia làm 4 bước rõ ràng:

### Bước 1: Chọn Xe

- **Giao diện:** Hiển thị danh sách các xe khách hàng đã đăng ký dưới dạng các thẻ (Cards) trực quan. Mỗi xe gồm Biển số xe và Dòng xe.
- **Hành động:** Khách hàng chạm chọn vào một chiếc xe $\rightarrow$ Hệ thống đánh dấu tích xanh lá và tự động chuyển sang Bước 2.

### Bước 2: Chọn Ngày

- **Giao diện:** Hiển thị một dải lịch ngang gồm 7 đến 14 ngày kế tiếp (Phụ thuộc vào đặc quyền của hạng thẻ: Member hiển thị 7 ngày, Silver 10 ngày, Gold 12 ngày, Platinum 14 ngày). Các ngày nằm ngoài phạm vi này sẽ bị vô hiệu hóa (Disabled/Làm mờ).
- **Hành động:** Khách hàng chạm chọn ngày $\rightarrow$ Hệ thống tự động chuyển sang Bước 3.

### Bước 3: Chọn Khung giờ trống (Time-slot)

- **Giao diện:** Danh sách các khung giờ (Ví dụ: `08:00 - 09:00`, `09:00 - 10:00`,...) được biểu thị bằng các hộp nút bấm tròn trịa.
    - Hộp màu trắng: Slot còn trống và sẵn sàng đặt.
    - Hộp màu xám kèm chữ "Hết chỗ": Slot đã đầy công suất (Đã bị xe khác đặt kín).
- **Hành động:** Khách hàng bấm chọn khung giờ trống $\rightarrow$ Chuyển sang Bước 4.

### Bước 4: Xác nhận thông tin (Review & Confirm)

- **Giao diện:** Bảng tổng hợp thông tin tóm tắt bao gồm:
    - *Xe đăng ký dịch vụ:* Biển số xe đã chọn.
    - *Thời gian hẹn:* Ngày và khung giờ đã chọn.
    - *Ưu đãi áp dụng:* Hệ số điểm dự kiến tích lũy dựa trên hạng thẻ hiện tại của khách hàng.
- **Hành động:** Khách hàng nhấn nút **"XÁC NHẬN ĐẶT LỊCH"** màu xanh dương lớn ở góc đáy màn hình. Hệ thống hiển thị hộp thoại pop-up thông báo đặt lịch thành công và tự động điều hướng khách hàng về lại màn hình Trang chủ.

## 3. GIAO DIỆN QUẢN TRỊ & NHÂN VIÊN (ADMIN/STAFF PORTAL - DESKTOP OPTIMIZED)

Giao diện quản trị được tối ưu hóa hiển thị trên màn hình rộng máy tính (Desktop) theo bố cục Sidebar để nhân viên tại quầy thao tác nhanh chóng và chính xác.

### 3.1. Bố cục Tổng quan (Sidebar Layout)

- **Sidebar trái (Chiều rộng 250px):** Chứa Logo hệ thống **AutoWash Pro** màu xanh Cyan sáng nổi bật trên nền xanh đậm. Bên dưới là menu dọc:
    1. Bảng điều khiển (Dashboard)
    2. Lịch đặt hôm nay (Bookings)
    3. Thanh toán nhanh (Checkout)
    4. Cấu hình Tiers (Settings)
- **Nội dung chính bên phải (Phần còn lại của màn hình):** Hiển thị các bảng số liệu, biểu đồ báo cáo và form thao tác.

### 3.2. Quy trình Tiếp đón & Checkout nhanh bằng Modal Popup

Đây là tính năng quan trọng giúp nhân viên ghi nhận và hoàn tất thanh toán rửa xe cho khách chỉ trong vài cú nhấp chuột mà không phải tải lại trang.

### Sơ đồ hoạt động của Modal Checkout Popup

Khi nhân viên bấm nút "Thực hiện thanh toán" trên danh sách lịch đặt:

```
+-----------------------------------------------------------------+
|                      XÁC NHẬN HOÀN THÀNH & THANH TOÁN           | [X]
+-----------------------------------------------------------------+
| Khách hàng: Nguyễn Văn Bình       | Biển số xe: 30A-999.99     |
| Hạng thẻ: GOLD (Multiplier: 1.2)  | Điểm hiện tại: 1.500 điểm   |
+-----------------------------------------------------------------+
|  Nhập tổng tiền hóa đơn (VNĐ):                                  |
|  [ 200.000                                                   ]  |
+-----------------------------------------------------------------+
|  Khách muốn đổi điểm lấy giảm giá?                             |
|  (Tối đa có thể đổi: 1.500 điểm ~ giảm 150.000 VNĐ)             |
|  Nhập số điểm muốn đổi:                                         |
|  [ 500                                                       ]  |
|  -> Số tiền giảm trừ: - 50.000 VNĐ                              |
+-----------------------------------------------------------------+
|  TỔNG TIỀN KHÁCH PHẢI TRẢ THỰC TẾ: 150.000 VNĐ                  |
|  ĐIỂM TÍCH LŨY MỚI SẼ CỘNG VÀO VÍ: +180 điểm                    |
+-----------------------------------------------------------------+
|        [ HỦY BỎ ]                       [ XÁC NHẬN THANH TOÁN ] |
+-----------------------------------------------------------------+
```

### Thuật toán tính toán trực quan realtime trong Modal (JavaScript):

1. Khi nhân viên nhập "Tổng tiền hóa đơn" ($A$) và "Số điểm muốn đổi" ($P_{\text{redeem}}$).
2. Hệ thống tính toán ngay lập tức số tiền giảm trừ:$$\text{Giảm trừ} = P_{\text{redeem}} \times 100\text{ VNĐ}$$
3. Tính số tiền thực thu:$$\text{Thực thu} = A - \text{Giảm trừ}$$
4. Tính điểm tích lũy mới được nhận dựa trên hệ số nhân của hạng (ví dụ hạng Gold multiplier là 1.2):$$\text{Điểm cộng mới} = \frac{\text{Thực thu}}{1.000} \times 1.2$$
5. Cập nhật hiển thị lên Modal để nhân viên và khách hàng đối soát trực quan trước khi nhấn "XÁC NHẬN THANH TOÁN".

### 3.3. Trang Báo cáo Thống kê (Reports View)

Trang này được tích hợp thư viện **Chart.js** (thư viện vẽ biểu đồ JavaScript siêu nhẹ và dễ nhúng vào JSP) để trực quan hóa dữ liệu kinh doanh của cửa hàng trước hội đồng chấm thi:

1. **Biểu đồ Doanh thu (Doanh thu theo tuần/tháng):** Biểu đồ dạng cột (Bar Chart) thể hiện sự tăng trưởng doanh thu theo từng ngày hoặc từng tuần gần nhất.
2. **Biểu đồ Cơ cấu Hạng thành viên (Tier Distribution):** Biểu đồ hình tròn (Pie Chart) thể hiện tỉ lệ phần trăm khách hàng trong hệ thống đang nắm giữ các hạng thẻ khác nhau (Member, Silver, Gold, Platinum). Giúp chủ cửa hàng nắm bắt được mức độ trung thành của tệp khách hàng.

## 4. GIAO DIỆN THÔNG BÁO (NOTIFICATION DROPDOWN UI)

Hệ thống thông báo được tích hợp tinh tế trên thanh Header của cả giao diện khách hàng và quản trị để tạo trải nghiệm liền mạch:

### 4.1. Biểu tượng Quả chuông (Header Bell Icon)

- Nằm ở góc trên bên phải màn hình. Có hiển thị một chấm tròn màu đỏ nhỏ biểu thị số lượng thông báo chưa đọc (Ví dụ: chấm đỏ có số `2` nghĩa là có 2 thông báo mới).

### 4.2. Danh sách Dropdown thả xuống (Dropdown List)

Khi người dùng nhấp chạm vào biểu tượng Quả chuông, một menu thả xuống mềm mại (`dropdown-menu` bo góc `rounded-2xl`) sẽ hiển thị danh sách 5 thông báo mới nhất:

```
+-------------------------------------------------------------+
| THÔNG BÁO MỚI NHẤT                                          |
+-------------------------------------------------------------+
| [Chấm Đỏ] Chúc mừng! Tài khoản của bạn đã được nâng lên      |
| hạng GOLD trong kỳ đánh giá tháng này.                      |
| (10 phút trước)                                             |
+-------------------------------------------------------------+
| [Chấm Đỏ] Nhắc lịch hẹn: Xe 30A-999.99 có lịch hẹn rửa vào  |
| lúc 09:00 hôm nay. Vui lòng đến đúng giờ!                   |
| (2 giờ trước)                                               |
+-------------------------------------------------------------+
| Xem tất cả thông báo                                        |
+-------------------------------------------------------------+
```

- **Hành động đọc thông báo:** Khi nhấp chuột vào một thông báo cụ thể $\rightarrow$ Hệ thống lập tức thực hiện truy vấn AJAX gửi về Servlet nhằm cập nhật trạng thái `IsRead = 1` trong database SQL Server, đồng thời chấm đỏ thông báo chưa đọc tương ứng trên quả chuông tự động biến mất.