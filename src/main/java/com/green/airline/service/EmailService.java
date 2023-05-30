package com.green.airline.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.util.Base64;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    JavaMailSender emailsender;

    private String ePw; // 인증번호

 // 이미지 파일을 Base64 인코딩하여 데이터 URI로 변환하는 메서드
    private String getImageDataUri(String imagePath) throws IOException {
        File imageFile = new File(imagePath);
        if (!imageFile.exists()) {
            return null;
        }

        byte[] imageBytes = Files.readAllBytes(imageFile.toPath());
        String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
        String mimeType = Files.probeContentType(imageFile.toPath());

        return "data:" + mimeType + ";base64," + imageBase64;
    }

    public MimeMessage createMessage(String to,String gifticonImageName) throws MessagingException, UnsupportedEncodingException, IOException {
    	System.out.println("gifticonImageName : " + gifticonImageName);
        MimeMessage message = emailsender.createMimeMessage();
        to = "ekdns8276@naver.com";
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        // 집에서 사용
        // String imagePath = "C:\\Users\\a\\Desktop\\image/"+gifticonImageName;
        String imagePath = "C:\\Users\\GGG\\Desktop\\image/"+gifticonImageName;
        File imageFile = new File(imagePath);
        helper.setTo(to);
        helper.setSubject("GREEN AIR 항공 마일리지몰");
        if (imageFile.exists()) {
            try {
            	String imageDataUri = getImageDataUri(imagePath);
                String imageTag = "<img src='" + imageDataUri + "' alt='이미지'>";
                String imageCid = "image_cid";
                // 이미지를 인라인으로 첨부 (Content-ID 설정)
                helper.addInline(imageCid, new ByteArrayResource(Files.readAllBytes(imageFile.toPath())), "image/png");
                // HTML 내용 작성
                String htmlContent = "<div style='margin:100px;'>";
                htmlContent += "<h1>안녕하세요</h1>";
                htmlContent += "<h1>GREEN AIR 항공입니다</h1>";
                htmlContent += "<br>";
                htmlContent += "<p>구입하신 상품의 기프티콘입니다.</p>";
                htmlContent += "<br>";
                htmlContent += "<div align='center' style='border:1px solid black; font-family:verdana;'>";
                htmlContent += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
                htmlContent += "<div style='font-size:130%'>";
                htmlContent += ePw + "</strong><div><br/> ";
                htmlContent += "</div>";
                message.setContent(htmlContent, "text/html; charset=UTF-8");
                helper.setFrom(new InternetAddress("ekdns8276@naver.com", "GREEN AIR"));
                helper.setText(htmlContent, true);
            } catch (MessagingException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return message;
    }
    public MimeMessage createPwCode(String to) throws MessagingException, UnsupportedEncodingException, IOException {
        MimeMessage message = emailsender.createMimeMessage();
        to = "ekdns8276@naver.com";
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        // 집에서 사용
        // String imagePath = "C:\\Users\\a\\Desktop\\image/"+gifticonImageName;
        helper.setTo(to);
        helper.setSubject("GREEN AIR 항공 마일리지몰");
            try {
                String imageCid = "image_cid";
                // 이미지를 인라인으로 첨부 (Content-ID 설정)
                // HTML 내용 작성
                String htmlContent = "<div style='margin:100px;'>";
                htmlContent += "<h1>안녕하세요</h1>";
                htmlContent += "<h1>GREEN AIR 항공입니다</h1>";
                htmlContent += "<br>";
                htmlContent += "<p>구입하신 상품의 기프티콘입니다.</p>";
                htmlContent += "<br>";
                htmlContent += "<div align='center' style='border:1px solid black; font-family:verdana;'>";
                htmlContent += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
                htmlContent += "<p>" + ePw + "</P>";
                htmlContent += "<div style='font-size:130%'>";
                htmlContent += "</div>";
                message.setContent(htmlContent, "text/html; charset=UTF-8");
                helper.setFrom(new InternetAddress("ekdns8276@naver.com", "GREEN AIR"));
                helper.setText(htmlContent, true);
            } catch (MessagingException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
			return message;
    }
    // 랜덤 인증 코드 전송
    public String createKey() {
        StringBuffer key = new StringBuffer();
        Random rnd = new Random();

        for (int i = 0; i < 8; i++) { // 인증코드 8자리
            int index = rnd.nextInt(3); // 0~2 까지 랜덤, rnd 값에 따라서 아래 switch 문이 실행됨

            switch (index) {
                case 0:
                    key.append((char) ((int) (rnd.nextInt(26)) + 97));
                    // a~z (ex. 1+97=98 => (char)98 = 'b')
                    break;
                case 1:
                    key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    // A~Z
                    break;
                case 2:
                    key.append((rnd.nextInt(10)));
                    // 0~9
                    break;
            }
        }

        return key.toString();
    }

    // 메일 발송
    // sendSimpleMessage 의 매개변수로 들어온 to 는 곧 이메일 주소가 되고,
    // MimeMessage 객체 안에 내가 전송할 메일의 내용을 담는다.
    // 그리고 bean 으로 등록해둔 javaMail 객체를 사용해서 이메일 send!!

    public String sendSimpleMessage(String to, String gifticonImageName) throws Exception {
    	
        ePw = createKey(); // 랜덤 인증번호 생성

        MimeMessage message = createPwCode(to); // 메일 발송
        try {// 예외처리
            emailsender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }

        return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
    }
    // 비번 찾기 할 때 이메일로 코드 전
public String sendPwCodeMessage(String to ) throws Exception {
    	
        ePw = createKey(); // 랜덤 인증번호 생성

        MimeMessage message = createPwCode(to); // 메일 발송
        try {// 예외처리
            emailsender.send(message);
        } catch (MailException es) {
            es.printStackTrace();
            throw new IllegalArgumentException();
        }

        return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
    }
    
}