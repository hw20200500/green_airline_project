package com.green.airline.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;

@Service
public class XssSanitizerService {

    // Pattern to detect dangerous 'src' attributes in <script>, <img>, <iframe>
    private static final Pattern DANGEROUS_SRC_PATTERN = Pattern.compile(
        "(<script|<img|<iframe)[^>]*\\ssrc=['\"](http|javascript|data|.*\\.js)['\"][^>]*>",
        Pattern.CASE_INSENSITIVE);

    // Method to escape special characters
    public String sanitizeHtmlContent(String content) {
        // Step 1: Escape special characters
//        String escapedContent = StringEscapeUtils.escapeHtml(content);
        
        // Step 2: Check for dangerous src attributes in <script>, <img>, <iframe> tags
        Matcher matcher = DANGEROUS_SRC_PATTERN.matcher(content);
        if (matcher.find()) {
            throw new IllegalArgumentException("Upload contains dangerous content.");
            
        }

        return content;
    }
}
