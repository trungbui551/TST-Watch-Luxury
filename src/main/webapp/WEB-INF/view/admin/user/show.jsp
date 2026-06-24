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
                <link href="/css/sb-admin.css?v=6.2" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4 py-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h1 class="h3 mb-0 text-gray-800" style="padding-left: 0 !important; margin: 0 !important;">Quản lý người dùng</h1>
                                        <ol class="breadcrumb mb-0 mt-1">
                                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                            <li class="breadcrumb-item active">Quản lý người dùng</li>
                                        </ol>
                                    </div>
                                </div>

                                <div class="card mb-4">
                                    <div class="card-header d-flex justify-content-between align-items-center" style="background-color: #f8f9fa; border-bottom: 1px solid rgba(212, 175, 55, 0.2); padding: 18px 24px;">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-users me-2 text-gold"></i>
                                            <span class="fw-bold text-gold" style="letter-spacing: 0.03em;">DANH SÁCH NGƯỜI DÙNG</span>
                                        </div>
                                        <a href="/admin/user/create" class="btn btn-primary">
                                            <i class="fas fa-user-plus me-1"></i> Thêm người dùng
                                        </a>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0" style="border: none !important; border-radius: 0 !important; margin-top: 0 !important; box-shadow: none !important;">
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
                                                                     class="btn btn-warning text-white mx-2">Update</a>
                                                                 <button type="button" class="btn btn-danger btn-delete-user" data-id="${user.id}" data-email="${user.email}" data-bs-toggle="modal" data-bs-target="#deleteUserModal">Delete</button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                         
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
                                     <div class="modal-footer">
                                         <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                                         <form id="deleteUserForm" action="/admin/user/delete" method="post" style="margin: 0;">
                                             <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                             <input type="hidden" name="id" id="deleteUserIdInput" />
                                             <button type="submit" class="btn btn-danger">Xác nhận xóa</button>
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
