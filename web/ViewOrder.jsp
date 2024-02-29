<%-- 
    Document   : ViewAuthor
    Created on : Oct 30, 2022, 2:25:54 PM
    Author     : phuon
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="entity.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Order Management</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Roboto -->
        <link rel="stylesheet" href="css/fontawesome.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- https://fontawesome.com/ -->
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <!-- https://getbootstrap.com/ -->
        <link rel="stylesheet" href="css/templatemo-style.css">
        <!--
            Product Admin CSS Template
            https://templatemo.com/tm-524-product-admin
        
        -->
        <link rel="stylesheet" href="css/search_button.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
        <style type="text/css">
            a.button4{
                display:inline-block;
                padding:0.3em 1.2em;
                margin:0 0.1em 0.1em 0;
                border:0.16em solid rgba(255,255,255,0);
                border-radius:2em;
                box-sizing: border-box;
                text-decoration:none;
                font-family:'Roboto',sans-serif;
                font-weight:300;
                color:#FFFFFF;
                text-shadow: 0 0.04em 0.04em rgba(0,0,0,0.35);
                text-align:center;
                transition: all 0.2s;
            }

            a.button4:hover{
                border-color: rgba(255,255,255,1);
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-Yz5FyPzvSe6VxywFN+VGFnZZta3+kbq0U1lH6Ox6+tLJwe8AvllziHpQz24Og7hElKLcJFp7fmj1N7HaoyvWlA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-BtG4F1i0E9g9E9cT62tuo6nYlrCHp4FTuGj4t1yA+mz0G1L48fv2HiO0pv5WNZcKaB8rS+RiisVY8zI3pIsU5g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </head>
    <%
        ArrayList<Order> listOrder = (ArrayList<Order>) request.getAttribute("listOrder");
    %>
    <%
        ArrayList<String> listStatus = new ArrayList<>();
        listStatus.add("Pending");
        listStatus.add("In Transit");
        listStatus.add("Out For Delivery");
        listStatus.add("Completed");
        listStatus.add("Rejected");
        listStatus.add("Done");
    %>
    <%
        Gson gsonObj = new Gson();
        Map<Object, Object> map = null;

        List<Map<Object, Object>> list = (List<Map<Object, Object>>) request.getAttribute("listRevenueByMonth");

//        map = new HashMap<Object, Object>();
//        map.put("label", "January");
//        map.put("y", 12000000);
//        map.put("exploded", true);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "February");
//        map.put("y", 1200000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "March");
//        map.put("y", 3000000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "April");
//        map.put("y", 4500000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "May");
//        map.put("y", 4300000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "June");
//        map.put("y", 6000000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "July");
//        map.put("y", 8000000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "August");
//        map.put("y", 130000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "September");
//        map.put("y", 5400000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "October");
//        map.put("y", 3800000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "November");
//        map.put("y", 1300000);
//        list.add(map);
//        map = new HashMap<Object, Object>();
//        map.put("label", "December");
//        map.put("y", 0);
//        list.add(map);
        String dataPoints = gsonObj.toJson(list);
        System.out.println(dataPoints);

    %>

    <body id="reportsPage">
        <nav class="navbar navbar-expand-xl">
            <div class="container h-100">
                <a class="navbar-brand" href="home.jsp">
                    <h1 class="tm-site-title mb-0">Product Admin</h1>
                </a>
                <button
                    class="navbar-toggler ml-auto mr-0"
                    type="button"
                    data-toggle="collapse"
                    data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <i class="fas fa-bars tm-nav-icon"></i>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto h-100">
                        <li class="nav-item">
                            <a class="nav-link" href="ManageAuthorServlet?mode=viewAuthor">
                                <i class="fas fa-user-tie"></i> AUTHORS
                                <span class="sr-only">(current)</span>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link " href="ManageBookServlet?mode=viewBook">
                                <i class="fas fa-book"></i> BOOKS
                            </a>
                        </li>


                        <li class="nav-item">
                            <a class="nav-link" href="ManageGenreServlet?mode=viewGenre">
                                <i class="fas fa-money-bill-wave"></i> GENRE
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="ManageOrderServlet?mode=viewOrder">
                                <i class="far fa-file-alt"></i> ORDER & REPORTS
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageCustomerServlet?mode=viewCustomer">
                                <i class="fas fa-user"></i> CUSTOMER
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageStaffServlet?mode=viewStaff">
                                <i class="fas fa-user-plus"></i> STAFF
                            </a>
                        </li>
                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link d-block" href='adminLogin.jsp'>
                                Admin, <b>Logout</b>
                            </a>

                        </li>

                    </ul>
                </div>
            </div>
        </nav>
        <div class="container mt-5">
            <div class="row tm-content-row">
                <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 tm-block-col">
                    <div class="tm-bg-primary-dark tm-block tm-block-products" style="min-height: 600px;">
                        <form>
                            <div class="search-wrapper">

                                <div class="input-holder">
                                    <form action="ManageOrderServlet" method="post">
                                        <input type="text" class="search-input" placeholder="Type to search" name="searchInput" />
                                        <input type="hidden" name="mode" value="search">
                                    </form>
                                    <button type="submit" class="search-icon" onclick="searchToggle(this, event);"><span></span></button>

                                </div>
                                <span class="close" onclick="searchToggle(this, event);"></span>
                            </div>
                        </form>
                        <div class="tm-product-table-container" style="margin-top: 25px">    

                            <table class="table table-hover tm-table-small tm-product-table">
                                <thead>

                                    <tr>

                                        <th scope="col"> Order ID </th>
                                        <th scope="col">Customer ID</th>
                                        <th scope="col">Order date</th>
                                        <th scope="col">Total</th>
                                        <th scope="col">Shipping status</th>
                                        <th scope="col">&nbsp;</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>


                                    <% for (int i = 0; i < listOrder.size(); i++) {%>
                                <form action="ManageOrderServlet?mode=updateShippingStatus" method="post">
                                    <tr>

                                        <td><%=listOrder.get(i).getOrder_id()%></td>
                                        <td><%=listOrder.get(i).getCustomer_id()%></td>
                                        <td><%=listOrder.get(i).getOrder_date()%> </td>

                                        <td><%=listOrder.get(i).getTotal()%></td>

                                        <td>
                                            <!--                                           <select class="custom-select tm-select-accounts"
                                                                                                id="category" name="shipping_status">
                                            <%

                                                for (int j = 0; j < listStatus.size() - 1; j++) {
                                                    String selected = "";
                                                    if (listOrder.get(i).getShipping_status().equals(listStatus.get(j))) {
                                                        selected = "selected";
                                                    }
                                            %>

                                            <option <%=selected%> value ="<%=listStatus.get(j)%>" > <%=listStatus.get(j)%> </option>
                                            <%}%>
                                        </select>-->
                                            <select class="custom-select tm-select-accounts"
                                                    id="category" name="shipping_status" <%= listOrder.get(i).getShipping_status().equals("Done") ? "disabled" : ""%>>
                                                <%

                                                    for (int j = 0; j < listStatus.size(); j++) {
                                                        String selected = "";
                                                        if (listOrder.get(i).getShipping_status().equals(listStatus.get(j))) {
                                                            selected = "selected";
                                                        }
                                                        String disable = "";
                                                        if (listStatus.get(j).equals("Done")) {
                                                            disable = "disabled";
                                                        }

                                                %>
                                                <option <%=selected%> <%=disable%> value="<%=listStatus.get(j)%>" > <%=listStatus.get(j)%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="hidden" name="orderID" value="<%=listOrder.get(i).getOrder_id()%>">
                                            <button type="submit" style="border: none; background: none;">
                                                <a class="tm-product-delete-link">
                                                    <i class="fa fa-floppy-o" aria-hidden="true", style="color: white"></i>                                          
                                                </a>
                                            </button>
                                        </td>
                                        <td>
                                            <a class="button4" href="ManageOrderServlet?mode=viewOrderDetail&orderID=<%=listOrder.get(i).getOrder_id()%>">
                                                View                                        
                                            </a>
                                        </td>

                                    </tr> 
                                </form>
                                <% }%>  


                                </tbody>
                            </table>
                        </div><!--
                        <!-- table container -->
                        <!--                        <a href="AddAuthor.jsp" class="btn btn-primary btn-block text-uppercase mb-3">Add new author </a>
                                                <button class="btn btn-primary btn-block text-uppercase">
                                                    Delete selected products
                                                </button>-->
                    </div>
                </div>
            </div>
            <form action="ManageOrderServlet?mode=generateChart" method="POST">
                <div class="row mt-3" style="margin-bottom: 20px">

                    <div class="col-md-4">


                        <label for="yearDropdown" style="color: white; size: 14px">Select Year</label>
                        <select class="form-control" id="yearDropdown" name="selectedYear" style="padding: 10px 10px; background-color: #435c70">
                            <%
                                int currentYear = java.time.Year.now().getValue();
                                int selectedYear = (int) request.getAttribute("selectedYear");

                                for (int year = 2022; year <= currentYear; year++) {
                                    String selected = (year == selectedYear) ? "selected" : "";
                            %>
                            <option <%=selected%> ><%= year%></option>
                            <% } %>
                        </select>

                    </div>
                    <div class="col-md-4">
                        <label>&nbsp;</label>
                        <button class="btn btn-primary btn-block" onclick="generateReport()">Generate Report</button>
                    </div>

                </div></form>
            <div id="chartContainer"  style="height: 370px; width: 100%;" ></div>
        </div>



        <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script>


//                                    
//                                    function winOpen(int orderID)
//                                    {
////                                    String str = "ManageOrderServlet?mode=viewOrderDetail&orderID=" + orderID;
//                                    String str = "ViewOrderDetail.jsp";
//                                    window.open(str);
//                                    }




                            function searchToggle(obj, evt) {
                                var container = $(obj).closest('.search-wrapper');
                                if (!container.hasClass('active')) {
                                    container.addClass('active');
                                    evt.preventDefault();
                                } else if (container.hasClass('active') && $(obj).closest('.input-holder').length == 0) {
                                    container.removeClass('active');
                                    // clear input
                                    container.find('.search-input').val('');
                                }
                            }
        </script>
        <script type="text/javascript">

            window.onload = function () {
                var selectedYear = $("#yearDropdown").val();
                var chart = new CanvasJS.Chart("chartContainer", {
                    theme: "light2",
                    animationEnabled: true,
                    exportFileName: "Revenue of BookSaw",
                    exportEnabled: true,
                    title: {
                        text: "Revenue of BookSaw in " + selectedYear,
                    },
                    data: [{
                            type: "column",
                            indexLabel: " {y}đ",
                            dataPoints: <%out.print(dataPoints);%>
                        }]
                });
                chart.render();
            };


        </script>
        <script>
            // Add the following script for the button click event
            function generateReport() {
                var selectedYear = $("#yearDropdown").val();
                // Add logic to generate report based on the selected year

                // For demonstration purposes, toggle chart visibility
                var chartContainer = $("#chartContainer");
                chartContainer.show();
            }
        </script>

    </body>
</html>
