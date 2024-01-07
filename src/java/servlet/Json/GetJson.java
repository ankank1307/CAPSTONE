/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet.Json;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CustomerDAO;
import entity.Customer;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.EncryptPassword;
import org.json.JSONObject;


/**
 *
 * @author phuon
 */
public class GetJson extends HttpServlet {

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
        //processRequest(request, response);
        CustomerDAO myCus = new dao.CustomerDAO();
        Gson gson = new Gson();
        List<Customer> listCustomer = myCus.getListCustomer();
        String json = gson.toJson(listCustomer);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
        System.out.println(json);
        request.setAttribute("listCustomer", listCustomer);
        //  RequestDispatcher rd= request.getRequestDispatcher("Json.jsp");
        // rd.forward(request, response);
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
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject requestDataJson = new JSONObject(sb.toString());
        String username = requestDataJson.getString("username");
        String password = EncryptPassword.encriptPass(requestDataJson.getString("password"));
        String name = requestDataJson.getString("name");
        String phone_number = requestDataJson.getString("phone_number");
        String address = requestDataJson.getString("address");
        String email = requestDataJson.getString("email");
        int status = requestDataJson.getInt("customer_status");
        int total_spent = 0;
        Customer customer = new Customer(username, password, name, phone_number, address, email, total_spent, status);
        CustomerDAO myCusDAO = new CustomerDAO();
        myCusDAO.insertCustomer(customer);
        JSONObject responseJson = new JSONObject();
        responseJson.put("customer_id", customer.getCustomer_id());
        responseJson.put("username", customer.getUsername());
        responseJson.put("password", customer.getPassword());
        responseJson.put("name", customer.getName());
        responseJson.put("phone_number", customer.getPhone_number());
        responseJson.put("address", customer.getAddress());
        responseJson.put("email", customer.getEmail());
        responseJson.put("customer_status", customer.getCustomer_status());
        System.out.println(responseJson.toString());
        response.getWriter().print(responseJson.toString());
        response.getWriter().flush();
    }
    protected void doPatch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject patchData = new JSONObject(sb.toString());
        int id = patchData.getInt("id");
        CustomerDAO myCusDAO = new CustomerDAO();
        myCusDAO.disableCustomer(id);
        Customer customer = myCusDAO.getCustomerByID(id);
        JSONObject responseJson = new JSONObject();
        responseJson.put("customer_id", customer.getCustomer_id());
        responseJson.put("username", customer.getUsername());
        responseJson.put("password", customer.getPassword());
        responseJson.put("name", customer.getName());
        responseJson.put("phone_number", customer.getPhone_number());
        responseJson.put("address", customer.getAddress());
        responseJson.put("email", customer.getEmail());
        responseJson.put("customer_status", customer.getCustomer_status());
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json");
        System.out.println(responseJson.toString());
        response.getWriter().print(responseJson.toString());
        response.getWriter().flush();
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

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jsonData = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        Gson gson = new Gson();
        Customer updatedCustomer = gson.fromJson(jsonData, Customer.class);
        CustomerDAO myCusDAO = new CustomerDAO();
        myCusDAO.updateCustomer(updatedCustomer);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("Response message");
    }

}
