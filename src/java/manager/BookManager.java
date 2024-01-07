/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;

import dao.BookDAO;
import entity.Book;
import java.util.ArrayList;

/**
 *
 * @author phuon
 */
public class BookManager {

    private ArrayList<Book> listBook;
    private BookDAO myBookDao;

    public BookManager() {
        this.listBook = new ArrayList();
        myBookDao = new BookDAO();

    }

    public BookManager(ArrayList<Book> listBook) {
        this.listBook = listBook;
        myBookDao = new BookDAO();
    }

    public void getBookbyID(int id) {

        myBookDao.getBookByID(id);

//       Book resBook = null;
//       listBook = this.myBookDao.getListBook();
//        for (int i = 0; i < listBook.size(); i++) {
//            Book currentBook = listBook.get(i);
//            if(currentBook.getBook_id() == id){
//                return currentBook;
//            }
//        }       
////        for (int i = 0; i < this.listBook.size(); i++) {
////            Book currentBook = listBook.get(i);
////            if (currentBook.getBook_id() == id) {
////                return currentBook;
////            }
////        }
//        return resBook;
    }

    public int addBook(Book book) {
        return this.myBookDao.insertBook(book);
    }

//    public boolean deleteBookbyID(int id) {
//        boolean result = false;
//
//        Book foundBook = this.getBookbyID(id);
//        if (foundBook != null) {
//            this.listBook.remove(foundBook);
//            result = true;
//        }
//        return result;
//    }
    public ArrayList getListBook() {
        return this.myBookDao.getListBook();
    }

    public ArrayList<Book> getListBookByID(String id) {
        listBook = myBookDao.getListBook();
        ArrayList<Book> resultBookList = new ArrayList<>();
        Book tempBook;
        for (int i = 0; i < listBook.size(); i++) {
            tempBook = listBook.get(i);
            String a = String.valueOf(tempBook.getBook_id());
            if (a.toLowerCase().startsWith(id)) {
                resultBookList.add(tempBook);
            }
        }
        return resultBookList;
    }

    public ArrayList getBookByGenre(int genre_id) {
        ArrayList resultBooklist = new ArrayList();

        Book tempBook;
        for (int i = 0; i < listBook.size(); i++) {
            tempBook = listBook.get(i);
            if (tempBook.getGenre_id() == genre_id) {
                resultBooklist.add(tempBook);
            }
        }
        return resultBooklist;
    }

    public ArrayList getBookByAuthor(int authorID) {
        ArrayList resultBoooklist = new ArrayList();

        Book tempBook;
        for (int i = 0; i < listBook.size(); i++) {
            tempBook = listBook.get(i);
            if (tempBook.getAuthor_id() == authorID) {
                resultBoooklist.add(tempBook);
            }
        }
        return resultBoooklist;
    }

//    public ArrayList getCDByPriceRang(float from, float to ) {
//        ArrayList resultCdlist = new ArrayList();
//
//        CD tempCD;
//        for(int i=0;i<listCD.size();i++)
//        {
//            tempCD =listCD.get(i);
//            if()
//            {
//                resultCdlist.add(tempCD);
//            }
//        }     
//        return resultCdlist;
//    }
    public void updateBook(Book edittedBook) {
        myBookDao.updateBook(edittedBook);
    }

}
