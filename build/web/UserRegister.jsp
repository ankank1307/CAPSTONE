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
        <title>Register</title>
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
                    <h2>Register Account</h2>
                    <!--     A welcome message or an explanation of the login form -->
                    <!--<p>login here using your username and password</p>-->
                </header>
                <!--     End  header Content  -->
                 <span style="color: red">${registerMess}</span>
                <br>
                 
                <div class="field-set">
                  
                    <form action = "ManageUserLoginServlet" method="post">
                        <input name="mode" type="hidden" value="userRegister" /> 
                        <!--   user name -->
                        <span class="input-item">



                            <i class="fa fa-group"></i>
                        </span>
                        <!--   user name Input-->

                             
                        <input class="form-input" id="txt-input" type="text" placeholder="Name" required="" name="name"  >
                        <br>
                        <span class="input-item">
                            <i class="fa fa-user-circle"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="text" placeholder="Username" id="pwd"  name="R_username" required="" >

                        <br>
                        <span class="input-item">
                            <i class="fa fa-key"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="password" placeholder="Password" id="pwd"  name="R_password" required="" >

                        <br>


                        <!--   Password -->

                        <span class="input-item">
                            <i class=" fa fa-address-card-o" ></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="text" placeholder="Address" id="pwd"  name="address" required="" >

                        
                        <br>
                        <span class="input-item">
                            <i class="fa fa-phone" style="font-size: 21px;"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="number" placeholder="Phone number" id="pwd"  name="phone_number"  required="">

                        <br>
                        <span class="input-item">
                            <i class="fa fa-envelope-o"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="email" placeholder="Email" id="pwd"  name="email" required="" >
                        <br>
                        
                        <button class="log-in"> Create Account </button>
                    </form>
                </div>
            </div> 


        </div>


    </body>
</html>
