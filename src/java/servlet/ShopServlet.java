 /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.BookDAO;
import entity.Book;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author BLC
 */
public class ShopServlet extends HttpServlet {

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
            BookDAO myBookDAO = new BookDAO();
            String mode = request.getParameter("mode");
            String target = "";
            if (mode.equals("viewShop")) {
                
                ArrayList<Book> listBook = myBookDAO.getListBook();
                for (int i = 0; i < listBook.size(); i++) {
                    if (listBook.get(i).getBook_status() == 0) {
                        listBook.remove(i);
                    }
                }
                
                request.setAttribute("listBook", listBook);
                target = "Shop.jsp";
            }
            
            if (mode.equals("search")) {
                String input = request.getParameter("searchInput");
                ArrayList<Book> listBook = myBookDAO.getListBookSearching(input);
                for (int i = 0; i < listBook.size(); i++) {
                    if (listBook.get(i).getBook_status() == 0) {
                        listBook.remove(i);
                    }
                }
                request.setAttribute("listBook", listBook);
                target = "Shop.jsp";
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
