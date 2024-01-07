<%-- 
    Document   : ViewOrderDetail
    Created on : Nov 23, 2022, 5:20:59 PM
    Author     : BLC
--%>

<%@page import="dao.BookDAO"%>
<%@page import="entity.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Detail</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title></title>
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

        <link rel="shortcut icon" type="image/x-icon" href="images/book.ico"/>
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
    </head>

    <%
        BookDAO myBookDAO = new BookDAO();
    %>
    <body>

        <div class="tm-product-table-container" style="margin-top: 25px">
            <a class="button4" href="ManageOrderServlet?mode=viewOrder">Back                                        
            </a>
            <%
                ArrayList<OrderDetail> listOrderDetail = (ArrayList<OrderDetail>) request.getAttribute("listOrderDetail");
            %>
            <table class="table table-hover tm-table-small tm-product-table">
                <thead>

                    <tr>


                        <th scope="col">Title</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Price</th>


                    </tr>
                </thead>
                <tbody>

                    <% for (int i = 0; i < listOrderDetail.size(); i++) {%>

                    <tr>

                        <td><%=myBookDAO.getBookByID(listOrderDetail.get(i).getBook_id()).getTitle()%></td>
                        <td><%=listOrderDetail.get(i).getQuantity()%></td>
                        <td><%=listOrderDetail.get(i).getPrice()%></td>

                    </tr> 

                    <% }%>                                                                      
                </tbody>
            </table>
        </div>
    </body>
</html>
