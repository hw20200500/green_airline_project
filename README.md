![로고2](https://github.com/seoyounglee0105/green_airline_project/assets/106488607/c91d95d8-6242-426e-a494-82a6a4d2806b)


<br>
## [👋 프로젝트 소개 README](https://github.com/seoyounglee0105/green_airline_project/wiki)


## [👋 프로젝트 소개 README](https://github.com/seoyounglee0105/green_airline_project/wiki/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%86%8C%EA%B0%9C-README)
<br>

## 1️⃣ 프로젝트 구조

```bash
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

```

<br>

## 2️⃣ 프로젝트 개요

<br>

* 핵심 기능이 많은 프로젝트를 고민하다 예약, 환불, 외부 API를 활용할 수 있는
* 항공권 예약 사이트 선정
* 현행 시스템(아시아나 항공, 대한 항공 벤치마킹)

# 기능 구분
### Member

* 소셜 로그인 API, 항공권 예매 기능, 결제 및 환불 API
* 기내 서비스 조회 기능, 서비스 신청 기능, 여행일지 조회 기능
* 구글 맵 API, 마일리지 숍 구매 기능, 네이버 이메일 SMTP 프로토콜

### Manager
* 대시보드 조회, 회원관리, 항공권 관리 및 조회, 서비스 신청 관리 및 조회
* 여행일지 관리 및 조회, 마일리지 숍 관리 및 조회, 고객센터 관리 및 조회


<br>

## 3️⃣ ERD & 테이블 명세서
테이블 명세서 : https://docs.google.com/spreadsheets/d/1oaUxJ4CWKrVUvi02h9mYOwBL-raDCLswAQ5Qllws7Xw/edit#gid=0

<br>
<br>

![ERD Model](https://github.com/seoyounglee0105/green_airline_project/assets/124985978/3dc47f53-61da-4115-9644-3d19a8e3f185)


<br>
<br>


## 4️⃣ SiteMap
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


## 5️⃣ 기능 - 회원
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
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/2dc43728-7f23-4543-94af-499a3ff0488f/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/0241460a-590b-4b0a-9b68-f32060f35c3b/img.gif"></td>
</tr>
<tr>
<td>비밀번호 변경</td>
<td>회원 정보 수정</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/57aa57a1-5e06-4dcc-a13f-996f09ace185/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/34c2060f-4cd2-4fc2-a213-64a64caa37ac/img.gif"></td>
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
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/b023ac0d-4eb7-4030-9793-9e34227743db/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/b325c105-f003-4543-aab1-f8999009a45e/img.gif"></td>
</tr>
<tr>
<td>특별 기내식 조회</td>
<td>특별 기내식 신청</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/f4234400-5ef8-49f0-b745-ce240790f4ea/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/eb117207-0638-4f19-b554-4a8f4a493acc/img.gif"></td>
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
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/31340929-d457-4c13-8ce5-8492e6ff9161/img.gif"></td>
</tr>
<tr>
<td>자주 묻는 질문</td>
<td>고객의 말씀 작성</td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/87c550e3-c8dc-448f-a171-1c50740659b2/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/106488607/ea38a3f9-cdae-42e6-8f3e-469970e2bdeb/img.gif"></td>
</tr>
<tr>
<td>회원 탈퇴</td>
<td></td>
</tr>
<tr>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/cd5e6864-95ae-4632-8c88-b7182ecabe41/img.gif"></td>
<td><img src="/img.gif"></td>
</tr>
</table>


## 6️⃣ 기능 - 관리자
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
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/c46fc3b8-b504-4c4d-86b9-337024528a99/img.gif"></td>
<td><img src="https://github.com/seoyounglee0105/green_airline_project/assets/105858187/a12c98ea-9413-4fdb-8e52-c396839731ca/img.gif"></td>
</tr>
</table>
