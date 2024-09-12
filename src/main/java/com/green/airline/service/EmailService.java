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
import javax.mail.internet.MimeMessage.RecipientType;

import org.apache.struts.taglib.html.ImgTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.MailException;
import org.springframework.mail.MailMessage;
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

   // 기프티콘 발송 메서드
   public MimeMessage createMessage(String to, String gifticonImageName)
         throws MessagingException, UnsupportedEncodingException, IOException {
      MimeMessage message = emailsender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
      
      // 수신자와 발신자 설정
      helper.setTo(to); // 받는 사람
      helper.setFrom(new InternetAddress("ekdns8276@naver.com", "그린항공")); // 발신자 명시

      helper.setSubject("그린항공 기프티콘샵");// 제목
      
      String imagePath = "C:\\upload" + gifticonImageName;
      File imageFile = new File(imagePath);
      if (imageFile.exists()) {
         String imageDataUri = getImageDataUri(imagePath);
         String imageTag = "<img src='" + imageDataUri + "' alt='이미지' style=width:500px; height:500px;>";
         
         String htmlContent = "<div>";
         htmlContent += "<h1>안녕하세요</h1>";
         htmlContent += "<h1>그린항공입니다</h1>";
         htmlContent += "<br>";
         htmlContent += "<p>구입하신 상품의 기프티콘입니다.</p>";
         htmlContent += "<br>";
         htmlContent += "<div style='font-family:verdana;'>";
         htmlContent += "<div style='font-size:130%'>";
         htmlContent += imageTag;
         htmlContent += "</div>";
         
         helper.setText(htmlContent, true); // HTML로 메일 내용 설정
      }

      return message;
   }

   // 비밀번호 찾기 이메일 발송 메서드
   public MimeMessage createPwCode(String to) throws MessagingException, UnsupportedEncodingException, IOException {
      MimeMessage message = emailsender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
      
      // 수신자와 발신자 설정
      helper.setTo(to); // 받는 사람
      helper.setFrom(new InternetAddress("loobis200172@naver.com", "그린항공")); // 발신자 명시

      helper.setSubject("그린항공 비밀번호 찾기 이메일 인증");// 제목

      String htmlContent = "<div style='margin:30px; border: 1px solid #ccc; padding:50px;width:500px; '>";
      htmlContent += "<h1>GREEN AIRlines 이메일 인증 안내</h1>";
      htmlContent += "<br>";
      htmlContent += "<p>'비밀번호 찾기'를 위해 이메일 인증을 진행합니다.</p>";
      htmlContent += "<p>아래 발급된 이메일 인증번호를 복사하거나 직접 입력하여 인증을 완료해주세요.</p>";
      htmlContent += "<h3>회원가입 인증 코드입니다.</h3>";
      htmlContent += "<p style='color:blue;font-weight: bold;'>" + ePw + "</p>";
      htmlContent += "<div style='font-size:130%'></div>";

      helper.setText(htmlContent, true); // HTML로 메일 내용 설정

      return message;
   }

   // 랜덤 인증 코드 생성 메서드
   public String createKey() {
      StringBuffer key = new StringBuffer();
      Random rnd = new Random();

      for (int i = 0; i < 8; i++) {
         int index = rnd.nextInt(3); 
         switch (index) {
         case 0:
            key.append((char) ((rnd.nextInt(26)) + 97)); // a~z
            break;
         case 1:
            key.append((char) ((rnd.nextInt(26)) + 65)); // A~Z
            break;
         case 2:
            key.append((rnd.nextInt(10))); // 0~9
            break;
         }
      }

      return key.toString();
   }

   // 이메일 발송 메서드
   public String sendSimpleMessage(String to, String gifticonImageName) throws Exception {
      ePw = createKey(); // 랜덤 인증번호 생성
      MimeMessage message = createMessage(to, gifticonImageName); // 메일 생성
      try {
         emailsender.send(message); // 메일 발송
      } catch (MailException es) {
         es.printStackTrace();
         throw new IllegalArgumentException();
      }

      return ePw; // 인증 코드 반환
   }

   // 비밀번호 찾기 이메일 발송
   public String sendPwCodeMessage(String to) throws Exception {
      ePw = createKey(); // 랜덤 인증번호 생성
      MimeMessage message = createPwCode(to); // 메일 생성
      try {
         emailsender.send(message); // 메일 발송
      } catch (MailException es) {
         es.printStackTrace();
         throw new IllegalArgumentException();
      }

      return ePw; // 인증 코드 반환
   }
}
