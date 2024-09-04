// chatbot.js
function toggleChat() {
    var chatbotContainer = document.getElementById('chatbot-container');
    if (chatbotContainer.style.display === 'none' || chatbotContainer.style.display === '') {
        chatbotContainer.style.display = 'flex';
    } else {
        chatbotContainer.style.display = 'none';
    }
}

function sendMessage() {
    var userInput = document.getElementById('user-input').value;
    if (userInput.trim() !== "") {
        var chatBox = document.getElementById('chat-box');
        var userMessage = "<div class='user-message'><strong>You:</strong> " + userInput + "</div>";
        chatBox.innerHTML += userMessage;

        // Flask 서버로 메시지 전송
        fetch("/get_response", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ message: userInput })
        })
        .then(response => response.text())
        .then(data => {
            var botMessage = "<div class='bot-message'><strong>Bot:</strong> " + data + "</div>";
            chatBox.innerHTML += botMessage;
            chatBox.scrollTop = chatBox.scrollHeight;
        });

        // 입력 필드 초기화
        document.getElementById('user-input').value = '';
    }
}

function checkEnter(event) {
    if (event.key === 'Enter') {
        event.preventDefault(); // 기본 Enter 키 동작 방지
        sendMessage();
    }
}
