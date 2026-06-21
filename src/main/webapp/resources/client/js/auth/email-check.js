// ============================================================
// COUNTDOWN TIMER — đọc expiryEpoch từ server (thông qua AppConfig)
// ============================================================
(function () {
    var config = window.AppConfig || {};
    var expiryEpoch = parseInt(config.tokenExpiryEpoch, 10);
    if (isNaN(expiryEpoch) || expiryEpoch <= 0) {
        expiryEpoch = Date.now() + 24 * 60 * 60 * 1000;
    }

    var cdHours   = document.getElementById('cdHours');
    var cdMinutes = document.getElementById('cdMinutes');
    var cdSeconds = document.getElementById('cdSeconds');
    var cdDigits  = document.getElementById('countdownDigits');
    var cdExpired = document.getElementById('countdownExpired');

    if (!cdHours || !cdMinutes || !cdSeconds || !cdDigits || !cdExpired) {
        return; // Page doesn't have countdown elements
    }

    function pad(n) {
        return n < 10 ? '0' + n : '' + n;
    }

    function applyStateClass(el, totalSecs) {
        el.classList.remove('warning', 'danger');
        if (totalSecs <= 300) {          // ≤ 5 phút → danger
            el.classList.add('danger');
        } else if (totalSecs <= 1800) {  // ≤ 30 phút → warning
            el.classList.add('warning');
        }
    }

    function tick() {
        var now       = Date.now();
        var remaining = Math.max(0, Math.floor((expiryEpoch - now) / 1000));

        if (remaining <= 0) {
            cdHours.textContent   = '00';
            cdMinutes.textContent = '00';
            cdSeconds.textContent = '00';
            cdDigits.style.display  = 'none';
            cdExpired.classList.add('show');
            return; // stop ticking
        }

        var h = Math.floor(remaining / 3600);
        var m = Math.floor((remaining % 3600) / 60);
        var s = remaining % 60;

        cdHours.textContent   = pad(h);
        cdMinutes.textContent = pad(m);
        cdSeconds.textContent = pad(s);

        applyStateClass(cdHours,   remaining);
        applyStateClass(cdMinutes, remaining);
        applyStateClass(cdSeconds, remaining);

        setTimeout(tick, 1000);
    }

    // Bắt đầu đếm ngược ngay khi DOM sẵn sàng
    document.addEventListener('DOMContentLoaded', tick);
})();

// ============================================================
// ENTRANCE STAGGER ANIMATION
// ============================================================
document.addEventListener('DOMContentLoaded', function () {
    var card = document.querySelector('.email-check-card');
    if (!card) return;
    var children = card.querySelectorAll(
        '.email-check-logo, .email-icon-wrap, .status-badge, .gold-divider, ' +
        '.email-check-title, .email-check-desc, .email-info-box, ' +
        '.countdown-block, .email-check-actions, .email-check-footer'
    );

    children.forEach(function (el, i) {
        el.style.opacity = '0';
        el.style.transform = 'translateY(12px)';
        el.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        setTimeout(function () {
            el.style.opacity = '1';
            el.style.transform = 'translateY(0)';
        }, 150 + i * 70);
    });
});
