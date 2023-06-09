![logo](https://github.com/moon335/tenco_shop_project/assets/124985978/d5eca6a3-8cd6-4ea6-a4a7-5ebc1776fcfe)


<br>
## [👋 프로젝트 소개 README]
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
* Member
* 소셜 로그인 API, 항공권 예매 기능, 결제 및 환불 API
* 기내 서비스 조회 기능, 서비스 신청 기능, 여행일지 조회 기능
* 구글 맵 API, 마일리지 숍 구매 기능, 네이버 이메일 SMTP 프로토콜

* Manager
* 대시보드 조회, 회원관리, 항공권 관리 및 조회, 서비스 신청 관리 및 조회
* 여행일지 관리 및 조회, 마일리지 숍 관리 및 조회, 고객센터 관리 및 조회


<br>

## 3️⃣ ERD & 테이블 명세서
테이블 명세서 : https://docs.google.com/spreadsheets/d/1oaUxJ4CWKrVUvi02h9mYOwBL-raDCLswAQ5Qllws7Xw/edit#gid=0

<br>
<br>
![ERD Model](https://github.com/moon335/tenco_shop_project/assets/124985978/d588157c-bad1-4aa5-a4ae-c7286910af93)


<br>
<br>
## 4️⃣ SiteMap

<table>
<tr>
<td>User</td>
<td>Manager</td>
</tr>
<tr>
<td><img src="https://github.com/moon335/tenco_shop_project/assets/124985978/9349f65c-7f44-4e72-9452-de666038db3a"></td>
<td><img src="https://github.com/moon335/tenco_shop_project/assets/124985978/934db446-eec0-4f8d-bbcb-b34ec7a8e3a5"></td>
</tr>
</table>
