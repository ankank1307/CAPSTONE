/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author BLC
 */
public class DBContext {

    static final String DB_URL = "jdbc:mysql://localhost:3306/bookstore";
    static final String DB_DRV = "com.mysql.jdbc.Driver";
    static final String DB_USER = "root";
    static final String DB_PASSWD = "admin";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(DB_DRV);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWD);
            if (con == null) {
                System.out.println("-----------------------------------CON IS NULL");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("----------------------" + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
}
