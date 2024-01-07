/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author BLC
 */
public class OrderDetailDAO {

    public ArrayList<OrderDetail> getListOrderDetail() {

        ArrayList<OrderDetail> listOrder = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM orderdetail;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4)
                );
                listOrder.add(orderDetail);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }
    
    public ArrayList<OrderDetail> getListOrderDetail_1() {
        ArrayList<OrderDetail> listOrderDetail = new ArrayList<>();

        String query = "select * from orderdetail inner join books on orderdetail.book_id = books.book_id inner join picture on orderdetail.book_id = picture.book_id order by orderdetail.book_id";
        Statement st;
        try {
            Connection con = DBContext.getConnection();
            st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(6),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(15)
                        );
                listOrderDetail.add(orderDetail);
            }

        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return listOrderDetail;
    }
    
    public ArrayList<OrderDetail> getListOrderDetailByOrder(int orderID) {
        ArrayList<OrderDetail> listOrderDetail = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM orderdetail Where order_id = ?");
            pst.setInt(1, orderID);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4)
                );
                listOrderDetail.add(orderDetail);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
        
    return listOrderDetail;
}
    
    public void insertOrderDetail(OrderDetail orderDetail) {
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("INSERT INTO orderdetail (order_id, book_id,quantity, price) VALUE(?,?,?,?)");

            pst.setInt(1, orderDetail.getOrder_id());
            pst.setInt(2, orderDetail.getBook_id());
            pst.setInt(3, orderDetail.getQuantity());
            pst.setInt(4, orderDetail.getPrice());


            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
    }
}
