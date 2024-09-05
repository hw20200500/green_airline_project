<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  		<!-- <button type="button" onclick="location.href='#';" class="page--up--button">
  			<span class="material-symbols-outlined">expand_less</span>
  		</button> -->
		<!-- 챗봇 버튼 -->
		<style>
			body {
				font-family: Arial, sans-serif;
				margin: 0;
				padding: 0;
			}
			.chatbot-button {
				position: fixed;
				bottom: 20px; /* 화면 하단에서 20px 떨어지게 설정 */
				right: 20px; /* 화면 오른쪽에서 20px 떨어지게 설정 */
				width: 60px;
				height: 60px;
				background-color: #007bff;
				color: white;
				border: none;
				border-radius: 50%;
				box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
				display: flex;
				justify-content: center;
				align-items: center;
				font-size: 24px;
				cursor: pointer;
				z-index: 1000; /* 버튼을 다른 요소 위에 표시 */
			}
			.chatbot-container {
				position: fixed;
				bottom: 80px; /* 버튼 위에 위치하도록 설정 */
				right: 20px;
				width: 300px; /* 채팅창의 너비 */
				height: 400px; /* 채팅창의 높이 */
				background-color: #fff;
				border-radius: 10px;
				box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
				display: none; /* 기본적으로 챗봇 창은 숨김 */
				flex-direction: column;
				z-index: 1000; /* 챗봇을 다른 요소 위에 표시 */
			}
			.chatbot-header {
				background-color: #007bff;
				color: white;
				padding: 15px;
				text-align: center;
				cursor: pointer;
				font-size: 18px;
				font-weight: bold;
			}
			.chat-container {
				display: flex;
				flex-direction: column;
				height: 100%;
			}
			.chat-box {
				flex-grow: 1;
				overflow-y: auto;
				border-top: 1px solid #ddd;
				padding: 15px;
				background-color: #f9f9f9;
				font-size: 14px;
			}
			.input-group {
				display: flex;
				border-top: 1px solid #ddd;
				background-color: #fff;
				padding: 10px;
				box-sizing: border-box;
			}
			.input-group input {
				flex: 1;
				padding: 12px;
				border: none;
				border-radius: 0;
				font-size: 14px;
			}
			.input-group button {
				padding: 12px;
				background-color: #007bff;
				border: none;
				color: white;
				cursor: pointer;
				border-radius: 0;
				font-size: 14px;
			}
			.user-message {
				text-align: right;
				margin-bottom: 10px;
			}
			.bot-message {
				text-align: left;
				margin-bottom: 10px;
			}
		</style>
		<button type="button" class="material-symbols-outlined chatbot-button" onclick="toggleChat()">💬</button>

		<!-- 챗봇 팝업 -->
		<div class="chatbot-container" id="chatbot-container">
			<div class="chatbot-header" onclick="toggleChat()">Chatbot</div>
			<div class="chat-container">
				<div class="chat-box" id="chat-box"></div>
				<div class="input-group">
					<input type="text" id="user-input" placeholder="Type a message..." onkeypress="checkEnter(event)">
					<button onclick="sendMessage()">Send</button>
				</div>
			</div>
		</div>
  		<hr style="width: 100%">
  		<footer>
  			COPYRIGHT(C) 2023 <a href="https://github.com/seoyounglee0105/green_airline_project">GREAN AIRLINES</a>. ALL RIGHTS RESERVED.
		</footer>

		<!-- 챗봇 관련 스크립트 -->
		<script>
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
		
					// 서버에 메시지 보내기
					fetch('http://localhost:5000/get_response', {
						mode: 'cors',
 						credentials: 'include',
						method: 'POST',
						headers: {
							'Content-Type': 'application/x-www-form-urlencoded',
						},
						body: 'message=' + encodeURIComponent(userInput)
					})
					.then(response => response.json())  // 수정된 부분
					.then(data => {
						var botMessage = "<div class='bot-message'><strong>Bot:</strong> " + data.response + "</div>";
						chatBox.innerHTML += botMessage;
						chatBox.scrollTop = chatBox.scrollHeight;
					})
					.catch(error => console.error('Error:', error));  // 오류 처리 추가
		
					document.getElementById('user-input').value = '';
				}
			}
		
			function checkEnter(event) {
				if (event.key === 'Enter') {
					event.preventDefault(); // 기본 Enter 키 동작 방지
					sendMessage();
				}
			}
		</script>
</div>
</body>
</html></html>
