package com.tstwatchluxury.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.tstwatchluxury.domain.Product;
import com.tstwatchluxury.domain.Role;
import com.tstwatchluxury.domain.User;
import com.tstwatchluxury.domain.Order;
import com.tstwatchluxury.domain.OrderDetail;
import com.tstwatchluxury.domain.Cart;
import com.tstwatchluxury.domain.CartDetail;
import com.tstwatchluxury.repository.ProductRepository;
import com.tstwatchluxury.repository.RoleRepository;
import com.tstwatchluxury.repository.UserRepository;
import com.tstwatchluxury.repository.OrderRepository;
import com.tstwatchluxury.repository.OrderDetailRepository;
import com.tstwatchluxury.repository.CartRepository;
import com.tstwatchluxury.repository.CartDetailRepository;

import java.time.LocalDateTime;

@Component
public class DatabaseInitializer implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final PasswordEncoder passwordEncoder;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;

    public DatabaseInitializer(RoleRepository roleRepository,
                               UserRepository userRepository,
                               ProductRepository productRepository,
                               PasswordEncoder passwordEncoder,
                               OrderRepository orderRepository,
                               OrderDetailRepository orderDetailRepository,
                               CartRepository cartRepository,
                               CartDetailRepository cartDetailRepository) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.passwordEncoder = passwordEncoder;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        System.out.println(">>> STARTING DATABASE INITIALIZATION SEEDING...");

        // Auto-correct any products with wrong/legacy factories (e.g. laptop brands like Apple)
        java.util.List<Product> allProducts = this.productRepository.findAll();
        for (Product p : allProducts) {
            String nameLower = p.getName() != null ? p.getName().toLowerCase() : "";
            String shortDescLower = p.getShortDesc() != null ? p.getShortDesc().toLowerCase() : "";
            String detailDescLower = p.getDetailDesc() != null ? p.getDetailDesc().toLowerCase() : "";
            String currentFactory = p.getFactory();
            String correctFactory = null;
            
            // Check text fields for watch brands
            if (nameLower.contains("rolex") || shortDescLower.contains("rolex") || detailDescLower.contains("rolex")) {
                correctFactory = "Rolex";
            } else if (nameLower.contains("hublot") || shortDescLower.contains("hublot") || detailDescLower.contains("hublot")) {
                correctFactory = "Hublot";
            } else if (nameLower.contains("cartier") || shortDescLower.contains("cartier") || detailDescLower.contains("cartier")) {
                correctFactory = "Cartier";
            } else if (nameLower.contains("casio") || shortDescLower.contains("casio") || detailDescLower.contains("casio")) {
                correctFactory = "Casio";
            } else if (nameLower.contains("tissot") || shortDescLower.contains("tissot") || detailDescLower.contains("tissot")) {
                correctFactory = "Tissot";
            } else if (nameLower.contains("omega") || shortDescLower.contains("omega") || detailDescLower.contains("omega")) {
                correctFactory = "Omega";
            } else if (nameLower.contains("longines") || shortDescLower.contains("longines") || detailDescLower.contains("longines")) {
                correctFactory = "Longines";
            } else if (nameLower.contains("seiko") || shortDescLower.contains("seiko") || detailDescLower.contains("seiko")) {
                correctFactory = "Seiko";
            } else if (nameLower.contains("patek") || shortDescLower.contains("patek") || detailDescLower.contains("patek")) {
                correctFactory = "Patek Philippe";
            } else if (nameLower.contains("orient") || shortDescLower.contains("orient") || detailDescLower.contains("orient")) {
                correctFactory = "Orient";
            } else if (nameLower.contains("citizen") || shortDescLower.contains("citizen") || detailDescLower.contains("citizen")) {
                correctFactory = "Citizen";
            }
            
            boolean isLegacy = currentFactory == null || 
                               currentFactory.equalsIgnoreCase("Apple") || 
                               currentFactory.equalsIgnoreCase("ASUS") || 
                               currentFactory.equalsIgnoreCase("Dell") || 
                               currentFactory.equalsIgnoreCase("HP") || 
                               currentFactory.equalsIgnoreCase("Lenovo") || 
                               currentFactory.equalsIgnoreCase("Acer");
            
            if (correctFactory != null) {
                if (!correctFactory.equalsIgnoreCase(currentFactory)) {
                    System.out.println(">>> Auto-correcting factory of product [" + p.getName() + "] from [" + currentFactory + "] to [" + correctFactory + "]");
                    p.setFactory(correctFactory);
                    this.productRepository.save(p);
                }
            } else if (isLegacy) {
                // Try to match based on image name fallback
                String imgLower = p.getImage() != null ? p.getImage().toLowerCase() : "";
                if (imgLower.contains("rolex")) {
                    correctFactory = "Rolex";
                } else if (imgLower.contains("hublot")) {
                    correctFactory = "Hublot";
                } else if (imgLower.contains("cartier")) {
                    correctFactory = "Cartier";
                } else if (imgLower.contains("casio")) {
                    correctFactory = "Casio";
                } else if (imgLower.contains("tissot")) {
                    correctFactory = "Tissot";
                } else if (imgLower.contains("omega")) {
                    correctFactory = "Omega";
                } else if (imgLower.contains("longines")) {
                    correctFactory = "Longines";
                } else if (imgLower.contains("seiko")) {
                    correctFactory = "Seiko";
                } else if (imgLower.contains("patek")) {
                    correctFactory = "Patek Philippe";
                } else if (imgLower.contains("orient")) {
                    correctFactory = "Orient";
                } else if (imgLower.contains("citizen")) {
                    correctFactory = "Citizen";
                } else {
                    correctFactory = "Rolex"; // default fallback
                }
                System.out.println(">>> Auto-correcting factory fallback of product [" + p.getName() + "] from [" + currentFactory + "] to [" + correctFactory + "]");
                p.setFactory(correctFactory);
                this.productRepository.save(p);
            }
        }

        // 1. Seed Roles
        Role adminRole = roleRepository.findByName("ADMIN");
        if (adminRole == null) {
            adminRole = new Role();
            adminRole.setName("ADMIN");
            adminRole.setDescription("Administrator Role");
            adminRole = roleRepository.save(adminRole);
            System.out.println("-> Seeded Role: ADMIN");
        }

        Role userRole = roleRepository.findByName("USER");
        if (userRole == null) {
            userRole = new Role();
            userRole.setName("USER");
            userRole.setDescription("Customer/Client Role");
            userRole = roleRepository.save(userRole);
            System.out.println("-> Seeded Role: USER");
        }

        // 2. Seed Administrative & Customer Users
        if (!userRepository.existsByEmail("admin@gmail.com")) {
            User admin = new User();
            admin.setEmail("admin@gmail.com");
            admin.setPassWord(passwordEncoder.encode("123456"));
            admin.setFullName("Administrator");
            admin.setAddress("Hà Nội, Việt Nam");
            admin.setPhone("0987654321");
            admin.setRole(adminRole);
            admin.setEnabled(true);
            admin.setAvatar("default-avatar.png");
            userRepository.save(admin);
            System.out.println("-> Seeded Default Admin: admin@gmail.com / 123456");
        }

        if (!userRepository.existsByEmail("user@gmail.com")) {
            User user = new User();
            user.setEmail("user@gmail.com");
            user.setPassWord(passwordEncoder.encode("123456"));
            user.setFullName("Khách Hàng Luxury");
            user.setAddress("TP. Hồ Chí Minh, Việt Nam");
            user.setPhone("0123456789");
            user.setRole(userRole);
            user.setEnabled(true);
            user.setAvatar("default-avatar.png");
            userRepository.save(user);
            System.out.println("-> Seeded Default User: user@gmail.com / 123456");
        }

        User user = userRepository.findOneByEmail("user@gmail.com");

        // 3. Seed Products (Luxury Watches)
        // Rolex Submariner Date
        Product rolexSub = null;
        var rolexSubList = productRepository.findByNameContainingIgnoreCase("Rolex Submariner Date 41mm");
        if (rolexSubList.isEmpty()) {
            rolexSub = new Product();
            rolexSub.setName("Rolex Submariner Date 41mm");
            rolexSub.setPrice(350000000.0);
            rolexSub.setImage("rolex_submariner.jpg");
            rolexSub.setDetailDesc("Đồng hồ Rolex Submariner Date Oystersteel là biểu tượng tối thượng của sự mạnh mẽ, lịch lãm và bền bỉ. Được trang bị vành xoay Cerachrom bằng gốm đen và mặt số đen đặc trưng cùng các điểm giờ phát quang Chromalight lớn, mẫu đồng hồ này có khả năng chống nước vượt trội lên đến 300 mét (1000 feet). Phù hợp cho cả hoạt động lặn biển chuyên nghiệp và phong cách sống thượng lưu.");
            rolexSub.setShortDesc("Đồng hồ nam Rolex Submariner Date Oystersteel 41mm mặt đen cao cấp");
            rolexSub.setQuantity(10);
            rolexSub.setSold(2);
            rolexSub.setFactory("Rolex");
            rolexSub.setTarget("Nam");
            rolexSub = productRepository.save(rolexSub);
            System.out.println("-> Seeded Product: Rolex Submariner Date 41mm");
        } else {
            rolexSub = rolexSubList.get(0);
        }

        // Rolex Datejust 36
        Product rolexDJ = null;
        var rolexDJList = productRepository.findByNameContainingIgnoreCase("Rolex Datejust 36 Champagne");
        if (rolexDJList.isEmpty()) {
            rolexDJ = new Product();
            rolexDJ.setName("Rolex Datejust 36 Champagne");
            rolexDJ.setPrice(280000000.0);
            rolexDJ.setImage("rolex_datejust.jpg");
            rolexDJ.setDetailDesc("Đồng hồ cổ điển Rolex Datejust 36 là chuẩn mực của sự thanh lịch sang trọng vượt thời gian. Sự kết hợp tinh tế giữa thép Oystersteel siêu bền và vàng vàng 18ct quý giá (mẫu Rolesor vàng), mặt số màu Champagne với các cọc số nạm kim cương lấp lánh mang lại vẻ đẹp đẳng cấp hoàng gia tuyệt đối.");
            rolexDJ.setShortDesc("Đồng hồ nam/nữ Rolex Datejust 36 Rolesor Vàng nạm kim cương");
            rolexDJ.setQuantity(8);
            rolexDJ.setSold(4);
            rolexDJ.setFactory("Rolex");
            rolexDJ.setTarget("Unisex");
            rolexDJ = productRepository.save(rolexDJ);
            System.out.println("-> Seeded Product: Rolex Datejust 36 Champagne");
        } else {
            rolexDJ = rolexDJList.get(0);
        }

        // Hublot Big Bang Sang Bleu II
        Product hublotBB = null;
        var hublotBBList = productRepository.findByNameContainingIgnoreCase("Hublot Big Bang Sang Bleu II");
        if (hublotBBList.isEmpty()) {
            hublotBB = new Product();
            hublotBB.setName("Hublot Big Bang Sang Bleu II");
            hublotBB.setPrice(680000000.0);
            hublotBB.setImage("hublot_bigbang.jpg");
            hublotBB.setDetailDesc("Sự hợp tác đỉnh cao giữa Hublot và nghệ sĩ xăm hình nổi tiếng Maxime Plescia-Buchi. Đồng hồ Hublot Big Bang Sang Bleu II Titanium mang thiết kế cấu trúc đa diện hình học lập thể cực kỳ phức tạp và cá tính. Toàn bộ vỏ máy được chế tác từ Titanium cấp độ 5 siêu nhẹ và siêu cứng, kết hợp bộ máy chronograph tự động flyback HUB1240 đẳng cấp.");
            hublotBB.setShortDesc("Đồng hồ nam Hublot Big Bang Sang Bleu II Titanium 45mm độc bản");
            hublotBB.setQuantity(5);
            hublotBB.setSold(1);
            hublotBB.setFactory("Hublot");
            hublotBB.setTarget("Nam");
            hublotBB = productRepository.save(hublotBB);
            System.out.println("-> Seeded Product: Hublot Big Bang Sang Bleu II");
        } else {
            hublotBB = hublotBBList.get(0);
        }

        // Cartier Ballon Bleu de Cartier
        Product cartierBB = null;
        var cartierBBList = productRepository.findByNameContainingIgnoreCase("Cartier Ballon Bleu de Cartier 33mm");
        if (cartierBBList.isEmpty()) {
            cartierBB = new Product();
            cartierBB.setName("Cartier Ballon Bleu de Cartier 33mm");
            cartierBB.setPrice(180000000.0);
            cartierBB.setImage("cartier_ballon.jpg");
            cartierBB.setDetailDesc("Thanh lịch như một quả bóng khinh khí cầu nổi bật với tông màu xanh ngọc bích sang trọng, Ballon Bleu de Cartier điểm xuyết thêm nét duyên dáng trên cổ tay của các quý cô. Các chữ số La Mã cổ điển được dẫn lối bởi cơ chế lên dây núm vặn sapphire xanh thẳm được bảo vệ độc đáo dưới vòng cung kim loại.");
            cartierBB.setShortDesc("Đồng hồ nữ Cartier Ballon Bleu de Cartier 33mm thép không gỉ quý phái");
            cartierBB.setQuantity(12);
            cartierBB.setSold(6);
            cartierBB.setFactory("Cartier");
            cartierBB.setTarget("Nữ");
            cartierBB = productRepository.save(cartierBB);
            System.out.println("-> Seeded Product: Cartier Ballon Bleu de Cartier 33mm");
        } else {
            cartierBB = cartierBBList.get(0);
        }

        // Casio G-Shock G-Steel
        Product casioGS = null;
        var casioGSList = productRepository.findByNameContainingIgnoreCase("Casio G-Shock G-Steel GST-B400");
        if (casioGSList.isEmpty()) {
            casioGS = new Product();
            casioGS.setName("Casio G-Shock G-Steel GST-B400");
            casioGS.setPrice(9500000.0);
            casioGS.setImage("casio_gsteel.jpg");
            casioGS.setDetailDesc("Dòng G-Shock G-Steel cao cấp vỏ kim loại siêu mỏng kết hợp sợi carbon bảo vệ lõi bền bỉ. Đồng hồ tích hợp kết nối Bluetooth thông minh với điện thoại, sạc pin bằng năng lượng ánh sáng Tough Solar, khả năng chống sốc và chống nước 200m bền bỉ trứ danh.");
            casioGS.setShortDesc("Đồng hồ nam Casio G-Shock G-Steel GST-B400D vỏ thép không gỉ");
            casioGS.setQuantity(20);
            casioGS.setSold(15);
            casioGS.setFactory("Casio");
            casioGS.setTarget("Nam");
            casioGS = productRepository.save(casioGS);
            System.out.println("-> Seeded Product: Casio G-Shock G-Steel GST-B400");
        } else {
            casioGS = casioGSList.get(0);
        }

        // Tissot Le Locle Powermatic 80
        Product tissotLL = null;
        var tissotLLList = productRepository.findByNameContainingIgnoreCase("Tissot Le Locle Powermatic 80");
        if (tissotLLList.isEmpty()) {
            tissotLL = new Product();
            tissotLL.setName("Tissot Le Locle Powermatic 80");
            tissotLL.setPrice(19500000.0);
            tissotLL.setImage("tissot_lelocle.jpg");
            tissotLL.setDetailDesc("Đồng hồ cơ cổ điển Tissot Le Locle vinh danh thị trấn khai sinh ra thương hiệu Thụy Sĩ lừng danh. Mặt số Guilloche vân nổi tinh xảo kết hợp cọc số La Mã cổ kính, trang bị bộ máy Powermatic 80 có khả năng trữ cót ấn tượng lên đến 80 giờ liên tục.");
            tissotLL.setShortDesc("Đồng hồ cơ nam Tissot Le Locle Powermatic 80 Thụy Sĩ sang trọng");
            tissotLL.setQuantity(15);
            tissotLL.setSold(8);
            tissotLL.setFactory("Tissot");
            tissotLL.setTarget("Nam");
            tissotLL = productRepository.save(tissotLL);
            System.out.println("-> Seeded Product: Tissot Le Locle Powermatic 80");
        } else {
            tissotLL = tissotLLList.get(0);
        }

        // Omega Seamaster Diver 300M
        Product omegaSM = null;
        var omegaSMList = productRepository.findByNameContainingIgnoreCase("Omega Seamaster Diver 300M Co-Axial");
        if (omegaSMList.isEmpty()) {
            omegaSM = new Product();
            omegaSM.setName("Omega Seamaster Diver 300M Co-Axial");
            omegaSM.setPrice(150000000.0);
            omegaSM.setImage("omega_seamaster.jpg");
            omegaSM.setDetailDesc("Đồng hồ lặn biển chuyên nghiệp Omega Seamaster Diver 300M nổi bật với mặt số ceramic màu xanh dương được khắc vân sóng laser đặc trưng. Trang bị bộ chuyển động Co-Axial Master Chronometer 8800 kháng từ trường vượt trội.");
            omegaSM.setShortDesc("Đồng hồ nam Omega Seamaster Diver 300M vỏ thép không gỉ");
            omegaSM.setQuantity(10);
            omegaSM.setSold(3);
            omegaSM.setFactory("Omega");
            omegaSM.setTarget("Nam");
            omegaSM = productRepository.save(omegaSM);
            System.out.println("-> Seeded Product: Omega Seamaster Diver 300M Co-Axial");
        } else {
            omegaSM = omegaSMList.get(0);
        }

        // Longines Master Collection
        Product longinesMC = null;
        var longinesMCList = productRepository.findByNameContainingIgnoreCase("Longines Master Collection Moonphase");
        if (longinesMCList.isEmpty()) {
            longinesMC = new Product();
            longinesMC.setName("Longines Master Collection Moonphase");
            longinesMC.setPrice(65000000.0);
            longinesMC.setImage("longines_master.jpg");
            longinesMC.setDetailDesc("Đại diện cho truyền thống chế tác đồng hồ lâu đời của Longines. Mẫu Master Collection Moonphase sở hữu tính năng hiển thị chu kỳ trăng thanh lịch ở góc 6 giờ, kim nung xanh nổi bật trên nền mặt số vân hạt lúa mạch cổ kính.");
            longinesMC.setShortDesc("Đồng hồ cơ nam Longines Master Collection Moonphase cao cấp");
            longinesMC.setQuantity(8);
            longinesMC.setSold(2);
            longinesMC.setFactory("Longines");
            longinesMC.setTarget("Nam");
            longinesMC = productRepository.save(longinesMC);
            System.out.println("-> Seeded Product: Longines Master Collection Moonphase");
        } else {
            longinesMC = longinesMCList.get(0);
        }

        // Seiko Presage Cocktail Time
        Product seikoPR = null;
        var seikoPRList = productRepository.findByNameContainingIgnoreCase("Seiko Presage Cocktail Time");
        if (seikoPRList.isEmpty()) {
            seikoPR = new Product();
            seikoPR.setName("Seiko Presage Cocktail Time");
            seikoPR.setPrice(12000000.0);
            seikoPR.setImage("seiko_presage.jpg");
            seikoPR.setDetailDesc("Lấy cảm hứng từ những ly cocktail lộng lẫy tại quán bar Tokyo. Mặt số Seiko Presage được hoàn thiện dập tia tỏa nắng vô cùng tinh xảo, tạo hiệu ứng phản quang lấp lánh cuốn hút dưới mọi góc nhìn ánh sáng.");
            seikoPR.setShortDesc("Đồng hồ nam/nữ Seiko Presage Cocktail Time mặt số xanh lục bảo");
            seikoPR.setQuantity(15);
            seikoPR.setSold(5);
            seikoPR.setFactory("Seiko");
            seikoPR.setTarget("Unisex");
            seikoPR = productRepository.save(seikoPR);
            System.out.println("-> Seeded Product: Seiko Presage Cocktail Time");
        } else {
            seikoPR = seikoPRList.get(0);
        }

        // Patek Philippe Nautilus 5711
        Product patekNL = null;
        var patekNLList = productRepository.findByNameContainingIgnoreCase("Patek Philippe Nautilus 5711/1A");
        if (patekNLList.isEmpty()) {
            patekNL = new Product();
            patekNL.setName("Patek Philippe Nautilus 5711/1A");
            patekNL.setPrice(2500000000.0);
            patekNL.setImage("patek_nautilus.jpg");
            patekNL.setDetailDesc("Kiệt tác huyền thoại của nhà thiết kế Gérald Genta. Patek Philippe Nautilus 5711 với thiết kế vỏ hình cửa sổ tàu biển đặc trưng và mặt số xanh lam sọc ngang nổi tiếng, là mẫu đồng hồ thể thao sang trọng được khao khát nhất mọi thời đại.");
            patekNL.setShortDesc("Đồng hồ nam Patek Philippe Nautilus 5711/1A-010 siêu sang trọng");
            patekNL.setQuantity(2);
            patekNL.setSold(1);
            patekNL.setFactory("Patek Philippe");
            patekNL.setTarget("Nam");
            patekNL = productRepository.save(patekNL);
            System.out.println("-> Seeded Product: Patek Philippe Nautilus 5711/1A");
        } else {
            patekNL = patekNLList.get(0);
        }

        // Orient Bambino Gen 2
        Product orientBambino = null;
        var orientBambinoList = productRepository.findByNameContainingIgnoreCase("Orient Bambino Gen 2");
        if (orientBambinoList.isEmpty()) {
            orientBambino = new Product();
            orientBambino.setName("Orient Bambino Gen 2");
            orientBambino.setPrice(6500000.0);
            orientBambino.setImage("orient_bambino.jpg");
            orientBambino.setDetailDesc("Đồng hồ nam Orient Bambino Gen 2 nổi tiếng với mặt kính siêu cong cổ điển quyến rũ. Mặt số màu trắng ngà kết hợp các cọc số La Mã thanh mảnh và bộ kim xanh nung tinh tế, trang bị bộ máy cơ tự động Caliber F6722 bền bỉ có hỗ trợ cót tay và dừng kim giây.");
            orientBambino.setShortDesc("Đồng hồ cơ nam Orient Bambino Gen 2 kính cong cổ điển");
            orientBambino.setQuantity(25);
            orientBambino.setSold(12);
            orientBambino.setFactory("Orient");
            orientBambino.setTarget("Nam");
            orientBambino = productRepository.save(orientBambino);
            System.out.println("-> Seeded Product: Orient Bambino Gen 2");
        } else {
            orientBambino = orientBambinoList.get(0);
        }

        // Citizen C7 Automatic
        Product citizenC7 = null;
        var citizenC7List = productRepository.findByNameContainingIgnoreCase("Citizen C7 Automatic");
        if (citizenC7List.isEmpty()) {
            citizenC7 = new Product();
            citizenC7.setName("Citizen C7 Automatic");
            citizenC7.setPrice(5800000.0);
            citizenC7.setImage("citizen_c7.jpg");
            citizenC7.setDetailDesc("Đồng hồ Citizen C7 tái hiện dòng sản phẩm Crystal Seven huyền thoại năm 1965. Thiết kế mặt số trẻ trung với ô lịch thứ hình heptagon (7 cạnh) độc đáo đặt dưới góc 12 giờ, mặt kính khoáng cong nhẹ và nắp lưng trong suốt lộ máy cơ.");
            citizenC7.setShortDesc("Đồng hồ cơ nam Citizen C7 thiết kế phong cách retro");
            citizenC7.setQuantity(30);
            citizenC7.setSold(18);
            citizenC7.setFactory("Citizen");
            citizenC7.setTarget("Nam");
            citizenC7 = productRepository.save(citizenC7);
            System.out.println("-> Seeded Product: Citizen C7 Automatic");
        } else {
            citizenC7 = citizenC7List.get(0);
        }

        // Seiko 5 Sports SRPD55K1
        Product seikoSports = null;
        var seikoSportsList = productRepository.findByNameContainingIgnoreCase("Seiko 5 Sports SRPD55K1");
        if (seikoSportsList.isEmpty()) {
            seikoSports = new Product();
            seikoSports.setName("Seiko 5 Sports SRPD55K1");
            seikoSports.setPrice(7200000.0);
            seikoSports.setImage("seiko_sports.jpg");
            seikoSports.setDetailDesc("Đồng hồ thể thao Seiko 5 Sports thế hệ mới kế thừa huyền thoại SKX. Thiết kế vành xoay dive bezel khỏe khoắn, mặt số màu đen nhám kết hợp các cọc số phủ dạ quang siêu sáng Lumibrite giúp dễ dàng đọc giờ trong bóng tối.");
            seikoSports.setShortDesc("Đồng hồ cơ thể thao nam Seiko 5 Sports SRPD55K1");
            seikoSports.setQuantity(15);
            seikoSports.setSold(9);
            seikoSports.setFactory("Seiko");
            seikoSports.setTarget("Nam");
            seikoSports = productRepository.save(seikoSports);
            System.out.println("-> Seeded Product: Seiko 5 Sports SRPD55K1");
        } else {
            seikoSports = seikoSportsList.get(0);
        }

        // Casio Edifice EFV-600D
        Product casioEdifice = null;
        var casioEdificeList = productRepository.findByNameContainingIgnoreCase("Casio Edifice EFV-600D");
        if (casioEdificeList.isEmpty()) {
            casioEdifice = new Product();
            casioEdifice.setName("Casio Edifice EFV-600D");
            casioEdifice.setPrice(3500000.0);
            casioEdifice.setImage("casio_edifice.jpg");
            casioEdifice.setDetailDesc("Đồng hồ ghi giờ Chronograph Casio Edifice năng động, mạnh mẽ. Thiết kế mặt số đa kim thể thao với vành kim loại đo tốc độ Tachymeter, vỏ và dây đeo làm bằng thép không gỉ cao cấp, khả năng chống nước đạt mức 100 mét.");
            casioEdifice.setShortDesc("Đồng hồ nam ghi giờ thể thao Casio Edifice EFV-600D");
            casioEdifice.setQuantity(40);
            casioEdifice.setSold(25);
            casioEdifice.setFactory("Casio");
            casioEdifice.setTarget("Nam");
            casioEdifice = productRepository.save(casioEdifice);
            System.out.println("-> Seeded Product: Casio Edifice EFV-600D");
        } else {
            casioEdifice = casioEdificeList.get(0);
        }

        // 4. Seed Test Order history for user@gmail.com

        if (user != null && orderRepository.findByUser(user).isEmpty()) {
            Order testOrder1 = new Order();
            testOrder1.setUser(user);
            testOrder1.setOrderDate(LocalDateTime.now().minusDays(5));
            testOrder1.setReceiverName("Khách Hàng Luxury");
            testOrder1.setReceiverPhone("0123456789");
            testOrder1.setReceiverAddress("123 Đường Đồng Khởi, Quận 1, TP. Hồ Chí Minh");
            testOrder1.setTotalPrice(rolexSub.getPrice());
            testOrder1.setStatus("DELIVERED");
            testOrder1.setOrderCode("ORD-DEMO001");
            testOrder1 = orderRepository.save(testOrder1);

            OrderDetail detail1 = new OrderDetail();
            detail1.setOrder(testOrder1);
            detail1.setProduct(rolexSub);
            detail1.setPrice(rolexSub.getPrice());
            detail1.setQuantity(1);
            orderDetailRepository.save(detail1);

            Order testOrder2 = new Order();
            testOrder2.setUser(user);
            testOrder2.setOrderDate(LocalDateTime.now().minusDays(2));
            testOrder2.setReceiverName("Khách Hàng Luxury");
            testOrder2.setReceiverPhone("0123456789");
            testOrder2.setReceiverAddress("123 Đường Đồng Khởi, Quận 1, TP. Hồ Chí Minh");
            testOrder2.setTotalPrice(tissotLL.getPrice());
            testOrder2.setStatus("SHIPPING");
            testOrder2.setOrderCode("ORD-DEMO002");
            testOrder2 = orderRepository.save(testOrder2);

            OrderDetail detail2 = new OrderDetail();
            detail2.setOrder(testOrder2);
            detail2.setProduct(tissotLL);
            detail2.setPrice(tissotLL.getPrice());
            detail2.setQuantity(1);
            orderDetailRepository.save(detail2);

            Order testOrder3 = new Order();
            testOrder3.setUser(user);
            testOrder3.setOrderDate(LocalDateTime.now().minusDays(1));
            testOrder3.setReceiverName("Khách Hàng Luxury");
            testOrder3.setReceiverPhone("0123456789");
            testOrder3.setReceiverAddress("123 Đường Đồng Khởi, Quận 1, TP. Hồ Chí Minh");
            testOrder3.setTotalPrice(cartierBB.getPrice() * 2);
            testOrder3.setStatus("PENDING");
            testOrder3.setOrderCode("ORD-DEMO003");
            testOrder3 = orderRepository.save(testOrder3);

            OrderDetail detail3 = new OrderDetail();
            detail3.setOrder(testOrder3);
            detail3.setProduct(cartierBB);
            detail3.setPrice(cartierBB.getPrice());
            detail3.setQuantity(2);
            orderDetailRepository.save(detail3);

            System.out.println("-> Seeded 3 demo orders for user@gmail.com successfully!");
        }

        // 5. Seed Test Cart items for user@gmail.com to checkout demo
        if (user != null) {
            Cart cart = cartRepository.findByUser(user);
            if (cart == null) {
                cart = new Cart();
                cart.setUser(user);
                cart.setSum(1);
                cart = cartRepository.save(cart);

                CartDetail cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProduct(cartierBB);
                cartDetail.setPrice(cartierBB.getPrice());
                cartDetail.setQuantity(1);
                cartDetailRepository.save(cartDetail);

                System.out.println("-> Seeded demo cart and items for user@gmail.com successfully!");
            }
        }

        System.out.println(">>> DATABASE INITIALIZATION SEEDING COMPLETED SUCCESSFULLY.");
    }
}
