package controller;

import dto.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.CustomerService;

/**
 * LoginController - Xử lý đăng nhập của khách hàng
 */
@WebServlet(name="LoginController", urlPatterns={"/LoginController"})
public class LoginController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");

            // Lấy phone, password từ form login
            String phone = request.getParameter("txtphone");
            String password = request.getParameter("txtpassword");
            
            CustomerService customerService = new CustomerService();
            try {
                Customer customer = customerService.authenticate(phone, password);
                request.getSession().setAttribute("USER", customer);
                response.sendRedirect("MainController?action=Dashboard");
            } catch (Exception e) {
                request.setAttribute("ERROR", e.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch(Exception e) {
            log("Error at LoginController: " + e.toString());
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Controller using CustomerService";
    }
}
