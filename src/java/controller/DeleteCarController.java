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
 * DeleteCarController - Xử lý xóa xe của khách hàng.
 */
@WebServlet(name = "DeleteCarController", urlPatterns = {"/DeleteCarController"})
public class DeleteCarController extends HttpServlet {

    /**
     * LUỒNG XỬ LÝ 
     * 1. Đảm bảo mã hóa UTF-8 cho request/response.
     * 2. Kiểm tra đăng nhập: Lấy "USER" từ session. Nếu null, dùng response.sendRedirect("MainController?action=Login") để chuyển về trang đăng nhập.
     * 3. Lấy tham số: Đọc "txtcarid" gửi từ form bằng request.getParameter, parse sang kiểu int (plateId).
     * 4. Gọi tầng Service: Gọi CarService.deleteCar(userId, plateId) để xử lý xóa dưới DB.
     * 5. Xử lý thông báo (Flash Message):
     *    - Nếu thành công, setSessionAttribute("SUCCESS_CAR", "Xóa xe thành công!").
     *    - Nếu thất bại (catch Exception), setSessionAttribute("ERROR_CAR", e.getMessage()).
     * 6. Điều hướng: Dùng response.sendRedirect("MainController?action=ViewCars") để tránh lỗi Double Submit khi F5 trang.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Kiểm tra đăng nhập
            Customer us = (Customer) request.getSession().getAttribute("USER");
            if (us == null) {
                response.sendRedirect("MainController?action=Login");
                return;
            }
            
            // 2. Lấy tham số
            int plateId = Integer.parseInt(request.getParameter("txtcarid"));
            
            // 3. Gọi tầng Service
            CarService carService = new CarService();
            carService.deleteCar(us.getCusId(), plateId);
            
            request.getSession().setAttribute("SUCCESS_CAR", "Xóa xe thành công!");

        } catch (Exception e) {
            log("Error at DeleteCarController: " + e.toString());
            request.getSession().setAttribute("ERROR_CAR", e.getMessage());
        }

        // Luôn redirect về trang danh sách xe sau khi xử lý
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
