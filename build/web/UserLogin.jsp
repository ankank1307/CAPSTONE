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
        <title>Login</title>
        <link rel="stylesheet" href="css/loginstyle.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
    </head>
    <body class="align">
        <div class="overlay">
            <!-- LOGN IN FORM by Omar Dsoky -->
                <!--   con = Container  for items in the form-->
                <div class="con">
                    <!--     Start  header Content  -->

                    <header class="head-form">
                        <h2>Log In</h2>
                        <!--     A welcome message or an explanation of the login form -->
                        <p>login here using your username and password</p>
                    </header>
                    <!--     End  header Content  -->
                    <br>
                    <div class="field-set">
                        <span style="color: red">${mess}</span>
                         <form action = "ManageUserLoginServlet" method="post">
                        <!--   user name -->
                        <span class="input-item">
                            
                            
                            
                            <i class="fa fa-user-circle"></i>
                        </span>
                        <!--   user name Input-->
                       
                         <input name="mode" type="hidden" value="userLogin" />
                        <input class="form-input" id="txt-input" type="text" placeholder="UserName" required="" name="username"  >

                        <br>

                        <!--   Password -->

                        <span class="input-item">
                            <i class="fa fa-key"></i>
                        </span>
                        <!--   Password Input-->
                        <input class="form-input" type="password" placeholder="Password" id="pwd"  name="password" >

                        <!--      Show/hide password  -->
                        <!--     <span>
                                <i class="fa fa-eye" aria-hidden="true"  type="button" id="eye"></i>
                             </span>-->


                        <br>
                        <!--        buttons -->
                        <!--      button LogIn -->
                        <button class="log-in"> Log In </button>
                        </form>
                    </div>
                                          

                    <div class="other">
                        <!--      Forgot Password button-->
                        <a href="ForgetPassword.jsp" ><button class="btn submits frgt-pass">Forgot Password</button></a>
                        <!--     Sign Up button -->
                        <a href="UserRegister.jsp"><button class="btn submits sign-up">Sign Up 
                            <!--         Sign Up font icon -->
                            <i class="fa fa-user-plus" aria-hidden="true"></i>
                            </button></a>
                        <!--      End Other the Division -->
                    </div>
                </div> 
            

        </div>

        <script>


//            function show() {
//                var p = document.getElementById('pwd');
//                p.setAttribute('type', 'text');
//            }
//
//            function hide() {
//                var p = document.getElementById('pwd');
//                p.setAttribute('type', 'password');
//            }
//
//            var pwShown = 0;
//
//            document.getElementById("eye").addEventListener("click", function () {
//                if (pwShown == 0) {
//                    pwShown = 1;
//                    show();
//                } else {
//                    pwShown = 0;
//                    hide();
//                }
//            }, false);
        </script>
    </body>
</html>
