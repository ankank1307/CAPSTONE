<%-- 
    Document   : UserProfile
    Created on : Nov 10, 2022, 2:09:00 PM
    Author     : BLC
--%>

<%@page import="dao.BookDAO"%>
<%@page import="dao.OrderDetailDAO"%>
<%@page import="entity.OrderDetail"%>
<%@page import="entity.Order"%>
<%@page import="dao.OrderDAO"%>
<%@page import="entity.Genre"%>
<%@page import="dao.GenreDAO"%>
<%@page import="entity.Author"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="entity.Book"%>
<%@page import="entity.Cart"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile - Order</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="author" content="">
        <meta name="keywords" content="">
        <meta name="description" content="">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        <link rel="stylesheet" type="text/css" href="ordertracking.css">
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <!-- script
        ================================================== -->
        <script src="js/modernizr.js"></script>

        <style type="text/css">
            .profile * {
                margin: 0;
                padding: 0
            }

            .profile body {
                background-image: linear-gradient(-225deg, #FFE6FA 0%, #F3F2EC 100%);
                background-image: linear-gradient(to top, #F3F2EC 0%, #F3F2EC 100%);
                background-attachment: fixed;
                background-repeat: no-repeat;
            }

            .profile .card {
                padding: 15px;
                width: 350px;
                background-image: white;
                border: none;
                cursor: pointer;
                transition: all 0.5s;
                margin: 0;
            }

            .profile .image img {
                transition: all 0.5s
            }

            .profile .card:hover .image img {
                transform: scale(1.5)
            }

            .profile .btn {
                height: 140px;
                width: 140px;
                border-radius: 50%
            }


            .profile .name {
                font-size: 22px;
                font-weight: bold
            }

            .profile .idd {
                font-size: 14px;
                font-weight: 600
            }

            .profile .idd1 {
                font-size: 14px
            }

            .profile .number {
                font-size: 16px;
                font-weight: bold
            }

            .profile .follow {
                font-size: 12px;
                font-weight: 500;
                color: #444444
            }

            .profile .btn1 {
                height: 40px;
                width: 150px;
                border: none;
                background-color: #000;
                color: #aeaeae;
                font-size: 15px
            }
            .profile .btn1 .logout {
                background-color: #000;
                color: #aeaeae;
                text-decoration: none;
            }
            .profile .btn1 a {
                height: 40px;
                width: 150px;
                border: none;
            }

            .profile .text span {
                font-size: 14px;
                color: #545454;
                font-weight: 600;
            }
            .profile .text .idd{
                font-size: 14px;
                font-weight: 600;
                color: #000;
            }

            .profile .icons i {
                font-size: 19px
            }

            .profile hr .new1 {
                border: 1px solid
            }

            .profile .join {
                font-size: 14px;
                color: #a0a0a0;
                font-weight: bold
            }

            .profile .date {
                background-color: #ccc
            }
        </style>

    </head>
    <%
        int cartCount = 0;
        ArrayList<Cart> listCart = (ArrayList<Cart>) session.getAttribute("listCart");
        if (listCart != null) {
            cartCount = listCart.size();
        }

        AuthorDAO myAuthorDAO = new AuthorDAO();
        ArrayList<Author> list = myAuthorDAO.getListAuthor();
        ArrayList<Author> listAuthor = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getAuthor_status() == 1) {
                listAuthor.add(list.get(i));
            }
        }
        GenreDAO myGenreDAO = new GenreDAO();
        ArrayList<Genre> list_genre = myGenreDAO.getListGenre();
        ArrayList<Genre> listGenre = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            if (list_genre.get(i).getGenre_status() == 1) {
                listGenre.add(list_genre.get(i));
            }
        }

        OrderDAO myOrderDAO = new OrderDAO();
        OrderDetailDAO myOrderDetailDAO = new OrderDetailDAO();
        BookDAO myBookDAO = new BookDAO();
    %>
    <body>
        <div id="header-wrap">
            <div class="top-content" style="padding: 10px 0 0 0">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="social-links">
                                <ul>
                                    <li>
                                        <a href="#"><i class="icon icon-facebook"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="icon icon-twitter"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="icon icon-youtube-play"></i></a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="icon icon-behance-square"></i></a>
                                    </li>
                                </ul>
                            </div><!--social-links-->
                        </div>
                        <div class="col-md-6">
                            <div class="right-element">
                                <%                                    String txtAccount = "Login";
                                    String link = "UserLogin.jsp";
                                    String ss = (String) session.getAttribute("UserLogin");
                                    Customer customer;
                                    if (ss != null) {
                                        customer = (Customer) session.getAttribute("tempCustomer");
                                        txtAccount = ss;
                                        link = "ManageUserLoginServlet?mode=viewProfile&customerID=";
                                        link += customer.getCustomer_id();
                                    }%>
                                <a href=<%=link%> class="user-account for-buy" ><i class="icon icon-user"></i><span> <%=txtAccount%></span></a>

                                <a href="CartServlet?mode=viewCart" class="cart for-buy"><i class="icon icon-clipboard"></i><span>Cart(<%=cartCount%>)</span></a>

                                <div class="action-menu">

                                    <div class="search-bar">
                                        <a type="submit" class="search-button search-toggle" data-selector="#header-wrap">
                                            <i class="icon icon-search"></i>
                                        </a>
                                        <form action="ShopServlet" role="search" method="get" class="search-box">
                                            <input name="searchInput" class="search-field text search-input" placeholder="Search" type="search">
                                            <input type="hidden" name="mode" value="search">
                                        </form>
                                    </div>
                                </div>

                            </div><!--top-right-->
                        </div>

                    </div>
                </div>
            </div><!--top-content-->

            <header id="header">
                <div class="container">
                    <div class="row">

                        <div class="col-md-2">
                            <div class="main-logo">
                                <a href="UserActivityServlet?mode=userViewBook"><img src="images/main-logo.png" alt="logo"></a>
                            </div>
                        </div>

                        <div class="col-md-10">
                            <nav id="navbar">
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list">
                                        <li class="menu-item active"><a href="UserActivityServlet?mode=userViewBook" data-effect="Home">Home</a></li>

                                        <li class="menu-item has-sub">
                                            <a href="ManageBookServlet?mode=viewBookByGenre&genreID=<%=listGenre.get(0).getGenre_id()%>" class="nav-link" data-effect="Pages">Genre</a>

                                            <ul>
                                                <%for (int i = 0; i < listGenre.size(); i++) {
                                                %>
                                                <li><a href="ManageBookServlet?mode=viewBookByGenre&genreID=<%=listGenre.get(i).getGenre_id()%>"><%=listGenre.get(i).getGenre()%></a></li>

                                                <% } %>
                                            </ul>

                                        </li>


                                        <li class="menu-item has-sub">
                                            <a href="ManageBookServlet?mode=viewBookByAuthor&authorID=<%=listAuthor.get(0).getAuthor_id()%>" class="nav-link" data-effect="Pages">Authors</a>

                                            <ul>
                                                <%for (int i = 0; i < listAuthor.size(); i++) {
                                                %>
                                                <li><a href="ManageBookServlet?mode=viewBookByAuthor&authorID=<%=listAuthor.get(i).getAuthor_id()%>"><%=listAuthor.get(i).getAuthor_name()%></a></li>

                                                <% }%>
                                            </ul>

                                        </li>
                                        <li class="menu-item"><a href="ShopServlet?mode=viewShop" class="nav-link" data-effect="Shop">Shop</a></li>
                                        <li class="menu-item"><a href="Contact.jsp" class="nav-link" data-effect="Contact">Contact</a></li>
                                    </ul>
                                    <div class="hamburger">
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                        <span class="bar"></span>
                                    </div>

                                </div>
                            </nav>

                        </div>

                    </div>
                </div>
            </header>

        </div>
        <!--header-wrap-->
        <% Customer tempCustomer = (Customer) session.getAttribute("tempCustomer");%>

        <div class="container-fluid" style="display: inline-block">
            <div class="row">
                <div class="col-md-3">
                    <div class="profile" style="max-width: 100%">
                        <div class="container" style="width: 100%"> 
                            <div class="card"> 
                                <div class=" image d-flex flex-column justify-content-center align-items-center"> 

                                    <button class="btn btn-secondary"> <img src="https://bootdey.com/img/Content/avatar/avatar7.png" height="100" width="100" style="max-width: 100%" />
                                        <!--https://i.imgur.com/wvxPV9S.png-->

                                    </button> <span class="name mt-3"><%=tempCustomer.getName()%> </span> 

                                    <span class="idd">@<%=tempCustomer.getUsername()%></span> 

                                    <div class=" d-flex mt-2"> 
                                        <a href="ManageUserLoginServlet?mode=editProfile&customerID=<%=tempCustomer.getCustomer_id()%>" class="logout"><button class="btn1 btn-dark">Edit Profile</button></a>
                                    </div>
                                    <br>
                                    <span class="idd">Email: <%=tempCustomer.getEmail()%></span> 
                                    <div class="d-flex flex-row justify-content-center align-items-center mt-3"> 
                                        <span class="number"><span class="idd">Phone Number: </span>0<%=tempCustomer.getPhone_number()%></span> 
                                    </div> 

                                    <div class="text mt-3">   
                                        <span>
                                            <span class="idd">Address: </span><%=tempCustomer.getAddress()%>
                                        </span> 
                                    </div> 
                                    <div class="gap-3 mt-3 icons d-flex flex-row justify-content-center align-items-center"> 
                                        <span><i class="fa fa-twitter"></i></span> 
                                        <span><i class="fa fa-facebook-f"></i></span> 
                                        <span><i class="fa fa-instagram"></i></span> 
                                        <span><i class="fa fa-linkedin"></i></span> </div>
                                    <a href="ManageUserLoginServlet?mode=userLogout" class="logout"><button class="btn1 btn-dark">Logout</button></a>
                                    <div class=" px-2 rounded mt-4 date "> <span class="join">Joined May,2021</span> 
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                    
                <div class="col-md-9" style="display: flex">
                    <div class="order-tracking">
                        <div class="container">
                            <div class="d-flex row">
                                <div class="col-md-10">
                                    <div class="rounded">
                                        <div class="table-responsive table-borderless">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        
                                                        <th>Item #</th>
                                                        <th></th>
                                                        <th>Title</th>
                                                        <th>Quantity</th>
                                                        <th>Price</th>

                                                    </tr>
                                                </thead>
                                                <tbody class="table-body">
                                                    <%
                                                        customer = (Customer) session.getAttribute("tempCustomer");

                                                        int orderID = Integer.parseInt(request.getAttribute("orderID").toString());
                                                        ArrayList<OrderDetail> listOrderDetail = myOrderDetailDAO.getListOrderDetailByOrder(orderID);
                                                        if (listOrderDetail.size() != 0) {
                                                            for (int i = 0; i < listOrderDetail.size(); i++) {
                                                    %>

                                                    <tr class="cell-1">
                                                        <td><%=i + 1%></td>
                                                        <td><img src="bookImages/<%=listOrderDetail.get(i).getBook_id()%>.jpg" style="max-width: 100%;width: 80px;height: 120px;" alt="loading"> </td>
                                                        <td><%=myBookDAO.getBookByID(listOrderDetail.get(i).getBook_id()).getTitle()%></td>
                                                        <td><%=listOrderDetail.get(i).getQuantity()%></td>
                                                        <td><%=listOrderDetail.get(i).getPrice()%></td>
                                                    </tr>
                                                    <% }

                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>  
                </div>

            </div>


            <script>
                function hide() {
                    var litag = document.getElementsByClassName('user-account for-buy'), i;

                    for (i = 0; i < litag.length; i += 1) {
                        if (session === null) {
                            litag[i].style.display = 'none';
                        }
                    }

                }

            </script>
            <script src="js/jquery-1.11.0.min.js"></script>
            <script src="js/plugins.js"></script>
            <script src="js/script.js"></script>

    </body>
</html>
