/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Genre;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author BLC
 */
public class GenreDAO {

    public ArrayList<Genre> getListGenre() {

        ArrayList<Genre> listGenre = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM genre;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Genre genre = new Genre(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                );
                listGenre.add(genre);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listGenre;
    }

    public void insertGenre(Genre genre) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO genre( genre, description, genre_status) VALUE(?,?,?)");

            pst.setString(1, genre.getGenre());
            pst.setString(2, genre.getDescription());
            pst.setInt(3, genre.getGenre_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
    }

    public void updateGenre(Genre genre) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE genre SET genre = ?, description = ?, genre_status = ? WHERE genre_id = ?";

            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(4, genre.getGenre_id());
            pst.setString(1, genre.getGenre());
            pst.setString(2, genre.getDescription());
            pst.setInt(3, genre.getGenre_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }

    public Genre getGenreByID(int id) {
        Genre genre = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM genre WHERE genre_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                genre = new Genre(id,
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4));
            }
            con.close();
            pst.close();
            rs.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return genre;
    }

    public void disableGenre(int id) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE genre SET genre_status = 0 WHERE genre_id = ?";
            String query1 = "UPDATE genre SET genre_status = 1 WHERE genre_id = ?";

            int status = this.getGenreByID(id).getGenre_status();
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
    
    public ArrayList<Genre> getListGenreSearching(String input) {
        ArrayList<Genre> listGenre = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM genre WHERE genre like ?");
            pst.setString(1, "%" + input + "%");

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {

                Genre genre = new Genre(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                );
                listGenre.add(genre);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listGenre;
    }
}
