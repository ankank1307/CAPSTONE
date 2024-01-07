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
public class Order {

    private int order_id;
    private int customer_id;
    private String order_date;
    private int total;
    private String shipping_status;
    private int order_status;
    private String review_status;

    public Order(int order_id, int customer_id, String order_date, int total, String shipping_status, int order_status, String reivew_status) {
        this.order_id = order_id;
        this.customer_id = customer_id;
        this.order_date = order_date;
        this.total = total;
        this.shipping_status = shipping_status;
        this.order_status = order_status;
        this.review_status = reivew_status;
    }

    public Order(int customer_id, String order_date, int order_status) {
        this.customer_id = customer_id;
        this.order_date = order_date;
        this.order_status = order_status;
    }

  
    
    

    public Order(int customer_id, String order_date, int total, String shipping_status, int order_status,String review_status) {
        this.customer_id = customer_id;
        this.order_date = order_date;
        this.total = total;
        this.shipping_status = shipping_status;
        this.order_status = order_status;
        this.review_status = review_status;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public String getReview_status() {
        return review_status;
    }

    public void setReview_status(String review_status) {
        this.review_status = review_status;
    }
    

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getOrder_date() {
        return order_date;
    }

    public void setOrder_date(String order_date) {
        this.order_date = order_date;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getShipping_status() {
        return shipping_status;
    }

    public void setShipping_status(String shipping_status) {
        this.shipping_status = shipping_status;
    }

    public int getOrder_status() {
        return order_status;
    }

    public void setOrder_status(int order_status) {
        this.order_status = order_status;
    }
}
