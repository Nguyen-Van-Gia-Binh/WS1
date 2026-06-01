/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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
 * LoginController - Xử lý đăng nhập của khách hàng
 */
@WebServlet(name="LoginController", urlPatterns={"/LoginController"})
public class LoginController extends HttpServlet {
   
   public void processRequest(HttpServletRequest request, HttpServletResponse response){
       try{
          request.setCharacterEncoding("UTF-8");
          response.setContentType("text/html;charset=UTF-8");

          // Lấy phone, password từ form login
          String phone = request.getParameter("txtphone");
          String password = request.getParameter("txtpassword");
          
          CustomerDAO customerDAO = new CustomerDAO();
          Customer customer = customerDAO.getCustomerByPhoneAndPassword(phone, password);
          
          if(customer == null){
              String msg = "Số điện thoại hoặc mật khẩu không chính xác!";
              request.setAttribute("ERROR", msg);
              request.getRequestDispatcher("login_page.jsp").forward(request, response);
          } else {
              request.getSession().setAttribute("USER", customer);
              response.sendRedirect("MainController?action=Dashboard");
          } 
       }catch(Exception e){
          e.printStackTrace();
       } 
   }
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("login_page.jsp");
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          processRequest(request,response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
