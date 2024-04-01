<%-- 
    Document   : ViewBookDetail
    Created on : Nov 18, 2022, 6:16:06 PM
    Author     : BLC
--%>

<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="dao.CartDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="entity.Discount"%>
<%@page import="dao.DiscountDAO"%>
<%@page import="entity.Genre"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Customer"%>
<%@page import="dao.GenreDAO"%>
<%@page import="dao.AuthorDAO"%>
<%@page import="entity.Author"%>
<%@page import="entity.Book"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Cart</title>
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
        <link rel="stylesheet" type="text/css" href="css/cart.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <!-- script
        ================================================== -->
        <script src="js/modernizr.js"></script>

    </head>

    <% Date currentDate = new Date();%>
    <%
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
        for (int i = 0; i < list_genre.size(); i++) {
            if (list_genre.get(i).getGenre_status() == 1) {
                listGenre.add(list_genre.get(i));
            }
        }
        DiscountDAO myDiscountDAO = new DiscountDAO();
        ArrayList<Discount> list_discount = myDiscountDAO.getListDiscount();
        ArrayList<Discount> listDiscount = new ArrayList<>();
        for (int i = 0; i < list_discount.size(); i++) {
            if (list_discount.get(i).getStatus() == 1) {
                listDiscount.add(list_discount.get(i));
            }
        }
        ArrayList<Discount> validDiscounts = new ArrayList<>();
        for (Discount discount : listDiscount) {
            if (discount.getQuantity() != 0 && discount.getEndDate() != null) {
                if (discount.getQuantity() >= 1 && discount.getEndDate().compareTo(currentDate.toString()) >= 0) {
                    validDiscounts.add(discount);
                }
            }
        }
        int total = 0;

        String level = "";
        Customer customer1 = (Customer) session.getAttribute("tempCustomer");;

        if (customer1.getTotal_spent() <= 1000000) {
            level = "Silver";
        }
        if (customer1.getTotal_spent() > 1000000 && customer1.getTotal_spent() <= 1000000) {
            level = "Gold";
        }
        if (customer1.getTotal_spent() > 2000000 && customer1.getTotal_spent() <= 3000000) {
            level = "Diamond";
        }
        if (customer1.getTotal_spent() > 3000000 && customer1.getTotal_spent() <= 4000000) {
            level = "Platinum";
        }

        if (level.equals("Silver")) {
            ArrayList<Discount> silverDiscounts = new ArrayList<>();
            for (Discount discount : listDiscount) {
                if (discount.getPercent() <= 15) {
                    silverDiscounts.add(discount);
                }
            }
            validDiscounts = silverDiscounts;
        }
        if (level.equals("Gold")) {
            ArrayList<Discount> goldDiscounts = new ArrayList<>();
            for (Discount discount : listDiscount) {
                if (discount.getPercent() > 15 && discount.getPercent() <= 20) {
                    goldDiscounts.add(discount);
                }
            }
            validDiscounts = goldDiscounts;
        }
        if (level.equals("Diamond")) {
            ArrayList<Discount> diamondDiscounts = new ArrayList<>();
            for (Discount discount : listDiscount) {
                if (discount.getPercent() > 20 && discount.getPercent() <= 25) {
                    diamondDiscounts.add(discount);
                }
            }
            validDiscounts = diamondDiscounts;
        }
        if (level.equals("Platinum")) {
            ArrayList<Discount> platinumDiscounts = new ArrayList<>();
            for (Discount discount : listDiscount) {
                if (discount.getPercent() > 25) {
                    platinumDiscounts.add(discount);
                }
            }
            validDiscounts = platinumDiscounts;
        }

// Now you can use the 'validDiscounts' variable containing the discounts based on customer's level
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
// Set the currency symbol to "VND" if necessary
        currencyFormat.setCurrency(Currency.getInstance("VND"));
    %>
    <body style="background-color: var(--light-color);">

        <div id="header-wrap">
            <div class="top-content" style="padding: 10px 0 0 0">
                <div class="container-fluid" style="margin:0px 46.667px !important">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="social-links">
                                <!--                                <ul>
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
                                                                </ul>-->
                            </div><!--social-links-->
                        </div>

                        <div class="col-md-6">
                            <div class="right-element">
                                <%
                                    Customer customer;
                                    int cartCount = 0;
                                    String txtAccount = "Login";
                                    String link = "UserLogin.jsp";
                                    String ss = (String) session.getAttribute("UserLogin");
                                    ArrayList<Cart> listCart = new ArrayList<>();
                                    if (ss != null) {
                                        customer = (Customer) session.getAttribute("tempCustomer");
                                        txtAccount = ss;
                                        link = "ManageUserLoginServlet?mode=viewProfile&customerID=";
                                        link += customer.getCustomer_id();
                                        CartDAO myCartDao = new CartDAO();

                                        listCart = myCartDao.getListCartByCustomerID(customer.getCustomer_id());
                                        System.out.println(listCart.size());
                                        if (listCart != null) {
                                            cartCount = listCart.size();
                                        }
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
                <div class="container-fluid">
                    <div class="row">

                        <div class="col-md-2">
                            <div class="main-logo" style="margin-left: 100px;">
                                <a href="UserActivityServlet?mode=userViewBook"><img src="images/main-logo.png" alt="logo" style="width: 300px;"></a>
                            </div>
                        </div>

                        <div class="col-md-10">
                            <nav id="navbar">
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list" style="text-align: center">
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

        <section class="cartcss">
            <form action="CartServlet?mode=checkout" method="post">
                <div class="container">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-8 cart" >
                                <div class="title">
                                    <div class="row">
                                        <div class="col"><h4><b>Shopping Cart</b></h4></div>
                                        <div class="col align-self-center text-right text-muted"><%=listCart.size()%> items</div>
                                    </div>
                                </div> 
                                <div>
                                    <div class="row border-top border-bottom" >
                                        <% if (listCart != null) {
                                        %>
                                        <% for (int i = 0; i < listCart.size(); i++) {%>

                                        <div class="row main align-items-center">
                                            <div class="col-2"><img class="img-fluid" src="bookImages/<%=listCart.get(i).getBookID()%>.jpg"></div>
                                            <div class="col">
                                                <div class="row text-muted"><%=listCart.get(i).getTitle()%></div>
                                                <div class="row"></div>
                                            </div>
                                            <div class="col">
                                                <a href="CartServlet?mode=downQuantity&bookID=<%=listCart.get(i).getBookID()%>">-</a><a href="" class="border"><%=listCart.get(i).getQuantity()%></a><a href="CartServlet?mode=upQuantity&bookID=<%=listCart.get(i).getBookID()%>">+</a>
                                            </div>
                                            <div class="col"><%=currencyFormat.format(listCart.get(i).getPrice())%> <a href="CartServlet?mode=deleteItem&bookID=<%=listCart.get(i).getBookID()%>" ><span class="close">&#10005;</span></a></div>
                                        </div>
                                        <%}%>

                                    </div>
                                </div> 
                            </div>


                            <div class="col-md-4 summary">
                                <div><h5><b>Summary</b></h5></div>
                                <hr>
                                <div class="row">
                                    <div class="col" style="padding-left:0;">ITEMS <%=listCart.size()%></div>
                                    <!--                                <div class="col text-right"> </div>-->
                                </div>
                                <form>
                                    <p>SHIPPING</p>
                                    <select style="margin-bottom: 0"><option class="text-muted">Standard-Delivery- 30000 VND</option></select>
                                </form>
                                <p>Discount</p>
                                <select id="selectedDiscount" name="selectedDiscount">
                                    <option class="text-muted" value="None" selected>None</option>
                                    <%
                                        Collections.sort(validDiscounts, new Comparator<Discount>() {
                                            @Override
                                            public int compare(Discount discount1, Discount discount2) {
                                                return Double.compare(discount2.getPercent(), discount1.getPercent());
                                            }
                                        });
                                    %>
                                    <%
                                        for (int i = 0; i < validDiscounts.size(); i++) {%>
                                    <option value="<%=validDiscounts.get(i).getPercent()%>"> <%= validDiscounts.get(i).getCode()%> - Discount <%= validDiscounts.get(i).getPercent()%>%</option>
                                    <% } %>
                                </select>
                                </form>
                                <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                                    <div class="col">TOTAL PRICE</div>
                                    <div class="col text-right">
                                        <%
                                            String selectedDiscountPercent = request.getParameter("selectedDiscount");

                                            total = 0;
                                            for (int i = 0; i < listCart.size(); i++) {
                                                total += listCart.get(i).getPrice() * listCart.get(i).getQuantity();
                                            }
                                            total += 30000;
                                            if (selectedDiscountPercent != null && !selectedDiscountPercent.isEmpty() && !selectedDiscountPercent.equals("None")) {
                                                double discountPercent = Double.parseDouble(selectedDiscountPercent);
                                                double discountAmount = (discountPercent / 100) * total;
                                                total -= discountAmount;
                                            }
                                        %>

                                        <div class="col text-right">
                                            <%= total%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <form action="CartServlet?mode=checkout" method="post">
                                <select name="method">
                                    <option value="COD">COD</option>>
                                    <option value="VNPay">VN Pay</option>
                                </select>
                                <input type="hidden" name="cartTotal" value="<%=total%>"
                                <a><button type="submit" class="btn">PLACE ORDER</button></a>
                            </form>
                          
                        </div>
                        </form>
                        </section>
                        <%}%>
                    </div>


                    <script src="js/jquery-1.11.0.min.js"></script>
                    <script src="js/plugins.js"></script>
                    <script src="js/script.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const selectedDiscount = document.getElementById("selectedDiscount");
                            const totalAmountElement = document.querySelector(".summary .col.text-right");

                            // Function to update the total amount and format it
                            function updateTotalAmount() {
                                const selectedDiscountPercent = selectedDiscount.value;
                                let total = <%=total%>; // Total amount calculated in server-side code

                                if (selectedDiscountPercent !== "None") {
                                    const discountPercent = parseFloat(selectedDiscountPercent);
                                    const discountAmount = (discountPercent / 100) * total;
                                    total -= discountAmount;
                                }

                                // Format the total amount
                                const currencyFormatter = new Intl.NumberFormat("en-US", {
                                    style: "currency",
                                    currency: "VND" // Adjust currency code as needed
                                });
                                const formattedTotal = currencyFormatter.format(total);

                                // Update the total amount element with the formatted total
                                totalAmountElement.textContent = formattedTotal;

                            }

                            // Add event listener to the discount dropdown
                            selectedDiscount.addEventListener("change", updateTotalAmount);

                            // Initial calculation on page load
                            updateTotalAmount();
                        });

                    </script>

                    </body>
                    </html>	