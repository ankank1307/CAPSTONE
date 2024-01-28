/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.DiscountDAO;
import entity.Discount;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author phuon
 */
public class EditDiscountServlet extends HttpServlet {

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
        DiscountDAO mydiscountDAO = new DiscountDAO();
        String mode = request.getParameter("mode");
        String target = "";
       if (mode.equals("viewDiscount")) {
                int id = Integer.parseInt(request.getParameter("discountID"));
                Discount tempDiscount = mydiscountDAO.getDiscountByID(id);
                request.setAttribute("tempDiscount", tempDiscount);
                target = "EditDiscount.jsp";
            }

            if (mode.equals("editDiscount")) {
                int ID, quantity,percent, status;
                String description,code, endDate;

               ID = Integer.parseInt(request.getParameter("voucher_id"));
               quantity = Integer.parseInt(request.getParameter("quantity"));
               percent = Integer.parseInt(request.getParameter("percent"));
               status = Integer.parseInt(request.getParameter("status"));
               description = request.getParameter("description");
               endDate = request.getParameter("end-date");
               code = request.getParameter("code");

                Discount newDiscount = new Discount(ID, code, percent, quantity, endDate, status, description);
                mydiscountDAO.updateDiscount(newDiscount);

                target = "ManageDiscountServlet?mode=viewDiscount";
            }
            RequestDispatcher rd = request.getRequestDispatcher(target);
            rd.forward(request, response);
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
