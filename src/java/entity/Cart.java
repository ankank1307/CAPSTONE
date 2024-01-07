/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;

/**
 *
 * @author BLC
 */
public class Cart implements Serializable{
    private int book_id;
    private String title;
    private int price;
    private int quantity;
    private String picture;
    private int customer_id;

    public Cart() {
    }

    public Cart(int bookID, String title, int price, int quantity) {
        this.book_id = bookID;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
    }

    public Cart(int bookID,int customer_id, String title, int price, int quantity, String picture) {
        this.book_id = bookID;
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.picture = picture;
        this.customer_id = customer_id;
    }
    

    public int getBookID() {
        return book_id;
    }

    public void setBookID(int bookID) {
        this.book_id = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public int getCustomer_id() {
        return customer_id;
    }
 
}
