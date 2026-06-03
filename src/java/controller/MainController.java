package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * MainController - Front Controller for URL routing (MVC2 pattern)
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String url = "index.jsp";
        /*
        LUỒNG XỬ LÝ:
        1. Đảm bảo mã hóa UTF-8 cho request/response.
        2. Đọc action: Lấy tham số "action" từ client để xác định hành động cần thực thi (Ví dụ: "Login", "Register", "ViewCars").
        3. Phân nhánh URL: Dựa vào "action", gán giá trị biến "url" trỏ đến Controller hoặc JSP tương ứng.
           - Nếu action là "Dashboard", url trỏ đến "DashboardController".
           - Nếu action là "Login", url trỏ đến "LoginController".
           - Nếu action là "Register", url trỏ đến "RegisterController".
           - Nếu action là "Logout", url trỏ đến "LogoutController".
           - Nếu action là "ViewCars", url trỏ đến "GetAllCarController".
           - Nếu action là "AddCar", url trỏ đến "AddCarController".
           - Nếu action là "UpdateCar", url trỏ đến "UpdateCarController".
           - Nếu action là "DeleteCar", url trỏ đến "DeleteCarController".
        4. Chuyển tiếp (Forward): Dùng request.getRequestDispatcher(url).forward(...) để đẩy yêu cầu sang Controller hoặc JSP đã chọn để xử lý tiếp hoặc hiển thị kết quả.
        */
        try {
            if (action == null || action.isEmpty()) {
                url = "index.jsp";
            } else if (action.equals("Dashboard")) {
                url = "DashboardController";
            } else if (action.equals("Login")) {
                url = "LoginController";
            } else if (action.equals("Register")) {
                url = "RegisterController";
            } else if (action.equals("Logout")) {
                url = "LogoutController";
            } else if (action.equals("ViewCars")) {
                url = "GetAllCarController";
            } else if (action.equals("AddCar")) {
                url = "AddCarController";
            } else if (action.equals("UpdateCar")) {
                url = "UpdateCarController";
            } else if (action.equals("DeleteCar")) {
                url = "DeleteCarController";
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
