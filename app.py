import os
import subprocess

from flask import Flask, jsonify, render_template, render_template_string, request
from flask_cors import CORS  # 추가된 부분

app = Flask(__name__)
CORS(app, supports_credentials=True)  # CORS 설정


# 간단한 챗봇 응답 함수
def chatbot_response(user_input):
    # 간단한 질문에 대한 응답
    ticket_url = "http://localhost/ticket/selectSchedule"

    if "안녕" in user_input:
        return "안녕하세요! 무엇을 도와드릴까요?"
    elif "만나서 반가워" in user_input:
        return "저도 반가워요!"
    elif "날씨" in user_input:
        return "오늘 날씨는 맑음입니다. 우산은 필요 없을 것 같아요!"
    elif "항공권" in user_input:
        return f"항공권에 대한 정보를 찾고 계신가요? 항공권 예약은 여기를 클릭하세요: <a href='http://localhost/ticket/selectSchedule'>예약 페이지</a>"
    elif "기내 서비스" in user_input or "서비스" in user_input:
        return f"기내 서비스 정보를 찾고 계신가요? <a href='http://localhost/inFlightService/inFlightServiceSearch'>기내 서비스 페이지로 이동</a>"
    else:
        # 파이썬 cmd 명령어 실행 및 출력 코드 :
        # subprocess.check_output('명령어', shell=True, stderr=subprocess.STDOUT, text=True)
        return f"'{user_input}'에 대해서는 저도 모르겠어요.."  # 명령어 처리로 넘어가기 위해 None 반환


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
