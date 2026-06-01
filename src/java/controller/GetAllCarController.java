package controller;

import dto.Car;
import dto.Customer;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CarService;

/**
 * GetAllCarController - Lấy danh sách xe của khách hàng đang đăng nhập
 * và chuyển tiếp sang trang cars.jsp để hiển thị.
 */
@WebServlet(name = "GetAllCarController", urlPatterns = {"/GetAllCarController"})
public class GetAllCarController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            Customer us = (Customer) request.getSession().getAttribute("USER");
            if (us == null) {
                response.sendRedirect("MainController?action=Login");
                return;
            }

            int custid = us.getCusId();
            CarService carService = new CarService();
            List<Car> listCars = carService.getCarsByCustomerId(custid);

            // Truyền danh sách xe sang cars.jsp
            request.setAttribute("LISTCARS", listCars);
            request.getRequestDispatcher("cars.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error at GetAllCarController: " + e.toString());
            e.printStackTrace();
        }
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
