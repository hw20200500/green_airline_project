package com.green.airline;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

@WebFilter(urlPatterns = "/*") // 모든 URL에 적용
public class UrlValidationFilter implements Filter {
	private static final Pattern FORMAT_STRING_PATTERN = Pattern.compile("%[sdnfx%]");
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

    	HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 요청된 URL을 가져옴
        String requestURI = httpRequest.getRequestURI();

        

        // 전체 URL을 포함한 URL을 가져옴
        StringBuffer requestURL = httpRequest.getRequestURL();
        String queryString = httpRequest.getQueryString();
        if (queryString != null) {
            requestURL.append('?').append(queryString);
        }

        // fullURL에 원래 요청된 URL 저장
        String fullURL = requestURL.toString();
        System.out.println("Original Full URL: " + fullURL);

        // %s와 같은 포맷 문자열이 있는지 확인
        if (FORMAT_STRING_PATTERN.matcher(fullURL).find()) {
        	try {
        		// 포맷 문자열을 제거한 새 URL 생성
                String cleanURL = FORMAT_STRING_PATTERN.matcher(fullURL).replaceAll("");
                System.out.println("Filtered Clean URL: " + cleanURL);

                // 클라이언트를 필터링된 URL로 리다이렉트
                httpResponse.setContentType("text/html");
                httpResponse.getWriter().write(
                    "<html><body>" +
                    "<script>" +
                    "alert('포맷스트링 문자열을 제외한 나머지 URL을 리다이렉트 합니다.');" +
                    "window.location.href = '" + cleanURL + "';" +
                    "</script>" +
                    "</body></html>"
                );
//                httpResponse.sendRedirect(cleanURL);
        	} catch (IllegalArgumentException e) {
        		httpResponse.sendRedirect("/");
        	}
            
        } else {
            // 포맷 문자열이 없으면 필터 체인을 그대로 통과
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
	
}