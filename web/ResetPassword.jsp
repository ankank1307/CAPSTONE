<%-- 
    Document   : ResetPassword
    Created on : Nov 10, 2022, 3:52:16 PM
    Author     : BLC
--%>

<%@page import="entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
        <link rel="stylesheet"  href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" >
        <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" >
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"/>
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <style type="text/css">

            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body{
                background-image: linear-gradient(-225deg, #FFE6FA 0%, #F3F2EC 100%);
                background-image: linear-gradient(to top, #F3F2EC 0%, #F3F2EC 100%);
                background-attachment: fixed;
                background-repeat: no-repeat;
            }

            .wrapper{
                padding: 30px 50px;
                border: 1px solid #ddd;
                border-radius: 15px;
                margin: 10px auto;
                max-width: 600px;
            }


            .image:hover img {
                transition: all 0.5s;
                transform: scale(1.5);
            }

            .name {
                font-size: 18px;
                font-weight: 600;
            }


            h4{
                letter-spacing: -1px;
                font-weight: 400;
            }
            .img{
                width: 70px;
                height: 70px;
                border-radius: 6px;
                object-fit: cover;
            }
            #img-section p,#deactivate p{
                font-size: 12px;
                color: #777;
                margin-bottom: 10px;
                text-align: justify;
            }
            #img-section b,#img-section button,#deactivate b{
                font-size: 14px;
            }

            label{
                margin-bottom: 0;
                font-size: 14px;
                font-weight: 500;
                color: #777;
                padding-left: 3px;
            }

            .form-control{
                border-radius: 10px;
            }

            input[placeholder]{
                font-weight: 500;
            }
            .form-control:focus{
                box-shadow: none;
                border: 1.5px solid #0779e4;
            }
            select{
                display: block;
                width: 100%;
                border: 1px solid #ddd;
                border-radius: 10px;
                height: 40px;
                padding: 5px 10px;
                /* -webkit-appearance: none; */
            }

            select:focus{
                outline: none;
            }
            .button{
                background-color: #fff;
                color: #0779e4;
            }
            .button:hover{
                background-color: #0779e4;
                color: #fff;
            }
            .btn-primary{
                background-color: #0779e4;
            }
            .danger{
                background-color: #fff;
                color: #e20404;
                border: 1px solid #ddd;
            }
            .danger:hover{
                background-color: #e20404;
                color: #fff;
            }
            @media(max-width:576px){
                .wrapper{
                    padding: 25px 20px;
                }
                #deactivate{
                    line-height: 18px;
                }
            }
        </style>
    </head>
    <body>
        <% Customer tempCustomer = (Customer) session.getAttribute("tempCustomer"); %>
        <div class="wrapper bg-white mt-sm-5">
            <h4 class="pb-4 border-bottom">Reset Account Password</h4>

            <div class=" image d-flex flex-column justify-content-center align-items-center">      
                <button class="btn btn-secondary"> <img src="https://bootdey.com/img/Content/avatar/avatar7.png" height="100" width="100" />
                    <!--https://i.imgur.com/wvxPV9S.png-->
                </button> 
                <span class="name mt-3">@<%=tempCustomer.getUsername()%></span> 
            </div>
            <!--            <div class="d-flex align-items-start py-3 border-bottom">
                            <img src="https://images.pexels.com/photos/1037995/pexels-photo-1037995.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                 class="img" alt="">
                            <div class="pl-sm-4 pl-2" id="img-section">
                                <b>Profile Photo</b>
                                <p>Accepted file type .png. Less than 1MB</p>
                                <button class="btn button border"><b>Upload</b></button>
                            </div>
                        </div>-->
            <div class="py-2">
                <form action="EditUserProfileServlet?mode=resetPassword&cusID=<%=tempCustomer.getCustomer_id()%>" method="POST">

                    <div class="row py-2">
                        <div class="col-md-6">
                            <label for="name">Old Password</label>
                            <input name="oldPass" type="password" class="bg-light form-control" required="" >
                        </div>
                    </div>
                    <div class="row py-2">
                        <div class="col-md-6">
                            <label for="email">New Password</label>
                            <input name="newPass" type="password" class="bg-light form-control" required="">
                        </div>
                    </div>
                    <div class="row py-2">
                        <div class="col-md-6">
                            <label for="name">Confirm Password</label>
                            <input name="cfPass" type="password" class="bg-light form-control" required="" >
                        </div>
                    </div>
                    <div class="py-3 pb-4 border-bottom">
                        <button class="btn btn-primary mr-3">Save Changes</button>
                        <a href="ManageUserLoginServlet?mode=viewProfile&customerID=<%=tempCustomer.getCustomer_id()%>"><button class="btn border button">Cancel</button></a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
