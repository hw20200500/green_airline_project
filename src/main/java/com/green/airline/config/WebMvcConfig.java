package com.green.airline.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
<<<<<<< HEAD
public class WebMvcConfig implements WebMvcConfigurer{

	
	 // 학원 이미지 경로
	  @Override public void addResourceHandlers(ResourceHandlerRegistry registry) {
	  registry.addResourceHandler("/product/**")
	  .addResourceLocations("file:///C:\\Users\\GGG\\Desktop\\image/"); }
	 
	
	// 집 이미지 경로 
	/*
	 * @Override public void addResourceHandlers(ResourceHandlerRegistry registry) {
	 * registry.addResourceHandler("/product/**")
	 * .addResourceLocations("file:///C:\\Users\\a\\Desktop\\image/"); }
	 */
	 
	 
	
=======
public class WebMvcConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/board/**")
				.addResourceLocations("file:///C:\\upload/");
	}

>>>>>>> feature/board
}
