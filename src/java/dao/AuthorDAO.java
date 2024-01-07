/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Author;
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
public class AuthorDAO {

    public ArrayList<Author> getListAuthor() {

        ArrayList<Author> listAuthor = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM authors;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Author author = new Author(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                );
                listAuthor.add(author);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listAuthor;
    }

    public void insertAuthor(Author author) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO authors( author_name, author_bio, author_status) VALUE(?,?,?)");

            pst.setString(1, author.getAuthor_name().toString());
            pst.setString(2, author.getAuthor_bio().toString());
            pst.setInt(3, author.getAuthor_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void updateAuthor(Author author) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE authors SET author_name = ?, author_bio = ?, author_status = ? WHERE author_id = ?";

            PreparedStatement pst = con.prepareStatement(query);
            pst.setInt(4, author.getAuthor_id());
            pst.setString(1, author.getAuthor_name());
            pst.setString(2, author.getAuthor_bio());
            pst.setInt(3, author.getAuthor_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }

    public Author getAuthorByID(int id) {
        Author author = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM authors WHERE author_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                author = new Author(id,
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
        return author;
    }

    public void disableAuthor(int id) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE authors SET author_status = 0 WHERE author_id = ?";
            String query1 = "UPDATE authors SET author_status = 1 WHERE author_id = ?";

            int status = this.getAuthorByID(id).getAuthor_status();
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

    public ArrayList<Author> getListAuthorSearching(String input) {
        ArrayList<Author> listAuthor = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM authors WHERE author_name like ?");
            pst.setString(1, "%" + input + "%");

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {

                Author author = new Author(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4)
                );
                listAuthor.add(author);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listAuthor;
    }

}
