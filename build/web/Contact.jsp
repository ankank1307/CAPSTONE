<%-- 
    Document   : contact
    Created on : Nov 20, 2022, 3:21:01 AM
    Author     : BLC
--%>

<%@page import="entity.Genre"%>
<%@page import="dao.GenreDAO"%>
<%@page import="entity.Author"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="entity.Customer"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Contact</title>
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
        <!-- script
        ================================================== -->
        <script src="js/modernizr.js"></script>

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

        </div><!--header-wrap-->

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h1 class="page-title">Contact us</h1>
                        <div class="breadcrumbs">
                            <span class="item"><a href="UserActivityServlet?mode=userViewBook">Home /</a></span>
                            <span class="item">Contact us</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="contact-information padding-large mt-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 p-0 mb-3">

                        <h2>Get in Touch</h2>

                        <div class="contact-detail d-flex flex-wrap mt-4">
                            <div class="detail mr-6 mb-4">
                                <p>Thanks for reaching out to BookSaw. In order to ensure you receive a quick reply, please fill out our Contact Us form.</p>
                                <ul class="list-unstyled list-icon">
                                    <li><i class="icon icon-phone"></i>+84 0123456789</li>
                                    <li><i class="icon icon-envelope-o"></i><a href="mailto:info@yourcompany.com">booksaw.store@gmail.com</a></li>
                                    <li><i class="icon icon-location2"></i>Eatern International University / Binh Duong / Vietnam</li>
                                </ul>
                            </div><!--detail-->
                            <div class="detail mb-4">
                                <h3>Social Links</h3>
                                <div class="social-links flex-container">
                                    <a href="#" class="icon icon-facebook"></a>
                                    <a href="#" class="icon icon-twitter"></a>
                                    <a href="#" class="icon icon-pinterest-p"></a>
                                    <a href="#" class="icon icon-youtube"></a>
                                    <a href="#" class="icon icon-linkedin"></a>
                                </div><!--social-links-->
                            </div><!--detail-->

                        </div><!--contact-detail-->
                    </div><!--col-md-6-->

                    <div class="col-md-6 p-0">

                        <div class="contact-information">
                            <h2>Send A Message</h2>
                            <form name="contactform" action="#" method="post" class="contact-form d-flex flex-wrap mt-4">
                                <div class="row">
                                    <div class="col-md-6">
                                        <input type="text" minlength="2" name="name" placeholder="Name" class="u-full-width" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="email" name="email" placeholder="E-mail" class="u-full-width" required>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">

                                        <textarea class="u-full-width" name="message" placeholder="Message" style="height: 150px;" required></textarea>

                                        <label>
                                            <input type="checkbox" required>
                                            <span class="label-body">I agree all the <a href="#">terms and conditions</a></span>
                                        </label>

                                        <button type="submit" name="submit" class="btn btn-full btn-rounded">Submit</button>
                                    </div>
                                </div>
                            </form>

                        </div><!--contact-information-->

                    </div><!--col-md-6-->

                </div>
            </div>
        </section>

        <section class="google-map">
            <div class="mapouter"><div class="gmap_canvas"><iframe width="100%" height="500" id="gmap_canvas" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3915.8080684228003!2d106.66398021460843!3d11.053012092134177!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174d1d7df763eaf%3A0xf4323e44f2867057!2zxJDhuqFpIGjhu41jIFF14buRYyB04bq_IE1p4buBbiDEkMO0bmc!5e0!3m2!1svi!2s!4v1668889491277!5m2!1svi!2s" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><a href="https://getasearch.com/fmovies"></a><br><style>.mapouter{
                            position:relative;
                            text-align:right;
                            height:500px;
                            width:100%;
                            }</style><a href="https://www.embedgooglemap.net">embedgooglemap.net</a><style>.gmap_canvas {
                            overflow:hidden;
                            background:none!important;
                            height:500px;
                            width:100%;
                            }</style></div></div>

        </section>



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
