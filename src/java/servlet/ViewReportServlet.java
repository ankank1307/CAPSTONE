/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author phuon
 */
public class ViewReportServlet extends HttpServlet {

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
        String mode = request.getParameter("mode");
        OrderDAO myOrderDAO = new OrderDAO();
        String target = "";
        try (PrintWriter out = response.getWriter()) {
           if (mode.equals("dailyReport")) {
                int year = 2023;
                String endDate = request.getParameter("endDate");
                String startDate = request.getParameter("startDate");
                int total = myOrderDAO.getRevenueByDate(startDate,endDate);   
                int totalOrders = myOrderDAO.getOrdersByDate(startDate, endDate);
                int totalCustomer = myOrderDAO.getCustomersByDate(startDate, endDate);
                int saleBook = myOrderDAO.getSaleBookByDate(startDate, endDate);
                List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();
                listRevenueByMonth = myOrderDAO.getRevenueByMonth(year);
                target = "DailyReport.jsp";
                request.setAttribute("totalRevenue", total);
                request.setAttribute("totalOrder", totalOrders);
                request.setAttribute("totalCustomer", totalCustomer);
                request.setAttribute("saleBook", saleBook);
                request.setAttribute("selectedYear", year);
                request.setAttribute("listRevenueByMonth", listRevenueByMonth);
            }
           
            RequestDispatcher rd = request.getRequestDispatcher(target);
            rd.forward(request, response);
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
