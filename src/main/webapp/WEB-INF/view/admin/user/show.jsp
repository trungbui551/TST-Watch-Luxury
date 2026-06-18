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
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
                    crossorigin="anonymous">
                <link href="/css/sb-admin.css?v=5.0" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <h1>Manager User</h1>


                        <div class="container mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Table Users</h3>
                                        <a href="/admin/user/create" class="btn btn-primary">Create an User</a>
                                    </div>
                                    <hr />
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Full Name</th>
                                                <th scope="col">Role</th>
                                                <th scope="col" style="width: 250px;">Actions</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users1}">
                                                <tr>
                                                    <td>${user.id}</td>
                                                    <td>${user.email}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.role.name}</td>
                                                    <td class="text-nowrap">
                                                        <a href="/admin/user/${user.id}"
                                                            class="btn btn-success">View</a>
                                                         <a href="/admin/user/update/${user.id}"
                                                             class="btn btn-warning mx-2">Update</a>
                                                         <button type="button" class="btn btn-danger btn-delete-user" data-id="${user.id}" data-email="${user.email}" data-bs-toggle="modal" data-bs-target="#deleteUserModal">Delete</button>
                                                     </td>
                                                 </tr>
                                             </c:forEach>
                                         </tbody>
                                     </table>
                                 </div>
                             </div>

                         </div>
                         
                         <!-- Modal xác nhận xóa User -->
                         <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
                             <div class="modal-dialog modal-dialog-centered">
                                 <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
                                     <div class="modal-header bg-danger text-white" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                         <h5 class="modal-title" id="deleteUserModalLabel"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa người dùng</h5>
                                         <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                     </div>
                                     <div class="modal-body p-4">
                                         <p class="mb-3">Bạn có chắc chắn muốn xóa tài khoản người dùng này không?</p>
                                         <div class="p-3 bg-light rounded border mb-3">
                                             <strong>ID:</strong> <span id="modalUserId"></span><br/>
                                             <strong>Email:</strong> <span id="modalUserEmail"></span>
                                         </div>
                                         <p class="text-danger mb-0 small"><i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn tác!</p>
                                     </div>
                                     <div class="modal-footer" style="background-color: #f8fafc; border-bottom-left-radius: 12px; border-bottom-right-radius: 12px; border-top: 1px solid rgba(0,0,0,0.06);">
                                         <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="background: #e2e8f0; color: #475569;">Hủy bỏ</button>
                                         <form id="deleteUserForm" action="/admin/user/delete" method="post" style="margin: 0;">
                                             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                             <input type="hidden" name="id" id="deleteUserIdInput" />
                                             <button type="submit" class="btn btn-danger" style="background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);">Xác nhận xóa</button>
                                         </form>
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
                 <script>
                     document.addEventListener("DOMContentLoaded", function () {
                         const deleteButtons = document.querySelectorAll(".btn-delete-user");
                         deleteButtons.forEach(button => {
                             button.addEventListener("click", function () {
                                 const userId = this.getAttribute("data-id");
                                 const userEmail = this.getAttribute("data-email");
                                 
                                 document.getElementById("modalUserId").textContent = userId;
                                 document.getElementById("modalUserEmail").textContent = userEmail;
                                 document.getElementById("deleteUserIdInput").value = userId;
                             });
                         });
                     });
                 </script>

             </body>

            </html>
