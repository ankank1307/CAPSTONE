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
public class Author {

    private int author_id;
    private String author_name;
    private String author_bio;
    private int author_status;

    public Author(int author_id, String author_name, String author_bio, int author_status) {
        this.author_id = author_id;
        this.author_name = author_name;
        this.author_bio = author_bio;
        this.author_status = author_status;
    }

    public Author(String author_name, String author_bio, int author_status) {
        this.author_name = author_name;
        this.author_bio = author_bio;
        this.author_status = author_status;
    }

    public int getAuthor_id() {
        return author_id;
    }

    public void setAuthor_id(int author_id) {
        this.author_id = author_id;
    }

    public String getAuthor_name() {
        return author_name;
    }

    public void setAuthor_name(String author_name) {
        this.author_name = author_name;
    }

    public String getAuthor_bio() {
        return author_bio;
    }

    public void setAuthor_bio(String author_bio) {
        this.author_bio = author_bio;
    }

    public int getAuthor_status() {
        return author_status;
    }

    public void setAuthor_status(int author_status) {
        this.author_status = author_status;
    }
}
