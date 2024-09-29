package com.green.airline.handler.exception;

import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.catalina.valves.ErrorReportValve;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

public class CustomErrorReportValve extends ErrorReportValve {

    // 포맷 문자열을 찾기 위한 정규 표현식
    private static final Pattern FORMAT_STRING_PATTERN = Pattern.compile("%[sdnfx]");

    @Override
    protected void report(Request request, Response response, Throwable throwable) {
        String requestURI = request.getRequestURI();

        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // 포맷 스트링이 있는지 확인
        if (FORMAT_STRING_PATTERN.matcher(requestURI).find()) {
            try {
                // 포맷 스트링을 제거한 새로운 URL 생성
                String cleanURL = FORMAT_STRING_PATTERN.matcher(requestURI).replaceAll("");

                // 리다이렉트

                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.setCharacterEncoding("UTF-8");
                httpResponse.getWriter().write(
                    "<html><body>" +
                    "<script>" +
                    "alert('포맷스트링 문자열을 제외한 나머지 URL을 리다이렉트 합니다.');" +
                    "window.location.href = '" + cleanURL + "';" +
                    "</script>" +
                    "</body></html>"
                );
//                response.sendRedirect(cleanURL);
                return;
            } catch (IOException e) {
                e.printStackTrace(); // 리다이렉트 실패 시 로그 출력
            }
        }
        
        // 기본 400 에러 처리 (포맷 스트링이 없는 경우)
        super.report(request, response, throwable);
    }
}
