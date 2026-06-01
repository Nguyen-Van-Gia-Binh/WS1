# Lộ Trình Đào Tạo Backend: Java Web (Servlet & JSP & MVC)

Chào mừng bạn đến với lộ trình học tập được thiết kế riêng nhằm giúp bạn lấy lại nền tảng Backend Java Web. Chúng ta sẽ cùng nhau đi từ số 0, làm rõ bản chất của từng dòng code, và xây dựng lại dự án `DemoMVC2` này một cách chuyên nghiệp nhất.

---

## 📅 Lộ Trình Học Tập (7 Giai Đoạn)

### Giai Đoạn 1: Ôn Tập Nền Tảng Java Core & OOP
*Mục tiêu: Đảm bảo bạn nắm vững cách tổ chức code bằng đối tượng và cách lưu trữ dữ liệu.*
* **Kiến thức cốt lõi:**
  * 4 tính chất của OOP: Đóng gói (Encapsulation), Kế thừa (Inheritance), Đa hình (Polymorphism), Trừu tượng (Abstraction).
  * Cách thiết kế một Class, Constructor, và các phương thức getter/setter.
  * Sử dụng List & ArrayList để lưu trữ danh sách đối tượng (rất quan trọng khi truy vấn dữ liệu từ DB).
* **Bài tập thực hành:** Tạo lớp đối tượng `User` hoặc `Product` và quản lý danh sách của chúng bằng `ArrayList`.

### Giai Đoạn 2: Lập Trình Web Căn Bản (HTTP & Client-Server)
*Mục tiêu: Hiểu cách trình duyệt (Client) giao tiếp với Server.*
* **Kiến thức cốt lõi:**
  * Giao thức HTTP hoạt động như thế nào? (Request gửi gì lên? Response trả về gì?).
  * Sự khác biệt giữa phương thức **GET** và **POST** (Khi nào dùng GET? Khi nào dùng POST?).
  * Cấu trúc thẻ `<form>` trong HTML: Thuộc tính `action` và `method`.
  * Cách Server nhận dữ liệu thông qua tham số (Parameter).

### Giai Đoạn 3: Servlet & JSP Cực Chi Tiết
*Mục tiêu: Hiểu cấu phần quan trọng nhất của Java Web truyền thống.*
* **Servlet:**
  * Cách định cấu hình Servlet bằng `@WebServlet` hoặc `web.xml`.
  * Các hàm vòng đời của Servlet (`init`, `service`, `destroy`, `doGet`, `doPost`).
  * Sử dụng `HttpServletRequest` (lấy parameter, set attribute) và `HttpServletResponse` (ghi dữ liệu ra Client bằng `PrintWriter`, chuyển hướng trang).
* **JSP (JavaServer Pages):**
  * Bản chất của JSP (JSP thực ra sẽ được compile thành Servlet).
  * Cách nhúng mã Java vào JSP bằng **Scriptlet** (`<% %>`), **Expression** (`<%= %>`).
  * Cách đọc dữ liệu từ Servlet truyền sang thông qua `request.getAttribute()`.
* **Phân biệt cơ bản:**
  * **Forward** (`request.getRequestDispatcher().forward()`): Chuyển tiếp luồng xử lý trên Server (URL không đổi).
  * **Redirect** (`response.sendRedirect()`): Yêu cầu trình duyệt gửi request mới tới URL khác (URL thay đổi).

### Giai Đoạn 4: Giải Mã Mô Hỏi MVC & Front Controller Pattern (Áp dụng vào DemoMVC2)
*Mục tiêu: Hiểu sâu cấu trúc hiện tại của dự án.*
* **Mô hình MVC:**
  * **M (Model):** Lớp chứa dữ liệu và xử lý logic nghiệp vụ (hiện tại dự án chưa có).
  * **V (View):** Giao diện hiển thị tới người dùng (`index.jsp`, `error.jsp`).
  * **C (Controller):** Nhận request, điều phối luồng xử lý (`MainController`, `SearchController`, `GetProfileController`).
* **Front Controller Pattern:**
  * Tại sao cần `MainController`? (Làm đầu mối duy nhất nhận mọi request, kiểm tra bảo mật, định tuyến luồng xử lý trước khi forward sang các Controller con).
* **Thực hành sửa lỗi:**
  * Phát hiện và sửa lỗi cú pháp trong `index.jsp` hiện tại (thuộc tính `acction` viết sai chính tả dẫn đến không submit đúng địa chỉ).

### Giai Đoạn 5: Cơ Sở Dữ Liệu & JDBC (Kết Nối DB)
*Mục tiêu: Đưa dữ liệu thực tế vào dự án thay vì dữ liệu giả (hardcoded) hiện tại.*
* **Kiến thức cốt lõi:**
  * Thiết kế cơ sở dữ liệu quan hệ (SQL Server / MySQL).
  * Kết nối Database trong Java bằng JDBC: Nạp Driver, mở `Connection`, thực thi câu lệnh qua `PreparedStatement`, nhận kết quả từ `ResultSet`.
  * Thiết kế lớp tiện ích kết nối `DBUtils` sử dụng Singleton Pattern để tối ưu hóa kết nối.
  * **DAO Pattern (Data Access Object):** Viết các lớp chuyên tương tác với DB (ví dụ: `UserDAO`, `ProductDAO`).
  * **DTO Pattern (Data Transfer Object) / Model:** Class biểu diễn cấu trúc bảng trong DB dưới dạng Java Object.

### Giai Đoạn 6: Session Management & Filter (Xác thực và Phân quyền)
*Mục tiêu: Xây dựng tính năng Login và bảo vệ các trang admin.*
* **Cookie vs Session:** Cách lưu trạng thái đăng nhập của người dùng.
* **Filter:** Bộ lọc chặn các request chưa đăng nhập hoặc không đủ quyền trước khi tới Controller.

### Giai Đoạn 7: Thực Hành Tự Tay Code Lại DemoMVC2 Từ Đầu (Có Nâng Cấp)
*Mục tiêu: Tự tay bạn sẽ code từng dòng để hoàn thiện dự án.*
* Chúng ta sẽ tạo một database có bảng `tblUsers` (chứa username, password, fullName, roleID).
* Viết chức năng Login, Search User, Delete User, Update User (CRUD đầy đủ).
* Áp dụng Filter để bảo vệ trang Admin.

---

## 🛠️ Phương Pháp Đào Tạo (Học Qua Hành Động)

Trong suốt cuộc hội thoại này, chúng ta sẽ làm việc theo quy trình:
1. **Học Lý Thuyết Tinh Gọn:** Tôi giải thích ngắn gọn bản chất của một phần kiến thức.
2. **Ví Dụ Trực Quan:** Xem xét code thực tế trong dự án hiện tại hoặc viết ví dụ ngắn.
3. **Thực Hành Tự Tay Code:** Tôi đưa ra đề bài, bạn tự viết hoặc tôi hướng dẫn bạn viết vào file.
4. **Giải Thích & Sửa Lỗi:** Tôi sẽ kiểm tra code của bạn, phân tích lỗi nếu có, và tối ưu hóa cấu trúc.

---

## 🚀 Hãy Bắt Đầu Ngay!

Để chuẩn bị tốt nhất, bạn hãy cho tôi biết:
1. **Hệ quản trị cơ sở dữ liệu** bạn muốn sử dụng (ví dụ: SQL Server hay MySQL, v.v.)?
2. Bạn đã cài đặt **JDK, IDE (NetBeans/Eclipse/IntelliJ) và Database** sẵn sàng trên máy chưa?
3. Bạn muốn bắt đầu từ **Giai Đoạn 1 (Java OOP & ArrayList)** hay muốn chuyển tiếp ngay sang **Giai Đoạn 2/3 (Cơ chế hoạt động của Web, Servlet & JSP)**?
