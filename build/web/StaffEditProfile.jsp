<%-- 
    Document   : AddProduct
    Created on : May 14, 2022, 7:41:16 PM
    Author     : phuon
--%>

<%@page import="entity.Genre"%>
<%@page import="entity.Author"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Add Book</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Roboto -->

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
        <style>




        </style>
    </head>
    <% ArrayList<Author> listAuthor = (ArrayList<Author>) request.getAttribute("listAuthor"); %>
    <% ArrayList<Genre> listGenre = (ArrayList<Genre>) request.getAttribute("listGenre");%>

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
                        <li class="nav-item">
                            <a class="nav-link" href="ManageOrderServlet?mode=viewOrder">
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

                        <!--                        <li class="nav-item">
                                                    <a class="nav-link" href="Billing.jsp">
                                                        <i class="fas fa-money-bill-wave"></i> 
                                                    </a>
                                                </li>-->

                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link d-block" href='LoginServlet?mode=logout'>
                                Admin, <b>Logout</b>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container tm-mt-big tm-mb-big">
            <div class="row">
                <div class="col-xl-9 col-lg-10 col-md-12 col-sm-12 mx-auto">
                    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
                        <div class="row">
                            <div class="col-12">
                                <h2 class="tm-block-title d-inline-block">EDIT PROFILE</h2>
                            </div>
                        </div>
                        <div class="row tm-edit-product-row">
                            <div class="col-xl-6 col-lg-6 col-md-10" id="add">
                                <form action="AddStaffServlet" method="post" class="tm-edit-product-form" enctype="multipart/form-data" >


                                    <div class="form-group mb-3">
                                        <label  for="name" >Name </label>
                                        <input id="name" name="name" type="text"class="form-control validate" value="" required=""/>
                                    </div>
                                    <div class="form-group mb-3">
                                        <label  for="name" >Username </label>
                                        <input id="name" name="username" value=""type="text"class="form-control validate" required=""/>
                                    </div>


                                    <!--                                    <div class="custom-file mt-3 mb-3">
                                                                            <input  name = "image" id="fileInput" type="file"  />
                                                                        </div>-->
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-12 mx-auto mb-4">
                                <div class="form-group mb-3">
                                    <label  for="name" >Password </label>
                                    <input id="name" name="password" value="" type="text"class="form-control validate" required=""/>
                                </div> 
                                <div class="form-group mb-3">
                                    <label  for="name" >Email </label>
                                    <input id="name" name="email" value="" type="text"class="form-control validate" required=""/>
                                </div>



                                <!--                                <div class="custom-file mt-3 mb-3">
                                                                    <input id="fileInput" type="file" name="image" style="display: none" accept=".png, .jpg, .jpeg, .gif"  />
                                                                    <input
                                                                        type="button"
                                                                        class="btn btn-primary btn-block mx-auto"
                                                                        value="UPLOAD PRODUCT IMAGE"
                                                                        onclick="document.getElementById('fileInput').click();"
                                                                        />
                                                                </div>-->
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary btn-block text-uppercase">UPDATE</button>
                            </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="tm-footer row tm-mt-small">
            <div class="col-12 font-weight-light">
                <p class="text-center text-white mb-0 px-4 small">
                    Copyright &copy; <b>2018</b> All rights reserved. 
                </p>
            </div>
        </footer> 

        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- https://jquery.com/download/ -->
        <script src="jquery-ui-datepicker/jquery-ui.min.js"></script>
        <!-- https://jqueryui.com/download/ -->
        <script src="js/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->
        <script>
            $(function () {
                $("#expire_date").datepicker();
            });
        </script>
    </body>
</html>
