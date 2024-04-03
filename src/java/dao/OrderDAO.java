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
            String query = "SELECT * FROM orders order by order_id desc";
            Statement st = con.prepareStatement(query);
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                Order order = new Order(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getString(8)
                );
                listOrder.add(order);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listOrder;
    }

    public int getRevenueByDate(String startDate, String endDate) {
        int total = 0;

        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "select sum(total) from orders where order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "select sum(total) from orders where order_date= ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Retrieve the total revenue
                System.out.println(total);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return total;
    }

    public int getOrdersByDate(String startDate, String endDate) {
        int total = 0;

        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "SELECT COUNT(order_id) AS numberOfOrder FROM orders where order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "SELECT COUNT(order_id) AS numberOfOrder FROM orders where order_date = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Retrieve the total revenue
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return total;
    }

    public int getCustomersByDate(String startDate, String endDate) {
        int total = 0;

        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "SELECT COUNT(distinct customer_id) AS numberOfOrder FROM orders where order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "SELECT COUNT(distinct customer_id) AS numberOfOrder FROM orders where order_date = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Retrieve the total revenue
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return total;
    }

    public int getSaleBookByDate(String startDate, String endDate) {
        int total = 0;
        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "select count(quantity) as total from orders inner join orderdetail on orders.order_id = orderdetail.order_id where order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "select count(quantity) as total from orders inner join orderdetail on orders.order_id = orderdetail.order_id where order_date = ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Retrieve the total revenue
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return total;
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
                if (i == 1) {
                    map.put("label", "January");
                }
                if (i == 2) {
                    map.put("label", "February");
                }
                if (i == 3) {
                    map.put("label", "March");
                }
                if (i == 4) {
                    map.put("label", "April");
                }
                if (i == 5) {
                    map.put("label", "May");
                }
                if (i == 6) {
                    map.put("label", "June");
                }
                if (i == 7) {
                    map.put("label", "July");
                }
                if (i == 8) {
                    map.put("label", "August");
                }
                if (i == 9) {
                    map.put("label", "September");
                }
                if (i == 10) {
                    map.put("label", "October");
                }
                if (i == 11) {
                    map.put("label", "November");
                }
                if (i == 12) {
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

    public Map<String, Integer> getRevenueByDay(String startDate, String endDate) {
        Map<String, Integer> listRevenueByDate = new HashMap<String, Integer>();

        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "select * from orders where order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "select * from orders where order_date= ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            Integer revenue = 0;
            HashMap<String, Integer> map = new HashMap<>();
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
                
                if (!map.containsKey(rs.getString(3))) {
                    revenue = order.getTotal();
                    map.put(rs.getString(3).toString(), revenue);
                    revenue = 0;
                } else {
                    revenue = map.get(rs.getString(3));
                    revenue += order.getTotal();
                    map.replace(rs.getString(3).toString(), revenue);
                }

            }

            listRevenueByDate = map;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listRevenueByDate;
    }
     public Map<String, Integer> getTopThreeBestSellingByDay(String startDate, String endDate) {
        Map<String, Integer> listRevenueByDate = new HashMap<String, Integer>();
        try {
            Connection con = DBContext.getConnection();
            String query = "";
            PreparedStatement pst;
            if (!startDate.equals("0") && !endDate.equals("0")) {
                query = "select * from orders inner join orderdetail on orders.order_id = orderdetail.order_id inner join books on orderdetail.book_id = books.book_id where orders.order_date between ? and ?";
                pst = con.prepareStatement(query);
                pst.setString(1, startDate);
                pst.setString(2, endDate);
            } else {
                query = "select * from orders inner join orderdetail on orders.order_id = orderdetail.order_id inner join books on orderdetail.book_id = books.book_id where orders.order_date= ?";
                pst = con.prepareStatement(query);
                pst.setString(1, endDate);
            }
            ResultSet rs = pst.executeQuery();
            Integer count = 0;
            HashMap<String, Integer> map = new HashMap<>();
            while (rs.next()) {
                
                if (!map.containsKey(rs.getString(14))) {                   
                    map.put(rs.getString(14), rs.getInt(11));
                  
                } else {
                    count = map.get(rs.getString(14));
                    count+= rs.getInt(11);
                    map.replace(rs.getString(14), count);
                }

            }

            listRevenueByDate = map;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return listRevenueByDate;
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

    public int saveOrdersByCustomer(Order order) {
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

    public int saveOrdersStaff(Order order) {
        int newID = 0;
        try {
            String sqlstm = "INSERT INTO orders(order_date, total , shipping_status, order_status, staff_id,review_status) VALUE(?,?,?,?,?,?)";

            Connection con = DBContext.getConnection();
            PreparedStatement pst = con.prepareStatement(sqlstm, PreparedStatement.RETURN_GENERATED_KEYS);

            pst.setString(1, order.getOrder_date());
            pst.setInt(2, order.getTotal());
            pst.setString(3, order.getShipping_status());
            pst.setInt(4, order.getOrder_status());
            pst.setInt(5, order.getStaff_id());
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

        String query = "UPDATE orders SET  order_date = ?, total = ?, shipping_status = ?, order_status = ?, review_status = ? WHERE order_id = ?";
        PreparedStatement pst = con.prepareStatement(query);

//        pst.setInt(1, order.getCustomer_id());
        pst.setString(1, order.getOrder_date());
        pst.setInt(2, order.getTotal());
        pst.setString(3, order.getShipping_status());
        pst.setInt(4, order.getOrder_status());
//        pst.setInt(6, order.getStaff_id());
        pst.setString(5, order.getReview_status());
        pst.setInt(6, order.getOrder_id());

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
