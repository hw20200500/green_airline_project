package com.green.airline.service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

/**
 * @author 서영
 * 문자 발송
 */
@Service
public class CoolSmsService {

	// 예약 성공 시 문자 발송
	@Transactional
	public void completeMessage(String tel, String name, String ticketId) {
		// 수신 전화번호, 이름 - member에서
		// 예약번호
		
		String apiKey = "NCSOVEBQAQL60IWF";
		String apiSecret = "RSSTXSIFJVEGDJPAJVUGR7VHRDTGADQO";
		
		Message message = new Message(apiKey, apiSecret);
		
		// 왕복이라면
		if (ticketId.length() == 9) {
			String t = ticketId.substring(0, 8);
			ticketId = t + "A, " + t + "B";
		}
		
		String text = name + "님, 항공권 예약이 완료되었습니다.\n예약번호 " + ticketId;
		
		HashMap<String, String> params = new HashMap<>();
		params.put("to", tel);
		params.put("from", "01037210730");
		params.put("type", "SMS");
		params.put("text", text);
		params.put("app_version", "test app 1.2");
		
		try {
			JSONObject obj = message.send(params);
			System.out.println(obj);
		} catch (CoolsmsException e) {
			e.printStackTrace();
		}
	}
	
	
}
