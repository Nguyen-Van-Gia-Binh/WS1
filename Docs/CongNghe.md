Dựa trên các tài liệu SRS và Design bạn đã chuẩn bị rất chi tiết, cùng với yêu cầu tiên quyết của môn học **PRJ301**, đây là bộ công nghệ (Tech Stack) tối ưu và phù hợp nhất để hiện thực hóa dự án **AutoWash Pro**.

Bộ công nghệ này đảm bảo tính "Simplicity" (Đơn giản là tiêu chuẩn) nhưng vẫn đáp ứng đầy đủ các logic phức tạp về phân hạng thành viên và đặt lịch.

---

## 1. Backend: Java Web Core

Đây là trái tim của dự án, tuân thủ nghiêm ngặt yêu cầu sử dụng Java trong chương trình học.

* **Ngôn ngữ:** **Java 8** hoặc **Java 11+**.
* **Công nghệ cốt lõi:** **Java Servlet & JSP**. Đây là yêu cầu bắt buộc để xử lý logic nghiệp vụ và điều hướng người dùng.
* **Thư viện hỗ trợ:**
* **JSTL (JavaServer Pages Standard Tag Library):** Để xử lý các vòng lặp hiển thị danh sách xe hoặc lịch đặt trực tiếp trên JSP mà không cần viết code Java thuần (Scriptlets).
* **Lombok:** Giúp mã nguồn gọn gàng hơn bằng cách tự động tạo Getter/Setter cho các Model (User, Booking, Tier).
* **Gson hoặc Jackson:** Cần thiết cho tính năng thông báo và cập nhật trạng thái `IsRead` qua AJAX như đã mô tả trong tài liệu Design.



## 2. Database: Quản trị Dữ liệu Quan hệ

Dữ liệu của hệ thống AutoWash Pro có tính liên kết chặt chẽ (Users - Tiers - Bookings), vì vậy một hệ quản trị CSDL quan hệ là lựa chọn duy nhất.

* **Hệ quản trị:** **Microsoft SQL Server**.
* **Kết nối:** **JDBC (Java Database Connectivity)**. Để đạt điểm cao về kiến trúc, bạn nên áp dụng **DAO (Data Access Object) Pattern** kết hợp với một **DBContext** dùng chung để quản lý kết nối.
* **Thiết kế:** Triển khai đúng 6 bảng đã đặc tả, chú trọng vào các khóa ngoại để đảm bảo tính toàn vẹn khi thực hiện tính năng hạ hạng (Downgrade Rules).

## 3. Frontend: Responsive & Modern UI

Tài liệu Design của bạn đã sử dụng các mã màu và lớp (class) đặc trưng của **Tailwind CSS**. Để giữ đúng tinh thần này:

* **Framework CSS:** **Tailwind CSS** (sử dụng qua CDN cho nhanh hoặc cài đặt qua PostCSS để tối ưu). Tailwind giúp bạn dễ dàng tạo các thẻ (Cards) bo góc `rounded-2xl` và thanh điều hướng đáy (Bottom Nav) cho Mobile.
* **Biểu đồ (Dashboard):** **Chart.js**. Thư viện này cực kỳ nhẹ và tương thích tốt với dữ liệu trả về từ Servlet dưới dạng JSON để vẽ biểu đồ doanh thu và cơ cấu hạng thành viên.
* **Icons:** **Lucide React** hoặc **FontAwesome** để hiển thị các biểu tượng lịch hẹn, xe, và quả chuông thông báo.

---

## 4. Công cụ & Môi trường Phát triển

Để đảm bảo dự án chạy ổn định và dễ dàng Demo trước hội đồng:

* **Web Server:** **Apache Tomcat 9.x** (hoặc bản phù hợp với môi trường Lab của trường).
* **Quản lý thư viện:** **Maven**. Sử dụng `pom.xml` để quản lý SQL Driver, JSTL và các thư viện phụ trợ khác.
* **Kiểm thử API:** **Postman** để test các Servlet trước khi ghép giao diện JSP.

---

## 5. Tóm tắt Kiến trúc Hệ thống (MVC)

Hệ thống sẽ được chia thành các lớp rõ rệt để tối ưu điểm "Kiến trúc mã nguồn":

| Lớp (Layer)    | Công nghệ / Thành phần        | Chức năng                                                       |
| ----------------| -------------------------------| -----------------------------------------------------------------|
| **View**       | JSP, Tailwind CSS, Chart.js   | Hiển thị giao diện Mobile cho khách và Desktop cho Admin.       |
| **Controller** | Java Servlets & Filters       | Tiếp nhận Request, kiểm tra Session (Phân quyền) và điều hướng. |
| **Service**    | Plain Old Java Objects (POJO) | Chứa thuật toán "Loyalty Engine" (Tính điểm, nâng hạng).        |
| **Repository** | DAO Pattern (JDBC)            | Thực hiện các câu lệnh SQL để truy vấn/cập nhật Database.       |

> **Lưu ý quan trọng:** Vì hệ thống có các công thức tính toán động (ví dụ: tiến trình thăng hạng $P$), hãy đảm bảo logic này được viết ở lớp **Service** để có thể tái sử dụng cả ở trang Dashboard và trang Checkout.

$$P = \min\left(100\%, \frac{\text{Số lần rửa hiện tại}}{\text{Số lần rửa tiêu chuẩn}} \times 100\%\right)$$
