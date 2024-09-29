package com.green.airline;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class FormatStringValidator {

    // 포맷 스트링 패턴: % 뒤에 s, d, n, x 등의 형식 지정자가 올 수 있음
    private static final Pattern FORMAT_STRING_PATTERN = Pattern.compile("%[sdnfx]");

    // 포맷 스트링이 포함된 문자열을 제거하는 메서드
    public static String FormatStringValidator(String input) {
        if (input == null || input.isEmpty()) {
            return input;  // 입력값이 null이거나 비어 있으면 그대로 반환
        }

        // 정규식 매칭을 통해 포맷 스트링 제거
        return FORMAT_STRING_PATTERN.matcher(input).replaceAll("");
    }


}
