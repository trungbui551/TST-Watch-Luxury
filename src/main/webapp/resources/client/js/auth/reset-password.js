function passwordChecking() {
    var password = document.getElementById("password").value;
    var passwordafter = document.getElementById("repeatpassword").value;
    var errorDiv = document.getElementById("msg");
    if (errorDiv) {
        if (password !== passwordafter) {
            errorDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i>Mật khẩu không khớp!';
            errorDiv.classList.remove("d-none");
            return false;
        } else {
            errorDiv.innerHTML = "";
            errorDiv.classList.add("d-none");
            return true;
        }
    }
    return true;
}
