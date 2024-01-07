/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Rate;
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
public class RateDAO {

    public void insertIntoRate(Rate rate) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO rate( rate, comment, customer_id, book_id, order_id) VALUE(?,?,?,?,?)");

            pst.setDouble(1, rate.getRate());
            pst.setString(2, rate.getComment());
            pst.setInt(3, rate.getCustomer_id());
            pst.setInt(4, rate.getBook_id());
            pst.setInt(5, rate.getOrder_id());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
    }

    public ArrayList<Rate> getListRatedBooks() {

        ArrayList<Rate> listRatedBooks = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM rate;";
            //Statement st = con.prepareStatement(query);
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery(query);
            

            while (rs.next()) {
                Rate ratedBook = new Rate(
                        rs.getDouble(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5)
                );
                listRatedBooks.add(ratedBook);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listRatedBooks;
    }

}
