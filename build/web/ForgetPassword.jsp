<%-- 
    Document   : UserLogin
    Created on : Nov 9, 2022, 2:32:02 AM
    Author     : phuon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forget Password</title>
        <link rel="stylesheet" href="css/loginstyle.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <meta charset=UTF-8" />
    </head>
    <body class="align">
        <div class="overlay">
            <!-- LOGN IN FORM by Omar Dsoky -->
            <!--   con = Container  for items in the form-->
            <div class="con">
                <!--     Start  header Content  -->

                <header class="head-form">
                    <h2>Forget Password</h2>
                      
                    <p>Enter email here to get validate code</p>
                </header>
                <!--     End  header Content  -->
                <br>
                <div class="field-set">
                     
                    <form action = "ForgetPasswordServlet" method="post">
                        
                     
                        <span class="input-item">
                            <i class="fa fa-envelope-o"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="email" placeholder="Email" id="pwd"  name="email" required="" >
                        <br>
                        
                        <button class="log-in"> Get Validate Code </button>
                    </form>
                </div>
            </div> 


        </div>


    </body>
</html>
