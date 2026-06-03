# KẾ HOẠCH ÔN TẬP backend SIÊU TỐC (60 PHÚT)

Dành riêng cho việc chuẩn bị buổi vấn đáp (thẩm vấn) ngày mai. Tập trung hoàn toàn vào **Backend, Logic xử lý và Kết nối**.

---

## ⏰ Phân Bổ Thời Gian (60 Phút)

### 📌 Phần 1: Kết Nối Cơ Sở Dữ Liệu & JDBC (15 phút)
* **Mục tiêu:** Hiểu rõ cấu trúc hàm kết nối, cách thực hiện câu lệnh SQL, và giải thích được các đối tượng JDBC.
* **Câu hỏi cô giáo hay hỏi:**
  1. Dòng `Class.forName("...")` dùng làm gì? (Nạp driver JDBC vào bộ nhớ).
  2. Khác biệt giữa `Statement` và `PreparedStatement`? (PreparedStatement biên dịch trước câu lệnh SQL, chống SQL Injection, chạy nhanh hơn khi thực thi nhiều lần nhờ cơ chế cache execution plan).
  3. `executeUpdate()` khác gì `executeQuery()`? (ExecuteUpdate trả về số dòng bị ảnh hưởng - INSERT/UPDATE/DELETE. ExecuteQuery trả về đối tượng `ResultSet` chứa dữ liệu truy vấn - SELECT).
  4. Tại sao lại dùng cấu trúc `try-with-resources`? (Để Java tự động đóng `Connection`, `PreparedStatement`, `ResultSet` khi chạy xong, tránh rò rỉ bộ nhớ/kết nối).
* **Bài tập thực hành:** Viết lại phương thức `createCustomer` và `getCustomerByPhoneAndPassword` từ con số 0 trong file [PracticeDAO.java](file:///c:/Users/nguye/Documents/Summer_2026/PRJ/WS1AutoCarProject/src/java/practice/PracticeDAO.java).

---

### 📌 Phần 2: Luồng Đi Của Request & Front Controller Pattern (15 phút)
* **Mục tiêu:** Giải thích được đường đi của một request từ trình duyệt -> Controller -> Service -> DAO -> Database -> Trả về View.
* **Câu hỏi cô giáo hay hỏi:**
  1. Front Controller Pattern là gì? Tại sao dùng `MainController`? (Là điểm tiếp nhận duy nhất cho mọi request từ Client. Giúp quản lý tập trung, dễ phân quyền, lọc dữ liệu, tránh việc khai báo quá nhiều servlet lộn xộn).
  2. Phân biệt `RequestDispatcher.forward()` và `HttpServletResponse.sendRedirect()`?
     * **Forward:** Chuyển tiếp luồng xử lý trên server. URL trên trình duyệt **không đổi**. Chỉ mất **1 request/response**. Chia sẻ được dữ liệu thông qua `request.setAttribute()`.
     * **Redirect:** Phản hồi về client mã 302 bắt client gửi một request mới tới URL khác. URL trên trình duyệt **thay đổi**. Tốn **2 request/response**. Không giữ được dữ liệu trong request scope cũ.
  3. Cách lấy dữ liệu từ Form gửi lên? (`request.getParameter("name_cua_input")`).
* **Bài tập thực hành:** Hoàn thành code định tuyến trong file [PracticeMainController.java](file:///c:/Users/nguye/Documents/Summer_2026/PRJ/WS1AutoCarProject/src/java/practice/PracticeMainController.java).

---

### 📌 Phần 3: Tách Biệt Tầng Logic (Service) & Validation (15 phút)
* **Mục tiêu:** Giải thích lý do tại sao không viết trực tiếp logic nghiệp vụ vào Controller hay DAO, mà phải tách ra Service.
* **Câu hỏi cô giáo hay hỏi:**
  1. Tại sao lại cần tầng `Service` khi đã có `DAO`? (DAO chỉ làm nhiệm vụ thô: lấy/ghi dữ liệu vào DB. Service là nơi chứa "luật chơi" - nghiệp vụ kinh doanh, validate dữ liệu, kiểm tra quyền, tính toán loyalty. Giúp code tái sử dụng được và độc lập với Database).
  2. Cách validate dữ liệu phía Backend (ví dụ: Biển số xe hoặc số điện thoại dùng Regex)?
* **Bài tập thực hành:** Viết logic kiểm tra định dạng biển số xe và ném ngoại lệ (`Exception`) trong file [PracticeCarService.java](file:///c:/Users/nguye/Documents/Summer_2026/PRJ/WS1AutoCarProject/src/java/practice/PracticeCarService.java).

---

### 📌 Phần 4: Giả Định Vấn Đáp & Hỏi Xoáy Đáp Xoay (15 phút)
* Tôi sẽ đóng vai cô giáo hỏi ngẫu nhiên các câu hỏi liên quan đến code dự án của bạn. Bạn sẽ trả lời bằng từ ngữ của bạn, tôi sẽ sửa và chỉnh lại câu chữ sao cho "chuyên nghiệp" và "đúng ý" giảng viên nhất.

---

## 🛠️ Hướng Dẫn Thực Hành

Để không làm hỏng code hiện tại của dự án (đang chạy tốt), anh đã tạo các file thực hành trống có tiếp đầu ngữ `Practice` trong package `practice` và `controller`. 

Nhiệm vụ của em:
1. Mở file thực hành ra.
2. Viết code vào các khu vực ghi chú `// TODO: VIẾT CODE Ở ĐÂY`.
3. Nhắn cho anh để anh kiểm tra, giải thích chi tiết ý nghĩa từng dòng và sửa lỗi cho em.

*Hãy bắt đầu ngay với **Phần 1: Kết nối DB và viết DAO**!*
