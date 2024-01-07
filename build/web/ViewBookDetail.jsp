<%-- 
    Document   : ViewBookDetail
    Created on : Nov 18, 2022, 6:16:06 PM
    Author     : BLC
--%>

<%@page import="entity.Genre"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Customer"%>
<%@page import="dao.GenreDAO"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="entity.Author"%>
<%@page import="entity.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Book Store</title>
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
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .rating {
                display: inline-block;
                position: relative;
                height: 50px;
                line-height: 50px;
                font-size: 35px;
            }

            .rating label {
                position: absolute;
                top: 0;
                left: 0;
                height: 100%;
                cursor: pointer;
            }

            .rating label:last-child {
                position: static;
            }

            .rating label:nth-child(1) {
                z-index: 5;
            }

            .rating label:nth-child(2) {
                z-index: 4;
            }

            .rating label:nth-child(3) {
                z-index: 3;
            }

            .rating label:nth-child(4) {
                z-index: 2;
            }

            .rating label:nth-child(5) {
                z-index: 1;
            }

            .rating label input {
                position: absolute;
                top: 0;
                left: 0;
                opacity: 0;
            }

            .rating label .icon {
                float: left;
                color: transparent;
            }

            .rating label:last-child .icon {
                color: #000;
            }

            .rating:not(:hover) label input:checked ~ .icon,
            .rating:hover label:hover input ~ .icon {
                color: yellow;
            }

            .rating label input:focus:not(:checked) ~ .icon:last-child {
                color: #000;
                text-shadow: 0 0 5px #09f;
            }
            .comment{
                display: inline-block;
            }
            .rating-section{
                border: 1px dashed black;
            }
            .rate{
                margin-left: 10px;
            }
            textarea{
                margin-left: 10px;
            }


            .card {

                border: none;
                box-shadow: 5px 6px 6px 2px #e9ecef;
                border-radius: 4px;
            }


            .dots{

                height: 4px;
                width: 4px;
                margin-bottom: 2px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
            }

            .badge{

                padding: 7px;
                padding-right: 9px;
                padding-left: 16px;
                box-shadow: 5px 6px 6px 2px #e9ecef;
            }

            .user-img{

                margin-top: 4px;
            }

            .check-icon{

                font-size: 17px;
                color: #c3bfbf;
                top: 1px;
                position: relative;
                margin-left: 3px;
            }

            .form-check-input{
                margin-top: 6px;
                margin-left: -24px !important;
                cursor: pointer;
            }


            .form-check-input:focus{
                box-shadow: none;
            }


            .icons i{

                margin-left: 8px;
            }
            .reply{

                margin-left: 12px;
            }

            .reply small{

                color: #b7b4b4;

            }


            .reply small:hover{

                color: green;
                cursor: pointer;

            }
            .checked {
                color: orange;
            }
        </style>
        <!-- script
        ================================================== -->
        <script src="js/modernizr.js"></script>

    </head>
    <% Book book = (Book) request.getAttribute("book");
    %>
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


    %>


    <body>
        <% ArrayList<Book> listBook = (ArrayList<Book>) request.getAttribute("newList"); %>
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
                                <% Customer customer;
                                    String txtAccount = "Login";
                                    String link = "UserLogin.jsp";
                                    String ss = (String) session.getAttribute("UserLogin");

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

                                                <% }%>
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

        </div><!--header-wrap-->

        <section class="bg-sand padding-large">
            <div class="container">
                <div class="row">

                    <div class="col-md-6">
                        <img class="imgdetail" src="bookImages/<%=book.getBook_id()%>.jpg">

                    </div>

                    <div class="col-md-6 pl-5">
                        <div class="product-detail">
                            <h1><%=book.getTitle()%> </h1>
                            <p><span style="font-weight: bold">Author: </span><%=myAuthorDAO.getAuthorByID(book.getAuthor_id()).getAuthor_name()%></p>
                            <p><span style="font-weight: bold">Genre: </span><%=myGenreDAO.getGenreByID(book.getGenre_id()).getGenre()%></p>
                            <p><span style="font-weight: bold">Year of release: </span><%=book.getYor()%> </p>
                            <span class="price colored"><span style="font-weight: bold">Price: </span><%=book.getPrice()%> VND</span>
                            <br>
                            <p>
                                <%= book.getDescription()%>
                            </p>


                            <a href="CartServlet?mode=addToCart&bookID=<%=book.getBook_id()%>"> <button type="submit" name="add-to-cart" value="27545" class="button">Add to cart</button> </a>

                            <!--                            <button type="submit" name="buy-now" value="27545" class="button">Buy Now</button>-->
                            <div class ="rating-section">

                                <div class = "rate">
                                    <h4>Add a comment</h4>
                                    <form class="rating">
                                        <label>
                                            <input type="radio" name="stars" value="1" />
                                            <span class="icon">★</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="stars" value="2" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="stars" value="3" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>   
                                        </label>
                                        <label>
                                            <input type="radio" name="stars" value="4" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>
                                        <label>
                                            <input type="radio" name="stars" value="5" />
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                            <span class="icon">★</span>
                                        </label>

                                </div>
                                <div class = "comment">
                                    <textarea  cols ="50" name="comment" ></textarea>
                                </div>
                            </div>
                            <button>Send</button>
                            </form>
                        </div>
                    </div>

                </div>
                <div class="row"> 
                    <div class="col-md-6">
                        <h1>reviews</h1>
                        <div class="container mt-5">

                            <div class="row  d-flex justify-content-center">

                                <div class="col-md-8">

                                    <div class="headings d-flex justify-content-between align-items-center mb-3">
                                        <h2>comments(6)</h2> 

                                    </div>
                                    <div class="card p-3">

                                        <div class="d-flex justify-content-between align-items-center">

                                            <div class="user d-flex flex-row align-items-center">
                                                <img src="bookImages/1002.jpg" style="width: 80px; height: 80px; border-radius: 50% " class="user-img rounded-circle mr-2">
                                                <span> james_olesenn</span>

                                                <small style="margin-left: 600px;">2 days ago</small>

                                            </div>
                                            <span> 
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star"></span>
                                                <span class="fa fa-star"></span>
                                            </span>
                                            <p>hihihsdhgshgshgkshdghasdghshgjkdhsfjkghsdkfghasghafhg</p>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

        </section>

        >                          


        <footer id="footer">
            <div class="container">
                <div class="row">

                    <div class="col-md-4">

                        <div class="footer-item">
                            <div class="company-brand">
                                <img src="images/main-logo.png" alt="logo" class="footer-logo">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed ptibus liberolectus nonet psryroin. Amet sed lorem posuere sit iaculis amet, ac urna. Adipiscing fames semper erat ac in suspendisse iaculis.</p>
                            </div>
                        </div>

                    </div>

                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>About Us</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">vision</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">articles </a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">careers</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">service terms</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">donate</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>Discover</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">Home</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Books</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Authors</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Subjects</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Advanced Search</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>My account</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">Sign In</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">View Cart</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">My Wishtlist</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Track My Order</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <div class="col-md-2">

                        <div class="footer-menu">
                            <h5>Help</h5>
                            <ul class="menu-list">
                                <li class="menu-item">
                                    <a href="#">Help center</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Report a problem</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Suggesting edits</a>
                                </li>
                                <li class="menu-item">
                                    <a href="#">Contact us</a>
                                </li>
                            </ul>
                        </div>

                    </div>

                </div>
                <!-- / row -->

            </div>
        </footer>

        <div id="footer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="copyright">
                            <div class="row">

                                <div class="col-md-6">
                                    <p>© 2022 All rights reserved. Free HTML Template by <a href="https://www.templatesjungle.com/" target="_blank">TemplatesJungle</a></p>
                                </div>

                                <div class="col-md-6">
                                    <div class="social-links align-right">
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
                                    </div>
                                </div>

                            </div>
                        </div><!--grid-->

                    </div><!--footer-bottom-content-->
                </div>
            </div>
        </div>

        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>

    </body>
</html>	