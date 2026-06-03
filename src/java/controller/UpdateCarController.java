package controller;

import dto.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CarService;

/**
 * UpdateCarController - Xử lý chỉnh sửa thông tin xe của khách hàng.
 */
@WebServlet(name = "UpdateCarController", urlPatterns = {"/UpdateCarController"})
public class UpdateCarController extends HttpServlet {

    /**
     * LUỒNG XỬ LÝ VÀ CÂU HỎI VẤN ĐÁP (SỬA/CẬP NHẬT XE):
     * 1. Đảm bảo mã hóa UTF-8 cho request/response.
     * 2. Kiểm tra đăng nhập: Lấy "USER" từ session. Nếu null, dùng response.sendRedirect("MainController?action=Login") để chuyển về trang đăng nhập.
     * 3. Lấy tham số:
     *    - ID xe cần sửa: "txtcarid" (parse sang int).
     *    - Các thông tin mới: Biển số xe ("txtlicenseplate"), Hãng xe ("txtbrand"), Dòng xe ("txtmodel"), Màu xe ("txtcolor").
     * 4. Gọi tầng Service: Gọi CarService.updateCar(userId, plateId, licensePlate, brand, model, color) để xử lý.
     * 5. Xử lý thông báo (Flash Message):
     *    - Nếu thành công, setSessionAttribute("SUCCESS_CAR", "Cập nhật thông tin xe " + biển số + " thành công!").
     *    - Nếu thất bại (catch Exception), setSessionAttribute("ERROR_CAR", e.getMessage()).
     * 6. Điều hướng: Dùng response.sendRedirect("MainController?action=ViewCars") để tránh lỗi Double Submit khi F5 trang.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            /*
             * LUỒNG XỬ LÝ VÀ YÊU CẦU NGHIỆP VỤ (HỖ TRỢ VẤN ĐÁP):
             * 1. Kiểm tra đăng nhập:
             *    - Lấy đối tượng USER từ Session. Nếu chưa đăng nhập (null), dùng sendRedirect về trang Login và kết thúc.
             * 2. Đọc dữ liệu cập nhật từ Form (JSP):
             *    - "txtcarid": ID xe cần sửa (được gửi từ thẻ input hidden trong form sửa xe).
             *    - "txtlicenseplate": Biển số xe mới nhập.
             *    - "txtbrand", "txtmodel", "txtcolor": Hãng xe, dòng xe, màu sắc xe mới.
             * 3. Gọi tầng nghiệp vụ (Service):
             *    - Gọi phương thức updateCar(...) trong CarService để tiến hành xác thực dữ liệu và ghi nhận vào Database.
             *    - Việc truyền cả `us.getCusId()` (ID khách hàng đang đăng nhập) là cực kỳ quan trọng để đảm bảo tính phân quyền
             *      (chỉ được sửa xe của chính mình, tránh trường hợp tấn công thay đổi ID xe của người khác).
             * 4. Lưu thông báo trạng thái (Flash Message):
             *    - Định dạng tạm thời biển số xe để hiển thị: `licensePlate.trim().toUpperCase()`.
             *    - Lưu thông báo thành công vào Session (SUCCESS_CAR) để trang JSP cars.jsp hiển thị thông báo bật lên (Toast).
             * 5. Catch Exception:
             *    - Nếu xảy ra lỗi (như biển số không đúng định dạng Việt Nam, hoặc biển số bị trùng với xe khác trong DB),
             *      bắt Exception và lưu chuỗi thông báo lỗi tiếng Việt thân thiện vào Session (ERROR_CAR).
             * 6. Phản hồi chuyển hướng (Redirect):
             *    - Sử dụng `response.sendRedirect` để bắt trình duyệt load lại trang xem danh sách xe mới nhất.
             *    - TẠI SAO DÙNG REDIRECT? Tránh trường hợp user bấm F5 gây gửi lại request sửa đổi lần nữa (Double Submit).
             */
            // BƯỚC 1: Kiểm tra đăng nhập từ Session
            // - Lấy đối tượng USER từ session. Nếu null (chưa đăng nhập), chuyển hướng (redirect) về trang Login.
            Customer us = (Customer) request.getSession().getAttribute("USER");
            if (us == null) {
                response.sendRedirect("MainController?action=Login");
                return;
            }

            // BƯỚC 2: Nhận và đọc các thông số cập nhật xe từ form Client gửi lên
            // - Nhận các tham số ID xe, biển số mới, hãng xe, dòng xe, màu xe.
            int plateId = Integer.parseInt(request.getParameter("txtcarid"));
            String licensePlate = request.getParameter("txtlicenseplate");
            String brand        = request.getParameter("txtbrand");
            String model        = request.getParameter("txtmodel");
            String color        = request.getParameter("txtcolor");

            // BƯỚC 3: Gọi tầng nghiệp vụ (CarService) để kiểm tra validation và cập nhật xe
            // - Truyền ID khách hàng đăng nhập để đảm bảo tính sở hữu đối với xe được chỉnh sửa.
            CarService carService = new CarService();
            carService.updateCar(us.getCusId(), plateId, licensePlate, brand, model, color);
            
            // BƯỚC 4: Đặt thông báo thành công vào Session
            String plateFormatted = licensePlate != null ? licensePlate.trim().toUpperCase() : "";
            request.getSession().setAttribute("SUCCESS_CAR", "Cập nhật thông tin xe " + plateFormatted + " thành công!");

        } catch (Exception e) {
            log("Error at UpdateCarController: " + e.toString());
            // BƯỚC 5: Đặt thông báo lỗi từ Exception vào Session nếu xảy ra lỗi
            request.getSession().setAttribute("ERROR_CAR", e.getMessage());
        }

        // BƯỚC 6: Luôn chuyển hướng (redirect) về trang danh sách xe sau khi xử lý
        // - Tránh lỗi gửi trùng lặp request khi người dùng tải lại trang (Double Submit).
        response.sendRedirect("MainController?action=ViewCars");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
