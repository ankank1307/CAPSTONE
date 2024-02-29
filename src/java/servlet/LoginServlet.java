/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.AdminDAO;
import dao.StaffDAO;
import entity.Admin;
import entity.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.DriverManager;
import java.util.ArrayList;
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
public class LoginServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        String username = "";
        String password = "";

        String userNameForm = request.getParameter("username");
        String passwordForm = request.getParameter("password");

        String mode = request.getParameter("mode");
        String target = "home.jsp";
        if (mode.equals("loginAdmin")) {
            ArrayList<Admin> list = new ArrayList<>();
            AdminDAO adminDao = new AdminDAO();
            list = adminDao.getAdmin();
            for (int i = 0; i < list.size(); i++) {
                username = list.get(i).getUsername();
                password = list.get(i).getPassword();

            }
            if (userNameForm.equals(username) && passwordForm.equals(password)) {
                target = "ManageBookServlet?mode=viewBook";
                session.setAttribute("adminLogin", username);
            } else {
                target = "adminLogin.jsp";
                String mess = "Username or password invalid";
                request.setAttribute("mess", mess);
            }
        }
        if (mode.equals("logoutAdmin")) {
            target = "adminLogin.jsp";
            session = request.getSession();
            session.removeAttribute("userLogin");
        }
        if (mode.equals("loginStaff")) {
            ArrayList<Staff> listStaff = new ArrayList<>();
            StaffDAO staffDao = new StaffDAO();
            listStaff = staffDao.getStaff();
            for (int i = 0; i < listStaff.size(); i++) {
                if (userNameForm.equals(listStaff.get(i).getUsername()) && passwordForm.equals(listStaff.get(i).getPassword())) {
                    target = "StaffManageServlet?mode=StaffViewBook";
                    session.setAttribute("staffLogin", listStaff.get(i).getStaff_name());
                    break;
                } else {
                    target = "staffLogin.jsp";
                    String mess = "Username or password invalid";
                    request.setAttribute("mess", mess);
                }
            }
        }

        RequestDispatcher rd = request.getRequestDispatcher(target);
        rd.forward(request, response);     
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
