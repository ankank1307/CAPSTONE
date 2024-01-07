<%-- 
    Document   : home
    Created on : Oct 30, 2022, 12:41:36 PM
    Author     : phuon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Admin</title>
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
        <!--
            Product Admin CSS Template
            https://templatemo.com/tm-524-product-admin
        -->
        
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <style>
            a:link, a:visited {
                background-color: #f5a623;
                color: white;
                padding: 14px 25px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
            }

            a:hover, a:active {
                background-color: #4e657a;
            }
            h1{
                color: white;
            }
            .manage {
                margin-left: auto;
                margin-right: auto;
                margin-left: 60px;
            }
            .logout{
                margin-left: 50px;
            }


        </style>
    </head>


    <body>
        <div class="container tm-mt-big tm-mb-big">
            <div class="row">
                <div class="col-12 mx-auto tm-login-col">
                    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">
                        <div class="row">
                            <div class="col-12 text-center">
                                <h1>Hello <%= session.getAttribute("adminLogin")%> </h1>
                            </div>
                        </div>
                        <div class="row mt-2 manage">
                            <div class="col-12">                           
                                <div class="form-group">
                                    <div class="form-group mt-4">                                        
                                        <a href="ManageBookServlet?mode=viewBook">BookStore Management</a>

                                    </div>
                                </div>


                                <a href="adminLogin.jsp" class="logout">Logout</a>       
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
