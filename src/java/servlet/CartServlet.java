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
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author BLC
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            BookDAO myBookDAO = new BookDAO();
            OrderDAO myOrderDAO = new OrderDAO();
            OrderDetailDAO myOrderDetailDAO = new OrderDetailDAO();
            String mode = request.getParameter("mode");
            String target = "Cart.jsp";
            HttpSession session = request.getSession();

            if (mode.equals("viewCart")) {
                ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");

                if (listCart == null) {
                    ArrayList<Cart> tempListCart = new ArrayList<>();
                    session.setAttribute("listCart", tempListCart);
                } else {
                    session.setAttribute("listCart", listCart);
                }
                target = "Cart.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);
            }

            if (mode.equals("addToCart")) {
                ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");
                Customer customer = (Customer) session.getAttribute("tempCustomer");

                if (customer != null) {
                    int bookID = Integer.parseInt(request.getParameter("bookID"));
                    Book book = myBookDAO.getBookByID(bookID);
                    Cart cart;
                    if (listCart == null) {
                        listCart = new ArrayList<Cart>();
                        cart = new Cart(bookID, book.getTitle(), book.getPrice(), 1);
                        listCart.add(cart);
                        session.setAttribute("listCart", listCart);
                    } else {
                        listCart = (ArrayList<Cart>) session.getAttribute("listCart");
                        int index = isExisting(bookID, listCart);
                        if (index == -1) {
                            listCart.add(new Cart(bookID, book.getTitle(), book.getPrice(), 1));
                        } else {
                            int quantity = listCart.get(index).getQuantity() + 1;
                            listCart.get(index).setQuantity(quantity);
                        }
                        session.setAttribute("listCart", listCart);
                    }
                    target = "Cart.jsp";
                } else {
                    target = "UserLogin.jsp";
                }

                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);
            }
            if (mode.equals("downQuantity")) {
                ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");
                int id = Integer.parseInt(request.getParameter("bookID"));

                int index = isExisting(id, listCart);

                int curQuantity = listCart.get(index).getQuantity();
                if (curQuantity == 1) {
                    listCart.remove(index);
                } else {
                    listCart.get(index).setQuantity(curQuantity - 1);
                }

                session.setAttribute("listCart", listCart);
                target = "Cart.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);

            }
            if (mode.equals("upQuantity")) {
                ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");
                int id = Integer.parseInt(request.getParameter("bookID"));

                int index = isExisting(id, listCart);

                int curQuantity = listCart.get(index).getQuantity();

                listCart.get(index).setQuantity(curQuantity + 1);

                session.setAttribute("listCart", listCart);
                target = "Cart.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);

            }
            if (mode.equals("deleteItem")) {
                ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");
                int id = Integer.parseInt(request.getParameter("bookID"));

                for (int i = 0; i < listCart.size(); i++) {
                    if (id == listCart.get(i).getBookID()) {
                        listCart.remove(i);
                        break;
                    }
                }
                session.setAttribute("listCart", listCart);
                target = "Cart.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);
            }

            if (mode.equals("checkout")) {
                ArrayList<Cart> listOrder = (ArrayList<Cart>) session.getAttribute("listCart");
                int total = Integer.parseInt(request.getParameter("cartTotal"));

                Customer customer = (Customer) session.getAttribute("tempCustomer");

                String date = java.time.LocalDate.now().toString();
                Order newOrder = new Order(customer.getCustomer_id(), date, total, "Pending", 1,"Reivew");

                int orderID = myOrderDAO.saveOrders(newOrder);
                if (orderID != 0) {
                    for (Cart cart : listOrder) {
                        Book book = myBookDAO.getBookByID(cart.getBookID());

                        int quantityOfBooks = book.getQuantity();
                        int quantityOfBuy = cart.getQuantity();
                        if (quantityOfBooks > 0 && quantityOfBuy < quantityOfBooks) {
                            OrderDetail orderDetail = new OrderDetail(orderID, cart.getBookID(), quantityOfBuy, book.getPrice());
                            myOrderDetailDAO.insertOrderDetail(orderDetail);

                            int restQuantity = quantityOfBooks - quantityOfBuy;
                            book.setQuantity(restQuantity);
                            myBookDAO.updateBook(book);

                        } else {
                            myOrderDAO.removeOrderByID(orderID);
                            out.println("<script type=\"text/javascript\">");
                            out.println("location='CartServlet?mode=viewCart';");
                            out.println("alert('Out of stock!');");
                            out.println("</script>");
                            break;
                        }
                    }
                    request.setAttribute("message", "Payment Success");
                    session.removeAttribute("listCart");
                    session.setAttribute("tempCustomer", customer);
                    request.getRequestDispatcher("ManageUserLoginServlet?mode=viewProfile&customerID=" + customer.getCustomer_id()).forward(request, response);
                }

            }
//            RequestDispatcher rd = request.getRequestDispatcher(target);
//            rd.forward(request, response);
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
    private int isExisting(int id, ArrayList<Cart> listCart) {
        for (int i = 0; i < listCart.size(); i++) {
            if (listCart.get(i).getBookID() == id) {
                return i;
            }
        }
        return -1;
    }

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
