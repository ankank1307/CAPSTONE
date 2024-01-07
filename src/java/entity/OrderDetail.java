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
public class OrderDetail {

    private int order_id;
    private int book_id;
    private String title;
    private int quantity;
    private int price;
    private String picture;

    public OrderDetail(int order_id, int book_id, int quantity, int price) {
        this.order_id = order_id;
        this.book_id = book_id;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderDetail(int order_id, int book_id, String title, int quantity, int price, String picture) {
        this.order_id = order_id;
        this.book_id = book_id;
        this.title = title;
        this.quantity = quantity;
        this.price = price;
        this.picture = picture;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    
    
    
  


    

    public int getOrder_id() {
        return order_id;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }
    

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

}
