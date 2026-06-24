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

// Global Add to Cart Modal Interceptor & Controller
function initGlobalCartModal() {
    const modalEl = document.getElementById('globalAddCartModal');
    if (!modalEl) return;

    const modalForm = document.getElementById('modalAddToCartForm');
    const modalTitle = document.getElementById('modalProductTitle');
    const modalPrice = document.getElementById('modalProductPrice');
    const modalImg = document.getElementById('modalProductImg');
    const modalSizeInput = document.getElementById('modalSelectedSize');
    const modalColorInput = document.getElementById('modalSelectedColor');
    const modalSizeError = document.getElementById('modalSizeError');
    const modalSizeSelector = document.getElementById('modalSizeSelector');
    const modalQtyInput = document.getElementById('modalQtyInput');
    const modalQtyPlus = document.getElementById('modalQtyPlus');
    const modalQtyMinus = document.getElementById('modalQtyMinus');

    // Bootstrap Modal Instance
    let bsModalInstance = null;

    // Intercept form submissions
    document.addEventListener('submit', function (e) {
        const form = e.target;
        const actionUrl = form.getAttribute('action') || '';

        // Intercept any add-to-cart form except the one inside the modal itself
        if (form.method.toLowerCase() === 'post' && actionUrl.indexOf('/add-product-to-cart/') !== -1) {
            if (form.id === 'modalAddToCartForm') {
                // If it is from the modal, let it submit.
                // We close the modal after submission (with a tiny delay if AJAX is running)
                setTimeout(() => {
                    if (bsModalInstance) {
                        bsModalInstance.hide();
                    }
                }, 400);
                return;
            }

            // If it is the detail page form, let detail.js handle validation and submission directly
            if (form.id === 'addToCartForm') {
                return;
            }

            // Otherwise, block the default submission and show the pop-up modal!
            e.preventDefault();
            e.stopPropagation();

            // Extract product info
            let title = '';
            let priceHtml = '';
            let imgSrc = '';

            const parentCard = form.closest('.luxury-card-watch');
            if (parentCard) {
                title = parentCard.querySelector('.product-title') ? parentCard.querySelector('.product-title').textContent.trim() : '';
                priceHtml = parentCard.querySelector('.product-price') ? parentCard.querySelector('.product-price').innerHTML.trim() : '';
                imgSrc = parentCard.querySelector('.product-img-hover') ? parentCard.querySelector('.product-img-hover').src : '';
            } else {
                // Check if detail page
                const detailTitleEl = document.querySelector('h1');
                const detailPriceEl = document.getElementById('detailProductPrice');
                const detailImgEl = document.getElementById('watchZoomImage');
                title = detailTitleEl ? detailTitleEl.textContent.trim() : '';
                priceHtml = detailPriceEl ? detailPriceEl.innerHTML.trim() : '';
                imgSrc = detailImgEl ? detailImgEl.src : '';
            }

            // Extract product custom options configurations
            const isUnique = form.getAttribute('data-is-unique') === 'true';
            const sizes = form.getAttribute('data-sizes') || '';
            const dialColors = form.getAttribute('data-dial-colors') || '';
            const strapColors = form.getAttribute('data-strap-colors') || '';
            const mainImage = form.getAttribute('data-image') || '';
            const images = form.getAttribute('data-images') || '';
            const dialColorsImages = form.getAttribute('data-dial-colors-images') || '';

            // Populate Modal values
            if (modalTitle) modalTitle.textContent = title;
            if (modalPrice) modalPrice.innerHTML = priceHtml;
            if (modalImg) modalImg.src = imgSrc;
            if (modalForm) modalForm.setAttribute('action', actionUrl);

            // Reset modal selection states
            if (modalQtyInput) modalQtyInput.value = '1';
            if (modalSizeError) modalSizeError.classList.remove('show');

            const uniqueBadge = document.getElementById('modalUniqueBadge');
            const sizeSection = document.getElementById('modalSizeSection');
            const dialColorSection = document.getElementById('modalDialColorSection');
            const strapColorSection = document.getElementById('modalStrapColorSection');

            if (isUnique) {
                if (uniqueBadge) uniqueBadge.classList.remove('d-none');
                if (sizeSection) sizeSection.classList.add('d-none');
                if (dialColorSection) dialColorSection.classList.add('d-none');
                if (strapColorSection) strapColorSection.classList.add('d-none');

                if (modalSizeInput) modalSizeInput.value = 'Độc bản';
                if (modalColorInput) modalColorInput.value = 'Độc bản';
            } else {
                if (uniqueBadge) uniqueBadge.classList.add('d-none');
                if (sizeSection) sizeSection.classList.remove('d-none');
                if (dialColorSection) dialColorSection.classList.remove('d-none');
                if (strapColorSection) strapColorSection.classList.remove('d-none');

                // Parse image configurations
                const imagesList = [mainImage];
                if (images) {
                    imagesList.push(...images.split(','));
                }
                let dialColorsImagesList = [];
                if (dialColorsImages) {
                    dialColorsImagesList = dialColorsImages.split(',').map(img => img.trim()).filter(Boolean);
                }

                // 1. Render sizes
                const sizeSelector = document.getElementById('modalSizeSelector');
                if (sizeSelector) {
                    sizeSelector.innerHTML = '';
                    const sizeList = sizes.split(',').map(s => s.trim()).filter(Boolean);
                    sizeList.forEach(sz => {
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'btn-size-pill';
                        btn.setAttribute('data-size', sz);
                        btn.textContent = sz;
                        sizeSelector.appendChild(btn);
                    });
                }

                // 2. Render dial colors
                const dialColorSelector = document.getElementById('modalDialColorSelector');
                const dialColorDisplay = document.getElementById('modalDialColorDisplay');
                const dialColorList = dialColors.split(',').map(c => c.trim()).filter(Boolean);
                if (dialColorSelector) {
                    dialColorSelector.innerHTML = '';
                    dialColorList.forEach((col, idx) => {
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'btn-color-swatch' + (idx === 0 ? ' active' : '');
                        btn.setAttribute('data-color', col);
                        btn.setAttribute('data-index', idx);
                        btn.title = col;

                        const colLower = col.toLowerCase();
                        let bg = '#d4af37';
                        if (colLower === 'silver' || colLower === 'bạc' || colLower === 'thép') bg = '#e5e7eb';
                        else if (colLower === 'rose gold' || colLower === 'vàng hồng') bg = '#b76e79';
                        else if (colLower === 'black' || colLower === 'đen') bg = '#111827';
                        else if (colLower === 'blue' || colLower === 'xanh dương' || colLower === 'xanh lam') bg = '#1e3a8a';
                        else if (colLower === 'white' || colLower === 'trắng') bg = '#ffffff';
                        else if (colLower === 'pink' || colLower === 'hồng') bg = '#fbcfe8';
                        else if (colLower === 'green' || colLower === 'xanh lá' || colLower === 'xanh lục') bg = '#0f5132';

                        btn.style.backgroundColor = bg;
                        if (colLower === 'black' || colLower === 'đen') btn.style.border = '1px solid rgba(255,255,255,0.2)';
                        dialColorSelector.appendChild(btn);
                    });
                }

                // 3. Render strap colors
                const strapColorSelector = document.getElementById('modalStrapColorSelector');
                const strapColorDisplay = document.getElementById('modalStrapColorDisplay');
                const strapColorList = strapColors.split(',').map(c => c.trim()).filter(Boolean);
                if (strapColorSelector) {
                    strapColorSelector.innerHTML = '';
                    strapColorList.forEach((str, idx) => {
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'btn-color-swatch' + (idx === 0 ? ' active' : '');
                        btn.setAttribute('data-color', str);
                        btn.title = str;

                        const strLower = str.toLowerCase();
                        let bg = '#d4af37';
                        if (strLower === 'silver' || strLower === 'bạc' || strLower === 'thép') bg = '#e5e7eb';
                        else if (strLower === 'rose gold' || strLower === 'vàng hồng') bg = '#b76e79';
                        else if (strLower === 'black' || strLower === 'đen' || strLower === 'da đen') bg = '#111827';
                        else if (strLower === 'brown' || strLower === 'nâu' || strLower === 'da nâu') bg = '#78350f';
                        else if (strLower === 'white' || strLower === 'trắng') bg = '#ffffff';
                        else if (strLower === 'pink' || strLower === 'hồng') bg = '#fbcfe8';
                        else if (strLower === 'green' || strLower === 'xanh lá' || strLower === 'xanh lục') bg = '#0f5132';

                        btn.style.backgroundColor = bg;
                        if (strLower === 'black' || strLower === 'đen') btn.style.border = '1px solid rgba(255,255,255,0.2)';
                        strapColorSelector.appendChild(btn);
                    });
                }

                // Set default option inputs
                if (modalSizeInput) modalSizeInput.value = '';
                if (modalColorInput && dialColorList.length > 0 && strapColorList.length > 0) {
                    modalColorInput.value = 'Mặt số: ' + dialColorList[0] + ' | Dây: ' + strapColorList[0];
                }
                const modalSelectedDialColor = document.getElementById('modalSelectedDialColor');
                const modalSelectedStrapColor = document.getElementById('modalSelectedStrapColor');
                if (modalSelectedDialColor) modalSelectedDialColor.value = dialColorList[0] || '';
                if (modalSelectedStrapColor) modalSelectedStrapColor.value = strapColorList[0] || '';

                if (dialColorDisplay) dialColorDisplay.textContent = dialColorList[0] || '';
                if (strapColorDisplay) strapColorDisplay.textContent = strapColorList[0] || '';

                // BIND modal interactions dynamically
                const dButtons = modalEl.querySelectorAll('#modalDialColorSelector .btn-color-swatch');
                const sButtons = modalEl.querySelectorAll('#modalStrapColorSelector .btn-color-swatch');
                const szButtons = modalEl.querySelectorAll('#modalSizeSelector .btn-size-pill');

                szButtons.forEach(btn => {
                    btn.addEventListener('click', function () {
                        szButtons.forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        if (modalSizeInput) modalSizeInput.value = btn.getAttribute('data-size');
                        if (modalSizeError) modalSizeError.classList.remove('show');
                    });
                });

                dButtons.forEach(btn => {
                    btn.addEventListener('click', function () {
                        dButtons.forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        const dialVal = btn.getAttribute('data-color');
                        if (dialColorDisplay) dialColorDisplay.textContent = dialVal;
                        if (modalSelectedDialColor) modalSelectedDialColor.value = dialVal;

                        // Change modal image dynamically based on Dial Color click
                        const idx = parseInt(btn.getAttribute('data-index') || 0, 10);
                        let targetImg = mainImage;
                        if (dialColorsImagesList.length > idx && dialColorsImagesList[idx]) {
                            targetImg = dialColorsImagesList[idx];
                        } else if (imagesList[idx]) {
                            targetImg = imagesList[idx];
                        }
                        if (modalImg && targetImg) {
                            modalImg.src = '/images/product/' + targetImg;
                        }

                        // Update combined color value
                        const activeStrapBtn = modalEl.querySelector('#modalStrapColorSelector .btn-color-swatch.active');
                        const strapVal = activeStrapBtn ? activeStrapBtn.getAttribute('data-color') : '';
                        if (modalColorInput) {
                            modalColorInput.value = 'Mặt số: ' + dialVal + ' | Dây: ' + strapVal;
                        }
                    });
                });

                sButtons.forEach(btn => {
                    btn.addEventListener('click', function () {
                        sButtons.forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                        const strapVal = btn.getAttribute('data-color');
                        if (strapColorDisplay) strapColorDisplay.textContent = strapVal;
                        if (modalSelectedStrapColor) modalSelectedStrapColor.value = strapVal;

                        // Update combined color value
                        const activeDialBtn = modalEl.querySelector('#modalDialColorSelector .btn-color-swatch.active');
                        const dialVal = activeDialBtn ? activeDialBtn.getAttribute('data-color') : '';
                        if (modalColorInput) {
                            modalColorInput.value = 'Mặt số: ' + dialVal + ' | Dây: ' + strapVal;
                        }
                    });
                });
            }

            // Show Modal using robust Bootstrap instance retrieval
            if (typeof bootstrap !== 'undefined') {
                bsModalInstance = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
                bsModalInstance.show();
            } else {
                console.error('Bootstrap is not loaded yet');
            }
        }
    });

    // Modal Quantity Controls
    if (modalQtyPlus && modalQtyInput) {
        modalQtyPlus.addEventListener('click', function () {
            modalQtyInput.value = parseInt(modalQtyInput.value || 1, 10) + 1;
        });
    }
    if (modalQtyMinus && modalQtyInput) {
        modalQtyMinus.addEventListener('click', function () {
            const val = parseInt(modalQtyInput.value || 1, 10);
            if (val > 1) modalQtyInput.value = val - 1;
        });
    }

    // Modal Form Validation
    if (modalForm) {
        modalForm.addEventListener('submit', function (e) {
            if (modalSizeInput && !modalSizeInput.value) {
                e.preventDefault();
                e.stopPropagation();
                if (modalSizeError) {
                    modalSizeError.textContent = 'Vui lòng lựa chọn kích thước phù hợp với cổ tay của quý khách!';
                    modalSizeError.classList.add('show');
                }
                if (modalSizeSelector) {
                    modalSizeSelector.classList.add('shake-anim');
                    setTimeout(() => {
                        modalSizeSelector.classList.remove('shake-anim');
                    }, 400);
                }
            }
        });
    }
}

// Safely execute or defer initialization depending on document readyState
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initGlobalCartModal);
} else {
    initGlobalCartModal();
}

// Global dynamic premium toast generator
window.showPremiumToast = function (message) {
    let container = document.getElementById('toastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'toastContainer';
        container.className = 'toast-container-custom';
        document.body.appendChild(container);
    }
    const toast = document.createElement('div');
    toast.className = 'toast-premium toast-anim';
    toast.innerHTML = '<i class="fas fa-check-circle"></i><span>' + message + '</span>';
    container.appendChild(toast);
    
    // Trigger slide-in animation
    setTimeout(() => {
        toast.classList.add('show');
    }, 50);
    
    // Remove toast with transition after 4 seconds
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => {
            toast.remove();
        }, 400);
    }, 4000);
};
