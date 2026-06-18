<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
                            Manager User
                        </main>
                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Detail </h3>
                                        <a href="/admin/user/create" class="btn btn-primary">Create an User</a>
                                    </div>

                                    <hr />
                                    <div class="card" style="width: 60%">
                                        <div class="card-header">
                                            <c:set var="avatarSrc" value="${not empty iuser.avatar ? iuser.avatar : 'default-avatar.png'}" />
                                            <img class="avatar" src="/images/avatar/${avatarSrc}" /> User Information
                                            <a class="btn btn-success" href="/images/avatar/${avatarSrc}">Show
                                                Avatar</a>
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">ID = ${id} </li>
                                            <li class="list-group-item">FullName: ${iuser.fullName}</li>
                                            <li class="list-group-item">Address: ${iuser.address}</li>
                                            <li class="list-group-item">Phone Number: ${iuser.phone}</li>
                                            <div class="list-group-item">Role: ${iuser.role.name}



                                            </div>
                                        </ul>

                                    </div>
                                </div>
                            </div>

                        </div>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                    crossorigin="anonymous"></script>

            </body>

            </html>
