/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import configPkg.ConfigInfo;
import dao.BookDAO;
import dao.PictureDAO;
import entity.Book;
import entity.Picture;
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
 * @author BLC
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class AddBookServlet extends HttpServlet {

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

            BookManager myBookManager = new BookManager();
            PictureDAO myPictureDAO = new PictureDAO();
            String target = "ViewBook.jsp";
            String title = request.getParameter("title");
            int authorID = Integer.parseInt(request.getParameter("authorID"));
            int genreID = Integer.parseInt(request.getParameter("genreID"));
            int yor = Integer.parseInt(request.getParameter("YOR"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int price = Integer.parseInt(request.getParameter("price"));
            String description = request.getParameter("description");
            Part filePart = request.getPart("image");
            int status = 1;
             
            Book newBook = new Book(title, authorID, genreID, price, quantity, yor, description, status);
            int newId=myBookManager.addBook(newBook);
            String pictureName = newId+".jpg";
            ArrayList<Book> listBook = new ArrayList<>();
            listBook = myBookManager.getListBook();
            
            filePart.write(ConfigInfo.getCtxRealPath() + "\\bookImages\\" + pictureName);
            String baseUrl = "http://localhost:8080/ProjectB_BookSaw";
            String pictureUrl = baseUrl + "/bookImages/" + pictureName;
            Picture picture = new Picture(newId, pictureUrl);
            myPictureDAO.insertImage(picture);
            request.setAttribute("listBook", listBook);
            target = "ManageBookServlet?mode=viewBook";
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

}
