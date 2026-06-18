<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Dashboard</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Dashboard</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active">Dashboard</li>
                                </ol>
                                <div class="row">
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-area me-1"></i>
                                                Doanh Thu
                                            </div>
                                            <div class="card-body"><canvas id="myAreaChart" width="100%"
                                                     height="40"></canvas>
                                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                                <script>
                                                    let myLineChart = null;
                                                    fetch('/revenue-data')
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            const ctx = document.getElementById('myAreaChart').getContext('2d');
                                                            if (myLineChart) {
                                                                myLineChart.destroy();
                                                            }
                                                            myLineChart = new Chart(ctx, {
                                                                type: 'bar',
                                                                data: {
                                                                    labels: data.labels,
                                                                    datasets: [{
                                                                        label: 'Doanh thu theo tháng',
                                                                        data: data.value,
                                                                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                                                                        borderColor: 'rgba(54, 162, 235, 1)',
                                                                        borderWidth: 1
                                                                    }]
                                                                },
                                                                options: {
                                                                    scales: {
                                                                        y: {
                                                                            beginAtZero: true
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        });
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xl-6">
                                        <div class="card mb-4">
                                            <div class="card-header">
                                                <i class="fas fa-chart-bar me-1"></i>
                                                Doanh thu theo hãng
                                            </div>
                                            <div class="card-body"><canvas id="myBarChart" width="100%"
                                                     height="40"></canvas>
                                                <script>
                                                    let myBarChartInstance = null;
                                                    fetch('/revenue-by-factory')
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            const ctx = document.getElementById('myBarChart').getContext('2d');
                                                            if (myBarChartInstance) {
                                                                myBarChartInstance.destroy();
                                                            }
                                                            myBarChartInstance = new Chart(ctx, {
                                                                type: 'bar',
                                                                data: {
                                                                    labels: data.labels,
                                                                    datasets: [{
                                                                        label: 'Doanh thu theo hãng',
                                                                        data: data.value,
                                                                        backgroundColor: 'rgba(153, 102, 255, 0.6)',
                                                                        borderColor: 'rgba(153, 102, 255, 1)',
                                                                        borderWidth: 1
                                                                    }]
                                                                },
                                                                options: {
                                                                    scales: {
                                                                        y: {
                                                                            beginAtZero: true
                                                                        }
                                                                    }
                                                                }
                                                            });
                                                        });
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                        Thống kê đơn hàng
                                    </div>
                                    <div class="card-body">
                                        <table id="datatablesSimple">
                                            <thead>
                                                <tr>
                                                    <th>Mã đơn hàng</th>
                                                    <th>Gía trị đơn hàng</th>
                                                    <th>Người nhận</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Trạng thái</th>
                                                    <th>Thời Gian</th>
                                                </tr>
                                            </thead>
                                            <tfoot>
                                                
                                            </tfoot>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td class="font-monospace fw-bold text-primary">${order.orderCode}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${order.totalPrice}" /> đ
                                                        </td>
                                                        <td>${order.receiverName}</td>
                                                        <td>${order.receiverAddress}</td>
                                                        <td>${order.receiverPhone}</td>
                                                         <td>
                                                             <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                                                         </td>
                                                        <td>${order.orderDate}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/datatables-simple-demo.js"></script>
            </body>

            </html>
