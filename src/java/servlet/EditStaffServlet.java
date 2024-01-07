/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.StaffDAO;
import entity.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tuyen Do
 */
public class EditStaffServlet extends HttpServlet {

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
            
            StaffDAO myStaffDAO = new StaffDAO();
            String mode = request.getParameter("mode");
            String target = "home.jsp";

            if (mode.equals("viewStaff")) {
                int id = Integer.parseInt(request.getParameter("staffID"));
//                String name = request.getParameter("name");
//                int status = Integer.parseInt(request.getParameter("status"));
                Staff tempStaff = myStaffDAO.getStaffByID(id);
                request.setAttribute("tempStaff", tempStaff);
                target = "EditStaff.jsp";
            }

            if (mode.equals("editStaff")) {
                int ID, status;
                String staffName, staffUserName, staffEmail, staffPassword;

                ID = Integer.parseInt(request.getParameter("staffID"));
                Staff thisStaff = myStaffDAO.getStaffByID(ID);
                staffName = request.getParameter("staffName");
                staffUserName = request.getParameter("staffUserName");
                staffPassword = thisStaff.getPassword();
                staffEmail = request.getParameter("staffEmail");
                status = Integer.parseInt(request.getParameter("status"));

                Staff newStaff = new Staff(ID, staffName, staffUserName, staffPassword,staffEmail, status );
                myStaffDAO.updateStaff(newStaff);

                target = "ManageStaffServlet?mode=viewStaff";
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
