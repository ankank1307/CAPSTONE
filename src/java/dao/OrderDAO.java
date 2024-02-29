/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Order;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author BLC
 */
public class OrderDAO {

    public ArrayList<Order> getListOrder() {

        ArrayList<Order> listOrder = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM orders;";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Order order = new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8)
                );
                listOrder.add(order);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }

    public ArrayList<Order> getListOrderByDate(String startDate, String endDate) {
        ArrayList<Order> listOrder = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM orders WHERE order_date BETWEEN ? AND ?;";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, startDate);
            pst.setString(2, endDate);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8)
                );
                listOrder.add(order);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }

    public List<Map<Object, Object>> getRevenueByMonth(int year) {
        List<Map<Object, Object>> listRevenueByMonth = new ArrayList<Map<Object, Object>>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM orders WHERE MONTH(order_date) = ? and YEAR(order_date) = ? and shipping_status in ('Completed','Done')";
            PreparedStatement pst = con.prepareStatement(query);
            
            for (int i = 1; i <= 12; i++) {
                Map<Object, Object> map = new HashMap<>();
                if (i==1) {
                    map.put("label", "January");
                }
                if (i==2) {
                    map.put("label", "February");
                }
                if (i==3) {
                    map.put("label", "March");
                }
                if (i==4) {
                    map.put("label", "April");
                }
                if (i==5) {
                    map.put("label", "May");
                }
                if (i==6) {
                    map.put("label", "June");
                }
                if (i==7) {
                    map.put("label", "July");
                }
                if (i==8) {
                    map.put("label", "August");
                }
                if (i==9) {
                    map.put("label", "September");
                }
                if (i==10) {
                    map.put("label", "October");
                }
                if (i==11) {
                    map.put("label", "November");
                }
                if (i==12) {
                    map.put("label", "December");
                }
                
                pst.setInt(1, i);
                pst.setInt(2, year);
                ResultSet rs = pst.executeQuery();
                int revenue = 0;
                while (rs.next()) {
                    Order order = new Order(
                            rs.getInt(1),
                            rs.getInt(2),
                            rs.getString(3),
                            rs.getInt(4),
                            rs.getString(5),
                            rs.getInt(6),
                            rs.getString(8)
                    );
                    revenue += order.getTotal();
                }
                map.put("y", revenue);
                map.put("exploded", true);
                listRevenueByMonth.add(map);

            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listRevenueByMonth;
    }

    public ArrayList<Order> getListOrderByCustomerID(int customerID) {

        ArrayList<Order> listOrder = new ArrayList<>();

        try {
            Connection con = DBContext.getConnection();
            String query = "SELECT * FROM orders WHERE customer_id = " + customerID;
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Order order = new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8)
                );
                listOrder.add(order);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }

    public int saveOrders(Order order) {
        int newID = 0;
        try {
            String sqlstm = "INSERT INTO orders(customer_id, order_date, total , shipping_status, order_status, review_status) VALUE(?,?,?,?,?,?)";

            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement(sqlstm, PreparedStatement.RETURN_GENERATED_KEYS);

            pst.setInt(1, order.getCustomer_id());
            pst.setString(2, order.getOrder_date());
            pst.setInt(3, order.getTotal());
            pst.setString(4, order.getShipping_status());
            pst.setInt(5, order.getOrder_status());
            pst.setString(6, order.getReview_status());

            pst.executeUpdate();

            ResultSet res = pst.getGeneratedKeys();

            while (res.next()) {
                newID = res.getInt(1);
                System.out.println("Generated key: ----------" + newID);
            }

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());

        }
        return newID;
    }

    public Order getOrderByID(int id) {
        Order order = null;
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM orders WHERE order_id = ?");
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                order = new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8)
                );
            }
            con.close();
            pst.close();
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return order;
    }

    public void removeOrderByID(int orderID) {
        try {
            Connection con = DBContext.getConnection();

            String query = "DELETE from orders WHERE order_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(1, orderID);

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void updateOrder(Order order) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE orders SET customer_id = ?, order_date = ?, total = ? , shipping_status = ?, order_status = ? WHERE order_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(6, order.getOrder_id());
            pst.setInt(1, order.getCustomer_id());
            pst.setString(2, order.getOrder_date());
            pst.setInt(3, order.getTotal());
            pst.setString(4, order.getShipping_status());
            pst.setInt(5, order.getOrder_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public ArrayList<Order> getListOrderSearching(String input) {
        ArrayList<Order> listOrder = new ArrayList<>();
        try {
            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement("SELECT * FROM orders WHERE order_id like ?");
            pst.setString(1, "%" + input + "%");

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {

                Order order = new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(8)
                );
                listOrder.add(order);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }

    public void updateOrderReview(Order order) {
        try {
            Connection con = DBContext.getConnection();

            String query = "UPDATE orders SET  review_status = ?, shipping_status = ? WHERE order_id = ?";
            PreparedStatement pst = con.prepareStatement(query);

            pst.setInt(3, order.getOrder_id());
            pst.setString(1, order.getReview_status());
            pst.setString(2, order.getShipping_status());

            pst.executeUpdate();

            pst.close();
            con.close();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
