package services;

import dao.CustomerDAO;
import dto.Customer;

/**
 * CustomerService - Lớp dịch vụ xử lý nghiệp vụ cho Khách hàng
 */
public class CustomerService {
    private final CustomerDAO customerDAO = new CustomerDAO();

    /**
     * Xác thực tài khoản khách hàng.
     */
    public Customer authenticate(String phone, String password) throws Exception {
        if (phone == null || phone.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new Exception("Số điện thoại hoặc mật khẩu không được để trống!");
        }
        
        Customer customer = customerDAO.getCustomerByPhoneAndPassword(phone.trim(), password.trim());
        if (customer == null) {
            throw new Exception("Số điện thoại hoặc mật khẩu không chính xác!");
        }
        return customer;
    }

    /**
     * Đăng ký tài khoản khách hàng mới.
     * Thực hiện kiểm tra tính hợp lệ của thông tin và kiểm tra trùng SĐT.
     */
    public void registerAccount(String fullName, String phone, String password) throws Exception {
        if (fullName == null || fullName.trim().isEmpty()) {
            throw new Exception("Họ và tên không được để trống!");
        }

        if (phone == null || phone.trim().isEmpty()) {
            throw new Exception("Số điện thoại không được để trống!");
        }

        String phoneTrimmed = phone.trim();
        if (!phoneTrimmed.matches("^0[0-9]{9}$")) {
            throw new Exception("Số điện thoại không hợp lệ! Phải bắt đầu bằng số 0 và có đúng 10 chữ số.");
        }

        if (password == null || password.trim().length() < 4) {
            throw new Exception("Mật khẩu phải có ít nhất 4 ký tự!");
        }

        // Kiểm tra trùng số điện thoại
        Customer existingCustomer = customerDAO.getCustomerByPhone(phoneTrimmed);
        if (existingCustomer != null) {
            throw new Exception("Số điện thoại " + phoneTrimmed + " đã được đăng ký trước đó! Vui lòng dùng số khác hoặc đăng nhập.");
        }

        Customer customer = new Customer();
        customer.setFullname(fullName.trim());
        customer.setPassword(password.trim());
        customer.setPhoneNumber(phoneTrimmed);
        customer.setRole("CUSTOMER");
        customer.setCurrentTierId("MEMBER");

        int result = customerDAO.createCustomer(customer);
        if (result < 1) {
            throw new Exception("Đăng ký thất bại! Số điện thoại có thể đã tồn tại trong hệ thống.");
        }
    }
}
