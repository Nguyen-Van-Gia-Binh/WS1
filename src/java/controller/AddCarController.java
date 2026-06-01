package controller;

import dao.CarDAO;
import dto.Car;
import dto.Customer;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AddCarController - Xử lý thêm mới xe cho khách hàng đang đăng nhập.
 * Luồng: car_page.jsp (POST form) → MainController (action=AddCar) → AddCarController → redirect ViewCars
 */
@WebServlet(name = "AddCarController", urlPatterns = {"/AddCarController"})
public class AddCarController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // Kiểm tra đăng nhập
            Customer us = (Customer) request.getSession().getAttribute("USER");
            if (us == null) {
                response.sendRedirect("login_page.jsp");
                return;
            }

            String licensePlate = request.getParameter("txtlicenseplate");
            String brand        = request.getParameter("txtbrand");
            String model        = request.getParameter("txtmodel");
            String color        = request.getParameter("txtcolor");

            // Validate biển số không rỗng
            if (licensePlate == null || licensePlate.trim().isEmpty()) {
                request.getSession().setAttribute("ERROR_CAR", "Biển số xe không được để trống!");
                response.sendRedirect("MainController?action=ViewCars");
                return;
            }

            String plateFormatted = licensePlate.trim().toUpperCase();

            // Validate regex biển số xe Việt Nam (server-side)
            String regex = "^\\d{2}[A-Z]\\d-\\d{4,5}$"
                         + "|^\\d{2}[A-Z]\\d-\\d{3}\\.\\d{2}$"
                         + "|^\\d{2}[A-Z]-\\d{4,5}$"
                         + "|^\\d{2}[A-Z]-\\d{3}\\.\\d{2}$";

            if (!plateFormatted.matches(regex)) {
                request.getSession().setAttribute("ERROR_CAR",
                    "Biển số xe không đúng định dạng Việt Nam! Ví dụ hợp lệ: 30A1-1234 hoặc 51F1-999.99");
                response.sendRedirect("MainController?action=ViewCars");
                return;
            }

            // Tạo đối tượng Car và lưu vào DB
            Car car = new Car(
                us.getCusId(),
                plateFormatted,
                brand  != null ? brand.trim()  : "",
                model  != null ? model.trim()  : "",
                color  != null ? color.trim()  : "",
                new Date(System.currentTimeMillis())
            );

            CarDAO carDAO = new CarDAO();
            int result = carDAO.addCar(car);

            if (result > 0) {
                request.getSession().setAttribute("SUCCESS_CAR",
                    "Đăng ký xe " + plateFormatted + " thành công!");
            } else {
                request.getSession().setAttribute("ERROR_CAR",
                    "Đăng ký xe thất bại. Biển số " + plateFormatted + " có thể đã được đăng ký trước đó!");
            }

        } catch (Exception e) {
            log("Error at AddCarController: " + e.toString());
            e.printStackTrace();
            request.getSession().setAttribute("ERROR_CAR", "Lỗi hệ thống: " + e.getMessage());
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
