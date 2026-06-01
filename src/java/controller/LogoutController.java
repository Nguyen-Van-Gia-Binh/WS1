package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * LogoutController - Xử lý đăng xuất của người dùng, xóa session.
 */
@WebServlet(name="LogoutController", urlPatterns={"/LogoutController"})
public class LogoutController extends HttpServlet {
   
   public void processRequest(HttpServletRequest request, HttpServletResponse response){
        try{
          request.getSession().invalidate();
          response.sendRedirect("index.jsp");
        }catch(Exception e){
           e.printStackTrace();
        } 
   }
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request,response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          processRequest(request,response);
    }

    @Override
    public String getServletInfo() {
        return "Logout Controller for AutoWash Pro";
    }
}
