<%@page import="servlet.Config"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <!-- Bootstrap core CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom styles -->
        <style>
            body {
                padding-top: 20px;
                background-color: #f8f9fa;
            }
            .container {
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }
            .header {
                margin-bottom: 20px;
            }
            .footer {
                margin-top: 20px;
                border-top: 1px solid #e9ecef;
                padding-top: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

        %>
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <!-- Add more form groups for other fields -->
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Mã giao dịch thanh toán:</label>
                        <label><%=request.getParameter("vnp_TxnRef")%></label>
                    </div>
                    <div class="form-group">
                        <label>Mô tả giao dịch:</label>
                        <label><%=request.getParameter("vnp_OrderInfo")%></label>
                    </div>
                    <div class="form-group">
                        <label>Mã giao dịch tại CTT VNPAY-QR:</label>
                        <label><%=request.getParameter("vnp_TransactionNo")%></label>
                    </div>
                    <div class="form-group">
                        <label>Thời gian thanh toán:</label>
                        <label><%=request.getParameter("vnp_PayDate")%></label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Số tiền:</label>
                        <% int amount =Integer.parseInt(request.getParameter("vnp_Amount"))/100; %>
                        <label><%=amount%></label>
                    </div>
                    <div class="form-group">
                        <label>Mã lỗi thanh toán:</label>
                        <label><%=request.getParameter("vnp_ResponseCode")%></label>
                    </div>
                    <div class="form-group">
                        <label>Mã ngân hàng thanh toán:</label>
                        <label><%=request.getParameter("vnp_BankCode")%></label>
                    </div>
                    <!-- Add more fields here if needed -->
                </div>
            </div>
            <!-- End additional form groups -->

            <a href="UserActivityServlet?mode=userViewBook" class="btn btn-secondary">Back</a>
        </div>
        <p>
            &nbsp;
        </p>
        <footer class="footer">
            <p>&copy; VNPAY 2020</p>
        </footer>
    </div>
    <!-- Bootstrap core JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
