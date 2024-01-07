<%-- 
    Document   : adminLogin
    Created on : Oct 25, 2022, 7:58:21 AM
    Author     : BLC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Open+Sans -->
        <link rel="stylesheet" href="css/fontawesome.min.css" />
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
    <body>
        <div class="container tm-mt-big tm-mb-big">
            <div class="row">
                <div class="col-12 mx-auto tm-login-col">
                    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
                        <div class="row">
                            <div class="col-12 text-center">
                                <h2 class="tm-block-title mb-4">Welcome to Manager, Login</h2>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-12">
                                <span style="color: red">${mess}</span>
                                <form action="LoginServlet" method="post" class="tm-login-form">
                                    <div class="form-group">
                                        <input type="hidden" name="mode" value="loginAdmin">
                                        <label for="username">Username</label>
                                        <input
                                            name="username"
                                            type="text"
                                            class="form-control validate"
                                            id="username"
                                            value=""
                                            required=""
                                            />

                                    </div>
                                    <div class="form-group mt-3">
                                        <label for="password">Password</label>
                                        <input
                                            name="password"
                                            type="password"
                                            class="form-control validate"
                                            id="password"
                                            value="" 
                                            required=""
                                            />
                                    </div>
                                    <div class="form-group mt-4">
                                        <button
                                            type="submit"
                                            class="btn btn-primary btn-block text-uppercase"
                                            >
                                            Login
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="tm-footer row tm-mt-small">
            <div class="col-12 font-weight-light">
                <p class="text-center text-white mb-0 px-4 small">
                    <!--Copyright &copy; <b>2018</b> All rights reserved.--> 
                </p>
            </div>
        </footer>


        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- https://jquery.com/download/ -->
        <script src="js/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->

    </body>
</html>
