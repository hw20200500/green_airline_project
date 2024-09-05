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
        fetch("http://localhost:5000/get_response", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'message=' + encodeURIComponent(userInput)
        })
        .then(response => response.json())
        .then(data => {
            var botMessage = "<div class='bot-message'><strong>Bot:</strong> " + data.response + "</div>";
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
