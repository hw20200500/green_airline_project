package com.green.airline.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	
	 // 학원 이미지 경로
	  @Override public void addResourceHandlers(ResourceHandlerRegistry registry) {
//	  registry.addResourceHandler("/product/**")
//	  .addResourceLocations("file:///C:\\Users\\GGG\\Desktop\\image/"); 
//	  
//	  registry.addResourceHandler("/board/**")
//	  .addResourceLocations("file:///C:\\upload/");
	  
	  registry.addResourceHandler("/uploadImage/**")
	  .addResourceLocations("file:///C:\\upload/");
	  
	  	// 맥북 이미지 경로인데 남겨두면 도움이 될지도?? -정다운-
		/*
		 * registry.addResourceHandler("/uploadImage/**")
		 * .addResourceLocations("file:/Users/minjoo/Desktop/images/");
		 */
	  
	  }
	  
	 
	
	
	  @Bean
	  public PasswordEncoder passwordEncoder() {
		  return new BCryptPasswordEncoder();
	  }
	
}
