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

// // 이미지 파일을 Base64 인코딩하여 데이터 URI로 변환하는 메서드
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

   public MimeMessage createMessage(String to, String gifticonImageName)
         throws MessagingException, UnsupportedEncodingException, IOException {
      MimeMessage message = emailsender.createMimeMessage();
      message.addRecipients(RecipientType.TO, to);// 보내는 대상
      message.setSubject("그린항공 기프티콘샵");// 제목
      to = "ljh3364@naver.com";
      MimeMessageHelper helper = new MimeMessageHelper(message, true);
      String imagePath = "C:\\upload" + gifticonImageName;
      File imageFile = new File(imagePath);
      if (imageFile.exists()) {
         try {
            String imageDataUri = getImageDataUri(imagePath);
            String imageTag = "<img src='" + imageDataUri + "' alt='이미지' style=width:500px; height:500px;>";
            String imageCid = "image_cid";
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

            message.setText(htmlContent, "utf-8", "html");// 내용, charset 타입, subtype
            // 보내는 사람의 이메일 주소, 보내는 사람 이름
            message.setFrom(new InternetAddress("ekdns8276@naver.com", "그린항공"));// 보내는 사람
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
      message.addRecipients(RecipientType.TO, to);// 보내는 대상
      message.setSubject("그린항공 비밀번호 찾기 이메일 인증");// 제목
      to = "ljh3364@naver.com";
      MimeMessageHelper helper = new MimeMessageHelper(message, true);
//      String imagePath = "classpath:static/images/logo.jpg";
   // ClassPathResource를 사용하여 리소스 파일을 로드
      
//      File imageFile = new File(imagePath);
      try {
         
         String imageCid = "image_cid";
         // 이미지를 인라인으로 첨부 (Content-ID 설정)
      // 이미지 파일을 ClassPathResource로 불러오기
         ClassPathResource resource = new ClassPathResource("static/images/logo.jpg");

         // 파일이 존재하는지 확인
         File imageFile = resource.getFile();
         if (!imageFile.exists()) {
             System.out.println("파일 없음....");
         }
         helper.addAttachment("logo.jpg", new ByteArrayResource(Files.readAllBytes(imageFile.toPath())));
         helper.addInline("image", new ClassPathResource("/static/images/logo.jpg"));
         String imageTag = "<img src='cid:logo.jpg' alt='이미지' style='width:200px; height:200px;'>";
         // HTML 내용 작성
         String htmlContent = "<div style='margin:30px; border: 1px solid #ccc; padding:50px;width:500px; '>";
         htmlContent += imageTag + "<h1>GREEN AIRlines 이메일 인증 안내</h1>";
         htmlContent += "<br>";
         htmlContent += "<div  font-family:verdana;'>";
         htmlContent += "<p>" + "안녕하세요. 고객님" + "</p>";
         htmlContent += "<p>" + "'비밀번호 찾기'를 위해 이메일 인증을 진행합니다." + "</p>";
         htmlContent += "<p>" + "아래 발급된 이메일 인증번호를 복사하거나 직접 입력하여 인증을 완료해주세요." + "</p>";
         htmlContent += "<h3>회원가입 인증 코드입니다.</h3>";
         htmlContent += "<p style='color:blue;font-weight: bold;'>" + ePw + "</P>";
         htmlContent += "<div style='font-size:130%'>";
         htmlContent += "</div>";
         message.setText(htmlContent, "utf-8", "html");// 내용, charset 타입, subtype
         // 보내는 사람의 이메일 주소, 보내는 사람 이름
         message.setFrom(new InternetAddress("ljh3364@naver.com", "그린 항공"));// 보내는 사람
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

      MimeMessage message = createMessage(to, gifticonImageName); // 메일 발송
      try {// 예외처리
         emailsender.send(message);
      } catch (MailException es) {
         es.printStackTrace();
         throw new IllegalArgumentException();
      }

      return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
   }

   // 비번 찾기 할 때 이메일로 코드 전
   public String sendPwCodeMessage(String to) throws Exception {

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

   // 메일 내용 작성
   public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException {

      MimeMessage message = emailsender.createMimeMessage();

      message.addRecipients(RecipientType.TO, to);// 보내는 대상
      message.setSubject("GoodJob 회원가입 이메일 인증");// 제목

      String msgg = "";
      msgg += "<div style='margin:100px;'>";
      msgg += "<h1> 안녕하세요</h1>";
      msgg += "<h1> 통합 취업 정보 포탈 GoodJob 입니다</h1>";
      msgg += "<br>";
      msgg += "<p>아래 코드를 회원가입 창으로 돌아가 입력해주세요<p>";
      msgg += "<br>";
      msgg += "<p>항상 당신의 꿈을 응원합니다. 감사합니다!<p>";
      msgg += "<br>";
      msgg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
      msgg += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
      msgg += "<div style='font-size:130%'>";
      msgg += "CODE : <strong>";
      msgg += ePw + "</strong><div><br/> "; // 메일에 인증번호 넣기
      msgg += "</div>";
      message.setText(msgg, "utf-8", "html");// 내용, charset 타입, subtype
      // 보내는 사람의 이메일 주소, 보내는 사람 이름
      message.setFrom(new InternetAddress("ekdns8276@naver.com", "GoodJob_Admin"));// 보내는 사람

      return message;
   }

   // 랜덤 인증 코드 전송
   public String createKey1() {
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
   public String sendSimpleMessage1(String to) throws Exception {

      ePw = createKey(); // 랜덤 인증번호 생성

      // TODO Auto-generated method stub
      MimeMessage message = createMessage(to); // 메일 발송
      try {// 예외처리
         emailsender.send(message);
      } catch (MailException es) {
         es.printStackTrace();
         throw new IllegalArgumentException();
      }

      return ePw; // 메일로 보냈던 인증 코드를 서버로 반환
   }
}
