package servlet;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StaffManageOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String mode = request.getParameter("mode");
            String target = "StaffViewOrder.jsp";

            OrderDAO orderDAO = new OrderDAO();

            if (mode.equals("updateShippingStatus")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                String shippingStatus = request.getParameter("shipping_status");

                Order order = orderDAO.getOrderByID(orderID);
                if (order != null) {
                    order.setShipping_status(shippingStatus);
                    orderDAO.updateOrder(order);
                }
                ArrayList<Order> listOrder = orderDAO.getListOrder();
                request.setAttribute("listOrder", listOrder);
                target = "StaffViewOrder.jsp";      
            } else if (mode.equals("makeOrder")) {
                // Implement logic for creating a new order
                // You need to fetch data from the request and create a new Order object
                // Then, add the order to the database using the OrderDAO

                // Example:
                // Order newOrder = new Order();
                // newOrder.setCustomer_id(...); // Set other attributes
                // orderDAO.addOrder(newOrder);

                // Redirect to the order management page
                ArrayList<Order> listOrder = orderDAO.getListOrder();
                request.setAttribute("listOrder", listOrder);
                target = "staff_manage_order.jsp"; // Update with the appropriate JSP page
            }

            RequestDispatcher rd = request.getRequestDispatcher(target);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
