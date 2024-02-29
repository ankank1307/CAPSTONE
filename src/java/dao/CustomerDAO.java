/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author BLC
 */
public class CustomerDAO {

    public ArrayList<Customer> getListCustomer() {

        ArrayList<Customer> listCus = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM customer;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Customer customer = new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
                listCus.add(customer);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listCus;
    }

    public void insertCustomer(Customer customer) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO customer(username, password,name,phone_number,address,email,total_spent,customer_status) VALUE(?,?,?,?,?,?,?,?)");

            pst.setString(1, customer.getUsername());
            pst.setString(2, customer.getPassword());
            pst.setString(3, customer.getName());
            pst.setString(4, customer.getPhone_number());
            pst.setString(5, customer.getAddress());
            pst.setString(6, customer.getEmail());
            pst.setInt(7, customer.getTotal_spent());
            pst.setInt(8,customer.getCustomer_status() );
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
    }
    public ArrayList<Customer> getListCustomerSearching(String input) {
        ArrayList<Customer> listCustomer = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE name like ?");
            pst.setString(1, "%" + input + "%");

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {

                Customer customer = new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9));
                listCustomer.add(customer);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listCustomer;
    }

    public Customer getCustomerByID(int id) {
        Customer customer = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE customer_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                customer = new Customer(id,
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
            }
            con.close();
            pst.close();
            rs.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return customer;
    }

    public Customer getCustomerByEmail(String email) {
        Customer customer = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE email = ?");
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                customer = new Customer(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)
                );
            }
            con.close();
            pst.close();
            rs.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return customer;
    }

    public void disableCustomer(int id) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE customer SET customer_status = 0 WHERE customer_id = ?";
            String query1 = "UPDATE customer SET customer_status = 1 WHERE customer_id = ?";

            int status = this.getCustomerByID(id).getCustomer_status();
            PreparedStatement pst;
            if (status == 1) {
                pst = con.prepareStatement(query);
                pst.setInt(1, id);
            } else {
                pst = con.prepareStatement(query1);
                pst.setInt(1, id);
            }

            pst.executeUpdate();
            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void updateCustomer(Customer customer) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE customer SET username = ?, password = ?, name = ?, phone_number= ?, address = ?, email = ?,total_spent = ?, customer_status=? WHERE customer_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(8, customer.getCustomer_id());
            pst.setString(1, customer.getUsername());
            pst.setString(2, customer.getPassword());
            pst.setString(3, customer.getName());
            pst.setString(4, customer.getPhone_number());
            pst.setString(5, customer.getAddress());
            pst.setString(6, customer.getEmail());
            pst.setInt(7, customer.getCustomer_status());
            pst.setInt(8, customer.getCustomer_status());

            pst.executeUpdate();

            pst.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void updatePassword(Customer customer, String pass) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE customer SET password = ? WHERE customer_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setString(1, pass);
            pst.setInt(2, customer.getCustomer_id());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

}
