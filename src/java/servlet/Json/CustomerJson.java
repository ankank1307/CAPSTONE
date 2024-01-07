/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.Json;

import com.google.gson.Gson;
import dao.CustomerDAO;
import entity.Customer;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
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
public class CustomerJson extends HttpServlet {

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
            out.println("<title>Servlet CustomerJson</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerJson at " + request.getContextPath() + "</h1>");
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
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("application/json");
//        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
//        StringBuilder sb = new StringBuilder();
//        String line;
//        while ((line = reader.readLine()) != null) {
//            sb.append(line);
//        }
//        reader.close();
//        JSONObject requestDataJson = new JSONObject(sb.toString());
//        String username = requestDataJson.getString("username");
//        String password = requestDataJson.getString("password");
//        String name = requestDataJson.getString("name");
//        int phone_number = requestDataJson.getInt("phone_number");
//        String address = requestDataJson.getString("address");
//        String email = requestDataJson.getString("email");
//        int status = requestDataJson.getInt("customer_status");
//        Customer customer = new Customer(username, password, name, phone_number, address, email,status);
//        System.out.println("username");
//        CustomerDAO myCusDAO = new CustomerDAO();
//        myCusDAO.insertCustomer(customer);
//        JSONObject responseJson = new JSONObject();
//        responseJson.put("customer_id", customer.getCustomer_id());
//        responseJson.put("username", customer.getUsername());
//        responseJson.put("password", customer.getPassword());
//        responseJson.put("name", customer.getName());
//        responseJson.put("phone_number", customer.getPhone_number());
//        responseJson.put("address", customer.getAddress());
//        responseJson.put("email", customer.getEmail());
//        responseJson.put("customer_status", customer.getCustomer_status());
//        response.getWriter().print(responseJson.toString());
//        response.getWriter().flush();
//        
//    }
      @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonData = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Customer updatedCustomer = gson.fromJson(jsonData, Customer.class);
       //  System.out.println(updatedCustomer.toString());
        int id = updatedCustomer.getCustomer_id();
        System.out.println(id);
        CustomerDAO myCusDAO = new CustomerDAO();
        Customer cus = new Customer();
        myCusDAO.disableCustomer(id);
        cus = myCusDAO.getCustomerByID(id);
        System.out.println(cus.toString());
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
