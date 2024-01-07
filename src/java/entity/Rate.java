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
public class Rate {
    private double rate;
    private String comment;
    private int customer_id;
    private int book_id;
    private int order_id;

    public Rate(double rate, String comment, int customer_id, int book_id, int order_id) {
        this.rate = rate;
        this.comment = comment;
        this.customer_id = customer_id;
        this.book_id = book_id;
        this.order_id = order_id;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public int getOrder_id() {
        return order_id;
    }
    
    
}
