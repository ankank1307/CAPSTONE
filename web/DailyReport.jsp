<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/customstyle.css" />
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
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:400,700"
            />
        <!-- https://fonts.google.com/specimen/Roboto -->

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.2.0/css/all.min.css" integrity="sha512-6c4nX2tn5KbzeBJo9Ywpa0Gkt+mzCzJBrE1RB6fmpcsoN+b/w/euwIMuQKNyUoU/nToKN3a8SgNOtPrbW12fug==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="css/customstyle.css" />
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
        <title>Daily Report</title>
        <style>
            .dropbtn {
                background-color: #04AA6D;
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #567086;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: white;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }
            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #3e8e41;
            }

            .form-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            form {
                display: flex;
                flex-wrap: wrap;
                justify-content: flex-end;
                align-items: center;
            }
            input[type="date"] {
                padding: 10px;
                margin: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            button {
                padding: 10px 20px;
                margin: 5px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            button:hover {
                background-color: #0056b3;
            }
            .text{
                color: white;
            }
            .b-padding{
                padding-left: 40px;
            }
        </style>
    </head>
    <%
        Gson gsonObj = new Gson();
        Map<Object, Object> map = null;
        int total = (Integer) request.getAttribute("totalRevenue");
        int totalOrders = (Integer) request.getAttribute("totalOrder");
        int totalCustomer = (Integer) request.getAttribute("totalCustomer");
        int saleBook = (Integer) request.getAttribute("saleBook");
        List<Map<Object, Object>> list = (List<Map<Object, Object>>) request.getAttribute("listRevenueByMonth");
        String dataPoints = gsonObj.toJson(list);
        System.out.println(dataPoints);
        List<Map<String, Object>> dataPointsList = gsonObj.fromJson(dataPoints, new TypeToken<List<Map<String, Object>>>() {
        }.getType());
         List<String> dates = (List<String>)request.getAttribute("dates");
         Gson gson = new Gson();
         String dataJson = gson.toJson(dates);
        List<Integer> revenueByDate = (List<Integer>) request.getAttribute("revenueByDate");
        List<Integer> yValues = new ArrayList<>();
        for (Map<String, Object> entry : dataPointsList) {
            if (entry.containsKey("y")) {
                yValues.add(((Double) entry.get("y")).intValue());
            } else {
                yValues.add(0);
            }
        }
        System.out.println(yValues.size());
    %>
    <body id="reportsPage">
        <div class="" id="home">
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
                                <a class="nav-link" href="ManageAuthorServlet?mode=viewAuthor">
                                    <i class="fas fa-user-tie"></i> AUTHORS
                                    <span class="sr-only">(current)</span>
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
                            <div class="dropdown ">
                                <a class="nav-link active" href="">
                                    <i class="fas fa-file-alt"></i> 
                                    <span>
                                        REPORT<i class="fas fa-angle-down" style="padding-left: 5px;"></i>
                                    </span>
                                </a>
                                <div class="dropdown-content">
                                    <a href="ManageOrderServlet?mode=viewOrder">ORDER</a>
                                    <!--<a href="DailyReport.jsp">WEEKLY REPORT</a>-->
                                    <% String date = java.time.LocalDate.now().toString();
                                        System.out.println(date);
                                    %>
                                    <a href="ViewReportServlet?mode=dailyReport&startDate=<%=0%>&endDate=<%=date%>">DAILY REPORT</a>
                                </div>
                            </div>
                            <div class="dropdown">
                                <a class="nav-link" href="ManageStaffServlet?mode=viewStaff">
                                    <i class="fas fa-user"></i> 
                                    <span>
                                        USER<i class="fas fa-angle-down" style="padding-left: 5px;"></i>
                                    </span>
                                </a>

                                <div class="dropdown-content">
                                    <a href="ManageStaffServlet?mode=viewStaff">STAFF</a>
                                    <a href="ManageCustomerServlet?mode=viewCustomer">CUSTOMER</a>
                                </div>
                            </div>
                            <li class="nav-item">
                                <a class="nav-link" href="ManageDiscountServlet?mode=viewDiscount">
                                    <i class="fas fa-money-check"></i> VOUCHERS
                                </a>
                            </li>
                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link d-block" href='adminLogin.jsp'>
                                    Admin, <b>Logout</b>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="container">

                <div style="margin-top:50px; margin-bottom: 10px; ">
                    <form action="ViewReportServlet">

                        <input type="hidden" value="dailyReport" name="mode">
                        <label class="text">From:</label>
                        <input type="date" id="start" name="startDate" value="<%=date%>" max="<%=date%>" onchange="updateEndDate()" />
                        <label class="text">To:</label>
                        <input type="date" id="end" name="endDate" value="<%=date%>" max="<%=date%>" />
                        <button>View</button>
                    </form>
                </div>
                <div class="row" >
                    <div class="col-3">
                        <p class="tm-bg-primary-dark text" style="padding-bottom: 40px; padding-top: 40px;padding-left: 20px; border-radius: 5%">Revenue: <b class="b-padding"><%=total%></b></p>
                    </div>
                    <div class="col-3">
                        <p class="tm-bg-primary-dark text" style="padding: 40px;border-radius: 5%">Orders:<b class="b-padding"><%=totalOrders%></b></p>
                    </div>
                    <div class="col-3">
                        <p class="tm-bg-primary-dark text" style="padding: 40px;border-radius: 5%">Customers: <b class="b-padding"><%=totalCustomer%></b></p>
                    </div>
                    <div class="col-3">
                        <p class="tm-bg-primary-dark text" style="padding: 40px;border-radius: 5%">Sale books: <b class="b-padding"><%=saleBook%></b></p>
                    </div>
                </div>


                <!-- row -->
                <div class="row tm-content-row">

                    <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
                        <div class="tm-bg-primary-dark tm-block">
                            <h2 class="tm-block-title">Daily report</h2>
                            <canvas id="barChart"></canvas>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
                        <div class="tm-bg-primary-dark tm-block tm-block-taller">
                            <h2 class="tm-block-title">Top book sales</h2>
                            <div id="pieChartContainer">
                                <canvas id="pieChart" class="chartjs-render-monitor" width="200" height="200"></canvas>
                            </div>                        
                        </div>
                    </div>    
                </div>
            </div>

        </div>
        <script>
            function updateEndDate() {
                var startDate = new Date(document.getElementById("start").value);
                var maxEndDate = new Date(startDate);
                maxEndDate.setDate(startDate.getDate() + 7);
                var currentDate = new Date();
                currentDate.setDate(currentDate.getDate() + 1); // Set current date to tomorrow

                var endDateInput = document.getElementById("end");
                endDateInput.min = startDate.toISOString().split('T')[0]; // Set minimum date to the selected "From" date
                endDateInput.max = currentDate.toISOString().split('T')[0]; // Set maximum date to current date + 1 day

                // If the current value of "To" date is not within the allowed range, reset it to the maximum allowed date
                if (new Date(endDateInput.value) > maxEndDate || new Date(endDateInput.value) > currentDate) {
                    endDateInput.value = maxEndDate.toISOString().split('T')[0];
                }
            }
        </script>  

        <script src="js/jquery-3.3.1.min.js"></script>
        <!-- https://jquery.com/download/ -->
        <script src="js/moment.min.js"></script>
        <!-- https://momentjs.com/ -->
        <script src="js/Chart.min.js"></script>
        <!-- http://www.chartjs.org/docs/latest/ -->
        <script src="js/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->
        <script src="js/tooplate-scripts.js"></script>
        <script>

            Chart.defaults.global.defaultFontColor = 'white';
            let ctxLine,
                    ctxBar,
                    ctxPie,
                    optionsLine,
                    optionsBar,
                    optionsPie,
                    configLine,
                    configBar,
                    configPie,
                    lineChart;
            barChart, pieChart;
            // DOM is ready

            $(function () {
                $(function drawBarChart() {
                    if ($("#barChart").length) {
                        ctxBar = document.getElementById("barChart").getContext("2d");

                        optionsBar = {
                            responsive: true,
                            scales: {
                                yAxes: [
                                    {
                                        barPercentage: 0.9,
                                        ticks: {
                                            beginAtZero: true
                                        },
                                        scaleLabel: {
                                            display: true,
                                            labelString: "Hits"
                                        }
                                    }
                                ]
                            }
                        };
                        optionsBar.maintainAspectRatio =
                                $(window).width() < width_threshold ? false : true;

                        configBar = {
                            type: "horizontalBar",
                            data: {
                                labels: <%=dataJson %>,
                                datasets: [
                                    {
                                        label: "",
                                        data: <%=revenueByDate %>,
                                        backgroundColor: [
                                            "#F7604D",
                                            "#4ED6B8",
                                            "#A8D582",
                                            "#D7D768",
                                            "#9D66CC",
                                            "#DB9C3F",
                                            "#F7604D",
                                            "#3889FC",
                                            "#D7D768",
                                            "#3889FC",
                                            "#4ED6B8",
                                            "#9D66CC"
                                        ],
                                        borderWidth: 0
                                    }
                                ],

                            },
                            options: optionsBar
                        };

                        barChart = new Chart(ctxBar, configBar);
                    }
                })
                $(function drawPieChart() {
                    if ($("#pieChart").length) {
                        var chartHeight = 300;

                        $("#pieChartContainer").css("height", chartHeight + "px");

                        ctxPie = document.getElementById("pieChart").getContext("2d");

                        optionsPie = {
                            responsive: true,
                            maintainAspectRatio: false,
                            layout: {
                                padding: {
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                    bottom: 10
                                }
                            },
                            legend: {
                                position: "top"
                            }
                        };

                        configPie = {
                            type: "pie",
                            data: {
                                datasets: [
                                    {
                                        data: [18.24, 6.5, 9.15],
                                        backgroundColor: ["#F7604D", "#4ED6B8", "#A8D582"],
                                        label: "Storage"
                                    }
                                ],
                                labels: [
                                    "Used Storage (18.240GB)",
                                    "System Storage (6.500GB)",
                                    "Available Storage (9.150GB)"
                                ]
                            },
                            options: optionsPie
                        };

                        pieChart = new Chart(ctxPie, configPie);
                    }
                })
                $(window).resize(function () {
                    updateLineChart();
                    updateBarChart();
                });
            })
        </script>
    </body>

</html>