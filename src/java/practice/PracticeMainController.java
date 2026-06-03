package practice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * FILE THỰC HÀNH ÔN TẬP FRONT CONTROLLER (MainController)
 * 
 * Nhiệm vụ của bạn: Điền logic điều phối URL (Routing) dựa vào tham số "action".
 */
@WebServlet(name = "PracticeMainController", urlPatterns = {"/PracticeMainController"})
public class PracticeMainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy tham số "action" từ request
        String action = request.getParameter("action");
        String url = "index.jsp"; // URL mặc định nếu không khớp action nào
        
        try {
            // TODO: VIẾT CODE ĐIỀU PHỐI Ở ĐÂY
            // Gợi ý:
            // - Nếu action bằng null hoặc rỗng -> chuyển về "index.jsp".
            // - Nếu action bằng "Login" -> chuyển tới "LoginController".
            // - Nếu action bằng "Register" -> chuyển tới "RegisterController".
            // - Nếu action bằng "Dashboard" -> chuyển tới "DashboardController".
            // - Nếu action bằng "ViewCars" -> chuyển tới "GetAllCarController".
            if (action == null || action.isEmpty()) {
                url ="index.jsp";
            } else if (action.equalsIgnoreCase("Login")){
                url = "LoginController";
            } else if (action.equalsIgnoreCase("Register")){
                url = "RegisterController";
            } else if (action.equalsIgnoreCase("Dashboard")) {
                url = "DashboardController";
            } else if (action.equals("ViewCars")) {
                url = "GetAllCarController";
            }
        } catch (Exception e) {
            log("Error at PracticeMainController: " + e.toString());
        } finally {
            // 2. Chuyển tiếp request và response tới URL đích
            // TODO: VIẾT LỆNH CHUYỂN TIẾP (FORWARD) Ở ĐÂY
            // Gợi ý cho vấn đáp: Lệnh nào dùng để chuyển tiếp tài nguyên trên Server mà giữ nguyên URL ở trình duyệt?
            // request.getRequestDispatcher(url).forward(request, response);
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
