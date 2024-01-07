/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author phuon
 */
public class Picture {
    private int book_id;
    private String picture;

    public Picture(int book_id, String picture) {
        this.book_id = book_id;
        this.picture = picture;
    }

    public int getBook_id() {
        return book_id;
    }
    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
    
}
