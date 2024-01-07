/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet.Json;

import com.google.gson.Gson;
import dao.OrderDAO;

import dao.RateDAO;
import entity.Rate;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author phuon
 */
public class RateJson extends HttpServlet {

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
        
        RateDAO myRateDAO = new RateDAO() ;
        Gson gson = new Gson();
        List<Rate> listRate = myRateDAO.getListRatedBooks();
        String json = gson.toJson(listRate);
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
        RateDAO rateDao = new RateDAO();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();
        JSONObject requestDataJson = new JSONObject(sb.toString());
        double rate = requestDataJson.getDouble("rate");
        int book_id = requestDataJson.getInt("book_id");
        int customer_id = requestDataJson.getInt("customer_id");
        String comment = requestDataJson.getString("comment");
        int order_id = requestDataJson.getInt("order_id");
        Rate myRate = new Rate(rate, comment, customer_id, book_id,order_id);
        rateDao.insertIntoRate(myRate);
        JSONObject responseJson = new JSONObject();
//        responseJson.put("order_id", myOrderDetail.getOrder_id());
//        responseJson.put("book_id", myOrderDetail.getBook_id());
//        responseJson.put("quantity", myOrderDetail.getQuantity());
//        responseJson.put("price",myOrderDetail.getPrice() );
//        responseJson.put("picture",myOrderDetail.getPicture() );
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

}
