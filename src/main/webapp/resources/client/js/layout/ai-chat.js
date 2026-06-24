/* ==========================================================================
   AI CHAT CONSULTANT - CLIENT SIDE LOGIC
   ========================================================================== */

document.addEventListener('DOMContentLoaded', function() {
    const trigger = document.getElementById('aiChatTrigger');
    const windowEl = document.getElementById('aiChatWindow');
    const closeBtn = document.getElementById('aiChatClose');
    const chatBody = document.getElementById('aiChatBody');
    const chatForm = document.getElementById('aiChatForm');
    const chatInput = document.getElementById('aiChatInput');
    const suggestions = document.querySelectorAll('.ai-pill');

    if (!trigger || !windowEl || !chatBody) return;

    // Define Storage configs dynamically based on Authentication
    const isAuthenticated = window.HeaderConfig?.isAuthenticated === true;
    const username = window.HeaderConfig?.username || 'guest';
    const storageKey = `ai_chat_history_${username}`;
    const storageEngine = isAuthenticated ? localStorage : sessionStorage;
    const initiatedKey = `ai_chat_initiated_${username}`;

    // Toggle Chat Window
    trigger.addEventListener('click', function() {
        const isShowing = windowEl.classList.contains('show');
        if (isShowing) {
            closeChat();
        } else {
            openChat();
        }
    });

    if (closeBtn) {
        closeBtn.addEventListener('click', closeChat);
    }

    function openChat() {
        trigger.classList.add('active');
        windowEl.classList.add('show');
        chatInput.focus();
        scrollToBottom();
        
        // Mark greeting as shown or reload history
        if (!storageEngine.getItem(initiatedKey)) {
            storageEngine.setItem(initiatedKey, 'true');
            loadDefaultGreeting();
        }
    }

    function closeChat() {
        trigger.classList.remove('active');
        windowEl.classList.remove('show');
    }

    // Load Chat History from storage
    function loadHistory() {
        const history = storageEngine.getItem(storageKey);
        if (history) {
            const messages = JSON.parse(history);
            chatBody.innerHTML = '';
            messages.forEach(msg => {
                appendMessageBubble(msg.text, msg.sender);
            });
            scrollToBottom();
        } else {
            loadDefaultGreeting();
        }
    }

    function loadDefaultGreeting() {
        chatBody.innerHTML = '';
        const greetingText = "Xin chào! Tôi là **Trợ lý ảo tư vấn đồng hồ** của **TST Watch Luxury**.\n\n" +
                             "Tôi có thể hỗ trợ bạn chọn size mặt số phù hợp, gợi ý đồng hồ theo phong cách, công việc, lứa tuổi hoặc giới tính.\n" +
                             "Bạn hãy đặt câu hỏi để tôi hỗ trợ ngay nhé!";
        appendMessageBubble(greetingText, 'server');
        saveToHistory(greetingText, 'server');
    }

    // Append Message to Chat body
    function appendMessageBubble(text, sender) {
        const bubble = document.createElement('div');
        bubble.className = `ai-msg ai-msg-${sender}`;
        
        if (sender === 'server') {
            bubble.innerHTML = formatReply(text);
        } else {
            bubble.textContent = text;
        }
        
        chatBody.appendChild(bubble);
    }

    // Display typing indicator
    function showTypingIndicator() {
        const indicator = document.createElement('div');
        indicator.id = 'aiTypingIndicator';
        indicator.className = 'ai-msg ai-msg-server';
        indicator.innerHTML = `
            <div class="ai-typing-indicator">
                <div class="ai-typing-dot"></div>
                <div class="ai-typing-dot"></div>
                <div class="ai-typing-dot"></div>
            </div>
        `;
        chatBody.appendChild(indicator);
        scrollToBottom();
    }

    function removeTypingIndicator() {
        const indicator = document.getElementById('aiTypingIndicator');
        if (indicator) {
            indicator.remove();
        }
    }

    // Save conversation history
    function saveToHistory(text, sender) {
        let history = storageEngine.getItem(storageKey);
        let messages = history ? JSON.parse(history) : [];
        messages.push({ text, sender });
        storageEngine.setItem(storageKey, JSON.stringify(messages));
    }

    // Send Message Event
    if (chatForm) {
        chatForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const message = chatInput.value.trim();
            if (!message) return;

            sendMessageToServer(message);
        });
    }

    // Suggestion pills click event
    suggestions.forEach(pill => {
        pill.addEventListener('click', function() {
            const text = this.getAttribute('data-query');
            if (text) {
                sendMessageToServer(text);
            }
        });
    });

    function sendMessageToServer(message) {
        // Render user bubble
        appendMessageBubble(message, 'client');
        saveToHistory(message, 'client');
        chatInput.value = '';
        scrollToBottom();

        // Show typing spinner
        showTypingIndicator();

        // Retrieve CSRF config from global scope
        const csrfHeader = window.HeaderConfig?.csrfHeader || '';
        const csrfToken = window.HeaderConfig?.csrfToken || '';

        const headers = {
            'Content-Type': 'application/json'
        };
        if (csrfHeader && csrfToken) {
            headers[csrfHeader] = csrfToken;
        }

        // Call backend API
        fetch('/api/chat', {
            method: 'POST',
            headers: headers,
            body: JSON.stringify({ message: message })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error("Mất kết nối máy chủ");
            }
            return response.json();
        })
        .then(data => {
            removeTypingIndicator();
            const reply = data.reply || "Xin lỗi, đã xảy ra sự cố khi tải câu trả lời.";
            appendMessageBubble(reply, 'server');
            saveToHistory(reply, 'server');
            scrollToBottom();
        })
        .catch(error => {
            removeTypingIndicator();
            const errorMsg = "Không thể kết nối đến trợ lý ảo. Quý khách vui lòng kiểm tra kết nối mạng và thử lại sau ít phút.";
            appendMessageBubble(errorMsg, 'server');
            scrollToBottom();
            console.error("AI Chat connection failed: ", error);
        });
    }

    function scrollToBottom() {
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Parse Markdown text formatting to premium HTML nodes
    function formatReply(text) {
        if (!text) return '';
        
        // Escape HTML for security
        let escaped = text
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
            
        // Convert **bold** to <strong>bold</strong>
        escaped = escaped.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
        
        // Convert list bullets starting with - or * or \u2022
        escaped = escaped.replace(/(?:\r?\n)(?:-|\\*|\u2022)\s+(.*?)(?=\r?\n|$)/g, '<br>&bull; $1');
        
        // Replace double newlines with paragraph boundaries, single newlines with line-breaks
        escaped = escaped.replace(/\n\n/g, '</p><p>').replace(/\n/g, '<br>');
        
        return '<p>' + escaped + '</p>';
    }

    // Init chat history
    loadHistory();
});
