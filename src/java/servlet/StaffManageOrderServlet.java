/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.BookDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import entity.Book;
import entity.Cart;
import entity.Order;
import entity.OrderDetail;
import entity.Staff;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author phuon
 */
public class StaffManageOrderServlet extends HttpServlet {

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
            String mode = request.getParameter("mode");
            BookDAO myBookDAO = new BookDAO();
            OrderDAO myOrderDAO = new OrderDAO();
            HttpSession ss = request.getSession();
            String target = "staffLogin.jsp";
            OrderDetailDAO myOrderDetailDAO = new OrderDetailDAO();
            if (mode.equals("StaffAddToBill")) {
                int bookID = Integer.parseInt(request.getParameter("bookID"));
                System.out.println(bookID);
                ArrayList<Cart> listBill = (ArrayList<Cart>) ss.getAttribute("listBill");
                Book book = myBookDAO.getBookByID(bookID);
                Cart cart = new Cart(bookID, book.getTitle(), book.getPrice(), 1);
                if (listBill == null) {
                    listBill = new ArrayList<>();
                    listBill.add(cart);
                } else {
                    int index = isExisting(bookID, listBill);
                    if (index == -1) {
                        listBill.add(new Cart(bookID, book.getTitle(), book.getPrice(), 1));
                    } else {
                        int quantity = listBill.get(index).getQuantity() + 1;
                        listBill.get(index).setQuantity(quantity);
                    }
                }
                ss.setAttribute("listBill", listBill);
                target = "StaffManageBookServlet?mode=StaffViewBook";
            }
            if (mode.equals("DeleteItem")) {
                int itemID = Integer.parseInt(request.getParameter("itemID"));

                ArrayList<Cart> listBill = (ArrayList<Cart>) ss.getAttribute("listBill");
                for (int i = 0; i < listBill.size(); i++) {
                    if (listBill.get(i).getBookID() == itemID) {
                        listBill.remove(listBill.get(i));
                    }
                }

                System.out.println("listCheck" + listBill);
                ss.setAttribute("listBill", listBill);
                target = "StaffManageBookServlet?mode=StaffViewBook";
            }
            if (mode.equals("viewOrderDetail")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                ArrayList<OrderDetail> listOrderDetail = myOrderDetailDAO.getListOrderDetailByOrder(orderID);

                target = "StaffViewOrderDetail.jsp";

                request.setAttribute("listOrderDetail", listOrderDetail);

            }
           
            if (mode.equals("upQuantity")) {
                int itemID = Integer.parseInt(request.getParameter("itemID"));
                ArrayList<Cart> listBill = (ArrayList< Cart>) ss.getAttribute("listBill");
                int index = isExisting(itemID, listBill);
                int quantity = listBill.get(index).getQuantity() + 1;
                listBill.get(index).setQuantity(quantity);
                ss.setAttribute("listBill", listBill);
                target = "StaffManageBookServlet?mode=StaffViewBook";
            }
            if (mode.equals("downQuantity")) {
                int itemID = Integer.parseInt(request.getParameter("itemID"));
                ArrayList<Cart> listBill = (ArrayList< Cart>) ss.getAttribute("listBill");
                int index = isExisting(itemID, listBill);
                int quantity = listBill.get(index).getQuantity();
                if (quantity == 1) {
                    listBill.remove(listBill.get(index));
                } else {
                    listBill.get(index).setQuantity(quantity - 1);
                }

                ss.setAttribute("listBill", listBill);
                target = "StaffManageBookServlet?mode=StaffViewBook";
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
                target = "StaffManageServlet?mode=StaffViewOrder";
                request.setAttribute("listOrder", listOrder);
            }
            if (mode.equals("makeOrder")) {
                ArrayList<Cart> listBill = (ArrayList<Cart>) ss.getAttribute("listBill");
                String date = java.time.LocalDate.now().toString();
                int total = Integer.parseInt(request.getParameter("total"));
                Staff staff = (Staff) ss.getAttribute("staffLogin");
                int staffID = staff.getStaff_id();
                Order order = new Order(date, total, "Completed", 1, "Review", staffID);
                int orderID = myOrderDAO.saveOrdersStaff(order);
                Book book;
                OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
                boolean flag = false;
                if (orderID != 0) {
                    for (int i = 0; i < listBill.size(); i++) {
                        book = myBookDAO.getBookByID(listBill.get(i).getBookID());
                        if (book.getQuantity() > 0 && book.getQuantity() > listBill.get(i).getQuantity()) {
                            flag = true;
                        }
                    }
                    if (flag) {
                        for (int i = 0; i < listBill.size(); i++) {
                            book = myBookDAO.getBookByID(listBill.get(i).getBookID());
                            OrderDetail orderDetail = new OrderDetail(orderID, listBill.get(i).getBookID(), listBill.get(i).getQuantity(), listBill.get(i).getPrice());
                            orderDetailDAO.insertOrderDetail(orderDetail);
                            int quantity = book.getQuantity();
                            book.setQuantity(quantity - listBill.get(i).getQuantity());
                            myBookDAO.updateBook(book);
                        }
                        ss.removeAttribute("listBill");

                    } else {
                        myOrderDAO.removeOrderByID(orderID);
                        out.println("<script type=\"text/javascript\">");
                        out.println("location='CartServlet?mode=viewCart';");
                        out.println("alert('Out of stock!');");
                        out.println("</script>");
                    }
                }
                target = "StaffManageServlet?mode=StaffViewOrder";
            }
            RequestDispatcher rd = request.getRequestDispatcher(target);
            rd.forward(request, response);
        }
    }
    

    private int isExisting(int id, ArrayList<Cart> listBill) {
        for (int i = 0; i < listBill.size(); i++) {
            if (listBill.get(i).getBookID() == id) {
                return i;
            }
        }
        return -1;
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
