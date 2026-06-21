// ============================================================
// ENTRANCE STAGGER ANIMATION
// ============================================================
document.addEventListener('DOMContentLoaded', function () {
    var card = document.querySelector('.bad-user-card');
    if (!card) return;
    var children = card.querySelectorAll(
        '.bad-user-logo, .error-icon-wrap, .status-badge-error, .bad-user-title, ' +
        '.bad-user-desc, .error-msg-box, .bad-user-actions, .bad-user-footer'
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
