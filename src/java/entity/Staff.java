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
public class Staff {
    private int staff_id;
    private String staff_name;
    private String username;
    private String password;
    private String email;
    private int staff_status;

    public Staff(int staff_id, String staff_name, String username, String password, String email, int staff_status) {
        this.staff_id = staff_id;
        this.staff_name = staff_name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.staff_status = staff_status;
    }

    public Staff(String staff_name, String username, String password, String email, int staff_status) {
        this.staff_name = staff_name;
        this.username = username;
        this.password = password;
        this.email = email;
        this.staff_status = staff_status;
    }

   
    

    public int getStaff_id() {
        return staff_id;
    }

    public String getStaff_name() {
        return staff_name;
    }

    public void setStaff_name(String staff_name) {
        this.staff_name = staff_name;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getStaff_status() {
        return staff_status;
    }

    public void setStaff_status(int staff_status) {
        this.staff_status = staff_status;
    }
    
    
}
