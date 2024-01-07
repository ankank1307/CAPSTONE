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
public class Customer {

    private int customer_id;
    private String username;
    private String password;
    private String name;
    private String phone_number;
    private String address;
    private String email;
    private int total_spent ;
    private int customer_status;

    public Customer(int customer_id, String username, String password, String name, String phone_number, String address, String email,int total_spent, int customer_status) {
        this.customer_id = customer_id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.phone_number = phone_number;
        this.address = address;
        this.email = email;
        this.customer_status = customer_status;
        this.total_spent = total_spent;
    }

    public Customer(String username, String password, String name, String phone_number, String address, String email,int total_spent, int customer_status) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.phone_number = phone_number;
        this.address = address;
        this.email = email;
        this.customer_status = customer_status;
        this.total_spent = total_spent;
    }

    public Customer() {
    }
    

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCustomer_status() {
        return customer_status;
    }

    public void setCustomer_status(int customer_status) {
        this.customer_status = customer_status;
    }

    public int getTotal_spent() {
        return total_spent;
    }

    public void setTotal_spent(int total_spent) {
        this.total_spent = total_spent;
    }
    
}
