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
                <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <style>
                    /* KPI Cards Styling — Light Gold */
                    .kpi-card {
                        border: 1px solid rgba(184, 148, 30, 0.25) !important;
                        border-radius: 16px !important;
                        background-color: #ffffff !important;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04) !important;
                        transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
                        overflow: hidden;
                        position: relative;
                    }
                    .kpi-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 12px 30px rgba(184, 148, 30, 0.15) !important;
                    }
                    .kpi-card::before {
                        content: "";
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 5px;
                        height: 100%;
                        background-color: var(--card-accent-color, #d4af37);
                    }
                    .kpi-icon-container {
                        width: 52px;
                        height: 52px;
                        border-radius: 14px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background-color: var(--card-accent-light, rgba(212, 175, 55, 0.08));
                        color: var(--card-accent-color, #b8941e);
                        font-size: 22px;
                        transition: all 0.25s ease;
                    }
                    .kpi-card:hover .kpi-icon-container {
                        transform: scale(1.1) rotate(5deg);
                    }
                    .kpi-title {
                        font-size: 11px;
                        font-weight: 700;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        color: #64748b;
                        margin-bottom: 8px;
                    }
                    .kpi-value {
                        font-size: 24px;
                        font-weight: 800;
                        color: #1e293b;
                        letter-spacing: -0.5px;
                    }
                    
                    /* Chart Cards — Light Gold */
                    .chart-card {
                        border: 1px solid rgba(184, 148, 30, 0.25) !important;
                        border-radius: 16px !important;
                        background-color: #ffffff !important;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04) !important;
                        transition: transform 0.25s ease, box-shadow 0.25s ease !important;
                        overflow: hidden;
                    }
                    .chart-card:hover {
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08) !important;
                    }
                    .chart-card-header {
                        background-color: #f8f9fa !important;
                        border-bottom: 1px solid rgba(212, 175, 55, 0.2) !important;
                        padding: 20px 24px !important;
                        font-weight: 700 !important;
                        color: #b8941e !important;
                        font-size: 16px !important;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }
                    .chart-card-body {
                        padding: 24px !important;
                    }
                </style>

            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4 mb-4">Dashboard</h1>
                                <%
                                    double todayRevenue = 0;
                                    double monthRevenue = 0;
                                    int pendingOrdersCount = 0;
                                    
                                    java.time.LocalDate today = java.time.LocalDate.now();
                                    int todayYear = today.getYear();
                                    int todayMonth = today.getMonthValue();
                                    int todayDay = today.getDayOfMonth();
                                    
                                    java.util.List<com.tstwatchluxury.domain.Order> orders = (java.util.List<com.tstwatchluxury.domain.Order>) request.getAttribute("orders");
                                    if (orders != null) {
                                        for (com.tstwatchluxury.domain.Order order : orders) {
                                            if (order.getOrderDate() != null) {
                                                java.time.LocalDateTime oDate = order.getOrderDate();
                                                if (oDate.getYear() == todayYear && oDate.getMonthValue() == todayMonth && oDate.getDayOfMonth() == todayDay) {
                                                    todayRevenue += order.getTotalPrice();
                                                }
                                                if (oDate.getYear() == todayYear && oDate.getMonthValue() == todayMonth) {
                                                    monthRevenue += order.getTotalPrice();
                                                }
                                            }
                                            if (order.getStatus() != null && (order.getStatus().equalsIgnoreCase("PENDING") || order.getStatus().equalsIgnoreCase("Chờ xử lý"))) {
                                                pendingOrdersCount++;
                                            }
                                        }
                                    }
                                    pageContext.setAttribute("todayRevenue", todayRevenue);
                                    pageContext.setAttribute("monthRevenue", monthRevenue);
                                    pageContext.setAttribute("pendingOrdersCount", pendingOrdersCount);
                                    pageContext.setAttribute("totalOrdersCount", orders != null ? orders.size() : 0);
                                %>

                                <!-- KPI Cards Section -->
                                <div class="row">
                                    <!-- Card 1: Today's Revenue -->
                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card kpi-card h-100" style="--card-accent-color: #10b981; --card-accent-light: rgba(16, 185, 129, 0.08);">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div>
                                                        <div class="kpi-title">Doanh thu hôm nay</div>
                                                        <div class="kpi-value">
                                                            <fmt:formatNumber type="number" value="${todayRevenue}" /> đ
                                                        </div>
                                                    </div>
                                                    <div class="kpi-icon-container">
                                                        <i class="fas fa-coins"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Card 2: This Month's Revenue -->
                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card kpi-card h-100" style="--card-accent-color: #4f46e5; --card-accent-light: rgba(79, 70, 229, 0.08);">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div>
                                                        <div class="kpi-title">Doanh thu tháng này</div>
                                                        <div class="kpi-value">
                                                            <fmt:formatNumber type="number" value="${monthRevenue}" /> đ
                                                        </div>
                                                    </div>
                                                    <div class="kpi-icon-container">
                                                        <i class="fas fa-wallet"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Card 3: Total Orders -->
                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card kpi-card h-100" style="--card-accent-color: #06b6d4; --card-accent-light: rgba(6, 182, 212, 0.08);">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div>
                                                        <div class="kpi-title">Tổng số đơn hàng</div>
                                                        <div class="kpi-value">${totalOrdersCount}</div>
                                                    </div>
                                                    <div class="kpi-icon-container">
                                                        <i class="fas fa-shopping-cart"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Card 4: Pending Orders -->
                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card kpi-card h-100" style="--card-accent-color: #f59e0b; --card-accent-light: rgba(245, 158, 11, 0.08);">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center justify-content-between">
                                                    <div>
                                                        <div class="kpi-title">Đơn chờ xử lý</div>
                                                        <div class="kpi-value">${pendingOrdersCount}</div>
                                                    </div>
                                                    <div class="kpi-icon-container">
                                                        <i class="fas fa-clock"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Row 2: Daily Revenue (Line Area Chart) - Big Hero Chart -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card chart-card mb-4">
                                            <div class="chart-card-header">
                                                <span><i class="fas fa-chart-line me-2 text-primary"></i>Doanh Thu Theo Ngày</span>
                                                <span class="badge bg-light text-muted font-monospace" style="font-size: 11px;">Cập nhật tự động</span>
                                            </div>
                                            <div class="chart-card-body" style="height: 350px; position: relative;">
                                                <canvas id="myDailyChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Row 3: Monthly Revenue & Brand Revenue Side-by-Side -->
                                <div class="row">
                                    <!-- Monthly Revenue Bar Chart -->
                                    <div class="col-xl-6">
                                        <div class="card chart-card mb-4">
                                            <div class="chart-card-header">
                                                <span><i class="fas fa-chart-bar me-2 text-cyan"></i>Doanh Thu Theo Tháng</span>
                                            </div>
                                            <div class="chart-card-body" style="height: 320px; position: relative;">
                                                <canvas id="myAreaChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Brand Revenue Doughnut Chart -->
                                    <div class="col-xl-6">
                                        <div class="card chart-card mb-4">
                                            <div class="chart-card-header">
                                                <span><i class="fas fa-chart-pie me-2 text-indigo"></i>Doanh Thu Theo Hãng</span>
                                            </div>
                                            <div class="chart-card-body" style="height: 320px; position: relative;">
                                                <canvas id="myBarChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function() {
                                        // Helper: format money
                                        const formatVND = (value) => {
                                            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                                        };

                                        // Common Options for scales
                                        const getCommonOptions = (datasetLabel) => ({
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            plugins: {
                                                legend: {
                                                    display: false
                                                },
                                                tooltip: {
                                                    backgroundColor: 'rgba(255, 255, 255, 0.95)',
                                                    borderColor: 'rgba(212, 175, 55, 0.25)',
                                                    borderWidth: 1,
                                                    titleFont: { family: 'Inter', size: 13, weight: 'bold' },
                                                    titleColor: '#b8941e',
                                                    bodyFont: { family: 'Inter', size: 12 },
                                                    bodyColor: '#1e293b',
                                                    padding: 12,
                                                    cornerRadius: 8,
                                                    callbacks: {
                                                        label: function(context) {
                                                            let label = datasetLabel || context.dataset.label || '';
                                                            if (label) {
                                                                label += ': ';
                                                            }
                                                            if (context.parsed.y !== null) {
                                                                label += formatVND(context.parsed.y);
                                                            }
                                                            return label;
                                                        }
                                                    }
                                                }
                                            },
                                            scales: {
                                                x: {
                                                    grid: {
                                                        display: false
                                                    },
                                                    ticks: {
                                                        font: { family: 'Inter', size: 11 },
                                                        color: '#64748b'
                                                    }
                                                },
                                                y: {
                                                    grid: {
                                                        color: 'rgba(0, 0, 0, 0.05)',
                                                        borderDash: [5, 5]
                                                    },
                                                    ticks: {
                                                        font: { family: 'Inter', size: 11 },
                                                        color: '#64748b',
                                                        callback: function(value) {
                                                            if (value >= 1000000) return (value / 1000000).toFixed(1) + 'Mđ';
                                                            if (value >= 1000) return (value / 1000).toFixed(0) + 'Kđ';
                                                            return value + 'đ';
                                                        }
                                                    }
                                                }
                                            }
                                        });

                                        // 1. Daily Revenue Chart (Line Chart with Gradient)
                                        fetch('/revenue-by-day')
                                            .then(response => response.json())
                                            .then(data => {
                                                const ctx = document.getElementById('myDailyChart').getContext('2d');
                                                
                                                // Create linear gradient
                                                const gradient = ctx.createLinearGradient(0, 0, 0, 300);
                                                gradient.addColorStop(0, 'rgba(212, 175, 55, 0.25)');
                                                gradient.addColorStop(1, 'rgba(212, 175, 55, 0.00)');
                                                
                                                new Chart(ctx, {
                                                    type: 'line',
                                                    data: {
                                                        labels: data.labels,
                                                        datasets: [{
                                                            label: 'Doanh thu',
                                                            data: data.value,
                                                            borderColor: '#d4af37',
                                                            borderWidth: 3,
                                                            pointBackgroundColor: '#d4af37',
                                                            pointBorderColor: '#ffffff',
                                                            pointBorderWidth: 2,
                                                            pointRadius: 4,
                                                            pointHoverRadius: 7,
                                                            pointHoverBackgroundColor: '#d4af37',
                                                            pointHoverBorderColor: '#ffffff',
                                                            pointHoverBorderWidth: 2,
                                                            fill: true,
                                                            backgroundColor: gradient,
                                                            tension: 0.35
                                                        }]
                                                    },
                                                    options: getCommonOptions('Doanh thu ngày')
                                                });
                                            });

                                        // 2. Monthly Revenue Chart (Bar Chart with Rounded Bars)
                                        fetch('/revenue-data')
                                            .then(response => response.json())
                                            .then(data => {
                                                const ctx = document.getElementById('myAreaChart').getContext('2d');
                                                
                                                const gradient = ctx.createLinearGradient(0, 0, 0, 250);
                                                gradient.addColorStop(0, '#d4af37');
                                                gradient.addColorStop(1, '#b8941e');
                                                
                                                new Chart(ctx, {
                                                    type: 'bar',
                                                    data: {
                                                        labels: data.labels,
                                                        datasets: [{
                                                            label: 'Doanh thu',
                                                            data: data.value,
                                                            backgroundColor: gradient,
                                                            borderRadius: 6,
                                                            borderSkipped: false
                                                        }]
                                                    },
                                                    options: getCommonOptions('Doanh thu tháng')
                                                });
                                            });

                                        // 3. Brand Revenue Chart (Doughnut Chart)
                                        fetch('/revenue-by-factory')
                                            .then(response => response.json())
                                            .then(data => {
                                                const ctx = document.getElementById('myBarChart').getContext('2d');
                                                
                                                const palette = [
                                                    '#d4af37', // Gold
                                                    '#4ade80', // Emerald
                                                    '#fbbf24', // Amber
                                                    '#f87171', // Red
                                                    '#60a5fa', // Blue
                                                    '#a78bfa', // Purple
                                                    '#f472b6', // Pink
                                                    '#94a3b8'  // Slate
                                                ];
                                                
                                                new Chart(ctx, {
                                                    type: 'doughnut',
                                                    data: {
                                                        labels: data.labels,
                                                        datasets: [{
                                                            data: data.value,
                                                            backgroundColor: palette.slice(0, data.labels.length),
                                                            borderWidth: 2,
                                                            borderColor: '#ffffff'
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        maintainAspectRatio: false,
                                                        plugins: {
                                                            legend: {
                                                                display: true,
                                                                position: 'right',
                                                                labels: {
                                                                    font: { family: 'Inter', size: 12, weight: '500' },
                                                                    color: '#64748b',
                                                                    padding: 12,
                                                                    usePointStyle: true,
                                                                    pointStyle: 'circle'
                                                                }
                                                            },
                                                            tooltip: {
                                                                backgroundColor: 'rgba(255, 255, 255, 0.95)',
                                                                borderColor: 'rgba(212, 175, 55, 0.25)',
                                                                borderWidth: 1,
                                                                titleColor: '#b8941e',
                                                                bodyColor: '#1e293b',
                                                                titleFont: { family: 'Inter', size: 13, weight: 'bold' },
                                                                bodyFont: { family: 'Inter', size: 12 },
                                                                padding: 12,
                                                                cornerRadius: 8,
                                                                callbacks: {
                                                                    label: function(context) {
                                                                        let label = context.label || '';
                                                                        if (label) {
                                                                            label += ': ';
                                                                        }
                                                                        if (context.raw !== null) {
                                                                            label += formatVND(context.raw);
                                                                        }
                                                                        return label;
                                                                    }
                                                                }
                                                            }
                                                        },
                                                        cutout: '70%',
                                                        hoverOffset: 8
                                                    }
                                                });
                                            });
                                    });
                                </script>
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
                                                              <c:set var="statusTrim" value="${order.status.trim()}" />
                                                              <c:choose>
                                                                  <c:when test="${statusTrim == 'PENDING' || statusTrim == 'Đang xử lý'}">
                                                                      <span class="status-badge status-pending">Đang xử lý</span>
                                                                  </c:when>
                                                                  <c:when test="${statusTrim == 'SHIPPING' || statusTrim == 'Đang giao hàng'}">
                                                                      <span class="status-badge status-shipped">Đang giao hàng</span>
                                                                  </c:when>
                                                                  <c:when test="${statusTrim == 'DELIVERED' || statusTrim == 'Hoàn tất'}">
                                                                      <span class="status-badge status-completed">Hoàn tất</span>
                                                                  </c:when>
                                                                  <c:when test="${statusTrim == 'CANCELLED' || statusTrim == 'Đã hủy'}">
                                                                      <span class="status-badge status-cancelled">Đã hủy</span>
                                                                  </c:when>
                                                                  <c:otherwise>
                                                                      <span class="status-badge">${order.status}</span>
                                                                  </c:otherwise>
                                                              </c:choose>
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
