// Hide spinner
window.addEventListener('load', function () {
    var spinner = document.getElementById('spinner');
    if (spinner) {
        spinner.classList.add('hidden');
        setTimeout(function() { spinner.style.display = 'none'; }, 350);
    }
});

// Quantity control
var qtyInput = document.getElementById('qtyInput');
if (qtyInput) {
    var qtyPlus = document.getElementById('qtyPlus');
    var qtyMinus = document.getElementById('qtyMinus');
    if (qtyPlus) {
        qtyPlus.addEventListener('click', function () {
            qtyInput.value = parseInt(qtyInput.value || 1, 10) + 1;
        });
    }
    if (qtyMinus) {
        qtyMinus.addEventListener('click', function () {
            var val = parseInt(qtyInput.value || 1, 10);
            if (val > 1) qtyInput.value = val - 1;
        });
    }
}

// Image zoom at mouse hover
const zoomContainer = document.getElementById('watchZoomContainer');
const zoomImage = document.getElementById('watchZoomImage');
if (zoomContainer && zoomImage) {
    zoomContainer.addEventListener('mousemove', function(e) {
        const rect = zoomContainer.getBoundingClientRect();
        const x = ((e.clientX - rect.left) / rect.width) * 100;
        const y = ((e.clientY - rect.top) / rect.height) * 100;
        
        zoomImage.style.transformOrigin = `${x}% ${y}%`;
        zoomImage.style.transform = 'scale(1.8)';
    });
    
    zoomContainer.addEventListener('mouseleave', function() {
        zoomImage.style.transform = 'scale(1)';
        zoomImage.style.transformOrigin = 'center center';
    });
}

// Product Gallery controls
(function() {
    const mainImg = document.getElementById('watchZoomImage');
    const thumbs = document.querySelectorAll('.gallery-thumb-item');
    const btnPrev = document.getElementById('prevProductImg');
    const btnNext = document.getElementById('nextProductImg');
    
    if (!mainImg || thumbs.length === 0) return;
    
    let currentIndex = 0;
    
    function showImage(index) {
        if (index < 0) index = thumbs.length - 1;
        if (index >= thumbs.length) index = 0;
        
        currentIndex = index;
        
        // Active class
        thumbs.forEach((thumb, idx) => {
            if (idx === currentIndex) {
                thumb.classList.add('active');
            } else {
                thumb.classList.remove('active');
            }
        });
        
        // Change src with transition
        mainImg.style.opacity = '0';
        setTimeout(() => {
            mainImg.src = thumbs[currentIndex].getAttribute('data-img');
            mainImg.style.opacity = '1';
        }, 150);
    }
    
    // Add click listeners to thumbs
    thumbs.forEach((thumb, idx) => {
        thumb.addEventListener('click', () => {
            showImage(idx);
        });
    });
    
    // Add click listeners to nav buttons
    if (btnPrev) {
        btnPrev.addEventListener('click', (e) => {
            e.stopPropagation(); // Avoid triggering zoom
            showImage(currentIndex - 1);
        });
    }
    if (btnNext) {
        btnNext.addEventListener('click', (e) => {
            e.stopPropagation(); // Avoid triggering zoom
            showImage(currentIndex + 1);
        });
    }
})();

// Related Products Carousel with Auto Play & Dynamic Pagination (Vanilla JS)
(function() {
    const track = document.querySelector('.related-carousel-track');
    const items = document.querySelectorAll('.related-carousel-item');
    const pagination = document.getElementById('carouselPagination');
    const wrapper = document.querySelector('.related-carousel-wrapper');
    
    if (!track || items.length === 0 || !pagination || !wrapper) return;
    
    const totalItems = items.length;
    let itemsPerPage = getItemsPerPage();
    let totalPages = Math.ceil(totalItems / itemsPerPage);
    let currentPage = 1;
    let autoPlayInterval;
    
    function getItemsPerPage() {
        const width = window.innerWidth;
        if (width > 1024) return 4;
        if (width > 768) return 3;
        if (width > 480) return 2;
        return 1;
    }
    
    function renderPagination() {
        pagination.innerHTML = '';
        if (totalPages <= 1) return;
        
        for (let i = 1; i <= totalPages; i++) {
            const li = document.createElement('li');
            li.className = 'premium-page-item' + (i === currentPage ? ' active' : '');
            
            const a = document.createElement('a');
            a.className = 'premium-page-link';
            a.href = '#';
            a.textContent = i;
            a.setAttribute('data-page', i);
            
            a.addEventListener('click', function(e) {
                e.preventDefault();
                const page = parseInt(this.getAttribute('data-page'), 10);
                moveToPage(page);
                startAutoPlay();
            });
            
            li.appendChild(a);
            pagination.appendChild(li);
        }
    }
    
    function moveToPage(page) {
        if (page < 1) page = totalPages;
        if (page > totalPages) page = 1;
        
        currentPage = page;
        
        const itemWidth = items[0].getBoundingClientRect().width;
        const offset = -(currentPage - 1) * itemWidth * itemsPerPage;
        
        // Giới hạn offset để tránh khoảng trắng ở trang cuối
        const maxOffset = -(track.scrollWidth - wrapper.getBoundingClientRect().width);
        const finalOffset = Math.max(offset, maxOffset);
        
        track.style.transform = 'translateX(' + finalOffset + 'px)';
        
        // Cập nhật class active
        const pageItems = pagination.querySelectorAll('.premium-page-item');
        pageItems.forEach((item, idx) => {
            if (idx === (currentPage - 1)) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });
    }
    
    function startAutoPlay() {
        stopAutoPlay();
        autoPlayInterval = setInterval(function() {
            moveToPage(currentPage + 1);
        }, 4000); // Tự động trượt sang phải mỗi 4 giây
    }
    
    function stopAutoPlay() {
        if (autoPlayInterval) {
            clearInterval(autoPlayInterval);
        }
    }
    
    // Khởi tạo
    renderPagination();
    moveToPage(1);
    startAutoPlay();
    
    // Dừng autoplay khi di chuột vào carousel
    wrapper.addEventListener('mouseenter', stopAutoPlay);
    wrapper.addEventListener('mouseleave', startAutoPlay);
    
    // Xử lý khi resize window
    window.addEventListener('resize', function() {
        const newItemsPerPage = getItemsPerPage();
        if (newItemsPerPage !== itemsPerPage) {
            itemsPerPage = newItemsPerPage;
            totalPages = Math.ceil(totalItems / itemsPerPage);
            if (currentPage > totalPages) currentPage = totalPages;
            renderPagination();
            moveToPage(currentPage);
        }
    });
})();
