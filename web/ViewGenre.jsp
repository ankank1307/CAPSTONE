<%-- 
    Document   : ViewAuthor
    Created on : Oct 30, 2022, 2:25:54 PM
    Author     : phuon
--%>

<%@page import="com.sun.tools.javac.jvm.Gen"%>
<%@page import="entity.Genre"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Genre Management</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Roboto -->
        <link rel="stylesheet" href="css/fontawesome.min.css" />
        <link rel="stylesheet" href="css/customstyle.css" />
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
    </head>

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
                            <a class="nav-link" href="ManageBookServlet?mode=viewBook">
                                <i class="fas fa-book"></i> BOOKS
                            </a>
                        </li>


                        <li class="nav-item">
                            <a class="nav-link active" href="ManageGenreServlet?mode=viewGenre">
                                <i class="fas fa-money-bill-wave"></i> GENRE
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="ManageOrderServlet?mode=viewOrder">
                                <i class="far fa-file-alt"></i> ORDER
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
                    <div class="tm-bg-primary-dark tm-block tm-block-products">
                        <form>
                            <div class="search-wrapper">

                                <div class="input-holder">
                                     <form action="ManageGenreServlet" method="post">
                                        <input type="text" class="search-input" placeholder="Type to search" name="searchInput" />
                                        <input type="hidden" name="mode" value="search">
                                    </form>
                                    <button type="submit" class="search-icon" onclick="searchToggle(this, event);"><span></span></button>

                                </div>
                                <span class="close" onclick="searchToggle(this, event);"></span>
                            </div>
                            <a href="AddGenre.jsp" style="margin-top: 30px" class="btn btn-primary btn-block text-uppercase mb-3">Add new genre </a>
                        </form>
                        <div class="tm-product-table-container" style="margin-top: 25px">
                            <%
                                ArrayList<Genre> listGenre = (ArrayList<Genre>) request.getAttribute("listGenre");
                            %>
                            <table class="table table-hover tm-table-small tm-product-table">
                                <thead>

                                    <tr>

                                        <th scope="col">ID </th>
                                        <th scope="col">Genre</th>
                                        <th scope="col">Genre Description</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">&nbsp;</th>
                                        <th scope="col">&nbsp;</th>

                                    </tr>
                                </thead>
                                <tbody>

                                    <% for (int i = 0; i < listGenre.size(); i++) {%>
                                    <tr class="rowGenre<%=listGenre.get(i).getGenre_status()%>">

                                        <td><%=listGenre.get(i).getGenre_id()  %></td>
                                        <td class="tm-product-name"><%=listGenre.get(i).getGenre() %></td>
                                        <td><%=listGenre.get(i).getDescription() %> </td>

                                        <td><%=listGenre.get(i).getGenre_status()%></td>
<!--                                        <td><img src="dishImages/<% %>" style="max-width: 100%;width: 115px;height: 115px;" alt="loading" loading="lazy"> </td>-->
                                        <td>
                                            <a href="ManageGenreServlet?mode=disableGenre&genreID=<%= listGenre.get(i).getGenre_id() %>" class="tm-product-delete-link"/>
                                            <i class="far fa-trash-alt tm-product-delete-icon"></i>

                                        </td>
                                        <td>
                                            <a href="EditGenreServlet?mode=viewGenre&genreID=<%= listGenre.get(i).getGenre_id() %>" class="tm-product-delete-link">
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
