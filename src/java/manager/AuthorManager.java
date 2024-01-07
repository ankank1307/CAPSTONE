/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;

import dao.AuthorDAO;
import dao.BookDAO;
import entity.Author;
import java.sql.SQLException;

import java.util.ArrayList;

/**
 *
 * @author phuon
 */
public class AuthorManager {

    private ArrayList<Author> listAuthor;
    private AuthorDAO myAuthorDao;

    public AuthorManager() {
        this.listAuthor = new ArrayList();
        myAuthorDao = new AuthorDAO();
//        myBookDao.createFolder();

    }

    public AuthorManager(ArrayList<Author> listAuthor) {
        this.listAuthor = listAuthor;
        myAuthorDao = new AuthorDAO();
    }

    public Author getAuthorByID(int id) {
        listAuthor = this.myAuthorDao.getListAuthor();

        Author resAuthor = null;
        for (int i = 0; i < this.listAuthor.size(); i++) {
            Author currentAuthor = listAuthor.get(i);
            if (currentAuthor.getAuthor_id() == id) {
                return currentAuthor;
            }
        }
        return resAuthor;
//            this.myAuthorDao.getAuthorByID(id);
    }

    public void addAuthor(Author author) {
        this.myAuthorDao.insertAuthor(author);
    }

//    public boolean deleteBookbyID(int id) {
//        boolean result = false;
//
//        Book foundBook = this.getAuthorByID(id);
//        if (foundBook != null) {
//            this.listBook.remove(foundBook);
//            result = true;
//        }
//        return result;
//    }
    public ArrayList getListAuthor() {
        return this.myAuthorDao.getListAuthor();
    }

    public ArrayList getAuthorByName(String name) {
        ArrayList resultAuthorlist = new ArrayList();

        Author tempAuthor;
        for (int i = 0; i < listAuthor.size(); i++) {
            tempAuthor = listAuthor.get(i);
            if (tempAuthor.getAuthor_name().toLowerCase().equalsIgnoreCase(name)) {
                resultAuthorlist.add(tempAuthor);
            }
        }
        return resultAuthorlist;
    }

    public void updateAuthor(Author edittedAuthor) {
//        boolean result = false;
//        Author oldAuthor;
        //        for(int i=0;i<this.listCD.size();i++)
        //        {
        //            oldCD=(CD)this.listCD.get(i);
        //            if(oldCD.getCdID().equalsIgnoreCase(edittedCD.getCdID()))
        //            {
        //                this.listCD.remove(i);
        //                this.listCD.add(i, edittedCD);
        //                result=true;
        //                break;
        //            }
        //        }
//        oldAuthor = this.myAuthorDao.getListAuthor();
//        if (oldAuthor != null) {
//            int i = this.listAuthor.indexOf(oldAuthor);
//            this.listAuthor.remove(i);
//            this.listAuthor.add(i, edittedAuthor);
//            result = true;
//        }
//        return result;
        this.myAuthorDao.updateAuthor(edittedAuthor);
    }
}
