/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.BookDAO;
import dao.CustomerDAO;
import entity.Book;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import manager.EncryptPassword;

/**
 *
 * @author phuon
 */
public class EditUserProfileServlet extends HttpServlet {

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
            String mode = request.getParameter("mode");
             HttpSession mySession = request.getSession();
            String target = "";
            CustomerDAO myCustomerDAO = new CustomerDAO();
            if (mode.equals("editProfile")) {
                int id = Integer.parseInt(request.getParameter("cusID"));
                Customer thisCus = myCustomerDAO.getCustomerByID(id);
                String phone = request.getParameter("phone");
                int status = thisCus.getCustomer_status();
                String name = request.getParameter("name");
                String username = thisCus.getUsername();
                int total_spent = thisCus.getTotal_spent();
                String email = request.getParameter("email");
                String password = EncryptPassword.encriptPass(thisCus.getPassword());
                String address = request.getParameter("address");


                Customer edittedCustomer = new Customer(id, username, password, name, phone, address, email,total_spent, status);
                myCustomerDAO.updateCustomer(edittedCustomer);
                target = "ManageUserLoginServlet?mode=viewProfile&customerID=" + id;

            }

            if (mode.equals("resetPassword")) {
                int cusID = Integer.parseInt(request.getParameter("cusID"));
                Customer customer = myCustomerDAO.getCustomerByID(cusID);
                String oldPass = EncryptPassword.encriptPass(request.getParameter("oldPass"));
                String newPass = request.getParameter("newPass");
                String cfPass = request.getParameter("cfPass");
                target="ResetPassword.jsp";

                if (oldPass.equals(customer.getPassword())) {
                    if (newPass.equals(cfPass)) {
                        String password = EncryptPassword.encriptPass(cfPass);
                        System.out.println(password);
                        myCustomerDAO.updatePassword(customer, password);
                        String mess = "Password Updated";
                        request.setAttribute("mess", mess);
                        System.out.println(mess);
                        mySession.removeAttribute("UserLogin");
                        target = "UserLogin.jsp";
                    } else {
                        target="ResetPassword.jsp";
                        String mess = "Password does not match!";
                        request.setAttribute("mess", mess);
                        System.out.println(mess);

                    }
                } else {
                    String mess = "Old password is not correct!";
                    request.setAttribute("mess", mess);
                    System.out.println(mess);
                }

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
