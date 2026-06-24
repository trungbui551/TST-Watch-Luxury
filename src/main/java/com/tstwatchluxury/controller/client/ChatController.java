package com.tstwatchluxury.controller.client;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import com.tstwatchluxury.service.SystemSettingService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ChatController {

    @Value("${gemini.api.key:}")
    private String geminiApiKey;

    private final RestTemplate restTemplate = new RestTemplate();
    private final SystemSettingService systemSettingService;

    public ChatController(SystemSettingService systemSettingService) {
        this.systemSettingService = systemSettingService;
    }

    private static final String SYSTEM_PROMPT = 
        "Bạn là Trợ lý Tư vấn Đồng hồ Cao cấp (AI Advisor) đại diện cho thương hiệu TST Watch Luxury. " +
        "Nhiệm vụ của bạn là tư vấn cho khách hàng chọn mua mẫu đồng hồ phù hợp dựa trên các yếu tố: " +
        "1. Kích thước cổ tay (Size): Cổ tay < 15cm tư vấn size 33mm - 36mm (ví dụ: Cartier Ballon Bleu 33mm). Cổ tay 15cm - 17cm tư vấn size 38mm - 40.5mm (ví dụ: Rolex Datejust 36mm, Seiko Presage 40.5mm). Cổ tay > 17cm tư vấn size 41mm - 45mm (ví dụ: Rolex Submariner 41mm, Omega Seamaster 42mm). " +
        "2. Sở thích & Phong cách: Thanh lịch (Dress watch như Tissot Le Locle, Cartier), Cá tính/Độc bản (Hublot Big Bang), Thể thao/Mạnh mẽ (Rolex Submariner, Omega Seamaster). " +
        "3. Tính chất công việc: Công sở/Văn phòng (cần mỏng nhẹ, dây kim loại/da phối với sơ mi), Kỹ thuật/Hoạt động ngoài trời (cần bền bỉ, chống nước tốt như Rolex Submariner, Casio G-Steel). " +
        "4. Lứa tuổi & Giới tính: Trẻ trung năng động (Casio G-Steel, Seiko 5), Doanh nhân thành đạt (Patek Philippe, Rolex, Hublot), Phái nữ quý phái (Cartier Ballon Bleu Pink, Rolex Datejust nạm kim cương). " +
        "Hãy luôn trả lời bằng tiếng Việt, lịch sự, nhã nhặn, tôn trọng khách hàng. Đưa ra gợi ý cụ thể từ các dòng sản phẩm của TST Watch Luxury gồm: " +
        "Rolex Submariner, Rolex Datejust, Hublot Big Bang Sang Bleu, Cartier Ballon Bleu, Omega Seamaster, Seiko Presage, Seiko 5 Sports, Tissot Le Locle, Casio G-Steel, Patek Philippe Nautilus, Orient Bambino, Citizen C7.";

    @PostMapping("/api/chat")
    public Map<String, String> chatWithAI(@RequestBody Map<String, String> payload) {
        String userMessage = payload.get("message");
        Map<String, String> response = new HashMap<>();

        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.put("reply", "Xin lỗi, tôi chưa nhận được tin nhắn từ bạn.");
            return response;
        }

        // Get dynamic API key first, fallback to properties value
        String activeApiKey = systemSettingService.getSettingValue("AI_CHAT_API_KEY", "");
        if (activeApiKey == null || activeApiKey.trim().isEmpty()) {
            activeApiKey = geminiApiKey;
        }

        // Check if API Key is configured
        if (activeApiKey == null || activeApiKey.trim().isEmpty()) {
            response.put("reply", getMockResponse(userMessage));
            return response;
        }

        try {
            String reply = callGeminiAPI(userMessage, activeApiKey);
            if (reply != null && !reply.trim().isEmpty()) {
                response.put("reply", reply);
            } else {
                response.put("reply", getMockResponse(userMessage));
            }
        } catch (Exception e) {
            System.err.println("Gemini API call failed, falling back to mock response. Reason: " + e.getMessage());
            response.put("reply", getMockResponse(userMessage));
        }

        return response;
    }

    private String callGeminiAPI(String userMessage, String activeApiKey) {
        try {
            return callGeminiAPIWithModel(userMessage, activeApiKey, "gemini-1.5-flash");
        } catch (Exception e) {
            System.err.println("Gemini gemini-1.5-flash failed. Reason: " + e.getMessage() + ". Trying fallback model: gemini-1.5-pro...");
            try {
                return callGeminiAPIWithModel(userMessage, activeApiKey, "gemini-1.5-pro");
            } catch (Exception e2) {
                System.err.println("Gemini gemini-1.5-pro failed. Reason: " + e2.getMessage());
                throw e2;
            }
        }
    }

    private String callGeminiAPIWithModel(String userMessage, String activeApiKey, String modelName) {
        String url = "https://generativelanguage.googleapis.com/v1beta/models/" + modelName + ":generateContent?key=" + activeApiKey.trim();

        // Build Request payload
        Map<String, Object> requestBody = new HashMap<>();
        List<Map<String, Object>> contents = new ArrayList<>();
        Map<String, Object> contentMap = new HashMap<>();
        List<Map<String, String>> parts = new ArrayList<>();
        Map<String, String> partMap = new HashMap<>();
        
        partMap.put("text", SYSTEM_PROMPT + "\n\nKhách hàng hỏi: " + userMessage);
        parts.add(partMap);
        contentMap.put("parts", parts);
        contents.add(contentMap);
        requestBody.put("contents", contents);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        Map<String, Object> apiResponse = restTemplate.postForObject(url, entity, Map.class);
        
        if (apiResponse != null && apiResponse.containsKey("candidates")) {
            List<Map<String, Object>> candidates = (List<Map<String, Object>>) apiResponse.get("candidates");
            if (candidates != null && !candidates.isEmpty()) {
                Map<String, Object> firstCandidate = candidates.get(0);
                Map<String, Object> content = (Map<String, Object>) firstCandidate.get("content");
                if (content != null && content.containsKey("parts")) {
                    List<Map<String, Object>> resParts = (List<Map<String, Object>>) content.get("parts");
                    if (resParts != null && !resParts.isEmpty()) {
                        return (String) resParts.get(0).get("text");
                    }
                }
            }
        }
        return null;
    }

    private String getMockResponse(String userMessage) {
        String msg = userMessage.toLowerCase();
        
        if (msg.contains("size") || msg.contains("cổ tay") || msg.contains("đo") || msg.contains("kích thước")) {
            return "Chào quý khách! Về **size (kích thước) cổ tay**, TST Watch Luxury xin tư vấn nguyên tắc chọn như sau:\n\n" +
                   "1. **Cổ tay nhỏ (dưới 15cm)**: Thích hợp với các mặt số từ **33mm đến 36mm**. Dòng sản phẩm tiêu biểu là **Cartier Ballon Bleu 33mm** hoặc các bản cổ điển thanh mảnh.\n" +
                   "2. **Cổ tay trung bình (15cm - 17cm)**: Lý tưởng nhất với size **38mm đến 40.5mm** như **Rolex Datejust 36mm** hoặc **Seiko Presage 40.5mm**.\n" +
                   "3. **Cổ tay lớn (trên 17cm)**: Vừa vặn với các dòng thể thao hầm hố từ **41mm đến 45mm** như **Rolex Submariner 41mm**, **Omega Seamaster 42mm** hay **Casio G-Steel**.\n\n" +
                   "Quý khách có thể đo chu vi cổ tay bằng thước dây để chúng tôi tư vấn chính xác nhất mẫu đồng hồ tương ứng!";
        }
        
        if (msg.contains("công sở") || msg.contains("đi làm") || msg.contains("văn phòng") || msg.contains("sơ mi") || msg.contains("comple")) {
            return "Đối với môi trường **văn phòng/công sở**, quý khách nên ưu tiên các dòng đồng hồ thanh lịch (Dress Watch) có đặc điểm mỏng nhẹ để dễ mặc luồn trong tay áo sơ mi:\n\n" +
                   "- **Rolex Datejust 36mm** (Vành vàng, mặt Champagne nạm kim cương) - Biểu tượng của sự sang trọng, chỉn chu.\n" +
                   "- **Tissot Le Locle Powermatic 80** - Mang phong cách Thụy Sĩ cổ điển, vân Guilloche tinh tế, giá cả phải chăng.\n" +
                   "- **Seiko Presage Cocktail** - Thiết kế mặt số chải tia lộng lẫy cực kỳ cuốn hút dưới ánh đèn văn phòng.\n\n" +
                   "Các mẫu này thường đi kèm dây da cao cấp hoặc thép Oyster sáng bóng đánh bóng mượt mà.";
        }
        
        if (msg.contains("thể thao") || msg.contains("chạy") || msg.contains("lặn") || msg.contains("năng động") || msg.contains("bơi") || msg.contains("chống nước")) {
            return "Để phục vụ các hoạt động **thể thao năng động, bơi lội hoặc lặn biển**, quý khách nên tham khảo các dòng Sport Watch chuyên dụng chống nước và chống va đập cực tốt:\n\n" +
                   "- **Rolex Submariner Date 41mm** - Khả năng chống nước lên tới 300m, vành gốm Cerachrom xoay một chiều siêu bền.\n" +
                   "- **Omega Seamaster Diver 300M** - Bộ máy Co-Axial chống từ trường vượt trội, thiết kế mặt số vân sóng biểu tượng.\n" +
                   "- **Casio G-Shock G-Steel GST-B400** - Cực kỳ bền bỉ trước mọi va đập vật lý, chống nước 200m và thiết kế thép góc cạnh hiện đại.\n\n" +
                   "Các dòng này thường sử dụng dây kim loại Oyster steel hoặc dây cao su bền bỉ.";
        }

        if (msg.contains("nữ") || msg.contains("phái đẹp") || msg.contains("chị em") || msg.contains("quà tặng vợ") || msg.contains("tặng bạn gái")) {
            return "Chào quý khách! TST Watch Luxury sở hữu những tuyệt tác tinh tế dành riêng cho **phái nữ quý phái** hoặc làm quà tặng đắt giá:\n\n" +
                   "- **Cartier Ballon Bleu de Cartier 33mm (Mặt số hồng)**: Mặt kính vòm cong độc đáo kết hợp cùng sắc hồng pastel ngọt ngào, quý phái.\n" +
                   "- **Rolex Datejust 36 nạm kim cương**: Sự kết hợp đẳng cấp giữa vàng 18ct, thép Oystersteel siêu bền và cọc số kim cương lấp lánh.\n\n" +
                   "Quý khách có muốn chúng tôi hỗ trợ chuẩn bị hộp quà cao cấp và nơ lụa thắt tay đặc biệt không?";
        }
        
        if (msg.contains("giá") || msg.contains("tiền") || msg.contains("triệu") || msg.contains("đắt") || msg.contains("rẻ")) {
            return "Tại TST Watch Luxury, chúng tôi phân phối đa dạng các phân khúc giá từ vài triệu đến hàng trăm triệu đồng:\n\n" +
                   "1. **Phân khúc Thượng lưu (Trên 100 triệuđ)**: Rolex Submariner (350 triệu), Rolex Datejust (280 triệu), Hublot Big Bang (680 triệu), Patek Philippe Nautilus.\n" +
                   "2. **Phân khúc Cận cao cấp (15 - 50 triệuđ)**: Longines Master Collection, Omega Seamaster.\n" +
                   "3. **Phân khúc Tiếp cận (Dưới 15 triệuđ)**: Seiko Presage, Tissot Le Locle, Casio G-Steel, Orient Bambino, Citizen C7.\n\n" +
                   "Xin hỏi khoảng ngân sách quý khách đang dự tính đầu tư là bao nhiêu?";
        }

        return "Xin chào! Tôi là Trợ lý ảo tư vấn đồng hồ cao cấp của **TST Watch Luxury**.\n\n" +
               "Tôi có thể hỗ trợ quý khách giải đáp các thắc mắc về:\n" +
               "1. **Đo size cổ tay** phù hợp với mặt số đồng hồ.\n" +
               "2. Lựa chọn dòng máy (Cơ Automatic hay Pin Quartz) phù hợp **sở thích**.\n" +
               "3. Đồng hồ phối hợp theo **lứa tuổi, giới tính hoặc yếu tố công việc** (văn phòng hay hoạt động thể thao ngoài trời).\n\n" +
               "Quý khách hãy đặt câu hỏi để tôi hỗ trợ ngay nhé!";
    }
}
