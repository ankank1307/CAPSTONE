/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Picture;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author phuon
 */
public class PictureDAO {
     public void insertImage(Picture picture) {
        try {
            String sqlstm = "INSERT INTO picture(book_id,picture_url) VALUE(?,?)";

            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement(sqlstm);
            pst.setInt(1, picture.getBook_id());
            pst.setString(2, picture.getPicture());
            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
  }   
     
}
