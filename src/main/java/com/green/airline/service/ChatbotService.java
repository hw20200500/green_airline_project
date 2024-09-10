package com.green.airline.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.green.airline.dto.ChatRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class ChatbotService {

    private final ObjectMapper objectMapper;

    public String sendToFlask(String result) throws JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String param = objectMapper.writeValueAsString(result);
        HttpEntity<String> entity = new HttpEntity<>(param, headers);

        String url = "http://localhost:5000/get_response";

        // Flask 서버에서 이중으로 인코딩된 JSON 문자열을 받아옴
        String flaskResponse = restTemplate.postForObject(url, entity, String.class);

        // 받은 응답을 다시 파싱 (이중 인코딩 해제)
        JsonNode jsonNode = objectMapper.readTree(flaskResponse);
        String responseString = jsonNode.get("response").asText();  // 이중 인코딩된 부분을 문자열로 받음

        // 이 문자열을 다시 한 번 JSON으로 변환하여 최종 메시지 추출
        JsonNode finalResponse = objectMapper.readTree(responseString);
        return finalResponse.get("message").asText();
    }
}