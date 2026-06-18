# Spring Boot MVC Shop Architecture & Learnings

> Tổng hợp kiến thức kiến trúc, quy chuẩn mã nguồn, và giải pháp kỹ thuật nâng cao trong dự án Spring Boot MVC Web Shop.
> Cập nhật lần cuối: 2026-05-26

---

## Architecture

### 1. Kiến trúc 3 lớp tiêu chuẩn & JSP View Engine
- **Chi tiết**: Dự án sử dụng mô hình Spring MVC truyền thống kết hợp JSP View Engine. Sự phân tách rõ ràng giữa:
  - **Controller**: Điều hướng yêu cầu, nạp dữ liệu vào Model (ví dụ: `HomePageController.java`).
  - **Service**: Xử lý nghiệp vụ chính, tính toán và phân trang (ví dụ: `ProductService.java`).
  - **Repository**: Thực thi các thao tác cơ sở dữ liệu dùng Spring Data JPA (ví dụ: `ProductRepository.java`).
- **Files liên quan**: [HomePageController.java](file:///d:/Phat-Trien-Web-Shop/src/main/java/com/taplamweb/controller/client/HomePageController.java), [ProductService.java](file:///d:/Phat-Trien-Web-Shop/src/main/java/com/taplamweb/service/ProductService.java)

### 2. Cấu hình bảo mật CSRF & Phân loại yêu cầu
- **Chi tiết**: Spring Security được thiết lập để tự động kiểm soát tấn công CSRF.
  - Các yêu cầu an toàn (`GET` - đọc dữ liệu) được Spring Security tự động bỏ qua để tăng hiệu suất.
  - Các yêu cầu thay đổi dữ liệu (`POST` - thêm giỏ hàng, thanh toán) bắt buộc đính kèm CSRF Token.
  - Cấu hình bỏ qua CSRF (`ignoringRequestMatchers`) chuyên biệt cho các cổng kết nối WebSocket `/ws/**` và `/chat/**` để tránh lỗi bắt tay HTTP 403 Forbidden do đặc thù kết nối liên tục của WebSocket.
- **Files liên quan**: [SecurityConfiguration.java](file:///d:/Phat-Trien-Web-Shop/src/main/java/com/taplamweb/config/SecurityConfiguration.java)

---

## Bugs & Solutions

### 1. Lỗi cú pháp JavaScript khi tiêm biến JSP trực tiếp
- **Vấn đề**: Việc in trực tiếp thuộc tính sản phẩm từ JSP vào biến JavaScript bằng dấu nháy đơn, nháy kép hoặc dấu backtick (``` ` ```) gây lỗi `SyntaxError` hoặc `ReferenceError` khi dữ liệu thật trong database chứa ký tự xuống dòng (`\n`), nháy kép (`"`), hoặc cấu trúc trùng với cú pháp ES6 `${...}`. Lưới sản phẩm hoàn toàn biến mất.
- **Root cause**: Trình duyệt biên dịch các ký tự thô này trực tiếp như mã JavaScript thực thi thay vì hiểu là chuỗi thuần túy.
- **Fix**: Sử dụng giải pháp **DOM Data Attributes**: In dữ liệu sản phẩm vào các phần tử HTML ẩn (`<div class="hidden-product-item">`) dùng thẻ `<c:out>` của JSTL để mã hóa HTML an toàn. JavaScript đọc dữ liệu thông qua `.getAttribute()`. Trình duyệt tự động giải mã các ký tự này khi lấy thuộc tính, loại bỏ 100% lỗi cú pháp và nguy cơ XSS.
- **Files liên quan**: [show.jsp](file:///D:/Phat-Trien-Web-Shop/src/main/webapp/WEB-INF/view/client/homepage/show.jsp)

### 2. Lỗi chớp tắt sản phẩm do tái tạo DOM làm mất Observer
- **Vấn đề**: Sản phẩm xuất hiện trong tích tắc rồi biến mất vĩnh viễn với trạng thái ẩn (`opacity: 0`).
- **Root cause**: Gán HTML lưới sản phẩm trước, rồi cộng dồn HTML Phân trang sau (`container.innerHTML += ...`) làm trình duyệt phá hủy và tái tạo lại toàn bộ DOM Nodes của Card sản phẩm, làm mất các IntersectionObserver đã đăng ký trước đó. Các Card mới tái tạo bị giữ nguyên thuộc tính ẩn `opacity: 0` do không được observer quét qua.
- **Fix**: Ghép Grid HTML và Pagination HTML thành một chuỗi duy nhất, gán vào DOM đúng một lần duy nhất (`container.innerHTML = htmlContent;`), sau đó mới kích hoạt hiệu ứng hoạt cảnh (`applyCardAnimation()`) và liên kết sự kiện.
- **Files liên quan**: [show.jsp](file:///D:/Phat-Trien-Web-Shop/src/main/webapp/WEB-INF/view/client/homepage/show.jsp)

---

## How-To

### 1. Đồng bộ hóa bộ lọc Tìm kiếm nhanh ở Frontend với thanh Search ở Header
- **Bước thực hiện**:
  1. Header/Banner gửi yêu cầu `GET` chứa tham số `?keyword=...` lên controller.
  2. Controller chuyển giá trị `keyword` vào Model.
  3. Ở JS Frontend của JSP, kiểm tra và nạp giá trị từ Model vào ô input lọc nhanh:
     ```javascript
     var headerKeyword = "${keyword}";
     if (headerKeyword && headerKeyword !== 'null' && headerKeyword !== '') {
         searchFilterInput.value = headerKeyword;
     }
     ```
  4. Gọi hàm `applyFilters()` lần đầu để tự động kích hoạt lọc kết quả.
- **Files liên quan**: [show.jsp](file:///D:/Phat-Trien-Web-Shop/src/main/webapp/WEB-INF/view/client/homepage/show.jsp), [banner.jsp](file:///d:/Phat-Trien-Web-Shop/src/main/webapp/WEB-INF/view/client/layout/banner.jsp)

---

## Patterns

### 1. CSS Variables & Design System Tokenization
- **Chi tiết**: Sử dụng CSS Custom Properties đặt ở `:root` để thiết lập một hệ thống thiết kế (Design System) đồng nhất gồm màu sắc HSL, bóng đổ (`box-shadow`), góc bo (`border-radius`) và khoảng cách (`spacing`). Đảm bảo giao diện hiện đại, dễ bảo trì và dễ tích hợp Dark Mode.
- **Files liên quan**: [premium-base.css](file:///D:/Phat-Trien-Web-Shop/src/main/webapp/resources/css/premium-base.css)

### 2. Client-Side Dynamic Pill Filters
- **Chi tiết**: Thay vì hardcode các thẻ nút lọc (Asus, Dell, HP,...), viết mã JS tự động thu thập các giá trị hãng (`factory`) và nhu cầu (`target`) duy nhất (unique) từ tập dữ liệu sản phẩm để vẽ các Pill động, giúp bộ lọc tự động điều chỉnh theo dữ liệu thực tế của cửa hàng.
- **Files liên quan**: [show.jsp](file:///D:/Phat-Trien-Web-Shop/src/main/webapp/WEB-INF/view/client/homepage/show.jsp)
