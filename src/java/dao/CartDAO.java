/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Cart;
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
public class CartDAO {

    public void insertIntoCart(Cart cart) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO cart( book_id, customer_id, title,price,quantity,picture) VALUE(?,?,?,?,?,?)");

            pst.setInt(1, cart.getBookID());
            pst.setInt(2, cart.getCustomer_id());
            pst.setString(3, cart.getTitle());
            pst.setInt(4, cart.getPrice());
            pst.setInt(5, cart.getQuantity());
            pst.setString(6, cart.getPicture());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
    }

    public void updateQuantity(Cart cart) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE cart SET quantity = ? WHERE book_id = ? and customer_id=?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(1, cart.getQuantity());
            pst.setInt(2, cart.getBookID());
            pst.setInt(3, cart.getCustomer_id());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    public void DeleteCartItem(int book_id, int customer_id) {
        try {
            Connection con = DBContext.getConnection();

            String query = "delete from cart where book_id = ? and  customer_id = ?;";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(1, book_id);
            pst.setInt(2, customer_id);
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public ArrayList<Cart> getListCart() {

        ArrayList<Cart> listCart = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM cart;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {

                Cart cart = new Cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getString(6));
                listCart.add(cart);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listCart;
    }
    
    public ArrayList<Cart> getListCartByCustomerID(int customerID) {
        ArrayList<Cart> listCart = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM cart where customer_id = ?");
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                Cart cart = new Cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getString(6));
                listCart.add(cart);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listCart;
    }
}
