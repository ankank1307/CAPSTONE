    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author phuon
 */
public class Genre {

    private int genre_id;
    private String genre;
    private String description;
    private int genre_status;

    public Genre(int genre_id, String genre, String description, int genre_status) {
        this.genre_id = genre_id;
        this.genre = genre;
        this.description = description;
        this.genre_status = genre_status;
    }

    public Genre(String genre, String description, int genre_status) {
        this.genre = genre;
        this.description = description;
        this.genre_status = genre_status;
    }

    public int getGenre_id() {
        return genre_id;
    }

    public void setGenre_id(int genre_id) {
        this.genre_id = genre_id;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getGenre_status() {
        return genre_status;
    }

    public void setGenre_status(int genre_status) {
        this.genre_status = genre_status;
    }
}
