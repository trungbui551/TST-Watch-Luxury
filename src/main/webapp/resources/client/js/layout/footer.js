window.fbAsyncInit = function () {
    if (typeof FB !== 'undefined') {
        FB.init({ xfbml: true, version: 'v19.0' });
    }
};

(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = 'https://connect.facebook.net/vi_VN/sdk/xfbml.customerchat.js';
    if (fjs && fjs.parentNode) {
        fjs.parentNode.insertBefore(js, fjs);
    }
}(document, 'script', 'facebook-jssdk'));

window.addEventListener('load', function () {
    setTimeout(function () {
        const fbChat = document.querySelector('.fb_dialog');
        const fallback = document.getElementById('messengerFallbackFab');
        if (fbChat && fallback) {
            fallback.style.display = 'none';
        }
    }, 3500);
});
