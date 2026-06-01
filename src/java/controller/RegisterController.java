package controller;

import dao.CustomerDAO;
import dto.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * RegisterController - Xử lý đăng ký tài khoản khách hàng mới.
 * Kiểm tra trùng SĐT, validate input, tạo user MEMBER mặc định.
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register_page.jsp");
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

        // 2. Validate server-side (không tin client-side validation)
        if (fullname == null || fullname.trim().isEmpty()) {
            forwardError(request, response, "Họ và tên không được để trống!");
            return;
        }

        if (phone == null || phone.trim().isEmpty()) {
            forwardError(request, response, "Số điện thoại không được để trống!");
            return;
        }

        // Validate format SĐT: bắt đầu bằng 0, đúng 10 chữ số (Chuẩn di động Việt Nam)
        phone = phone.trim();
        if (!phone.matches("^0[0-9]{9}$")) {
            forwardError(request, response, "Số điện thoại không hợp lệ! Phải bắt đầu bằng số 0 và có đúng 10 chữ số.");
            return;
        }

        if (password == null || password.trim().length() < 4) {
            forwardError(request, response, "Mật khẩu phải có ít nhất 4 ký tự!");
            return;
        }

        // 3. *** KIỂM TRA TRÙNG SỐ ĐIỆN THOẠI ***
        CustomerDAO customerDAO = new CustomerDAO();
        Customer existingCustomer = customerDAO.getCustomerByPhone(phone);

        if (existingCustomer != null) {
            forwardError(request, response,
                "Số điện thoại " + phone + " đã được đăng ký trước đó! Vui lòng dùng số khác hoặc đăng nhập.");
            return;
        }

        // 4. Tạo tài khoản mới (hạng MEMBER mặc định)
        Customer customer = new Customer();
        customer.setFullname(fullname.trim());
        customer.setEmail("");
        customer.setPassword(password.trim());
        customer.setPhoneNumber(phone);
        customer.setStatus(true);
        customer.setCurrentTierId("MEMBER");

        try {
            int result = customerDAO.createCustomer(customer);

            if (result >= 1) {
                // Đăng ký thành công → chuyển sang trang Login
                response.sendRedirect("login_page.jsp");
            } else {
                forwardError(request, response,
                    "Đăng ký thất bại! Số điện thoại có thể đã tồn tại trong hệ thống.");
            }
        } catch (Exception e) {
            log("Error at RegisterController: " + e.toString());
            e.printStackTrace();
            forwardError(request, response,
                "Lỗi hệ thống: " + e.getMessage());
        }
    }

    /**
     * Helper: Forward lỗi về trang register kèm thông báo
     */
    private void forwardError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("ERROR", message);
        request.getRequestDispatcher("register_page.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Register Controller for AutoWash Pro";
    }
}
