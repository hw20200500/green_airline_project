package com.green.airline.config;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.green.airline.UrlValidationFilter;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<UrlValidationFilter> urlValidationFilter() {
        FilterRegistrationBean<UrlValidationFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new UrlValidationFilter());
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }
}
