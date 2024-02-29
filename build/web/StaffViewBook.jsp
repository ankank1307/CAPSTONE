
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Book"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
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




        </style>
    </head>

    <body id="reportsPage">
        <nav class="navbar navbar-expand-xl">
            <div class="container h-100">
                <a class="navbar-brand" href="home.jsp">
                    <h1 class="tm-site-title mb-0">Product Staff</h1>
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
                            <a class="nav-link active" href="StaffManageServlet?mode=StaffViewBook">
                                <i class="fas fa-book"></i> BOOKS
                            </a>
                        </li>


                        
                        <li class="nav-item">
                            <a class="nav-link" href="StaffManageServlet?mode=StaffViewOrder">
                                <i class="far fa-file-alt"></i> ORDER
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="StaffManageServlet?mode=StaffViewCustomer">
                                <i class="fas fa-user"></i> CUSTOMER
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="">
                                <i class="fas fa-user"></i> PROFILE
                            </a>
                        </li>

                        <!--                        <li class="nav-item">
                                                    <a class="nav-link" href="Billing.jsp">
                                                        <i class="fas fa-money-bill-wave"></i> 
                                                    </a>
                                                </li>-->

                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link d-block" href='staffLogin.jsp'>
                                <%=session.getAttribute("staffLogin") %>, <b>Logout</b>
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
         
                        </form>
                        <div class="tm-product-table-container " style="margin-top: 25px">

                            <%
                                ArrayList<Book> listBook = (ArrayList<Book>) request.getAttribute("listBook");
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
                                    <tr class="rowBook<%=listBook.get(i).getBook_status() %>">

                                        <td><%=listBook.get(i).getBook_id()%></td>
                                        <td><%=listBook.get(i).getTitle()%></td>
                                        <td><%=listBook.get(i).getAuthor_id() %> </td>

                                        <td><%=listBook.get(i).getGenre_id()%></td>
                                        <td><%=listBook.get(i).getQuantity() %> </td>
                                        <td><%=listBook.get(i).getPrice() %> </td>
                                        <td><%=listBook.get(i).getYor() %> </td>
                                        <td><%=listBook.get(i).getBook_status() %> </td>
                                        <td><img src="bookImages/<%=listBook.get(i).getBook_id()%>.jpg" style="max-width: 100%;width: 115px;height: 115px;" alt="loading"> </td>

                                        <td>
                                            <a href="AddToBill.jsp " class="tm-product-delete-link"/>
                                          <i class="fas fa-cart-plus"></i>

                                        </td>
                                        <td>
                                            <a href="" class="tm-product-delete-link">
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