package com.green.airline.controller;

import com.green.airline.dto.ChatRequest;
import com.green.airline.service.ChatbotService;
import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ChatbotController {

    private final ChatbotService chatbotService;


    @PostMapping("/get_response")
    public String sendToFlask(@RequestBody ChatRequest dto) throws JsonProcessingException {
        return chatbotService.sendToFlask(dto);
    }
}