/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.GenreDAO;
import entity.Genre;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.GenreManager;

/**
 *
 * @author phuon
 */
public class EditGenreServlet extends HttpServlet {

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
            GenreManager myGenreManager = new GenreManager();
            GenreDAO myGenreDAO = new GenreDAO();
            String mode = request.getParameter("mode");
            String target = "home.jsp";

            if (mode.equals("viewGenre")) {
                int id = Integer.parseInt(request.getParameter("genreID"));
//                String name = request.getParameter("name");
//                int status = Integer.parseInt(request.getParameter("status"));
                Genre tempGenre = myGenreDAO.getGenreByID(id);
                request.setAttribute("tempGenre", tempGenre);
                target = "EditGenre.jsp";
            }

            if (mode.equals("editGenre")) {
                int ID, status;
                String genre, description;

                ID = Integer.parseInt(request.getParameter("genreID"));
                genre = request.getParameter("genre");
                description = request.getParameter("description");
                status = Integer.parseInt(request.getParameter("status"));

                Genre newGenre = new Genre(ID, genre, description, status);
                myGenreDAO.updateGenre(newGenre);

                target = "ManageGenreServlet?mode=viewGenre";
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
