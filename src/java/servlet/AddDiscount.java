/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.DiscountDAO;
import entity.Discount;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author phuon
 */
public class AddDiscount extends HttpServlet {

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
        String code = generateVoucherCode();
        int percent = Integer.parseInt(request.getParameter("percent"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String end_date = request.getParameter("end-date");
        
        String description = request.getParameter("description");
        int status =1;
        Discount discount = new Discount(code,percent,quantity,end_date,status,description);
        DiscountDAO myDiscountDAO = new DiscountDAO();
        myDiscountDAO.insertDiscount(discount);
        
          String target = "ManageDiscountServlet?mode=viewDiscount";
            RequestDispatcher rd = request.getRequestDispatcher(target);
            rd.forward(request, response);
        
        System.out.println("Hihi");
    }
      
    
    private static String generateVoucherCode() {
        int length = 6;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        Random random = new Random();

        StringBuilder voucherCodeBuilder = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(characters.length());
            voucherCodeBuilder.append(characters.charAt(randomIndex));
        }

        return voucherCodeBuilder.toString();
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
