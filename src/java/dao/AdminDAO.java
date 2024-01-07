/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Admin;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author BLC
 */
public class AdminDAO {

    public ArrayList<Admin> getAdmin() {
        try {

            Connection con = DBContext.getConnection();
            String query = "select * from admin;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            ArrayList<Admin> listAdmin = new ArrayList<>();
            while (rs.next()) {

                String uName = rs.getString("username");
                String pass = rs.getString("password");

                Admin admin = new Admin(uName, pass);
                listAdmin.add(admin);
            }
            return listAdmin;
        } catch (Exception e) {
        }
        return null;
    }

//    public ArrayList<Admin> Admin() {
//        String username = "admin";
//        String password = "admin";
//        Admin admin = new Admin(username, password);
//        ArrayList<Admin> listAdmin = new ArrayList<>();
//        listAdmin.add(admin);
//
//        return listAdmin;
//    }
}
