/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.BookDAO;
import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import entity.Book;
import entity.Cart;
import entity.Customer;
import entity.Order;
import entity.OrderDetail;
import entity.Picture;
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
        try (PrintWriter out = response.getWriter()) {
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
                CartDAO myCartDAO = new CartDAO();
                Customer customer = (Customer) session.getAttribute("tempCustomer");
                if (customer != null) {
                    ArrayList<Cart> listCart = myCartDAO.getListCartByCustomerID(customer.getCustomer_id());
                    int bookID = Integer.parseInt(request.getParameter("bookID"));
                    Book book = myBookDAO.getBookByID(bookID);
                    boolean flag = false;
                    Cart cart;
                    int quantity = 1;
                    for (int i = 0; i < listCart.size(); i++) {
                        if (bookID == listCart.get(i).getBookID() && customer.getCustomer_id() == listCart.get(i).getCustomer_id()) {
                            quantity = listCart.get(i).getQuantity();
                            quantity++;
                            flag = true;
                            break;
                        }
                    }
                    String picture = bookID + ".jpg";
                    String link = "http://localhost:8080/Capstone/bookImages/" + picture;
                    cart = new Cart(bookID, customer.getCustomer_id(), book.getTitle(), book.getPrice(), quantity, link);
                    if (flag) {
                        myCartDAO.updateQuantity(cart);
                    } else {
                        myCartDAO.insertIntoCart(cart);
                    }

                    target = "Cart.jsp";
                } else {
                    target = "UserLogin.jsp";
                }

                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);
            }
            if (mode.equals("downQuantity")) {
                CartDAO myCartDAO = new CartDAO();
                Customer customer = (Customer) session.getAttribute("tempCustomer");
                ArrayList<Cart> listCart = myCartDAO.getListCartByCustomerID(customer.getCustomer_id());
                int id = Integer.parseInt(request.getParameter("bookID"));

                int index = isExisting(id, listCart, customer.getCustomer_id());

                int curQuantity = listCart.get(index).getQuantity();
                if (curQuantity == 1) {
                    myCartDAO.DeleteCartItem(id, customer.getCustomer_id());
                } else {
                    int quantity = curQuantity - 1;
                    Cart cart = new Cart(id, quantity, customer.getCustomer_id());
                    myCartDAO.updateQuantity(cart);
                }

                target = "Cart.jsp";
                RequestDispatcher rd = request.getRequestDispatcher(target);
                rd.forward(request, response);

            }
            if (mode.equals("upQuantity")) {
                CartDAO myCartDAO = new CartDAO();
                Customer customer = (Customer) session.getAttribute("tempCustomer");
                ArrayList<Cart> listCart = myCartDAO.getListCartByCustomerID(customer.getCustomer_id());
                int id = Integer.parseInt(request.getParameter("bookID"));

                int index = isExisting(id, listCart, customer.getCustomer_id());

                int curQuantity = listCart.get(index).getQuantity();

                int quantity = curQuantity + 1;
                Cart cart = new Cart(id, quantity, customer.getCustomer_id());
                myCartDAO.updateQuantity(cart);
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
                System.out.println("Mode: "+ mode);
                String way = request.getParameter("method");
                int total = Integer.parseInt(request.getParameter("cartTotal"));
                if(way.equals("VNPay")){
                    request.setAttribute("cartTotal", total);
                    target = "VNPayAjax";
                    RequestDispatcher rd = request.getRequestDispatcher(target);
                    rd.forward(request, response);
                }else{
                ArrayList<Cart> listOrder = (ArrayList<Cart>) session.getAttribute("listCart");                          
                Customer customer = (Customer) session.getAttribute("tempCustomer");

                String date = java.time.LocalDate.now().toString();
              
                    Order newOrder = new Order(customer.getCustomer_id(), date, total, "Pending", 1, "Reivew");
                    int orderID = myOrderDAO.saveOrdersCustomer(newOrder);
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
    private int isExisting(int id, ArrayList<Cart> listCart, int customerID) {
        for (int i = 0; i < listCart.size(); i++) {
            if (listCart.get(i).getBookID() == id && listCart.get(i).getCustomer_id() == customerID) {
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
