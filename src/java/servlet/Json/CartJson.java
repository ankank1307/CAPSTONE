/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet.Json;

import com.google.gson.Gson;
import dao.CartDAO;
import entity.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.stream.Collectors;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author phuon
 */
public class CartJson extends HttpServlet {
   
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
            out.println("<title>Servlet CartJson</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartJson at " + request.getContextPath() + "</h1>");
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
           CartDAO myCartDAO = new CartDAO() ;
        Gson gson = new Gson();
        List<Cart> listCart = myCartDAO.getListCart();
        String json = gson.toJson(listCart);
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
        CartDAO myCartDAO = new CartDAO();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject requestDataJson = new JSONObject(sb.toString());
        int book_id = requestDataJson.getInt("book_id");
        int customer_id = requestDataJson.getInt("customer_id");
        String title = requestDataJson.getString("title");
        int price = requestDataJson.getInt("price");
        int quantity = requestDataJson.getInt("quantity");
        String picture = requestDataJson.getString("picture");
        Cart myCart = new Cart(book_id, customer_id, title, price, quantity, picture);
        myCartDAO.insertIntoCart(myCart);
        JSONObject responseJson = new JSONObject();
        responseJson.put("book_id", myCart.getBookID());
        responseJson.put("customer_id", myCart.getCustomer_id());
        responseJson.put("title", myCart.getTitle());
        responseJson.put("price", myCart.getPrice());
        responseJson.put("quantity", myCart.getQuantity());
        responseJson.put("picture", myCart.getPicture());
        System.out.println(responseJson.toString());
        response.getWriter().print(responseJson.toString());
        response.getWriter().flush();
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonData = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Cart updatedCart = gson.fromJson(jsonData, Cart.class);
       //  System.out.println(updatedCustomer.toString());
        int id = updatedCart.getBookID();
        int customer_id = updatedCart.getCustomer_id();
        String title = updatedCart.getTitle();
        int price = updatedCart.getPrice();
        int quantity = updatedCart.getQuantity();
        String picture = updatedCart.getPicture();
        System.out.println(id);
         CartDAO myCartDAO = new CartDAO();
        Cart cart = new Cart(id, customer_id, title, price, quantity, picture);
        myCartDAO.updateQuantity(cart);
        System.out.println(quantity);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Response message");
    }

    @Override
   protected void doDelete(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        CartDAO myCartDAO = new CartDAO();
    try {
        // Parse JSON data from the request body
         String jsonData = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Cart cartItem = gson.fromJson(jsonData, Cart.class);

        // Extract the cart item ID (adjust the property name as needed)
        int book_id = cartItem.getBookID();
        int customer_id = cartItem.getCustomer_id();
        System.out.println(book_id);
        
            myCartDAO.DeleteCartItem(book_id, customer_id);
            response.setStatus(HttpServletResponse.SC_OK);
       
    } catch (Exception e) {
        // Handle any exceptions and send an appropriate error response
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        e.printStackTrace();
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
