function toggleChat() {
  var chatbotContainer = document.getElementById("chatbot-container");
  if (chatbotContainer.style.display === "none" || chatbotContainer.style.display === "") {
    chatbotContainer.style.display = "flex";
  } else {
    chatbotContainer.style.display = "none";
  }
}

function sendMessage() {
  var userInput = document.getElementById("user-input").value;
  if (userInput.trim() !== "") {
    var chatBox = document.getElementById("chat-box");
    var userMessage = "<div class='user-message'><strong>You:</strong> " + userInput + "</div>";
    chatBox.innerHTML += userMessage;

    // 서버에 메시지 보내기
    fetch("http://localhost:5000/get_response", {
      mode: "cors",
      credentials: "include",
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: "message=" + encodeURIComponent(userInput),
    })
      .then((response) => response.json()) // 수정된 부분
      .then((data) => {
        var botMessage = "<div class='bot-message'><strong>Bot:</strong> " + data.response + "</div>";
        chatBox.innerHTML += botMessage;
        chatBox.scrollTop = chatBox.scrollHeight;
      })
      .catch((error) => console.error("Error:", error)); // 오류 처리 추가

    document.getElementById("user-input").value = "";
  }
}

function checkEnter(event) {
  if (event.key === "Enter") {
    event.preventDefault(); // 기본 Enter 키 동작 방지
    sendMessage();
  }
}
