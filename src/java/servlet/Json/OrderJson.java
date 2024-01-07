/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet.Json;

import com.google.gson.Gson;
import dao.OrderDAO;
import entity.Order;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author phuon
 */
public class OrderJson extends HttpServlet {

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
            out.println("<title>Servlet OrderJson</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderJson at " + request.getContextPath() + "</h1>");
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
        OrderDAO myOrderDAO = new OrderDAO();
        Gson gson = new Gson();
        List<Order> listOrder = myOrderDAO.getListOrder();
        String json = gson.toJson(listOrder);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
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
         response.setContentType("application/json");
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder sb = new StringBuilder();
        OrderDAO myorderDAO = new OrderDAO();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject requestDataJson = new JSONObject(sb.toString());
        int customer_id = requestDataJson.getInt("customer_id");
        String date = java.time.LocalDate.now().toString();
        int total =  requestDataJson.getInt("total");
        String shipping_status = "Pending";
        int order_status = requestDataJson.getInt("order_status");
        String review_status = "Review";
        Order order = new Order(customer_id, date, total, shipping_status, order_status, review_status);
        int order_id = myorderDAO.saveOrders(order);
        JSONObject responseJson = new JSONObject();
        responseJson.put("order_id", order_id);
        responseJson.put("customer_id", order.getCustomer_id());
        responseJson.put("order_date", order.getOrder_date());
        responseJson.put("total", order.getTotal());
        responseJson.put("shipping_status", order.getShipping_status());
        responseJson.put("order_status", order.getShipping_status());
        //responseJson.put("order_status", order.get));
        System.out.println(responseJson.toString());
        response.getWriter().print(responseJson.toString());
        response.getWriter().flush();
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
          String jsonData = req.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Order updateOrder = gson.fromJson(jsonData, Order.class);
        updateOrder.setReview_status("Reviewed");
        updateOrder.setShipping_status(updateOrder.getShipping_status());
        OrderDAO myOrderDAO = new OrderDAO();
        myOrderDAO.updateOrderReview(updateOrder);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Response message");
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
