/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.CustomerVoucher;
import entity.Discount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author phuon
 */
public class DiscountDAO {
     public ArrayList<Discount> getListDiscount() {

        ArrayList<Discount> listDiscount = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM discount;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Discount discount = new Discount(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7)
                );
                listDiscount.add(discount);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listDiscount;
    }

    public void insertDiscount(Discount discount) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO discount(code, percent,quantity, end_date, status,description) VALUE(?,?,?,?,?,?)");
            
            pst.setString(1, discount.getCode().toString());
            pst.setInt(2, discount.getPercent());
            pst.setInt(3, discount.getQuantity());
            pst.setString(4, discount.getEndDate().toString());
            pst.setInt(5, discount.getStatus());
            pst.setString(6, discount.getDescription());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    

    public void updateDiscount(Discount discount) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE discount SET percent = ?, quantity = ?, end_start = ?, status = ?, description = ? WHERE voucher_id = ?";

            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(6, discount.getVoucher_id());
            pst.setInt(1, discount.getPercent());
            pst.setInt(2, discount.getQuantity());
            pst.setString(3, discount.getEndDate().toString());
            pst.setInt(4, discount.getStatus());
            pst.setString(5, discount.getDescription());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }

    public Discount getDiscountByID(int id) {
        Discount discount = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM discount WHERE voucher_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                discount = new Discount(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7)
                );
            }
            con.close();
            pst.close();
            rs.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return discount;
    }
    public void insertCustomerVoucher(int voucher_id , int customer_id ) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO customer_voucher(voucher_id,customer_id,status) VALUE(?,?,?)");
            
            pst.setInt(1, voucher_id);
            pst.setInt(2,customer_id );
            pst.setInt(3, 1);
            
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
     
      public ArrayList<CustomerVoucher> getListCustomerVoucher() {

        ArrayList<CustomerVoucher> listVoucher = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM customer_voucher inner join discount on customer_voucher.voucher_id = discount.voucher_id";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                CustomerVoucher cv = new CustomerVoucher(rs.getInt(2),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8),
                        rs.getInt(3),
                        rs.getString(10)
                );
                
                listVoucher.add(cv);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listVoucher;
    }

    
}
