package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CustomerService;

/**
 * RegisterController - Xử lý đăng ký tài khoản khách hàng mới.
 * Sử dụng CustomerService để xử lý logic nghiệp vụ và xác thực đầu vào.
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register_page.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy thông tin từ form
        String fullname = request.getParameter("txtfullname");
        String phone    = request.getParameter("txtphone");
        String password = request.getParameter("txtpassword");

        CustomerService customerService = new CustomerService();
        try {
            // 2. Gọi service đăng ký
            customerService.registerAccount(fullname, phone, password);
            
            // Đăng ký thành công → chuyển hướng sang trang Login
            response.sendRedirect("MainController?action=Login");
        } catch (Exception e) {
            // Lưu thông báo lỗi và forward lại trang đăng ký
            request.setAttribute("ERROR", e.getMessage());
            request.getRequestDispatcher("register_page.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Register Controller using CustomerService";
    }
}
