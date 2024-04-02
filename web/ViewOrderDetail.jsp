<%-- 
    Document   : ViewOrderDetail
    Created on : Nov 23, 2022, 5:20:59 PM
    Author     : BLC
--%>

<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="dao.BookDAO"%>
<%@page import="entity.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Detail</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>
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

        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
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
            .dropbtn {
                background-color: #04AA6D;
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #567086;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: white;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #3e8e41;
            }
        </style>
    </head>

    <%
        BookDAO myBookDAO = new BookDAO();
                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
// Set the currency symbol to "VND" if necessary
        currencyFormat.setCurrency(Currency.getInstance("VND"));
        currencyFormat.setMaximumFractionDigits(0); 
    %>
    <body>

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
                        <div class="dropdown ">
                            <a class="nav-link active" href="">
                                <i class="fas fa-file-alt"></i> 
                                <span>
                                    REPORT<i class="fas fa-angle-down" style="padding-left: 5px;"></i>
                                </span>
                            </a>
                            <div class="dropdown-content">
                                <a href="ManageOrderServlet?mode=viewOrder">ORDER</a>
                                <!--<a href="DailyReport.jsp">WEEKLY REPORT</a>-->
                                <% String date = java.time.LocalDate.now().toString();
                                    System.out.println(date);
                                %>
                                <a href="ViewReportServlet?mode=dailyReport&startDate=<%=0%>&endDate=<%=date%>">DAILY REPORT</a>
                            </div>
                        </div>
                        <div class="dropdown">
                            <a class="nav-link" href="">
                                <i class="fas fa-user"></i> 
                                <span>
                                    USER<i class="fas fa-angle-down" style="padding-left: 5px;"></i>
                                </span>
                            </a>

                            <div class="dropdown-content">
                                <a href="ManageStaffServlet?mode=viewStaff">STAFF</a>
                                <a href="ManageCustomerServlet?mode=viewCustomer">CUSTOMER</a>
                            </div>
                        </div>
                        <li class="nav-item">
                            <a class="nav-link" href="ManageDiscountServlet?mode=viewDiscount">
                                <i class="fas fa-money-check"></i> VOUCHERS
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
                    <div clss="tm-bg-primary-dark tm-block tm-block-products">
                        <div class="tm-product-table-container" style="margin-top: 25px">
                            <a class="button4" href="ManageOrderServlet?mode=viewOrder">Back                                        
                            </a>
                            <%
                                ArrayList<OrderDetail> listOrderDetail = (ArrayList<OrderDetail>) request.getAttribute("listOrderDetail");
                                
                            %>
                            <table class="table table-hover tm-table-small tm-product-table">
                                <thead>
                                    <tr>
                                        <th scope="col">Image</th>
                                        <th scope="col">Title</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (int i = 0; i < listOrderDetail.size(); i++) {%>
                                    <tr>
                                        <td><img src="bookImages/<%=listOrderDetail.get(i).getBook_id()%>.jpg" style="max-width: 100%;width: 85px;height: 115px;" alt="loading"></td>
                                        <td><%=myBookDAO.getBookByID(listOrderDetail.get(i).getBook_id()).getTitle()%></td>
                                        <td><%=listOrderDetail.get(i).getQuantity()%></td>
                                        <td><%=currencyFormat.format(listOrderDetail.get(i).getPrice())%></td>
                                    </tr> 
                                    <% }%>                                                                      
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
