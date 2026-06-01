## HỆ THỐNG QUẢN LÝ RỬA XE TỰ ĐỘNG THÔNG MINH (AUTOWASH PRO)

## 1. TỔNG QUAN DỰ ÁN (PROJECT OVERVIEW)

### 1.1. Giới thiệu hệ thống

**AutoWash Pro** là một ứng dụng Web-App Responsive (tương thích cả Desktop và Mobile) được thiết kế nhằm hiện đại hóa quy trình đặt lịch rửa xe, tự động hóa quản lý khách hàng thân thiết (Loyalty Program), và tối ưu hóa hiệu suất vận hành của cửa hàng rửa xe ô tô.

Dự án được tinh giản tối đa các tích hợp phần cứng hoặc AI phức tạp, thay vào đó tập trung vào tính chính xác của thuật toán phân hạng thành viên, tính nhất quán của dữ liệu đặt lịch, và trải nghiệm người dùng mượt mà trên nền tảng **Java Servlet/JSP** và cơ sở dữ liệu **SQL Server**.

### 1.2. Đối tượng sử dụng (Target Users)

- **Khách hàng (Customer):** Chủ sở hữu ô tô đăng ký tài khoản trên hệ thống để quản lý xe, theo dõi điểm thưởng, nhận thông báo hạng thành viên và tiến hành đặt lịch hẹn trước dựa trên mức ưu tiên của hạng thẻ.
- **Quản trị viên / Nhân viên (Admin/Staff):** Chủ cửa hàng hoặc nhân viên vận hành sử dụng để xác nhận đặt lịch, nhập thông tin xe đến rửa, ghi nhận giao dịch, thiết lập cấu hình điểm/khuyến mãi, và xem báo cáo doanh thu.

### 1.3. Phạm vi hệ thống (Scope)

- Phát triển duy nhất **một ứng dụng Web Responsive** phục vụ cả giao diện khách hàng (giao diện tối ưu cho di động) và giao diện quản trị (tối ưu cho máy tính).
- Các chức năng như thanh toán trực tuyến, nhận diện biển số bằng camera (LPR OCR), gửi tin nhắn SMS/Email được giả lập (Mock) thông qua logic nghiệp vụ nội bộ của hệ thống nhằm đảm bảo dự án chạy độc lập và ổn định.

## 2. ĐẶC TẢ YÊU CẦU CHỨC NĂNG (FUNCTIONAL REQUIREMENTS)

### 2.1. Quản lý Tài khoản & Hồ sơ Khách hàng

### 2.1.1. Đăng ký / Đăng nhập

- Hỗ trợ đăng ký tài khoản khách hàng thông qua số điện thoại (làm mã định danh chính) và mật khẩu.

### 2.1.2. Quản lý Biển số xe (Multi-vehicle registration)

- Một tài khoản khách hàng có thể đăng ký và quản lý **nhiều biển số xe** khác nhau.
- Khi người dùng thêm mới hoặc cập nhật biển số, hệ thống sẽ thực hiện kiểm tra định dạng (Validation) tự động bằng biểu thức chính quy (Regex) để đảm bảo dữ liệu đầu vào chuẩn hóa theo quy chuẩn biển số xe Việt Nam.
- *Regex kiểm tra định dạng biển số xe Việt Nam gợi ý:*$$\text{Regex: } \text{/^\d{2}[A-Z]\d{1}-\d{4,5}$|^\d{2}[A-Z]\d{1}-\d{3}\.\d{2}$/}$$
    
    *(Ví dụ hợp lệ: `30A1-1234`, `51F1-999.99`, `43C2-88888`)*
    

### 2.1.3. Giao diện Hồ sơ Khách hàng (Customer Profile Dashboard - Workshop 1)

Để tạo động lực cho khách hàng tiếp tục sử dụng dịch vụ, giao diện chính sau khi khách hàng đăng nhập phải hiển thị trực quan 3 thông tin cốt lõi:

1. **Hạng thành viên hiện tại (Current Tier):** * Hiển thị rõ tên hạng thẻ kèm theo thẻ màu sắc tương ứng (ví dụ: Đồng cho Member, Bạc cho Silver, Vàng cho Gold, Bạch kim cho Platinum).
    - Hiển thị danh sách quyền lợi mà khách hàng đang được hưởng (Hệ số nhân điểm, số ngày được phép đặt lịch trước).
2. **Số dư điểm thưởng (Points Balance):**
    - Hiển thị rõ tổng số điểm hiện tại khách hàng đang sở hữu kèm theo giá trị quy đổi tương đương tiền mặt khi thanh toán ($1\text{ điểm} = 100\text{ VNĐ}$).
3. **Tiến trình đến phần thưởng kế tiếp (Next Reward Progress):**
    - **Khái niệm:** Hệ thống tính toán động dựa trên trạng thái tích lũy của khách hàng để hiển thị những gì họ cần đạt được để nhận được đặc quyền tiếp theo (Thăng hạng hoặc mốc đổi quà lớn).
    - **Thuật toán hiển thị "Next Reward" chi tiết:**
        - **Trường hợp hạng hiện hành là MEMBER:**
            - *Mục tiêu kế tiếp:* Lên hạng **SILVER**.
            - *Tính toán:* $$\text{Cần thêm} = \max(0, 5 - \text{TotalWashes}) \text{ lượt rửa}$$$$\text{HOẶC}$$$$\text{Cần thêm} = \max(0, 2.000.000 - \text{TotalSpent}) \text{ VNĐ}$$
            - *Hiển thị trên giao diện:* Thanh tiến trình (Progress Bar) thể hiện % hoàn thành mục tiêu nào gần đạt được nhất và dòng chữ: *"Bạn chỉ còn cách hạng Silver [X] lượt rửa hoặc [Y] VNĐ chi tiêu để nhận ưu đãi nhân 1.1 lần điểm thưởng!"*.
        - **Trường hợp hạng hiện hành là SILVER:**
            - *Mục tiêu kế tiếp:* Lên hạng **GOLD**.
            - *Tính toán:*$$\text{Cần thêm} = \max(0, 15 - \text{TotalWashes}) \text{ lượt rửa}$$$$\text{HOẶC}$$$$\text{Cần thêm} = \max(0, 6.000.000 - \text{TotalSpent}) \text{ VNĐ}$$
            - *Hiển thị trên giao diện:* *"Bạn chỉ còn cách hạng Gold [X] lượt rửa hoặc [Y] VNĐ chi tiêu để nhận ngay đặc quyền đặt lịch trước 12 ngày và 01 lần nâng cấp dịch vụ miễn phí mỗi tháng!"*.
        - **Trường hợp hạng hiện hành là GOLD:**
            - *Mục tiêu kế tiếp:* Lên hạng **PLATINUM**.
            - *Tính toán:*$$\text{Cần thêm} = \max(0, 30 - \text{TotalWashes}) \text{ lượt rửa}$$$$\text{HOẶC}$$$$\text{Cần thêm} = \max(0, 15.000.000 - \text{TotalSpent}) \text{ VNĐ}$$
            - *Hiển thị trên giao diện:* *"Bạn chỉ còn cách hạng Platinum [X] lượt rửa hoặc [Y] VNĐ chi tiêu để nhận ngay ưu đãi cao nhất: đặt lịch trước 14 ngày và tặng 01 lần rửa xe miễn phí mỗi tháng!"*.
        - **Trường hợp hạng hiện hành là PLATINUM (Đã đạt đỉnh):**
            - *Mục tiêu kế tiếp:* Khuyến khích đổi điểm thưởng lấy quà hiện vật/dịch vụ giá trị cao.
            - *Ví dụ phần quà mốc:* Gói phủ Nano sáp cao cấp (Trị giá $300\text{ điểm}$).
            - *Tính toán:*$$\text{Tiến trình đổi quà} = \min\left(100\%, \frac{\text{PointsBalance}}{300} \times 100\%\right)$$
            - *Hiển thị trên giao diện:* *"Bạn đang sở hữu [PointsBalance]/300 điểm để đổi ngay 01 lần Phủ Wax/Nano miễn phí trị giá 50.000 VNĐ!"* (Kèm nút bấm Đổi Quà).

### 2.2. Động cơ Loyalty & Quản lý Phân hạng (Loyalty Engine)

Hệ thống Loyalty là trái tim của đồ án, chịu trách nhiệm tự động hóa việc tính điểm, quy đổi điểm và cập nhật hạng thẻ của khách hàng.

### A. Quy tắc Tích lũy Điểm (Earning Points)

- Điểm được tích lũy dựa trên số tiền chi tiêu thực tế của khách hàng tại cửa hàng.
- Công thức tích lũy điểm cơ bản:$$\text{Số điểm tích lũy} = \frac{\text{Số tiền thanh toán (VNĐ)}}{1.000}$$
    
    *(Ví dụ: Khách hàng chi tiêu* $150.000\text{ VNĐ}$ *sẽ nhận được* $150\text{ điểm}$*)*
    
- **Hệ số nhân điểm theo hạng (Tier Multipliers):**
    - **Member:** Không nhân (Hệ số $1.0$) $\rightarrow$ Tiêu $1.000\text{ VNĐ}$ nhận $1.0\text{ điểm}$.
    - **Silver:** Nhân thêm $10\%$ (Hệ số $1.1$) $\rightarrow$ Tiêu $1.000\text{ VNĐ}$ nhận $1.1\text{ điểm}$.
    - **Gold:** Nhân thêm $20\%$ (Hệ số $1.2$) $\rightarrow$ Tiêu $1.000\text{ VNĐ}$ nhận $1.2\text{ điểm}$.
    - **Platinum:** Nhân thêm $30\%$ (Hệ số $1.3$) $\rightarrow$ Tiêu $1.000\text{ VNĐ}$ nhận $1.3\text{ điểm}$.

### B. Quy tắc Đổi Điểm (Redeeming Points)

- Khách hàng có thể dùng điểm tích lũy để quy đổi thành giá trị giảm giá trực tiếp cho hóa đơn rửa xe hiện tại.
- Công thức quy đổi giá trị điểm:$$\text{Giá trị giảm giá (VNĐ)} = \text{Số điểm quy đổi} \times 100$$
    
    *(Ví dụ: Khách hàng yêu cầu đổi* $300\text{ điểm}$ *tích lũy sẽ được giảm giá trực tiếp* $30.000\text{ VNĐ}$ *vào hóa đơn thanh toán)*
    

### C. Quy trình Nâng hạng / Hạ hạng (Tier Transitions State Machine)

- **Chu kỳ đánh giá:** Định kỳ vào ngày đầu tiên của mỗi tháng (Monthly Review), hệ thống sẽ quét toàn bộ dữ liệu lịch sử của khách hàng để cập nhật lại hạng thành viên.
- **Tiêu chuẩn phân hạng:**
    
    
    | **Hạng (Tier)** | **Điều kiện duy trì / nâng hạng (Trong vòng 30 ngày gần nhất)** | **Quyền lợi đi kèm** |
    | --- | --- | --- |
    | **Member** | Mặc định sau khi đăng ký tài khoản thành công | Tích điểm hệ số $1.0$, đặt lịch trước tối đa 7 ngày |
    | **Silver** | Đạt tối thiểu **5 lần rửa** HOẶC tổng chi tiêu đạt từ **2.000.000 VNĐ** | Tích điểm hệ số $1.1$, đặt lịch trước tối đa 10 ngày |
    | **Gold** | Đạt tối thiểu **15 lần rửa** HOẶC tổng chi tiêu đạt từ **6.000.000 VNĐ** | Tích điểm hệ số $1.2$, đặt lịch trước tối đa 12 ngày |
    | **Platinum** | Đạt tối thiểu **30 lần rửa** HOẶC tổng chi tiêu đạt từ **15.000.000 VNĐ** | Tích điểm hệ số $1.3$, đặt lịch trước tối đa 14 ngày |
- **Quy tắc hạ hạng (Downgrade Rules):**
    - Nếu trong tháng đánh giá khách hàng không đạt đủ điều kiện của hạng hiện tại $\rightarrow$ Khách hàng sẽ bị **giảm tối đa 1 hạng thành viên** cho tháng tiếp theo.
    - **Tuyệt đối không tụt thẳng về Member**.
        
        *(Ví dụ: Một khách hàng đang có hạng Platinum, nếu tháng vừa rồi không phát sinh lượt rửa nào, hệ thống chỉ hạ cấp xuống Gold chứ không hạ thẳng xuống Member)*
        

```
[Member] <=============> [Silver] <=============> [Gold] <=============> [Platinum]
          (Nâng/Hạ 1 cấp)          (Nâng/Hạ 1 cấp)         (Nâng/Hạ 1 cấp)
```

### 2.3. Quy trình Đặt lịch (Advance Booking Rules)

Hệ thống áp dụng chính sách mở băng thời gian đặt lịch (Booking Window) linh hoạt dựa trên hạng thành viên để tạo ra đặc quyền cho các hạng thẻ cao hơn:

- **Hạng Platinum:** Được đặt lịch trước tối đa **14 ngày**.
- **Hạng Gold:** Được đặt lịch trước tối đa **12 ngày**.
- **Hạng Silver:** Được đặt lịch trước tối đa **10 ngày**.
- **Hạng Member:** Được đặt lịch trước tối đa **7 ngày**.

**Quy trình nghiệp vụ đơn giản hóa:**

1. Khách hàng chọn một trong các biển số xe đã đăng ký của mình.
2. Khách hàng chọn ngày và khung giờ (Time-slot) mong muốn dựa trên giới hạn ngày đặt lịch cho phép của hạng thẻ của họ.
3. Hệ thống hiển thị trạng thái khả dụng của khung giờ. Nếu còn slot trống, khách hàng nhấn xác nhận đặt lịch.
4. Lịch đặt sẽ chuyển sang trạng thái `PENDING` (Chờ tiếp đón).

### 2.4. Hệ thống Thông báo Nội bộ (In-app Notification System)

- Loại bỏ hoàn toàn tích hợp SMS/Email/OTP để giảm tải kỹ thuật.
- Mọi thông báo đều được lưu trữ trực tiếp trong cơ sở dữ liệu và hiển thị qua một giao diện "Hộp thư thông báo" trên Web-App của khách hàng.
- **Các sự kiện bắt buộc gửi thông báo:**
    - **Thăng hạng / Hạ hạng:** *"Chúc mừng! Tài khoản của bạn đã được nâng lên hạng Gold"* hoặc *"Tài khoản của bạn đã được điều chỉnh về hạng Silver trong kỳ đánh giá tháng này"*.
    - **Nhắc nhở lịch hẹn:** Tự động gửi thông báo nhắc lịch hẹn trước khi khung giờ đặt bắt đầu khoảng 2 tiếng.

### 2.5. Giao diện Quản trị & Báo cáo (Admin Controls)

- **Tiếp tiếp đón & Ghi nhận hóa đơn:**
    - Khi khách hàng lái xe đến, nhân viên nhập thủ công biển số xe của khách lên hệ thống.
    - Hệ thống tự động kiểm tra xem biển số này có khớp với lịch đặt `PENDING` nào trong khung giờ hiện tại không.
    - Nhân viên xác nhận hoàn thành dịch vụ, nhập số tiền thanh toán thực tế và số điểm khách muốn đổi (nếu có). Hệ thống tự động tính điểm mới, cộng dồn vào ví điểm của khách hàng và cập nhật lịch đặt sang trạng thái `COMPLETED`.
- **Cấu hình hệ thống:** Cho phép Admin thay đổi các giá trị cấu hình cơ bản (Tỷ lệ tích điểm, tỷ lệ quy đổi điểm, số ngày đặt lịch trước của từng hạng) mà không cần can thiệp vào mã nguồn.
- **Báo cáo hệ thống (Reports):**
    - Thống kê số lượng khách hàng mới đăng ký theo khoảng thời gian.
    - Thống kê doanh thu theo ngày/tháng.
    - Thống kê cơ cấu tỷ lệ khách hàng theo các nhóm hạng (Member, Silver, Gold, Platinum).

## 3. YÊU CẦU PHI CHỨC NĂNG (NON-FUNCTIONAL REQUIREMENTS - NFR)

- **NFR-01: Response Time (Thời gian phản hồi):** Hệ thống Web phải phản hồi các yêu cầu tải trang, truy vấn lịch đặt, thông tin hạng thẻ dưới $3$ giây trong điều kiện tải bình thường.
- **NFR-02: Booking Processing (Tốc độ xử lý đặt lịch):** Thao tác lưu trữ đặt lịch, tính toán kiểm tra trùng lặp slot và trừ/cộng điểm phải được thực hiện đồng bộ trong một Transaction duy nhất với thời gian xử lý dưới $2$ giây.
- **NFR-03: Concurrent Users (Người dùng đồng thời):** Hệ thống đáp ứng tối thiểu 100 người dùng truy cập đồng thời mà không xảy ra tình trạng sập luồng (Thread pool starvation) trong môi trường Tomcat.
- **NFR-04: System Availability (Độ khả dụng):** Đạt mức 99% uptime trong điều kiện chạy thử nghiệm cục bộ.
- **NFR-05: Data Backup (Sao lưu dữ liệu):** Thiết lập tệp script SQL Server tự động phục hồi cấu trúc DB và dữ liệu mẫu bất cứ lúc nào phục vụ cho buổi thuyết trình bảo vệ đồ án.

## 4. THIẾT KẾ CƠ SỞ DỮ LIỆU CHI TIẾT (DATABASE SCHEMA)

Dưới đây là thiết kế chi tiết hệ thống bảng quan hệ trong **SQL Server**. Các mối quan hệ khóa ngoại được thiết lập chặt chẽ nhằm bảo đảm tính toàn vẹn của dữ liệu.

### 4.1. Sơ đồ thực thể quan hệ (ERD Logical Entities)

- Một `Users` có nhiều `LicensePlates` (1 - N)
- Một `Users` thuộc về một `Tiers` (N - 1)
- Một `Bookings` liên kết với một `Users` và một `LicensePlates` cụ thể.
- Một `Users` có nhiều `LoyaltyTransactions` (1 - N)
- Một `Users` nhận nhiều `Notifications` (1 - N)

### 4.2. Đặc tả cấu trúc các bảng dữ liệu

### Bảng 1: `Tiers` (Quản lý thông tin hạng thành viên)

| **Tên cột**   | **Kiểu dữ liệu** | **Ràng buộc**          | **Mô tả**                                               |
| ---------------| ------------------| ------------------------| ---------------------------------------------------------|
| `TierId`      | `VARCHAR(20)`    | `PRIMARY KEY`          | Định danh hạng (`MEMBER`, `SILVER`, `GOLD`, `PLATINUM`) |
| `TierName`    | `NVARCHAR(50)`   | `NOT NULL`             | Tên hiển thị hạng thành viên                            |
| `MinWashes`   | `INT`            | `NOT NULL`             | Số lần rửa tối thiểu để duy trì/nâng hạng               |
| `MinSpent`    | `DECIMAL(18,2)`  | `NOT NULL`             | Số tiền chi tiêu tối thiểu để duy trì/nâng hạng         |
| `Multiplier`  | `FLOAT`          | `NOT NULL DEFAULT 1.0` | Hệ số tích lũy điểm                                     |
| `BookingDays` | `INT`            | `NOT NULL`             | Số ngày được phép đặt lịch trước                        |

### Bảng 2: `Users` (Thông tin tài khoản khách hàng và nhân viên)

| **Tên cột**     | **Kiểu dữ liệu** | **Ràng buộc**                          | **Mô tả**                                       |
| -----------------| ------------------| ----------------------------------------| -------------------------------------------------|
| `UserId`        | `INT`            | `IDENTITY(1,1) PRIMARY KEY`            | Khóa chính tự tăng                              |
| `PhoneNumber`   | `VARCHAR(15)`    | `UNIQUE NOT NULL`                      | Số điện thoại đăng nhập chính                   |
| `Password`      | `VARCHAR(255)`   | `NOT NULL`                             | Mật khẩu đã được băm (BCrypt/SHA-256)           |
| `FullName`      | `NVARCHAR(100)`  | `NOT NULL`                             | Họ và tên khách hàng/nhân viên                  |
| `Role`          | `VARCHAR(20)`    | `NOT NULL DEFAULT 'CUSTOMER'`          | Vai trò hệ thống (`ADMIN`, `STAFF`, `CUSTOMER`) |
| `CurrentTierId` | `VARCHAR(20)`    | `FOREIGN KEY REFERENCES Tiers(TierId)` | Hạng thẻ hiện tại của khách hàng                |
| `PointsBalance` | `INT`            | `NOT NULL DEFAULT 0`                   | Số điểm tích lũy hiện có                        |
| `TotalSpent`    | `DECIMAL(18,2)`  | `NOT NULL DEFAULT 0`                   | Tổng chi tiêu tích lũy trọn đời                 |
| `TotalWashes`   | `INT`            | `NOT NULL DEFAULT 0`                   | Tổng số lần rửa xe trọn đời                     |
| `CreatedAt`     | `DATETIME`       | `DEFAULT GETDATE()`                    | Ngày đăng ký tài khoản                          |

### Bảng 3: `LicensePlates` (Danh sách xe đã đăng ký của khách hàng)

| **Tên cột** | **Kiểu dữ liệu** | **Ràng buộc** | **Mô tả** |
| --- | --- | --- | --- |
| `PlateId` | `INT` | `IDENTITY(1,1) PRIMARY KEY` | Khóa chính tự tăng |
| `UserId` | `INT` | `FOREIGN KEY REFERENCES Users(UserId)` | Chủ sở hữu xe |
| `PlateNumber` | `VARCHAR(20)` | `UNIQUE NOT NULL` | Biển số xe (VD: `30A-123.45`) |
| `VehicleModel` | `NVARCHAR(100)` | `NULL` | Tên dòng xe (VD: *Toyota Camry*) |
| `CreatedAt` | `DATETIME` | `DEFAULT GETDATE()` | Ngày đăng ký biển số |

### Bảng 4: `Bookings` (Thông tin lịch đặt rửa xe)

| **Tên cột** | **Kiểu dữ liệu** | **Ràng buộc** | **Mô tả** |
| --- | --- | --- | --- |
| `BookingId` | `INT` | `IDENTITY(1,1) PRIMARY KEY` | Khóa chính tự tăng |
| `UserId` | `INT` | `FOREIGN KEY REFERENCES Users(UserId)` | Khách hàng thực hiện đặt lịch |
| `PlateId` | `INT` | `FOREIGN KEY REFERENCES LicensePlates(PlateId)` | Biển số xe thực hiện dịch vụ |
| `BookingDate` | `DATE` | `NOT NULL` | Ngày hẹn rửa xe |
| `TimeSlot` | `VARCHAR(10)` | `NOT NULL` | Khung giờ hẹn (VD: `08:00-09:00`) |
| `Status` | `VARCHAR(20)` | `NOT NULL DEFAULT 'PENDING'` | Trạng thái đặt (`PENDING`, `COMPLETED`, `CANCELLED`) |
| `Notes` | `NVARCHAR(255)` | `NULL` | Ghi chú từ khách hàng |
| `CreatedAt` | `DATETIME` | `DEFAULT GETDATE()` | Thời điểm tạo yêu cầu đặt lịch |

### Bảng 5: `LoyaltyTransactions` (Nhật ký giao dịch tích/tiêu điểm)

| **Tên cột** | **Kiểu dữ liệu** | **Ràng buộc** | **Mô tả** |
| --- | --- | --- | --- |
| `TransactionId` | `INT` | `IDENTITY(1,1) PRIMARY KEY` | Khóa chính tự tăng |
| `UserId` | `INT` | `FOREIGN KEY REFERENCES Users(UserId)` | Khách hàng thực hiện giao dịch |
| `Type` | `VARCHAR(10)` | `NOT NULL` | Loại giao dịch: `EARN` (Tích điểm) hoặc `REDEEM` (Tiêu điểm) |
| `Points` | `INT` | `NOT NULL` | Số điểm biến động (+ hoặc -) |
| `RelatedBillAmount` | `DECIMAL(18,2)` | `NOT NULL` | Số tiền hóa đơn thực tế liên quan |
| `CreatedAt` | `DATETIME` | `DEFAULT GETDATE()` | Thời điểm phát sinh giao dịch |

### Bảng 6: `Notifications` (Thông báo nội bộ gửi cho người dùng)

| **Tên cột** | **Kiểu dữ liệu** | **Ràng buộc** | **Mô tả** |
| --- | --- | --- | --- |
| `NotificationId` | `INT` | `IDENTITY(1,1) PRIMARY KEY` | Khóa chính tự tăng |
| `UserId` | `INT` | `FOREIGN KEY REFERENCES Users(UserId)` | Khách hàng nhận thông báo |
| `Title` | `NVARCHAR(150)` | `NOT NULL` | Tiêu đề thông báo |
| `Content` | `NVARCHAR(MAX)` | `NOT NULL` | Chi tiết nội dung thông báo |
| `IsRead` | `BIT` | `NOT NULL DEFAULT 0` | Trạng thái đã đọc hay chưa (0: Chưa, 1: Rồi) |
| `CreatedAt` | `DATETIME` | `DEFAULT GETDATE()` | Thời điểm gửi thông báo |

## 5. THIẾT KẾ KIẾN TRÚC & ÁNH XẠ SERVLET (ARCHITECTURE & SERVLET MAPPING)

Hệ thống được thiết kế theo mô hình kiến trúc chuẩn **MVC (Model-View-Controller)** sử dụng mô hình lập trình hướng đối tượng có phân lớp logic rõ ràng để dễ bảo trì, chấm điểm thi đạt tối đa điểm kiến trúc mã nguồn.

```
+-------------------------------------------------------------+
|                        JSP View                             | (Giao diện hiển thị HTML/CSS/Tailwind)
+------------------------------+------------------------------+
                               | Gửi Request / Nhận Response
                               v
+------------------------------+------------------------------+
|                    Controller / Servlet                     | (Nhận Parameter, điều hướng luồng)
+------------------------------+------------------------------+
                               | Gọi nghiệp vụ kinh doanh
                               v
+------------------------------+------------------------------+
|                       Service Layer                         | (Logic nâng/hạ hạng, tính điểm, kiểm tra slot)
+------------------------------+------------------------------+
                               | Truy cập dữ liệu thông qua Object
                               v
+------------------------------+------------------------------+
|                    Repository / DAO Layer                   | (Tương tác trực tiếp SQL bằng JDBC)
+------------------------------+------------------------------+
                               | Thực thi câu lệnh SQL
                               v
+------------------------------+------------------------------+
|                      SQL Server Database                    |
+-------------------------------------------------------------+
```

### 5.1. Danh sách các Servlet phân quyền chính

Hệ thống sử dụng cơ chế bảo mật lọc (`Filter` hoặc kiểm tra `Session` trực tiếp trong Servlet) để bảo vệ các tài nguyên quản trị.

### A. Nhóm chức năng Khách hàng (Customer)

- `/register` (`RegisterServlet`): Xử lý đăng ký tài khoản khách hàng mới.
- `/login` (`LoginServlet`): Xác thực tài khoản khách hàng và quản trị viên, lưu thông tin vào Session.
- `/customer/dashboard` (`DashboardServlet`): Giao diện chính của khách hàng hiển thị: Hạng thẻ hiện tại, số điểm tích lũy, đặc quyền hạng, tiến trình phần thưởng kế tiếp (Next Reward), danh sách xe đã đăng ký, và lịch sử đặt lịch gần đây.
- `/customer/plates` (`LicensePlateServlet`): Thêm mới, chỉnh sửa, xóa biển số xe thuộc tài khoản. Chứa logic Regex định dạng biển số xe.
- `/customer/booking` (`BookingServlet`):
    - `GET`: Hiển thị form đặt lịch, kiểm tra hạng thẻ của user đăng nhập để giới hạn số ngày đặt lịch tối đa (`BookingDays`).
    - `POST`: Lưu thông tin đặt lịch vào database, kiểm tra không cho đặt trùng slot của cùng một xe hoặc quá tải công suất của cửa hàng.
- `/customer/notifications` (`NotificationServlet`): Hiển thị danh sách thông báo và cập nhật trạng thái `IsRead = 1` khi khách hàng nhấn xem.

### B. Nhóm chức năng Quản trị (Admin/Staff)

- `/admin/dashboard` (`AdminDashboardServlet`): Hiển thị báo cáo thống kê trực quan (Doanh thu ngày, số lượng đơn đặt hôm nay, tỷ lệ phân chia hạng thẻ khách hàng).
- `/admin/bookings` (`AdminBookingManageServlet`):
    - Danh sách các lịch đặt cần phục vụ trong ngày.
    - Hỗ trợ nhân viên tìm kiếm lịch hẹn theo biển số xe nhập thủ công.
- `/admin/checkout` (`CheckoutServlet`):
    - Xác nhận hoàn thành việc rửa xe.
    - Nhập số tiền thực tế hóa đơn.
    - Nhập số điểm khách hàng muốn trừ (Kiểm tra `PointsBalance` của khách hàng có đủ điều kiện áp dụng hay không).
    - Thực hiện đồng bộ việc trừ điểm/cộng điểm mới, ghi nhận hóa đơn vào `LoyaltyTransactions` và lưu doanh thu.

## 6. KỊCH BẢN DEMO TỪNG BƯỚC (DEMO FLOW SCENARIOS)

Để có một buổi bảo vệ đồ án ấn tượng trước hội đồng giám khảo, nhóm nên thực hiện demo hệ thống theo luồng kịch bản tuyến tính logic dưới đây:

### Bước 1: Khách hàng mới đăng ký tài khoản

- **Hành động:** Người dùng truy cập trang Web, chọn đăng ký tài khoản với số điện thoại và họ tên.
- **Trạng thái hệ thống:** * Tài khoản được tạo thành công với hạng mặc định là **Member** (`PointsBalance = 0`, `CurrentTierId = 'MEMBER'`).
- **Đăng ký xe:** Người dùng truy cập phần "Quản lý xe", thêm mới biển số xe `30A-999.99` (Kiểm tra hệ thống hoạt động của tính năng định dạng Regex).

### Bước 2: Đặt lịch hẹn và Kiểm định giới hạn đặt trước (Booking Window)

- **Hành động:** * Đăng nhập tài khoản khách hàng mới tạo (Hạng Member $\rightarrow$ Giới hạn đặt lịch 7 ngày).
    - Khi khách hàng mở lịch chọn ngày hẹn, hệ thống chỉ cho phép chọn các ngày trong phạm vi từ ngày hiện tại cộng thêm tối đa 7 ngày nữa (Các ngày sau đó bị làm mờ/khóa).
    - Khách hàng chọn lịch hẹn vào ngày mai lúc `09:00 - 10:00` cho biển số xe `30A-999.99`.

### Bước 3: Nhân viên đón khách tại cửa hàng & Ghi nhận hóa đơn

- **Hành động:**
    - Khách hàng lái xe đến cửa hàng vào ngày mai. Nhân viên trực tại quầy đăng nhập tài khoản quyền Admin/Staff, tìm kiếm thông tin biển số xe `30A-999.99` trên hệ thống.
    - Hệ thống tự động hiển thị lịch đặt ở trạng thái `PENDING` khớp với khung giờ hiện hành.
    - Nhân viên xác nhận rửa xe thành công, tiến hành tạo hóa đơn thanh toán trị giá **2.000.000 VNĐ** (Để kích hoạt nâng hạng nhanh lên Silver).
- **Trạng thái tính toán của hệ thống:**
    - Tính điểm tích lũy: Khách hạng Member có hệ số multiplier là $1.0$.
    - Số điểm nhận được:$$\text{Points Earned} = \frac{2.000.000}{1.000} \times 1.0 = 2.000\text{ điểm}$$
    - Ví điểm của khách hàng cập nhật từ $0 \rightarrow 2.000\text{ điểm}$. Tổng chi tiêu tích lũy được cập nhật lên $2.000.000\text{ VNĐ}$.

### Bước 4: Chạy Trigger quét phân hạng tháng (Giả lập Monthly Review)

- **Hành động:**
    - Để minh họa tính năng "Monthly Review" mà không cần đợi đến cuối tháng, Admin nhấn một nút chức năng ẩn trên bảng điều khiển quản trị: *"Chạy quét đánh giá hạng thành viên tháng"*.
- **Trạng thái hệ thống:**
    - Hệ thống quét lịch sử chi tiêu của khách hàng trong 30 ngày qua (Tổng chi tiêu đạt $2.000.000\text{ VNĐ}$ $\rightarrow$ Thỏa mãn tiêu chuẩn thăng hạng **Silver**).
    - Cập nhật `CurrentTierId` của tài khoản sang `SILVER`.
    - Tự động ghi một bản tin vào bảng `Notifications` để gửi thông báo chúc mừng thăng hạng cho khách hàng.

### Bước 5: Kiểm chứng quyền lợi hạng Silver mới của Khách hàng

- **Hành động:**
    - Khách hàng đăng nhập lại tài khoản của mình.
    - **Xem thông báo:** Thấy thông báo thăng hạng lên Silver xuất hiện trong phần Hộp thư của Web-App.
    - **Thử nghiệm Đặt lịch mới:** Khách hàng tiến hành đặt lịch tiếp theo. Hệ thống lúc này tự động nhận diện tài khoản hạng Silver và mở rộng phạm vi đặt trước lên tối đa **10 ngày** (Nhỉnh hơn 3 ngày so với hạng Member trước đó).
    - **Thử nghiệm đổi điểm:** Khách hàng đặt lịch thành công và đến cửa hàng rửa lần 2 với hóa đơn trị giá **100.000 VNĐ**. Lần này khách hàng yêu cầu đổi **500 điểm** tích lũy để nhận giảm giá.
    - **Trạng thái tính toán của hệ thống:**
        - Giá trị giảm giá nhận được:$$\text{Discount} = 500 \times 100\text{ VNĐ} = 50.000\text{ VNĐ}$$
        - Khách hàng chỉ cần trả tiền mặt: $100.000 - 50.000 = 50.000\text{ VNĐ}$.
        - Điểm dư trong ví khách hàng cập nhật về: $2.000 - 500 = 1.500\text{ điểm}$.
        - Hệ thống tính tiếp điểm tích lũy mới dựa trên số tiền khách hàng chi trả thực tế ($50.000\text{ VNĐ}$): Với hạng Silver (Multiplier = 1.1):$$\text{New Points Earned} = \frac{50.000}{1.000} \times 1.1 = 55\text{ điểm}$$
        - Số dư điểm cuối cùng: $1.500 + 55 = 1.555\text{ điểm}$.

## 7. KẾT LUẬN & ĐÁNH GIÁ CHUYÊN MÔN

Tài liệu này đã bao quát đầy đủ, cụ thể mọi khía cạnh logic nghiệp vụ thực tế của dự án **AutoWash Pro**. Bằng việc tinh giản các cấu phần phần cứng, AI và di động phức tạp, dự án của bạn giờ đây đã có:

1. **Tính khả thi tuyệt đối (100% Feasibility):** Có thể triển khai nhanh chóng và hoàn thành xuất sắc trong thời gian quy định của một đồ án môn học PRJ301.
2. **Logic nghiệp vụ sâu sắc:** Hệ thống xếp hạng thành viên, chuyển trạng thái hạ hạng cuốn chiếu, điều chỉnh hệ số nhân điểm và mở rộng ô đặt lịch tuyến tính tạo ra một bài toán lập trình hướng đối tượng cực kỳ chặt chẽ và thuyết phục các thầy cô trong hội đồng chấm thi.
3. **Thiết kế DB tối ưu:** Cấu trúc dữ liệu chuẩn hóa 3NF, loại bỏ hoàn toàn các trường dữ liệu dư thừa và thiết lập khóa ngoại liên kết trực quan.