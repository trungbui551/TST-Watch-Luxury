$(document).ready(() => {
    $("#avatarFile").change(function(e) {
        if (e.target.files && e.target.files[0]) {
            const imgURL = URL.createObjectURL(e.target.files[0]);
            $("#avatarPreview").attr("src", imgURL);
        }
    });
});
