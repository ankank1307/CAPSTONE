/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.AuthorDAO;
import dao.BookDAO;
import dao.GenreDAO;
import entity.Author;
import entity.Book;
import entity.Genre;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manager.BookManager;

/**
 *
 * @author phuon
 */
public class ManageBookServlet extends HttpServlet {

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
            String mode = request.getParameter("mode");
            BookManager myBookManager = new BookManager();
            String target = "home.jsp";
            BookDAO myBookDAO = new BookDAO();

            if (mode.equals("viewBook")) {
                List<Book> listBook = new ArrayList<>();

                listBook = myBookDAO.getListBook();

                target = "ViewBook.jsp";
                request.setAttribute("listBook", listBook);

            }
            if(mode.equals("viewBookByGenre")){
                int genreID = Integer.parseInt(request.getParameter("genreID"));
                ArrayList<Book> listGenreBook = new ArrayList<>();
                listGenreBook = myBookDAO.getListBookByGenre(genreID);
                
                request.setAttribute("listGenreBook", listGenreBook);
                target = "ViewBookByGenre.jsp";
            }
            
            if(mode.equals("viewBookByAuthor")){
                int authorID = Integer.parseInt(request.getParameter("authorID"));
                ArrayList<Book> listAuthorBook = new ArrayList<>();
                listAuthorBook = myBookDAO.getListBookByAuthor(authorID);
                
                request.setAttribute("listAuthorBook", listAuthorBook);
                target = "ViewBookByAuthor.jsp";
            }
            
            if (mode.equals("addBook")) {
                ArrayList<Author> listAuthor = new ArrayList<>();
                AuthorDAO authorDao = new AuthorDAO();
                listAuthor = authorDao.getListAuthor();

                ArrayList<Genre> listGenre = new ArrayList<>();
                GenreDAO genreDAO = new GenreDAO();
                listGenre = genreDAO.getListGenre();

                target = "AddBook.jsp";
                request.setAttribute("listAuthor", listAuthor);
                request.setAttribute("listGenre", listGenre);

            }
            if (mode.equals("disableBook")) {

                int id = Integer.parseInt(request.getParameter("bookID"));
                myBookDAO.disableBook(id);
                target = "ManageBookServlet?mode=viewBook";
            }
            if(mode.equals("search")){
                String input = request.getParameter("searchInput");
                ArrayList<Book> listBook = myBookDAO.getListBookSearching(input);
                
                request.setAttribute("listBook", listBook);
                target = "ViewBook.jsp";

                
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
