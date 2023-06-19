![로고2](https://github.com/seoyounglee0105/green_airline_project/assets/106488607/45885ada-932d-4640-93a8-4a84d451bb9c)




<br>

## 🚀 프로젝트 개요
- *모든 팀원이 풀스택으로 개발에 참여했으며, 주 포지션은 아래와 같습니다.*
<br>

|   Name   | 이서영 | 강민정 | 이치승 | 정다운 
| :------: | --- | --- | --- | --- |
| Position | 팀장 & 예약 기능 | 여행준비 기능 | 여행일지 기능 | 마일리지 기능 | Backend & UI |

- 프로젝트 기간 : 2023년 5월 15일 ~ 2023년 6월 7일
- 시연 영상 (유튜브) : https://youtu.be/TZmGoEAzEio

<br> 

## 🎮 기술 스택

### ✨ Front-End

<details>
    <summary>⚡️ FE 자세히 살펴보기</summary>
    <br>
    <ul>
        <li>bootstrap : 4.6.2 </li>
        <li>HTML5 </li>
        <li>CSS3 </li>
        <li>JavaScript : 1.16.1 </li>
        <li>JQuery : 3.6.4 </li>
        <li>Chart.js </li>
        <li>summernote : 0.8.18 </li>
    </ul>
</details>

  <br>

### 💻 Back-End

<details>
      <summary>⚡️ BE 자세히 살펴보기</summary>
      <br>
      <ul>
          <li>springboot : 4.18.0 </li>
          <li>H2 Database → MySQL : 8.0.32 </li>
          <li>jdk : 11.0.17 </li>
          <li>lombok </li>
          <li>MyBatis </li>
          <li>JSP </li>
          <li>BCrypt HASH </li>
          <li>Apache Tomcat : 9.0 </li>
      </ul>
  </details>
  
  <br>
  
### 🛠 외부 API

<details>
      <summary>⚡️ API 자세히 살펴보기</summary>
      <br>
      <ul>
          <li>카카오 소셜 로그인 API (OAuth 2.0 프로토콜)</li>
          <li>카카오페이 API</li>
          <li>이메일 전송 API (네이버 SMTP 프로토콜)</li>
          <li>구글 맵 API</li>
          <li>CoolSMS API</li>
          <li>DAUM 우편번호 찾기 API</li>
          <li>국가 코드 OPEN API</li>
      </ul>
</details>

  <br>

### 🙌🏻 Collaboration
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=Jira&logoColor=white"/> <img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=flat&logo=Slack&logoColor=white"/> <img src="https://img.shields.io/badge/Github-181717?style=flat&logo=Github&logoColor=white"/> <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Chart.js-FF6384?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Eclipse-2C2255?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Jira-0052CC?style=flat&logo=Notion&logoColor=white"/> <br><img src="https://img.shields.io/badge/JQuery-0769AD?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Gradle-02303A?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Tomcat-F8DC75?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=Notion&logoColor=white"/>


<br>

## ⚙ 의존성
```java
implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
implementation 'javax.servlet:jstl'
implementation 'org.springframework.boot:spring-boot-starter-aop'
implementation 'org.springframework.boot:spring-boot-starter-validation'
implementation 'org.springframework.boot:spring-boot-starter-web'
implementation 'org.springframework.security:spring-security-crypto'
compileOnly 'org.projectlombok:lombok'
developmentOnly 'org.springframework.boot:spring-boot-devtools'
implementation 'org.mybatis.spring.boot:mybatis-spring-boot-starter:2.3.0'
runtimeOnly 'com.mysql:mysql-connector-j'
annotationProcessor 'org.projectlombok:lombok'
testImplementation 'org.springframework.boot:spring-boot-starter-test'
implementation 'org.springframework.boot:spring-boot-starter-mail'
implementation 'org.springframework:spring-context-support'
implementation group: 'net.nurigo', name: 'javaSDK', version: '2.2'
implementation 'commons-io:commons-io:2.6'
implementation 'com.google.code.gson:gson:2.8.6'
implementation 'commons-fileupload:commons-fileupload:1.3.1'
```

<br>
<br>

## 1️⃣ 프로젝트 구조

<details>
    <summary>⚡️ 구조 자세히 살펴보기</summary>
    
    📦src
     ┗ 📂main
       ┣ 📂java
       ┃ ┗ 📂com
       ┃   ┗ 📂green
       ┃     ┗ 📂airline
       ┃       ┃ ┣ 📂config
       ┃       ┃ ┗ 📂controller
       ┃       ┣ 📂dto
       ┃       ┃ ┣ 📂kakao
       ┃       ┃ ┣ 📂nation
       ┃       ┃ ┣ 📂request
       ┃       ┃ ┗ 📂response
       ┃       ┣ 📂enums
       ┃       ┣ 📂handler
       ┃       ┃ ┗ 📂exception
       ┃       ┣ 📂repository
       ┃       ┃ ┣ 📂interfaces
       ┃       ┃ ┗ 📂model
       ┃       ┣ 📂service
       ┃       ┗ 📂utils
       ┣ 📂resources
       ┃ ┣ 📂db
       ┃ ┣ 📂mapper
       ┃ ┗ 📂static
       ┃   ┣ 📂css
       ┃   ┃ ┗ 📂summerNote
       ┃   ┃   ┗ 📂font
       ┃   ┣ 📂images
       ┃   ┃ ┣ 📂airplane
       ┃   ┃ ┣ 📂baggage
       ┃   ┃ ┣ 📂board
       ┃   ┃ ┣ 📂gifticon
       ┃   ┃ ┣ 📂in_flight
       ┃   ┃ ┣ 📂like
       ┃   ┃ ┣ 📂product
       ┃   ┃ ┗ 📂ticket
       ┃   ┗ 📂js
       ┃     ┗ 📂summerNote
       ┃       ┗ 📂lang
       ┗ 📂webapp
         ┗ 📂WEB-INF
           ┗ 📂view
             ┣ 📂baggage
             ┣ 📂board
             ┣ 📂faq
             ┣ 📂in_flight
             ┣ 📂layout
             ┣ 📂manager
             ┣ 📂mileage
             ┣ 📂myPage
             ┣ 📂notice
             ┣ 📂ticket
             ┣ 📂user
             ┗ 📂voc

    
</details>
    
<br>

## 2️⃣ 프로젝트 개요

* 핵심 기능이 많으며 실무에서 활용할 수 있는 기능이 포함된 것들 중, 예약, 환불, 외부 API를 활용할 수 있는 항공권 예약 사이트로 주제 선정
* 현행 시스템 벤치마킹 (아시아나 항공, 대한 항공 등)

<br>

## 3️⃣ 기능 구분

#### Member

* 소셜 로그인 API, 항공권 예매 기능, 결제 및 환불 API
* 기내 서비스 조회 기능, 서비스 신청 기능, 여행일지 조회 기능
* 구글 맵 API, 마일리지 숍 구매 기능, 네이버 이메일 SMTP 프로토콜

#### Manager
* 대시보드 조회, 회원관리, 항공권 관리 및 조회, 서비스 신청 관리 및 조회
* 여행일지 관리 및 조회, 마일리지 숍 관리 및 조회, 고객센터 관리 및 조회

<br>

## 4️⃣ ERD & 테이블 명세서
테이블 명세서 : https://docs.google.com/spreadsheets/d/1oaUxJ4CWKrVUvi02h9mYOwBL-raDCLswAQ5Qllws7Xw/edit#gid=0

<br>
<br>

![ERD Model](https://github.com/seoyounglee0105/green_airline_project/assets/124985978/3dc47f53-61da-4115-9644-3d19a8e3f185)


<br>
<br>


## 5️⃣ SiteMap
<br>

<table>
<tr>
 <td>User</td>
 <td>Manager</td>
 </tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/872e19cf-262f-48aa-bd3a-338e88208be6"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/faa63d99-e44c-49d5-adf1-66d1dff62262"></td>
</tr>
</table>

<br>

## 6️⃣ 주요 기능

#### 항공권 예약 - 스케줄 선택
- 왕복/편도 선택
- 출발지/도착지 입력 시 자동 완성 기능 제공
- 전체 공항 조회
- 탑승일 선택
- 탑승 인원 선택 (성인/유아/소아)
- 좌석 등급 선택
- 나이 계산기
- 옵션 선택 후, 스케줄 출력 (잔여 n석, 매진, 미운영)

#### 항공권 예약 - 좌석 선택
- 선택한 스케줄에 운항하는 항공기의 종류에 따라 좌석 배치가 다르게 나타남
- 선택한 좌석 등급이 아닌 좌석 선택 불가능
- 예약되지 않은 좌석만 선택 가능
- 운항시간, 국내선/국제선, 탑승객 유형, 좌석 등급에 따라 가격 계산

#### 항공권 예약 - 결제
- 탑승객 정보 입력
- 카카오페이 또는 마일리지로 결제 가능
- 결제 완료 시 문자 발송 (CoolSMS API)
- 회원 등급에 따른 적립 비율로 적립 예정 마일리지 추가
- 적립된 마일리지는 탑승일 다음 날부터 사용 가능

#### 항공권 환불
- 탑승일 이전인 경우 환불 신청 가능
- 환불 수수료 부과 (국제선/국내선, 탑승일까지 며칠 이전인지에 따라 결정됨)

#### 마일리지샵 구매
- 정렬 기능 (가격 높은 순, 가격 낮은 순)
- 페이징 처리
- 검색 기능 (브랜드, 상품명)
- 상품별 재고량 부여
- 구매 시 이메일로 기프티콘 이미지 발송
- 기프티콘 유효기간 1년 부여
- 마일리지샵 이용 내역 페이지에서 환불 가능

<br>

<table>
<tr>
  <td>항공권 예약/환불 (카카오페이)</td>
  <td>마일리지샵 구매 (이메일 SMTP)</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/1cd653da-4adf-4cd9-a653-24aed68336c2/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/8021f046-485e-486f-9862-15098df8aa41/img.gif"></td>
</tr>
</table>

<br>

## 7️⃣ 기능 - 회원

#### 회원가입
- 아이디 중복 확인
- 비밀번호 확인 
- Validation 처리
- 주소 찾기 (DAUM 우편번호 찾기 API)
- 국적 선택 (국가 코드 오픈 API)

#### 로그인
- 카카오 소셜 로그인 (OAuth 2.0 프로토콜)
- 일반 로그인
- 아이디/비밀번호 찾기 (이메일 SMTP 프로토콜)

#### 회원 정보
- 회원 정보 변경
- 비밀번호 변경

#### 예약 이후 서비스
- 노선에 따라 제공받을 수 있는 기내 서비스 조회
- 특별 기내식 조회 및 신청
- 위탁 수하물 조회 및 신청

#### 여행일지
- 게시글 CRUD
- 조회수 & 좋아요 수에 기반한 인기 게시글 선정
- MODAL을 이용한 게시글 상세 내용 출력
- 조회수 중복 방지 (쿠키 활용)
- 로그인 시에만 좋아요 버튼 활성화
- 페이징 처리

#### 공항 위치 조회
- 구글 맵 API 활용

#### 마일리지
- 마일리지샵 구매/환불
- 마일리지 조회
- 누적 탑승 마일리지에 따라 회원 등급 변동

#### 고객센터
- 공지사항 조회
- 자주 묻는 질문 조회
- 고객의 말씀 작성

<br>

<table>
<tr>
  <td>메인</td>
  <td>회원 안내</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/3ea6b895-9579-47b6-a423-fbfcfb58833d"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/f46b7412-65ce-44f3-a84b-6e192ecc30e6"></td>
</tr>
<tr>
  <td>카카오 소셜 로그인</td>
  <td>비밀번호 찾기 (이메일 SMTP)</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/8b4dbb54-cb86-4e52-9b80-9795dc45cfd1/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/fac17342-cb00-4329-8f1f-06a7d4fa94f8/img.gif"></td>
</tr>
<tr>
  <td>비밀번호 변경</td>
  <td>회원 정보 변경</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/65af6941-116b-443b-bf6a-022582240feb/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/9fa448ae-b9d3-44d2-82e6-e0b535ad7033a/img.gif"></td>
</tr>
<tr>
  <td>항공권 예약/환불 (카카오페이)</td>
  <td>항공권 예약/환불 (마일리지)</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/1cd653da-4adf-4cd9-a653-24aed68336c2/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/8295e81a-39ec-4d1f-b1f4-04bf66ff3289/img.gif"></td>
</tr>
<tr>
  <td>기내 서비스 조회</td>
  <td>위탁 수하물 신청</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/79470ee8-9b6d-42e3-877b-5b8e07bd3f84/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/c07b2977-7795-47e1-b2ba-b796f8d009ef/img.gif"></td>
</tr>
<tr>
  <td>특별 기내식 조회</td>
  <td>특별 기내식 신청</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/d075854e-8ebc-46ce-b78a-1fa218e5fd9c/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/dc56d0aa-5aff-4b47-963c-df326b674579/img.gif"></td>
</tr>
<tr>
  <td>여행일지</td>
  <td>공항 위치 정보 (구글 맵 API)</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/f5aab43f-dee4-4d17-838f-33668411aeaa/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/519cd0ca-d90a-4ed7-8fb2-e3d16f0ad3f2/img.gif"></td>
</tr>
<tr>
  <td>항공기 정보</td>
  <td>마일리지샵 구매 (이메일 SMTP)</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/3b1067de-58a7-478f-8576-fc91744a300d/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/8021f046-485e-486f-9862-15098df8aa41/img.gif"></td>
</tr>
<tr>
  <td>마일리지샵 환불</td>
  <td>공지사항</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/94235af1-5a2c-4fdd-9673-7aa45bd78b13/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/14721b13-882e-411b-b08a-00f1e11cbbc6/img.gif"></td>
</tr>
<tr>
  <td>자주 묻는 질문</td>
  <td>고객의 말씀 작성</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/3caecebf-071d-44c8-b5a2-bec30083b58c/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/ea38a3f9-cdae-42e6-8f3e-469970e2bdeb/img.gif"></td>
 </tr>
</table>

<br>

## 8️⃣ 기능 - 관리자

#### 대시보드
- chart.js 활용
- 이번 달 매출액, 신규 회원 수, 탈퇴 회원 수, 작성된 고객의 말씀 수
- 항공권 판매 매출액 추이 (지난 11개월 간)
- 도착지별 이용객 수 순위
- 마일리지샵 브랜드별 판매 순위
- 지난 달 고객의 말씀 유형 비율 (문의/불만/칭찬/건의)
- 처리되지 않은 고객의 말씀 알림
- 개인 메모 공간

#### 회원 관리
- 회원/관리자 정보 조회 (검색 기능, 페이징 처리)
- 회원 탈퇴 처리
- 신규 관리자 등록

#### 항공 서비스
- 운항 스케줄 조회
- 항공권 판매/환불 내역 조회
- 특별 기내식 신청 내역 조회
- 위탁 수하물 신청 내역 조회

#### 마일리지샵
- 상품 CRUD
- 상품 판매/환불 내역 조회

#### 게시판 관리
- 모든 게시글 삭제 가능

#### 고객센터
- 공지사항 CRUD
- 자주 묻는 질문 CRUD
- 고객의 말씀 답변

<br>

<table>
<tr>
  <td>대시보드</td>
  <td>회원 정보 조회</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/a5dd6d2d-c462-476b-90d9-86e759df94e9" width="445"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/15547ecc-167f-4a2a-b87c-4462ecce1f43/img.gif"></td>
</tr>
<tr>
  <td>관리자 정보 조회</td>
  <td>마일리지샵 상품 등록</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/df7e0db1-de86-46cf-9c55-4ef402f77680/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/80afc88c-6ba2-4107-8a18-62bf118546df/img.gif"></td>
</tr>
<tr>
  <td>마일리지샵 이용 내역 조회</td>
  <td>공지사항 작성</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/28eb301d-1af1-4498-9a3b-2bd168987e39/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/7bea7e6a-0fab-4082-b406-446702474c90/img.gif"></td>
</tr>
<tr>
  <td>자주 묻는 질문 작성</td>
  <td>고객의 말씀 답변</td>
</tr>
<tr>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/f8fce7d1-ab33-4d66-b7d1-c4b03c7c94a0/img.gif"></td>
  <td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/b0c45e0b-c09e-4473-8605-500392a60542/img.gif"></td>
</tr>
</table>
