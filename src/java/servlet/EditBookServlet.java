/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import configPkg.ConfigInfo;
import dao.AuthorDAO;
import dao.BookDAO;
import dao.GenreDAO;
import entity.Author;
import entity.Book;
import entity.Genre;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import manager.BookManager;

/**
 *
 * @author phuon
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100)// 100 MB
public class EditBookServlet extends HttpServlet {

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
            BookManager myBookManager = new BookManager();
            BookDAO myBookDAO = new BookDAO();
            String mode = request.getParameter("mode");
            String target = "home.jsp";

            if (mode.equals("viewBook")) {
                int id = Integer.parseInt(request.getParameter("bookID"));
                Book tempBook = myBookDAO.getBookByID(id);
                ArrayList<Author> listAuthor = new ArrayList<>();
                AuthorDAO authorDao = new AuthorDAO();
                listAuthor = authorDao.getListAuthor();

                ArrayList<Genre> listGenre = new ArrayList<>();
                GenreDAO genreDAO = new GenreDAO();
                listGenre = genreDAO.getListGenre();
                request.setAttribute("listAuthor", listAuthor);
                request.setAttribute("listGenre", listGenre);
                System.out.println(tempBook.getTitle());
                request.setAttribute("tempBook", tempBook);

                target = "EditBook.jsp";
            }

            if (mode.equals("editBook")) {
                int bookID, authorID, genreID, price, quantity, yor, status;
                String title, description;

                bookID = Integer.parseInt(request.getParameter("bookID"));
                authorID = Integer.parseInt(request.getParameter("authorID"));
                genreID = Integer.parseInt(request.getParameter("genreID"));
                price = Integer.parseInt(request.getParameter("price"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
                yor = Integer.parseInt(request.getParameter("YOR"));
                status = Integer.parseInt(request.getParameter("status"));
                title = request.getParameter("title");
                description = request.getParameter("description");
                String pictureName = bookID + ".jpg";
                Part imgFilePart = request.getPart("image");
                Book newBook = new Book(bookID, title, authorID, genreID, price, quantity, yor, description, status);
                myBookManager.updateBook(newBook);
                   if (imgFilePart != null) {
                    imgFilePart.write(ConfigInfo.getCtxRealPath() + "\\bookImages\\" + pictureName);
                }
                target = "ManageBookServlet?mode=viewBook";
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
