
<%@page import="java.util.Currency"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Book"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/customstyle.css" />
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
        <title>Book Management</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Roboto -->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/customstyle.css" />
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
        <style>
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
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
        currencyFormat.setCurrency(Currency.getInstance("VND"));
        currencyFormat.setMaximumFractionDigits(0);
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
                            <a class="nav-link active" href="ManageBookServlet?mode=viewBook">
                                <i class="fas fa-book"></i> BOOKS
                            </a>
                        </li>


                        <li class="nav-item">
                            <a class="nav-link" href="ManageGenreServlet?mode=viewGenre">
                                <i class="fas fa-money-bill-wave"></i> GENRE
                            </a>
                        </li>
                        <div class="dropdown ">
                            <a class="nav-link" href="">
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
                    <div class="tm-bg-primary-dark tm-block tm-block-products">
                        <form>
                            <div class="search-wrapper">

                                <div class="input-holder">
                                    <form action="ManageBookServlet" method="post">
                                        <input type="text" class="search-input" placeholder="Type to search" name="searchInput" />
                                        <input type="hidden" name="mode" value="search">
                                    </form>

                                    <button type="submit" class="search-icon" onclick="searchToggle(this, event);"><span></span></button>
                                </div>
                                <span class="close" onclick="searchToggle(this, event);"></span>
                            </div>
                            <a href="ManageBookServlet?mode=addBook" style="margin-top: 30px" class="btn btn-primary btn-block text-uppercase mb-3">Add new book</a>
                        </form>
                        <div class="tm-product-table-container " style="margin-top: 25px">

                            <%
                                ArrayList<Book> listBook = (ArrayList<Book>) request.getAttribute("listBook");
                                listBook.sort(( o1,   o2) -> Integer.compare(o2.getBook_id(), o1.getBook_id()));
                            %>
                            <table class="table table-hover tm-table-small tm-product-table">
                                <thead>

                                    <tr>

                                        <th scope="col">ID </th>
                                        <th scope="col">Title</th>
                                        <th scope="col">Author ID</th>
                                        <th scope="col">Genre ID</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Price</th> 
                                        <th scope="col">Year of Release</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Image</th>
                                        <th scope="col">&nbsp;</th>
                                        <th scope="col">&nbsp;</th>

                                    </tr>
                                </thead>
                                <tbody>

                                    <% for (int i = 0; i < listBook.size(); i++) {%>
                                    <tr class="rowBook<%=listBook.get(i).getBook_status()%>">

                                        <td><%=listBook.get(i).getBook_id()%></td>
                                        <td><%=listBook.get(i).getTitle()%></td>
                                        <td><%=listBook.get(i).getAuthor_id()%> </td>

                                        <td><%=listBook.get(i).getGenre_id()%></td>
                                        <td><%=listBook.get(i).getQuantity()%> </td>
                                        <td><%= currencyFormat.format(listBook.get(i).getPrice())%> </td>
                                        <td><%=listBook.get(i).getYor()%> </td>
                                        <%
                                            String status = "";
                                            if (listBook.get(i).getBook_status() == 0) {
                                                status = "Out of stock";
                                            } else {
                                                status = "Available";
                                            }

                                        %>
                                        <td><%=status%> </td>
                                        <td><img src="bookImages/<%=listBook.get(i).getBook_id()%>.jpg" style="max-width: 100%;width: 115px;height: 115px;" alt="loading"> </td>

                                        <td>
                                            <a href="ManageBookServlet?mode=disableBook&bookID=<%= listBook.get(i).getBook_id()%>" class="tm-product-delete-link"/>
                                            <i class="far fa-trash-alt tm-product-delete-icon"></i>
                                        </td>
                                        <td>
                                            <a href="EditBookServlet?mode=viewBook&bookID=<%= listBook.get(i).getBook_id()%>" class="tm-product-delete-link">
                                                <i class="fas fa-pen"></i>                                           
                                            </a>

                                        </td>

                                    </tr>  
                                    <% }%>                                                                      
                                </tbody>    
                            </table>

                        </div><!--
                        <!-- table container -->

                        <!--                        <button class="btn btn-primary btn-block text-uppercase">
                                                    Delete selected products
                                                </button>-->
                    </div>
                </div>
            </div>
        </div>

        <!--            <footer class="tm-footer row tm-mt-small">
                        <div class="col-12 font-weight-light">
                            <p class="text-center text-white mb-0 px-4 small">
                                Copyright &copy; <b>2018</b> All rights reserved. 
        
                                Design: <a rel="nofollow noopener" href="https://templatemo.com" class="tm-footer-link">Template Mo</a>
                            </p>
                        </div>
                    </footer>-->

        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- https://jquery.com/download/ -->
        <script src="js/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script>
                                    $(function () {
                                        $(".tm-product-name").on("click", function () {
                                            window.location.href = "edit-product.html";
                                        });
                                    });



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

    </body>
</html>