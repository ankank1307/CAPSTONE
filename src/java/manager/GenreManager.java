/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manager;

import dao.GenreDAO;
import entity.Genre;
import java.util.ArrayList;

/**
 *
 * @author phuon
 */
public class GenreManager {

    private ArrayList<Genre> listGenre;
    private GenreDAO myGenreDao;

    public GenreManager() {
        this.listGenre = new ArrayList();
        myGenreDao = new GenreDAO();

    }

//    public GenreManager(ArrayList<Genre> listGenre)
//    {
//        this.listGenre= listGenre;
//        myGenreDao=new GenreDAO();
//    }
    public void getGenreByID(int id) {
//        Genre resGenre = null;
//        for (int i = 0; i < this.listGenre.size(); i++) {
//            Genre currentGenre = listGenre.get(i);
//            if (currentGenre.getGenre_id()== id) {
//                return currentGenre;
//            }
//        }
//        return resGenre;

        myGenreDao.getGenreByID(id);
    }

    public void addGenre(Genre genre) {
        this.myGenreDao.insertGenre(genre);
    }

//    public boolean deleteBookbyID(int id) {
//        boolean result = false;
//
//        Book foundBook = this.getGenreByID(id);
//        if (foundBook != null) {
//            this.listBook.remove(foundBook);
//            result = true;
//        }
//        return result;
//    }
    public ArrayList getListGenre() {
        return this.listGenre;
    }

    public ArrayList getGenreByName(String name) {
        ArrayList resultGenrelist = new ArrayList();

        Genre tempGenre;
        for (int i = 0; i < listGenre.size(); i++) {
            tempGenre = listGenre.get(i);
            if (tempGenre.getGenre().toLowerCase().equalsIgnoreCase(name)) {
                resultGenrelist.add(tempGenre);
            }
        }
        return resultGenrelist;
    }

//    public boolean updateGenre(Genre edittedGenre) {
//        boolean result = false;
//        Genre oldGenre;
//        //        for(int i=0;i<this.listCD.size();i++)
//        //        {
//        //            oldCD=(CD)this.listCD.get(i);
//        //            if(oldCD.getCdID().equalsIgnoreCase(edittedCD.getCdID()))
//        //            {
//        //                this.listCD.remove(i);
//        //                this.listCD.add(i, edittedCD);
//        //                result=true;
//        //                break;
//        //            }
//        //        }
//        oldGenre = this.getGenreByID(edittedGenre.getGenre_id());
//        if (oldGenre != null) {
//            int i = this.listGenre.indexOf(oldGenre);
//            this.listGenre.remove(i);
//            this.listGenre.add(i, edittedGenre);
//            result = true;
//        }
//        return result;
//    }
}
