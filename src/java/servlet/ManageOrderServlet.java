/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import entity.Order;
import entity.OrderDetail;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
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
public class ManageOrderServlet extends HttpServlet {

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
            String mode = request.getParameter("mode");
            String target = "home.jsp";
            OrderDetailDAO myOrderDetailDAO = new OrderDetailDAO();
            OrderDAO myOrderDAO = new OrderDAO();
            if (mode.equals("viewOrder")) {
                List<Order> listOrder = new ArrayList<>();
                int year = Year.now().getValue();
                listOrder = myOrderDAO.getListOrder();
                List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();
                listRevenueByMonth = myOrderDAO.getRevenueByMonth(year);
                target = "ViewOrder.jsp";
                request.setAttribute("selectedYear", year);
                request.setAttribute("listRevenueByMonth", listRevenueByMonth);
                request.setAttribute("listOrder", listOrder);
            }
            if (mode.equals("generateChart")) {
                int year = Integer.parseInt(request.getParameter("selectedYear"));
                List<Order> listOrder = new ArrayList<>();
                listOrder = myOrderDAO.getListOrder();
                List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();
                listRevenueByMonth = myOrderDAO.getRevenueByMonth(year);
                target = "ViewOrder.jsp";
                request.setAttribute("listOrder", listOrder);
                request.setAttribute("selectedYear", year);
                request.setAttribute("listRevenueByMonth", listRevenueByMonth);
            }

            if (mode.equals("viewOrderDetail")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                ArrayList<OrderDetail> listOrderDetail = myOrderDetailDAO.getListOrderDetailByOrder(orderID);

                target = "ViewOrderDetail.jsp";

                request.setAttribute("listOrderDetail", listOrderDetail);

            }

            if (mode.equals("updateShippingStatus")) {
                List<Order> listOrder = new ArrayList<>();

                int orderID = Integer.parseInt(request.getParameter("orderID"));
                Order order = myOrderDAO.getOrderByID(orderID);
                String shipping_status = request.getParameter("shipping_status");
                System.out.println(shipping_status);
                System.out.println(order.getOrder_id());

                order.setShipping_status(shipping_status);

                myOrderDAO.updateOrder(order);
                listOrder = myOrderDAO.getListOrder();
                int year = Year.now().getValue();
                listOrder = myOrderDAO.getListOrder();
                List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();
                listRevenueByMonth = myOrderDAO.getRevenueByMonth(year);
                target = "ViewOrder.jsp";
                request.setAttribute("listRevenueByMonth", listRevenueByMonth);
                request.setAttribute("listOrder", listOrder);
                request.setAttribute("selectedYear", year);
            }
            if (mode.equals("search")) {
                String input = request.getParameter("searchInput");
                ArrayList<Order> listOrder = myOrderDAO.getListOrderSearching(input);
                    int year = Year.now().getValue();
                listOrder = myOrderDAO.getListOrder();
                List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();
                listRevenueByMonth = myOrderDAO.getRevenueByMonth(year);
               
                request.setAttribute("listRevenueByMonth", listRevenueByMonth);
                request.setAttribute("listOrder", listOrder);
                target = "ViewOrder.jsp";

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
