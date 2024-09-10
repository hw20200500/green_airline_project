package com.green.airline.controller;

import com.green.airline.dto.ChatRequest;
import com.green.airline.service.ChatbotService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/chat")
public class ChatbotController {

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();  
    @PostMapping
    public ResponseEntity<String> handleChatbotMessage(@RequestBody String userMessage) {
        // Flask 서버로 POST 요청
        String flaskUrl = "http://localhost:5000/get_response";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        

        HttpEntity<String> request = new HttpEntity<>(userMessage, headers);

        try {
            // Flask 서버에서 응답 받기
            ResponseEntity<String> response = restTemplate.postForEntity(flaskUrl, request, String.class);
         // 응답에서 'response' 필드의 값 추출
            JsonNode rootNode = objectMapper.readTree(response.getBody());
            String chatbotResponse = rootNode.path("response").asText();
            System.out.println("chatbot response::"+chatbotResponse);
            // 응답 내용 반환
            return ResponseEntity.ok(chatbotResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error communicating with Flask server");
        }
    }

}