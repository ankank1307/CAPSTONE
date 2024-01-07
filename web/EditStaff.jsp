<%-- 
    Document   : AddAuthor
    Created on : Oct 31, 2022, 3:46:46 PM
    Author     : BLC
--%>

<%@page import="entity.Staff"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Edit Staff</title>
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
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <!--
            Product Admin CSS Template
            https://templatemo.com/tm-524-product-admin
        -->
    </head>
    <% Staff editStaff = (Staff)request.getAttribute("tempStaff"); %>

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
                            <a class="nav-link active" href="ManageAuthorServlet?mode=viewAuthor">
                                <i class="fas fa-user-tie"></i> AUTHORS
                                
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="ManageBookServlet?mode=viewBook">
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
                               <span class="sr-only">(current)</span>
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
                                <h2 class="tm-block-title d-inline-block">EDIT STAFF</h2>
                            </div>
                        </div>
                        <div class="row tm-edit-product-row">
                            <div class="col-xl-6 col-lg-6 col-md-10" id="add">
                                <form action="EditStaffServlet" method="post" class="tm-edit-product-form" >
                                    <input type="hidden" name="mode" value="editStaff">   
                                    <div class="form-group mb-3">
                                        <label  for="name" >ID </label>
                                        <input id="name" name="staffID" type="number"class="form-control validate" readonly="" value="<%=editStaff.getStaff_id() %>" />
                                    </div> 

                                    <div class="form-group mb-3">
                                        <label  for="name" >Name </label>
                                        <input id="name" name="authorName" type="text"class="form-control validate" required="" value="<%=editStaff.getStaff_name() %>"/>
                                    </div> 
                                    
                                    <div class="form-group mb-3">
                                        <label  for="name" >User Name </label>
                                        <input id="name" name="staffUserName" type="text"class="form-control validate" required="" value="<%=editStaff.getUsername() %>"/>
                                    </div>
                                    
                                    
                                    <!--
                                                                        
                                                                        <div class="form-group mb-3">
                                                                            <label  for="name" >Year of Release </label>
                                                                            <input
                                                                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                                                                id="name" name="YOR" type="number" min = "1200" max="2022" maxlength="4"  pattern="\d*" class="form-control validate" required=""/>
                                                                        </div>
                                                                                                                                                                                                        
                                    -->
                                    <!--                                    <div class="custom-file mt-3 mb-3">
                                                                            <input  name = "image" id="fileInput" type="file"  />
                                                                        </div>-->
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-12 mx-auto mb-4">
                                <div class="form-group mb-3">
                                        <label  for="name" >Email </label>
                                        <input id="name" name="staffEmail" type="text"class="form-control validate" required="" value="<%=editStaff.getEmail() %>"/>
                                    </div>

                                    <div class="form-group mb-3">
                                        <label  for="name" >Status</label>
                                        <input oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"
                                               id="name" name="status" type="number" min = "0" max="1" maxlength="1"  pattern="\d*" class="form-control validate" readonly="" value="<%=editStaff.getStaff_status() %>"/>
                                    </div>

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
