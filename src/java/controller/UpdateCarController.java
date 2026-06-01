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

            int plateId = Integer.parseInt(request.getParameter("txtcarid"));
            String licensePlate = request.getParameter("txtlicenseplate");
            String brand        = request.getParameter("txtbrand");
            String model        = request.getParameter("txtmodel");
            String color        = request.getParameter("txtcolor");

            CarService carService = new CarService();
            carService.updateCar(us.getCusId(), plateId, licensePlate, brand, model, color);
            
            String plateFormatted = licensePlate != null ? licensePlate.trim().toUpperCase() : "";
            request.getSession().setAttribute("SUCCESS_CAR", "Cập nhật thông tin xe " + plateFormatted + " thành công!");

        } catch (Exception e) {
            log("Error at UpdateCarController: " + e.toString());
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
