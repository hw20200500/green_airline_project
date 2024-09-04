import json
from socket import *

import boto3
from flask import Flask, jsonify, render_template, render_template_string, request

app = Flask(__name__)


@app.route("/get_response", methods=["POST"])
def get_response():
    dto_json = request.get_json()

    user_message = dto_json.get("message", "No message provided")

    # 취약한 코드: 사용자 입력을 직접 템플릿으로 렌더링하여 평가
    response = render_template_string(json.dumps(dto_json, ensure_ascii=False))

    return jsonify({"response": response})


if __name__ == "__main__":
    app.run(debug=True)
