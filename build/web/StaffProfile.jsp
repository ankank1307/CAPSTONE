
<%@page import="entity.Staff"%>
<%@page import="entity.Order"%>
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Book"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Profile</title>
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
        <!--
            Product Admin CSS Template
            https://templatemo.com/tm-524-product-admin
        
        -->
        <link rel="stylesheet" href="css/search_button.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
        <%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
        <style type="text/css">
            a.button4{
                display:inline-block;
                padding:0.3em 1.2em;
                margin:0 0.1em 0.1em 0;
                border:0.16em solid rgba(255,255,255,0);
                border-radius:2em;
                box-sizing: border-box;
                text-decoration:none;
                font-family:'Roboto',sans-serif;
                font-weight:300;
                color:#FFFFFF;
                text-shadow: 0 0.04em 0.04em rgba(0,0,0,0.35);
                text-align:center;
                transition: all 0.2s;
            }

            a.button4:hover{
                border-color: rgba(255,255,255,1);
            }

        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-Yz5FyPzvSe6VxywFN+VGFnZZta3+kbq0U1lH6Ox6+tLJwe8AvllziHpQz24Og7hElKLcJFp7fmj1N7HaoyvWlA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-BtG4F1i0E9g9E9cT62tuo6nYlrCHp4FTuGj4t1yA+mz0G1L48fv2HiO0pv5WNZcKaB8rS+RiisVY8zI3pIsU5g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </head>


    <body id="reportsPage">
        <% Staff staff = (Staff) session.getAttribute("staffLogin");%>


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
                            <a class="nav-link" href="StaffManageServlet?mode=StaffViewBook">
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
                            <a class="nav-link" href="StaffProfile.jsp">
                                <i class="fas fa-user-plus"></i> PROFILE
                            </a>
                        </li>

                    </ul>
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link d-block" href='staffLogin.jsp'>
                                <%=staff.getStaff_name()%>, <b>Logout</b>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container mt-5">
            <div id="successMessage" class="alert alert-success" style="display:none;">
                Profile successfully updated!
            </div>
            <% if (request.getAttribute("updateSuccess") != null && (boolean) request.getAttribute("updateSuccess")) { %>
            <script>
                document.getElementById('successMessage').style.display = 'block';
            </script>
            <% }%>
            <div class="row tm-content-row">
                <div class="tm-block-col tm-col-avatar">
                    <div class="tm-bg-primary-dark tm-block tm-block-avatar">
                        <h2 class="tm-block-title">Staff Profile</h2>
                        <div class="tm-avatar-container">
                            <img
                                src="bookImages/StaffProfile.png"
                                alt="Avatar"
                                class="tm-avatar img-fluid mb-4"
                                />
                        </div>
                    </div>
                </div>
                <div class="tm-block-col tm-col-account-settings">
                    <div class="tm-bg-primary-dark tm-block tm-block-settings">
                        <h2 class="tm-block-title">Account Settings</h2>
                        <form action="StaffManageServlet" class="tm-signup-form row">
                            <input type="hidden" name="mode" value="StaffUpdateProfile"> 
                            <div class="form-group col-lg-6">
                                <label for="name">User Name</label>
                                <input
                                    id="name"
                                    name="staffUserName"
                                    type="text"
                                    class="form-control validate"
                                    value="<%=staff.getUsername()%>"
                                    />
                            </div>
                            <div class="form-group col-lg-6">
                                <label for="name">Staff Name</label>
                                <input
                                    id="name"
                                    name="staffName"
                                    type="text"
                                    class="form-control validate"
                                    value="<%=staff.getStaff_name()%>"
                                    />
                            </div>
                            <div class="form-group col-lg-6">
                                <label for="email">Account Email</label>
                                <input
                                    id="email"
                                    name="staffEmail"
                                    type="email"
                                    class="form-control validate"
                                    value="<%=staff.getEmail()%>"
                                    />
                            </div>
                            <!--                            <div class="form-group col-lg-6">
                            
                                                        </div>-->

                            <div class="form-group col-lg-6">
                                <label class="tm-hide-sm">&nbsp;</label>
                                <!--<a href="StaffManageServlet?mode=StaffUpdateProfile>-->
                                <button
                                    type="submit"
                                    class="btn btn-primary btn-block text-uppercase"
                                    >
                                    Update Your Profile
                                </button>
                                <!--</a>-->
                            </div>
                            <div class="col-12">

                            </div>
                        </form>
                        <!--                        <div>
                                                    <label class="tm-hide-sm">&nbsp;</label>
                                                    <a href="StaffManageServlet?mode=StaffUpdatePassword>
                                                       <button
                                                       type="submit"
                                                       class="btn btn-primary btn-block text-uppercase"
                                                       >
                                                        Update Password
                                                        </button>
                                                    </a>
                                                </div>-->
                    </div>
                </div>
            </div>
            <div class="row tm-content-row">
                <div class="col-12 tm-block-col">
                    <div class="tm-bg-primary-dark tm-block tm-block-h-auto">

                    </div>
                </div>
            </div>


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
            <script>
                // Function to hide the success message after 5 seconds
                function hideSuccessMessage() {
                    setTimeout(function () {
                        document.getElementById('successMessage').style.display = 'none';
                    }, 3000); // 5000 milliseconds = 5 seconds
                }

                // Call the function to hide the success message
                hideSuccessMessage();
            </script>

    </body>
</html>