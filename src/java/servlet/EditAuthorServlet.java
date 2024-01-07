/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.AuthorDAO;
import entity.Author;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.AuthorManager;

/**
 *
 * @author phuon
 */
public class EditAuthorServlet extends HttpServlet {

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
            AuthorManager myAuthorManager = new AuthorManager();
            AuthorDAO myAuthorDAO = new AuthorDAO();
            String mode = request.getParameter("mode");
            String target = "home.jsp";

            if (mode.equals("viewAuthor")) {
                int id = Integer.parseInt(request.getParameter("authorID"));
//                String name = request.getParameter("name");
//                int status = Integer.parseInt(request.getParameter("status"));
                Author tempAuthor = myAuthorDAO.getAuthorByID(id);
                request.setAttribute("tempAuthor", tempAuthor);
                target = "EditAuthor.jsp";
            }

            if (mode.equals("editAuthor")) {
                int ID, status;
                String authorName, authorBio;

                ID = Integer.parseInt(request.getParameter("authorID"));
                authorName = request.getParameter("authorName");
                authorBio = request.getParameter("authorBio");
                status = Integer.parseInt(request.getParameter("status"));

                Author newAuthor = new Author(ID, authorName, authorBio, status);
                myAuthorManager.updateAuthor(newAuthor);

                target = "ManageAuthorServlet?mode=viewAuthor";
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
