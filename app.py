import os
import subprocess

import pymysql
from flask import Flask, jsonify, render_template, render_template_string, request
from flask_cors import CORS  # 추가된 부분

app = Flask(__name__)
CORS(app, supports_credentials=True)  # CORS 설정


# 간단한 챗봇 응답 함수
def chatbot_response(user_input):
    con = pymysql.connect(
        host="127.0.0.1",
        user="root",
        password="123123",
        db="airline_db",
        charset="utf8",
    )
    cur = con.cursor()
    # 간단한 질문에 대한 응답

    if any(keyword in user_input for keyword in ["hi", "안녕", "하이"]):
        response = "안녕하세요! 무엇을 도와드릴까요?"
    elif "만나서 반가워" in user_input:
        response = "저도 반가워요!"
    elif "날씨" in user_input:
        response = "오늘 날씨는 맑음입니다. 우산은 필요 없을 것 같아요!"
    elif "?" in user_input:
        response = "자주 묻는 질문 페이지를 확인해주세요!<br><a href='http://localhost/faq/faqLis'><cite>F&Q 페이지</cite></a>"
    elif any(keyword in user_input for keyword in ["환불", "ghksqnf"]):
        response = """<br>항공권 환불 페이지 입니다! <a href='http://localhost/ticket/list/1'><cite>항공권 환불</cite></a><br>
        기프티콘 환불 페이지 입니다! <a href='http://localhost/gifticon/list'><cite>기프티콘 환불</cite></a>
        """
    elif any(
        keyword in user_input
        for keyword in [
            "항공권",
            "예매",
            "항공",
            "예약",
            "gkdrhdrnjs",
            "dPao",
            "gkdrhd",
            "dPdir",
        ]
    ):
        response = ""
        sql = """SELECT rb.departure, rb.destination, sb.departure_date, sb.arrival_date 
                 FROM (route_tb as rb JOIN schedule_tb as sb ON rb.id = sb.id)
            """
        cur.execute(sql)
        rows = cur.fetchall()
        response = "현재 예약 가능한 항공권은 다음과 같습니다."
        for row in rows:
            출발지 = row[0]
            도착지 = row[1]
            출발시간 = row[2].strftime("%Y-%m-%d %H:%M")
            도착시간 = row[3].strftime("%Y-%m-%d %H:%M")
            response += f"<br>출발지: {출발지}<br>도착지: {도착지}<br>출발 시간: {출발시간}<br>도착 시간: {도착시간}<br>==============="

    elif any(
        keyword in user_input
        for keyword in ["기내 서비스", "서비스", "rlso tjqltm", "tjqltm", "service"]
    ):
        response = f"기내 서비스 정보를 찾고 계신가요? <br><a href='http://localhost/inFlightService/inFlightServiceSearch'><cite>기내 서비스 페이지</cite></a>"
    # 기내식 서비스 조회 -> DB 연동
    elif any(
        keyword in user_input
        for keyword in ["기내식", "유아식", "아동식", "종교식", "야채식", "특별식"]
    ):
        response = ""
        if any(keyword in user_input for keyword in ["유아", "아동", "아이"]):
            sql2 = (
                "SELECT name, description FROM in_flight_meal_detail_tb WHERE meal_id=2"
            )
            cur.execute(sql2)
            rows = cur.fetchall()
            response = "유아 및 아동들을 위한 기내식의 종류는 아래와 같습니다.<br>========================<br>"
            for i, (name, description) in enumerate(rows, 1):
                response += f"{i}. {name}<br>{description}<br><br>"

        elif "종교" in user_input:
            sql2 = (
                "SELECT name, description FROM in_flight_meal_detail_tb WHERE meal_id=5"
            )
            cur.execute(sql2)
            rows = cur.fetchall()
            response = "그린항공에는 종교적으로 못 먹는 탑승객들을 위한 종교식을 따로 제공하고 있습니다. 그린 항공의 종교식 종류는 아래와 같습니다.<br>========================<br>"
            for i, (name, description) in enumerate(rows, 1):
                response += f"{i}. {name}<br>{description}<br><br>"
        elif any(keyword in user_input for keyword in ["야채", "채소", "채식"]):
            sql2 = (
                "SELECT name, description FROM in_flight_meal_detail_tb WHERE meal_id=3"
            )
            cur.execute(sql2)
            rows = cur.fetchall()
            response = "그린항공에는 채식주의자들을 위한 야채식을 따로 제공하고 있습니다. 야채식 종류는 아래와 같습니다.<br>========================<br>"
            for i, (name, description) in enumerate(rows, 1):
                response += f"{i}. {name}<br>{description}<br><br>"
        else:
            sql = "SELECT name FROM in_flight_meal_tb"
            cur.execute(sql)
            rows = cur.fetchall()
            result = [row[0] for row in rows]
            response = f"그린항공의 기내식은 {', '.join(result)}이 있습니다."

    # 마일리지
    elif any(keyword in user_input for keyword in ["마일리지", "mileage", "akdlfflwl"]):
        if any(keyword in user_input for keyword in ["샵", "사용처", "shop", "tiq"]):
            response = (
                "마일리지는 해당 페이지에서 이용하실 수 있습니다.\n"
                + "<a href='http://localhost/product/productMain/clasic'><cite>마일리지샵</cite></a>"
            )
        else:
            response = "<br>마일리지 관련 정보입니다!<br>"
            sql = "SELECT name, rank_up_mileage FROM member_grade_tb"
            cur.execute(sql)
            rows = cur.fetchall()
            sorted_rows = sorted(rows, key=lambda x: x[1] if x[1] is not None else 0)

            for row in sorted_rows:
                grade = f"{row[1]:,}" if row[1] is not None else "0"
                response += f"<br>마일리지 등급: {row[0]}<br>승급 기준: {grade}<br>-------------------"

    else:
        # 파이썬 cmd 명령어 실행 및 출력 코드 :
        # subprocess.check_output('명령어', shell=True, stderr=subprocess.STDOUT, text=True)
        response = f"'{user_input}'에 대해서는 저도 모르겠어요.."  # 명령어 처리로 넘어가기 위해 None 반환
    con.close()
    return response


@app.route("/get_response", methods=["POST"])
def get_response():
    # os.system('ls')
    user_message = request.form["message"]

    # 매우 취약한 코드: 사용자 입력을 필터링 없이 템플릿으로 렌더링
    # 취약점: 사용자 입력을 필터링 없이 템플릿으로 렌더링
    bot_response = chatbot_response(
        render_template_string(user_message, subprocess=subprocess)
    )
    my_res = jsonify({"response": bot_response})
    return my_res


if __name__ == "__main__":
    app.run(debug=True)
