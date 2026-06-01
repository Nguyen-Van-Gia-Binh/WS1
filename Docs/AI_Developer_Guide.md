# HƯỚNG DẪN PHÁT TRIỂN DỰ ÁN CHO AI (AI DEVELOPMENT BLUEPRINT & GUIDELINES)

> [!IMPORTANT]
> **DÀNH CHO AI ĐANG THỰC HIỆN DỰ ÁN AUTOWASH PRO:**
> File này chứa toàn bộ các chỉ thị, kiến trúc hệ thống, quy tắc viết code sạch, và thuật toán cốt lõi của dự án AutoWash Pro. AI phải đọc kỹ và tuân thủ nghiêm ngặt mọi quy tắc dưới đây khi nhận lệnh lập kế hoạch và lập trình. Tuyệt đối không tự ý thay đổi tech-stack hoặc bỏ qua các quy tắc này.

---

## 🎯 1. TƯ DUY & NGUYÊN TẮC CỐT LÕI (CORE PRINCIPLES)

Để giúp người dùng đọc hiểu mã nguồn và "học ngược" (reverse-learn) kiến trúc hệ thống một cách tốt nhất, AI phải luôn lập trình theo các nguyên tắc sau:

1. **Simplicity as Standard (Tối giản là tiêu chuẩn):**
   - Chỉ sử dụng các công nghệ cốt lõi của môn học **PRJ301**: **Java Servlet, JSP, JSTL, JDBC** kết hợp với **Maven**.
   - Tránh over-engineering (tránh dùng Spring Boot, Hibernate/JPA hoặc các thư viện quá phức tạp không có trong chương trình học).
2. **Clean & Extensible Code (Mã nguồn sạch & Dễ mở rộng):**
   - Áp dụng triệt để nguyên tắc **SOLID** (đặc biệt là Single Responsibility - mỗi lớp chỉ làm một nhiệm vụ) và **DRY** (Don't Repeat Yourself).
   - Đặt tên biến, hàm, class bằng **tiếng Anh** rõ nghĩa, mang tính mô tả cao (ví dụ: `pointsBalance` thay vì `pt`, `calculateNextReward` thay vì `tinhDiem`).
   - Đóng mở các tài nguyên Database (`Connection`, `PreparedStatement`, `ResultSet`) một cách an toàn bằng **`try-with-resources`** của Java 7+.
3. **Vietnamese Explanations & Comments (Giải thích tiếng Việt):**
   - Viết các comment (chú thích) trong code bằng **tiếng Việt có dấu** rõ ràng, tập trung giải thích *tại sao lại làm như vậy* (nhất là ở các thuật toán thăng hạng, tính điểm, và điều hướng Servlet).
   - Khi hoàn thành bất kỳ file nào, AI phải giải thích ngắn gọn luồng đi của dữ liệu (Data Flow) trong file đó để người dùng nắm vững kiến trúc.
4. **No Placeholders (Tuyệt đối không viết code giả/nửa vời):**
   - Không được viết các đoạn code dạng `// TODO: implement this`, `// ... code remains the same`.
   - Tất cả các class, method, trang JSP phải được viết **hoàn chỉnh 100%**, có đầy đủ logic xử lý lỗi (Exception Handling) và dữ liệu phản hồi thực tế để có thể chạy thử được ngay.

---

## 📂 2. BẢN ĐỒ KIẾN TRÚC & CẤU TRÚC THƯ MỤC (DIRECTORY BLUEPRINT)

Hệ thống bắt buộc phải triển khai theo mô hình **MVC (Model-View-Controller)** chia lớp rõ ràng. AI phải tuân thủ chính xác cấu trúc package dưới đây dưới thư mục `src/main/java/`:

```
com.autowash.autowashpro
│
├── 🔌 connection
│   └── DBContext.java                 # Quản lý kết nối SQL Server (JDBC) duy nhất
│
├── 📦 model
│   ├── Tier.java                      # Đại diện hạng thẻ (MEMBER, SILVER, GOLD, PLATINUM)
│   ├── User.java                      # Thông tin khách hàng, nhân viên, admin
│   ├── LicensePlate.java              # Danh sách biển số xe của khách
│   ├── Booking.java                   # Lịch đặt chỗ rửa xe
│   ├── LoyaltyTransaction.java        # Lịch sử tích/đổi điểm thưởng
│   └── Notification.java              # Hộp thư thông báo cá nhân
│
├── 🗃️ dao
│   ├── BaseDAO.java (Tùy chọn)        # Chứa các hàm JDBC bổ trợ dùng chung
│   ├── TierDAO.java
│   ├── UserDAO.java
│   ├── LicensePlateDAO.java
│   ├── BookingDAO.java
│   ├── LoyaltyTransactionDAO.java
│   └── NotificationDAO.java
│
├── ⚙️ service
│   ├── LoyaltyService.java            # Trái tim dự án: Thuật toán Loyalty Engine
│   └── BookingService.java            # Logic bổ trợ đặt lịch
│
├── 🎮 controller
│   ├── auth
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   └── LogoutServlet.java
│   ├── customer
│   │   ├── DashboardServlet.java      # Dashboard di động cho Khách
│   │   ├── BookingWizardServlet.java  # Đặt lịch 4 bước
│   │   ├── MyCarsServlet.java         # Quản lý biển số xe
│   │   └── NotificationServlet.java   # Đọc và cập nhật thông báo qua AJAX
│   └── admin
│       ├── AdminDashboardServlet.java # Dashboard máy tính cho Admin
│       ├── ManageBookingsServlet.java # Quản lý lịch hẹn
│       └── CheckoutServlet.java       # Thực hiện tiếp đón & thanh toán nhanh
│
└── 🛡️ filter
    └── AuthorizationFilter.java       # Bộ lọc phân quyền (Admin, Staff, Customer, Guest)
```

### Quy định về Frontend trong `src/main/webapp/`:
* Không tạo các tệp HTML tĩnh. Tất cả các trang giao diện phải sử dụng **JSP** kết hợp **JSTL** (`<c:forEach>`, `<c:if>`, `<c:choose>`) để render dữ liệu động.
* Sử dụng **Tailwind CSS qua CDN** để thiết kế giao diện hiện đại, bo góc lớn (`rounded-2xl`), chiều sâu mờ nhẹ (`shadow-md`).
* Sử dụng **Chart.js CDN** trên các trang Dashboard để trực quan hóa số liệu.

---

## 🗄️ 3. ĐẶC TẢ CƠ SỞ DỮ LIỆU & ÁNH XẠ (DATABASE & JDBC MAPPING)

AI phải sử dụng đúng cấu trúc database dưới đây để xây dựng các lớp **Model** và các câu truy vấn SQL trong **DAO**:

### Hệ thống 6 Bảng Cốt Lõi:
1. `Tiers` (`TierId` VARCHAR(20) PK, `TierName` NVARCHAR(50), `MinWashes` INT, `MinSpent` DECIMAL, `Multiplier` FLOAT, `BookingDays` INT)
2. `Users` (`UserId` INT IDENTITY PK, `PhoneNumber` VARCHAR(15) UNIQUE, `Password` VARCHAR(255), `FullName` NVARCHAR(100), `Role` VARCHAR(20), `CurrentTierId` VARCHAR(20) FK, `PointsBalance` INT, `TotalSpent` DECIMAL, `TotalWashes` INT, `CreatedAt` DATETIME)
3. `LicensePlates` (`PlateId` INT IDENTITY PK, `UserId` INT FK, `PlateNumber` VARCHAR(20) UNIQUE, `VehicleModel` NVARCHAR(100), `CreatedAt` DATETIME)
4. `Bookings` (`BookingId` INT IDENTITY PK, `UserId` INT FK, `PlateId` INT FK, `BookingDate` DATE, `TimeSlot` VARCHAR(20), `Status` VARCHAR(20) [PENDING, COMPLETED, CANCELLED], `Notes` NVARCHAR(255), `CreatedAt` DATETIME)
5. `LoyaltyTransactions` (`TransactionId` INT IDENTITY PK, `UserId` INT FK, `Type` VARCHAR(10) [EARN, REDEEM], `Points` INT, `RelatedBillAmount` DECIMAL, `CreatedAt` DATETIME)
6. `Notifications` (`NotificationId` INT IDENTITY PK, `UserId` INT FK, `Title` NVARCHAR(150), `Content` NVARCHAR(MAX), `IsRead` BIT, `CreatedAt` DATETIME)

---

## 🧠 4. ĐẶC TẢ THUẬT TOÁN NGHIỆP VỤ CỐT LÕI (LOYALTY ENGINE)

Đây là phần quan trọng nhất tạo nên điểm nhấn công nghệ cho đồ án. AI phải hiện thực hóa chính xác các thuật toán sau:

### 4.1. Thuật toán Tiến trình Phần thưởng Kế tiếp (Next Reward Progress)
Được viết tại `LoyaltyService.java` để hiển thị trực quan lên giao diện Dashboard khách hàng:
* **Hệ số quy đổi:**
  - $1\text{ điểm tích lũy} = 100\text{ VNĐ}$ giảm giá khi thanh toán.
  - Tỉ lệ tích điểm cơ sở: Chi tiêu $1.000\text{ VNĐ}$ thực tế sẽ nhận được $1\text{ điểm}$ cơ sở.
* **Hệ số nhân tích điểm (Multiplier) dựa trên hạng thẻ:**
  - Hạng `MEMBER`: Multiplier = `1.0`
  - Hạng `SILVER`: Multiplier = `1.1`
  - Hạng `GOLD`: Multiplier = `1.2`
  - Hạng `PLATINUM`: Multiplier = `1.3`
* **Thuật toán tính phần trăm tiến trình ($P$):**
  - Hệ thống tính toán động dựa trên trạng thái của khách hàng đối chiếu với điều kiện duy trì/nâng hạng kế tiếp trong bảng `Tiers`:
    - Nếu hạng hiện tại là `MEMBER` $\rightarrow$ Mục tiêu kế tiếp là `SILVER` (Yêu cầu: $5$ lần rửa HOẶC $2.000.000\text{ VNĐ}$ chi tiêu).
    - Nếu hạng hiện tại là `SILVER` $\rightarrow$ Mục tiêu kế tiếp là `GOLD` (Yêu cầu: $15$ lần rửa HOẶC $6.000.000\text{ VNĐ}$ chi tiêu).
    - Nếu hạng hiện tại là `GOLD` $\rightarrow$ Mục tiêu kế tiếp là `PLATINUM` (Yêu cầu: $30$ lần rửa HOẶC $15.000.000\text{ VNĐ}$ chi tiêu).
  - **Công thức tính % động:**
    $$\text{Phần trăm theo lượt rửa } (p_{\text{wash}}) = \min\left(100\%, \frac{\text{TotalWashes}}{\text{TargetWashes}} \times 100\%\right)$$
    $$\text{Phần trăm theo chi tiêu } (p_{\text{spent}}) = \min\left(100\%, \frac{\text{TotalSpent}}{\text{TargetSpent}} \times 100\%\right)$$
    $$P = \max(p_{\text{wash}}, p_{\text{spent}}) \text{ (Lấy chỉ số nào gần đạt được nhất để khuyến khích khách hàng)}$$
  - **Dòng thông báo động (Visual Text):** Hiển thị rõ số lượng lượt rửa còn lại và số tiền chi tiêu còn lại cần đạt được.
    - *Ví dụ:* `"Bạn chỉ còn cách hạng Silver [X] lượt rửa hoặc [Y] VNĐ chi tiêu để nhận ưu đãi nhân 1.1 lần điểm thưởng!"`
  - *Trường hợp hạng hiện tại là `PLATINUM` (Đỉnh):* Đặt mục tiêu tiếp theo là "Quà Nano Cơ Bản" (đạt mốc đổi $300$ điểm). Tính phần trăm dựa trên $PointsBalance / 300$.

### 4.2. Thuật toán Tiếp đón & Checkout Realtime (Modal Popup)
Được triển khai bằng sự kết hợp giữa **JavaScript Realtime** ở View và **Transaction SQL** ở Backend khi nhân viên ấn nút thanh toán trên Desktop:
1. **Phía Giao diện (JavaScript trong Modal):**
   - Khi nhân viên nhập *Tổng tiền hóa đơn gốc* ($A$) và *Số điểm muốn đổi* ($P_{\text{redeem}}$).
   - Hệ thống tự động tính toán realtime trên màn hình:
     - Số tiền giảm trừ: $D = P_{\text{redeem}} \times 100\text{ VNĐ}$.
     - Số tiền thực thu (phải trả thực tế): $T = \max(0, A - D)$.
     - Điểm tích lũy mới được nhận: $P_{\text{earn}} = \text{round}\left( \frac{T}{1000} \times \text{Multiplier} \right)$.
     - Hiển thị trực tiếp các con số này lên Modal trước khi nhân viên nhấn xác nhận.
2. **Phía Server (Java Transaction):**
   - Nhận dữ liệu thanh toán gửi lên Servlet. Phải thực hiện một **Database Transaction** bao gồm các bước sau để đảm bảo tính toàn vẹn dữ liệu:
     a. Cập nhật `Status = 'COMPLETED'` cho bản ghi `Bookings`.
     b. Khấu trừ điểm đã đổi và cộng điểm mới tích lũy vào ví của Khách hàng:
        $$\text{PointsBalance}_{\text{mới}} = \text{PointsBalance}_{\text{hiện tại}} - P_{\text{redeem}} + P_{\text{earn}}$$
     c. Cộng dồn số tiền thực tế chi tiêu và số lần rửa của khách:
        $$\text{TotalSpent}_{\text{mới}} = \text{TotalSpent}_{\text{hiện tại}} + T$$
        $$\text{TotalWashes}_{\text{mới}} = \text{TotalWashes}_{\text{hiện tại}} + 1$$
     d. Chèn bản ghi lịch sử vào bảng `LoyaltyTransactions` (Kiểu `REDEEM` nếu có đổi điểm, và kiểu `EARN` cho điểm tích lũy mới).
     e. **Quy tắc tự động nâng hạng thẻ (Upgrade Rules):** So sánh `TotalWashes_mới` và `TotalSpent_mới` với bảng cấu hình `Tiers` để tự động cập nhật hạng thẻ mới cao hơn cho người dùng (nếu đủ điều kiện).
     f. Tạo bản ghi thông báo tự động (bảng `Notifications`) gửi tới Khách hàng nếu họ được thăng hạng hoặc hoàn tất thanh toán thành công.

### 4.3. AJAX & Trạng thái Thông báo (Notification Bell)
* Biểu tượng quả chuông ở Header có chấm đỏ hiển thị số lượng thông báo chưa đọc.
* Khi người dùng click vào quả chuông, hiển thị Dropdown gồm danh sách các thông báo mới nhất.
* Khi người dùng click vào một thông báo cụ thể $\rightarrow$ Sử dụng **AJAX fetch** gửi request bất đồng bộ lên `NotificationServlet` để cập nhật trạng thái `IsRead = 1` trong database, đồng thời biến mất chấm đỏ tương ứng trên giao diện một cách mượt mà mà không phải load lại trang.

---

## 📱 5. THIẾT KẾ QUY TRÌNH ĐẶT LỊCH TỪNG BƯỚC (BOOKING WIZARD)

AI phải xây dựng giao diện Đặt lịch theo quy trình Wizard 4 bước (Mobile-First):

1. **Bước 1: Chọn Xe:** Hiển thị danh sách xe đã đăng ký dưới dạng Cards trực quan. Bắt buộc có **Regex validation** cho biển số xe Việt Nam khi khách hàng thêm xe mới:
   - *Regex Việt Nam:* `^\d{2}[A-Z]\d{1}-\d{4,5}$|^\d{2}[A-Z]\d{1}-\d{3}\.\d{2}$` (Ví dụ hợp lệ: `30A1-1234`, `51F1-999.99`, `43C2-88888`).
2. **Bước 2: Chọn Ngày:** Dựa trên hạng thành viên của Session hiện tại để giới hạn số lượng ngày được phép đặt trước (`BookingDays`):
   - `MEMBER`: Được chọn tối đa 7 ngày kế tiếp.
   - `SILVER`: Được chọn tối đa 10 ngày kế tiếp.
   - `GOLD`: Được chọn tối đa 12 ngày kế tiếp.
   - `PLATINUM`: Được chọn tối đa 14 ngày kế tiếp.
   - Các ngày vượt quá giới hạn phải bị disabled (làm mờ).
3. **Bước 3: Chọn Khung Giờ (Time-slot):** Hiển thị danh sách các khung giờ cố định dưới dạng nút bấm. Gửi request bất đồng bộ check số lượng xe đã đặt trong ngày đó. Nếu slot đã đạt công suất giới hạn $\rightarrow$ Hiển thị trạng thái "Hết chỗ" (Disabled).
4. **Bước 4: Xác nhận thông tin:** Hiển thị bảng tổng hợp chi tiết (Biển số xe, Ngày giờ hẹn, Hệ số tích điểm dự kiến). Nút "XÁC NHẬN ĐẶT LỊCH" kích hoạt gửi POST dữ liệu và mở Modal Popup thông báo thành công trước khi chuyển hướng về Dashboard.

---

## 🛠️ 6. QUY TRÌNH THỰC HIỆN TỪNG BƯỚC CHO AI (STEP-BY-STEP PLAN)

Khi được giao nhiệm vụ triển khai dự án này, AI nên tự động phân rã công việc và thực hiện tuần tự theo lộ trình tuyến tính dưới đây:

```
[Giai đoạn 1: Database & Config]
      └── Tạo CSDL SQL Server -> Chèn cấu hình Tiers -> Cập nhật pom.xml (JDBC, JSTL, Gson).
[Giai đoạn 2: Model & Connection]
      └── Viết DBContext.java -> Viết hàm test main kết nối -> Tạo 6 lớp Model Entity.
[Giai đoạn 3: DAO - Data Access Object]
      └── Viết UserDAO, TierDAO, LicensePlateDAO, BookingDAO, NotificationDAO, TransactionDAO.
[Giai đoạn 4: Service - Loyalty Engine]
      └── Thiết lập LoyaltyService.java với thuật toán thăng hạng và tính % tiến trình Next Reward.
[Giai đoạn 5: Authorization & Filters]
      └── Viết AuthorizationFilter.java phân quyền các thư mục /customer/, /admin/ và các trang khách.
[Giai đoạn 6: Controller & View (Khách hàng)]
      └── Viết DashboardServlet, BookingWizardServlet, MyCarsServlet -> Thiết kế giao diện JSP tương ứng + Tailwind CSS.
[Giai đoạn 7: Controller & View (Admin/Staff)]
      └── Viết CheckoutServlet, AdminDashboardServlet, ManageBookingsServlet -> Thiết kế giao diện Desktop.
[Giai đoạn 8: JavaScript & AJAX Polishing]
      └── Viết JS Realtime Checkout, AJAX Notification IsRead, AJAX check time-slot trống.
```

---

## 💬 7. HƯỚNG DẪN PROMPT AI ĐỂ THỰC THI (META-PROMPT FOR USER)

**Cách sử dụng file hướng dẫn này để ra lệnh cho AI:**
Bạn có thể copy toàn bộ nội dung file này hoặc chỉ định AI đọc file này bằng lệnh:
> *"Hãy đọc file tài liệu [AI_Developer_Guide.md](file:///c:/Users/nguye/Documents/Summer_2026/CSD/CSD_Code_Template/AutoWashPro/Docs/AI_Developer_Guide.md). Sau đó, hãy lập kế hoạch thực hiện phân rã các bước và tiến hành lập trình chi tiết từng phần theo cấu trúc và các nguyên tắc sạch, tối giản được mô tả trong tài liệu này để giúp tôi vừa chạy được code vừa học hỏi ngược lại kiến trúc hệ thống."*
