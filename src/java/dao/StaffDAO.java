/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Staff;
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
public class StaffDAO {
    public ArrayList<Staff> getStaff() {
        try {

            Connection con = DBContext.getConnection();
            String query = "select * from staff;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            ArrayList<Staff> listStaff = new ArrayList<>();
            while (rs.next()) {
                int staff_id = rs.getInt("staff_id");
                String staff_name = rs.getString("staff_name");
                String uName = rs.getString("username");
                String pass = rs.getString("password");
                String email = rs.getString("email");
                int staff_status = rs.getInt("staff_status");
        
                Staff staff = new Staff(staff_id, staff_name, uName, pass, email, staff_status);
                listStaff.add(staff);
            }
            return listStaff;
        } catch (Exception e) {
        }
        return null;
    }
      public void insertStaff(Staff staff) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO staff( staff_name, username, password, email, staff_status) VALUE(?,?,?,?,?)");
            pst.setString(1, staff.getStaff_name());
            pst.setString(2, staff.getUsername());
            pst.setString(3, staff.getPassword());
            pst.setString(4, staff.getEmail());
            pst.setInt(5, staff.getStaff_status());
            pst.executeUpdate();
            pst.close();
            con.close();
            System.out.println();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public void updateStaff(Staff staff) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE staff SET staff_name = ?, username = ?, password = ? , email = ?, staff_status=? WHERE staff_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(6, staff.getStaff_id());
            pst.setString(1, staff.getStaff_name());
            pst.setString(2, staff.getUsername());
            pst.setString(3, staff.getPassword());
            pst.setString(4, staff.getEmail());
            pst.setInt(5, staff.getStaff_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public Staff getStaffByID(int id) {
        Staff staff = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM staff WHERE staff_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                staff = new Staff(id,
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6)
                );
            }
            con.close();
            pst.close();
            rs.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return staff;
    }
    
    public void disableStaff(int id) {

        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE staff SET staff_status = 0 WHERE staff_id = ?";
            String query1 = "UPDATE staff SET staff_status = 1 WHERE staff_id = ?";

            int status = this.getStaffByID(id).getStaff_status();
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
}
