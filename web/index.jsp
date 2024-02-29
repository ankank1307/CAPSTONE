<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.BookDAO"%>
<%@page import="entity.Genre"%>
<%@page import="entity.Genre"%>
<%@page import="dao.GenreDAO"%>
<%@page import="entity.Author"%>
<%@page import="entity.Author"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="entity.Cart"%>
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Customer"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>BOOKSAW</title>
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
        BookDAO myBookDAO = new BookDAO();
    %>
    
    <body>
        <% ArrayList<Book> listBook = (ArrayList<Book>) request.getAttribute("newList"); %>
        <% System.out.print("hehehehhehe" + listBook.size()); %>
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

        <section id="billboard">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <button class="prev slick-arrow">
                            <i class="icon icon-arrow-left"></i>
                        </button>

                        <div class="main-slider pattern-overlay" style="padding: 0px;">
                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title"><%=listBook.get(20).getTitle()%></h2>
                                    <p><%=listBook.get(20).getDescription()%></p>
                                    <div class="btn-wrap">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(20).getBook_id()%>" class="btn btn-outline-accent btn-accent-arrow">Read More<i class="icon icon-ns-arrow-right"></i></a>
                                    </div>
                                </div><!--banner-content--> 
                                <img src="bookImages/<%=listBook.get(20).getBook_id()%>.jpg" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                            <div class="slider-item">
                                <div class="banner-content">
                                    <h2 class="banner-title"><%=listBook.get(1).getTitle()%></h2>
                                    <p><%=listBook.get(1).getDescription()%></p>
                                    <div class="btn-wrap">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(1).getBook_id()%>" class="btn btn-outline-accent btn-accent-arrow">Read More<i class="icon icon-ns-arrow-right"></i></a>
                                    </div>
                                </div><!--banner-content--> 
                                <img src="bookImages/<%=listBook.get(1).getBook_id()%>.jpg" alt="banner" class="banner-image">
                            </div><!--slider-item-->

                        </div><!--slider-->

                        <button class="next slick-arrow">
                            <i class="icon icon-arrow-right"></i>
                        </button>

                    </div>
                </div>
            </div>

        </section>

        <!--        <section id="client-holder" data-aos="fade-up">
                    <div class="container">
                        <div class="row">
                            <div class="inner-content">
                                <div class="logo-wrap">
                                    <div class="grid">
                                        <a href="#"><img src="images/client-image1.png" alt="client"></a>
                                        <a href="#"><img src="images/client-image2.png" alt="client"></a>
                                        <a href="#"><img src="images/client-image3.png" alt="client"></a>
                                        <a href="#"><img src="images/client-image4.png" alt="client"></a>
                                        <a href="#"><img src="images/client-image5.png" alt="client"></a>
                                    </div>
                                </div>image-holder
                            </div>
                        </div>
                    </div>
                </section>-->

        <section id="featured-books" style="margin-bottom: 30px">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="section-header align-center">
                            <div class="title">

                            </div>
                            <h2 class="section-title">Featured Books</h2>
                        </div>

                        <div class="product-list" data-aos="fade-up">
                            <div class="row">
                                <div class="col-md-3" >
                                    <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(2).getBook_id()%>">
                                        <figure class="product-style">
                                            <img src="bookImages/<%=listBook.get(2).getBook_id()%>.jpg" alt="Books" class="product-item">
                                            <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(2).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                            <figcaption>
                                                <h3><%=listBook.get(2).getTitle()%></h3>
                                                <p><%=listBook.get(2).getAuthor_name()%></p>
                                                <div class="item-price"><%=listBook.get(2).getPrice()%> VND</div>
                                            </figcaption>
                                        </figure>
                                    </a>
                                </div>

                                <div class="col-md-3">
                                    <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(3).getBook_id()%>">
                                        <figure class="product-style">
                                            <img src="bookImages/<%=listBook.get(3).getBook_id()%>.jpg" alt="Books" class="product-item">
                                            <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(3).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                            <figcaption>
                                                <h3><%=listBook.get(3).getTitle()%></h3>
                                                <p><%=listBook.get(3).getAuthor_name()%></p>
                                                <div class="item-price"><%=listBook.get(3).getPrice()%> VND</div>
                                            </figcaption>
                                        </figure>
                                    </a>
                                </div>

                                <div class="col-md-3">
                                    <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(4).getBook_id()%>">
                                        <figure class="product-style">
                                            <img src="bookImages/<%=listBook.get(4).getBook_id()%>.jpg" alt="Books" class="product-item">
                                            <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(4).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                            <figcaption>
                                                <h3><%=listBook.get(4).getTitle()%></h3>
                                                <p><%=listBook.get(4).getAuthor_name()%></p>
                                                <div class="item-price"><%=listBook.get(4).getPrice()%> VND</div>
                                            </figcaption>
                                        </figure>
                                    </a>
                                </div>

                                <div class="col-md-3">
                                    <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(5).getBook_id()%>">
                                        <figure class="product-style">
                                            <img src="bookImages/<%=listBook.get(5).getBook_id()%>.jpg" alt="Books" class="product-item">
                                            <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(5).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                            <figcaption>
                                                <h3><%=listBook.get(5).getTitle()%></h3>
                                                <p><%=listBook.get(5).getAuthor_name()%> </p>
                                                <div class="item-price"><%=listBook.get(5).getPrice()%> VND</div>
                                            </figcaption>
                                        </figure>
                                    </a>
                                </div>

                            </div><!--ft-books-slider-->				
                        </div><!--grid-->


                    </div><!--inner-content-->
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="btn-wrap align-right">
                            <a href="ShopServlet?mode=viewShop" class="btn-accent-arrow">View all products <i class="icon icon-ns-arrow-right"></i></a>
                        </div>

                    </div>		
                </div>
            </div>
        </section>

        <section id="best-selling" class="leaf-pattern-overlay">
            <div class="corner-pattern-overlay"></div>
            <div class="container">
                <div class="row">

                    <div class="col-md-8 col-md-offset-2">

                        <div class="row">

                            <div class="col-md-6">
                                <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(15).getBook_id()%>">
                                    <figure class="products-thumb">
                                        <img src="bookImages/<%=listBook.get(15).getBook_id()%>.jpg" alt="book" class="single-image">
                                    </figure>
                                </a>
                            </div>

                            <div class="col-md-6">
                                <div class="product-entry">
                                    <h2 class="section-title divider">Best Selling Book</h2>

                                    <div class="products-content">
                                        <div class="author-name"><%=listBook.get(15).getAuthor_name()%></div>
                                        <h3 class="item-title"><%=listBook.get(15).getTitle()%></h3>
                                        <p><%=listBook.get(15).getDescription()%></p>
                                        <div class="item-price"><%=listBook.get(15).getPrice()%> VND</div>
                                        <div class="btn-wrap">
                                            <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(15).getBook_id()%>" class="btn-accent-arrow">shop it now <i class="icon icon-ns-arrow-right"></i></a>
                                        </div>
                                    </div>


                                </div>
                            </div>

                        </div>
                        <!-- / row -->

                    </div>

                </div>
            </div>
        </section>

        <section id="popular-books" class="bookshelf">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="section-header align-center">
                            <div class="title">
                                <span>Some quality items</span>
                            </div>
                            <h2 class="section-title">Popular Books</h2>
                        </div>

                        <ul class="tabs">
                            <li data-tab-target="#all-genre" class="active tab">All Genre</li>
                            <li data-tab-target="#action" class="tab">Action and Adventure</li>
                            <li data-tab-target="#classics" class="tab">Classics</li>
                            <li data-tab-target="#comic" class="tab">Comic</li>
                            <li data-tab-target="#detective" class="tab">Detective</li>
                            <li data-tab-target="#children" class="tab">Children's literature</li>
                        </ul>

                        <div class="tab-content">
                            <div id="all-genre" data-tab-content class="active">
                                <div class="row">
                                    <%
                                        for (int i = 0; i < listBook.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>

                                    <div class="col-md-3" >
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listBook.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listBook.get(i).getTitle()%></h3>
                                                    <p><%=listBook.get(i).getAuthor_name()%></p>
                                                    <div class="item-price"><%=listBook.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div> 
                                    <%}%>
                                </div>
                                <div class="row">
                                    <%
                                        for (int i = 4; i < listBook.size(); i++) {
                                            if (i == 8) {
                                                break;
                                            }
                                    %>

                                    <div class="col-md-3" >
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listBook.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listBook.get(i).getTitle()%></h3>
                                                    <p><%=listBook.get(i).getAuthor_name()%></p>
                                                    <div class="item-price"><%=listBook.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div> 
                                    <%}%>
                                </div>
                            </div>

                            <div id="action" data-tab-content>
                                <div class="row">
                                    <%
                                        ArrayList<Book> listAction = myBookDAO.getListBookByGenre(1001);
                                        for (int i = 0; i < listAction.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>
                                    <div class="col-md-3">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listAction.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listAction.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listAction.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listAction.get(i).getTitle()%></h3>
                                                    <p><%=myAuthorDAO.getAuthorByID(listAction.get(i).getAuthor_id()).getAuthor_name()%> </p>
                                                    <div class="item-price"><%=listAction.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>

                            <div id="classics" data-tab-content>
                                <div class="row">
                                    <%
                                        ArrayList<Book> listClassics = myBookDAO.getListBookByGenre(1002);
                                        for (int i = 0; i < listClassics.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>
                                    <div class="col-md-3">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listClassics.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listClassics.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listClassics.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listClassics.get(i).getTitle()%></h3>
                                                    <p><%=myAuthorDAO.getAuthorByID(listClassics.get(i).getAuthor_id()).getAuthor_name()%> </p>
                                                    <div class="item-price"><%=listClassics.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>

                            <div id="comic" data-tab-content>
                                <div class="row">
                                    <%
                                        ArrayList<Book> listComic = myBookDAO.getListBookByGenre(1003);
                                        for (int i = 0; i < listComic.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>
                                    <div class="col-md-3">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listComic.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listComic.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listComic.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listComic.get(i).getTitle()%></h3>
                                                    <p><%=myAuthorDAO.getAuthorByID(listComic.get(i).getAuthor_id()).getAuthor_name()%> </p>
                                                    <div class="item-price"><%=listComic.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>

                            <div id="detective" data-tab-content>
                                <div class="row">
                                    <%
                                        ArrayList<Book> listDetective = myBookDAO.getListBookByGenre(1004);
                                        for (int i = 0; i < listDetective.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>
                                    <div class="col-md-3">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listDetective.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listDetective.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listDetective.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listDetective.get(i).getTitle()%></h3>
                                                    <p><%=myAuthorDAO.getAuthorByID(listDetective.get(i).getAuthor_id()).getAuthor_name()%> </p>
                                                    <div class="item-price"><%=listDetective.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>

                            <div id="children" data-tab-content>
                                <div class="row">
                                    <%
                                        ArrayList<Book> listchildren = myBookDAO.getListBookByGenre(1005);
                                        for (int i = 0; i < listchildren.size(); i++) {
                                            if (i == 4) {
                                                break;
                                            }
                                    %>
                                    <div class="col-md-3">
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listchildren.get(i).getBook_id()%>">
                                            <figure class="product-style">
                                                <img src="bookImages/<%=listchildren.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                                <a href="CartServlet?mode=addToCart&bookID=<%=listchildren.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                                <figcaption>
                                                    <h3><%=listchildren.get(i).getTitle()%></h3>
                                                    <p><%=myAuthorDAO.getAuthorByID(listchildren.get(i).getAuthor_id()).getAuthor_name()%> </p>
                                                    <div class="item-price"><%=listchildren.get(i).getPrice()%> VND</div>
                                                </figcaption>
                                            </figure>
                                        </a>
                                    </div>
                                    <%}%>
                                </div>
                            </div>

                        </div>

                    </div><!--inner-tabs-->

                </div>
            </div>
        </section>

        <section id="quotation" class="align-center">
            <div class="inner-content">
                <h2 class="section-title divider">Quote of the day</h2>
                <blockquote data-aos="fade-up">
                    <q>The more that you read, the more things you will know. The more that you learn, the more places you'll go.</q>
                    <div class="author-name">Dr. Seuss</div>			
                </blockquote>
            </div>		
        </section>

        <section id="special-offer" class="bookshelf">

            <div class="section-header align-center">
                <div class="title">
                    <span>Grab your opportunity</span>
                </div>
                <h2 class="section-title">Books with offer</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="inner-content">	
                        <div class="product-list" data-aos="fade-up">
                            <div class="grid product-grid">
                                <%
                                    for (int i = 0; i < listBook.size(); i++) {
                                        if (i == 5) {
                                            break;
                                        }

                                %>

                                <figure class="product-style">
                                    <img src="bookImages/<%=listBook.get(i).getBook_id()%>.jpg" alt="Books" class="product-item">
                                    <a href="CartServlet?mode=addToCart&bookID=<%=listBook.get(i).getBook_id()%>" ><button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button></a>
                                    <figcaption>
                                        <a href="ViewBookDetailServlet?mode=bookDetail&bookID=<%=listBook.get(i).getBook_id()%>" style="text-decoration: none">
                                            <h3><%=listBook.get(i).getTitle()%></h3></a>
                                        <p><%=listBook.get(i).getAuthor_name()%></p>
                                        <div class="item-price"><%=listBook.get(i).getPrice()%> VND</div>
                                    </figcaption>
                                </figure>

                                <%}%>

                                <!--                                <figure class="product-style">
                                                                    <img src="images/product-item6.jpg" alt="Books" class="product-item">
                                                                    <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button>
                                                                    <figcaption>
                                                                        <h3>Great travel at desert</h3>
                                                                        <p>Sanchit Howdy</p>
                                                                        <div class="item-price">
                                                                            <span class="prev-price">$ 30.00</span>$ 38.00</div>
                                                                    </figcaption>
                                                                </figure>
                                
                                                                <figure class="product-style">
                                                                    <img src="images/product-item7.jpg" alt="Books" class="product-item">
                                                                    <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button>
                                                                    <figcaption>
                                                                        <h3>The lady beauty Scarlett</h3>
                                                                        <p>Arthur Doyle</p>
                                                                        <div class="item-price">
                                                                            <span class="prev-price">$ 35.00</span>$ 45.00</div>
                                                                    </figcaption>
                                                                </figure>
                                
                                                                <figure class="product-style">
                                                                    <img src="images/product-item8.jpg" alt="Books" class="product-item">
                                                                    <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button>
                                                                    <figcaption>
                                                                        <h3>Once upon a time</h3>
                                                                        <p>Klien Marry</p>
                                                                        <div class="item-price">
                                                                            <span class="prev-price">$ 25.00</span>$ 35.00</div>
                                                                    </figcaption>
                                                                </figure>
                                
                                                                <figure class="product-style">
                                                                    <img src="images/product-item2.jpg" alt="Books" class="product-item">
                                                                    <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to Cart</button>
                                                                    <figcaption>
                                                                        <h3>Simple way of piece life</h3>
                                                                        <p>Armor Ramsey</p>
                                                                        <div class="item-price">$ 40.00</div>
                                                                    </figcaption>
                                                                </figure>					-->
                            </div><!--grid-->
                        </div>
                    </div><!--inner-content-->
                </div>
            </div>
        </section>

        <section id="subscribe">
            <div class="container">
                <div class="row">

                    <div class="col-md-8 col-md-offset-2">
                        <div class="row">

                            <div class="col-md-6">

                                <div class="title-element">
                                    <h2 class="section-title divider">Subscribe to get newest books</h2>
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="subscribe-content" data-aos="fade-up">
                                    <p>You'll receive a confirmation and tracking number when your order is placed, and our in-house customer service team will be standing by if you have issues or returns.</p>
                                    <form id="form">
                                        <input type="text" name="email" placeholder="Enter your email addresss here">
                                        <button class="btn-subscribe">
                                            <span>send</span> 
                                            <i class="icon icon-send"></i>
                                        </button>
                                    </form>
                                </div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </section>



        <!--        <section id="download-app" class="leaf-pattern-overlay">
                    <div class="corner-pattern-overlay"></div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-8 col-md-offset-2">
                                <div class="row">
        
                                    <div class="col-md-5">
                                        <figure>
                                            <img src="images/device.png" alt="phone" class="single-image">
                                        </figure>
                                    </div>
        
                                    <div class="col-md-7">
                                        <div class="app-info">
                                            <h2 class="section-title divider">Download our app now !</h2>
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed ptibus liberolectus nonet psryroin. Amet sed lorem posuere sit iaculis amet, ac urna. Adipiscing fames semper erat ac in suspendisse iaculis.</p>
                                            <div class="google-app">
                                                <img src="images/google-play.jpg" alt="google play">
                                                <img src="images/app-store.jpg" alt="app store">
                                            </div>
                                        </div>
                                    </div>
        
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->

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