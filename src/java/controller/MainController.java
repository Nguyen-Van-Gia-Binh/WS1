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
        
        try {
            if (action == null || action.isEmpty()) {
                url = "index.jsp";
            } else if (action.equals("LoginPage")) {
                url = "login_page.jsp";
            } else if (action.equals("RegisterPage")) {
                url = "register_page.jsp";
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
