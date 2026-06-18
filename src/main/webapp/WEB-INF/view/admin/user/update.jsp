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

            <div>
                <c:set var="avatarSrc" value="${not empty newUser.avatar ? newUser.avatar : 'default-avatar.png'}" />
                <h1 class="mt-5"><img class="avatar" src="/images/avatar/${avatarSrc}" /> Update User
                </h1>
            </div>

            <hr />
            <div class="container">
                <div class="row">
                    <form:form class="container mx-auto mt-5" style="max-width: 500px;"
                        action="/admin/user/update" method="post" modelAttribute="newUser"
                        enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label" style="display: none;">Id</label>
                            <form:input type="text" style="display: none;" class="form-control" path="id" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email address</label>
                            <form:input type="email" disabled="true" class="form-control" path="email" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label" style="display:none;">Password</label>
                            <form:input type="password" style="display:none;" class="form-control"
                                path="passWord" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number:</label>
                            <form:input type="text" class="form-control" path="phone" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Full Name:</label>
                            <form:input type="text" class="form-control" path="fullName" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address:</label>
                            <form:input type="text" class="form-control" path="address" />
                        </div>
                        <form:select class="form-select" path="role.name" id="select">
                            <option value="ADMIN">ADMIN</option>
                            <option value="USER">USER</option>
                        </form:select>

                        <div class="mb-3">
                            <label for="avatarFile" class="form-label" class="mb-3 col-12 col-md-6">Upload new Avatar File</label>
                            <input class="form-control" type="file" id="avatarFile"
                                accept=".png, jpg, .jpeg" name="newimg">
                        </div>
                        <div class="mb-3 col-12 col-md-6">
                            <img style="max-height: 250px;display: none;" alt="avatarPreview"
                                id="avatarPreview" />
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form:form>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <script>$("select").val("${newUser.role.name}")</script>
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
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");

            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>
</body>
</html>
