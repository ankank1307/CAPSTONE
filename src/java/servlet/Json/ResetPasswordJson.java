/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet.Json;

import com.google.gson.Gson;
import dao.CustomerDAO;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.EncryptPassword;

/**
 *
 * @author phuon
 */
public class ResetPasswordJson extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPasswordJson</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordJson at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String jsonData = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Customer updatedCustomer = gson.fromJson(jsonData, Customer.class);
        String email = updatedCustomer.getEmail();
        System.out.println(email);
        String password = updatedCustomer.getPassword();
        CustomerDAO myCusDAO = new CustomerDAO();
        List<Customer> listCustomer = myCusDAO.getListCustomer();
        for (int i = 0; i < listCustomer.size(); i++) {
            if (listCustomer.get(i).getEmail().equals(email) && listCustomer.get(i).getCustomer_status() == 1) {
                myCusDAO.updatePassword(listCustomer.get(i), EncryptPassword.encriptPass(password));
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("Response message");
                System.out.println("Update Successful");
                break;
            } else {
                System.out.println("Email not found");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
