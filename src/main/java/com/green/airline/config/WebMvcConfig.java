package com.green.airline.config;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.green.airline.handler.AuthInterceptor;
import com.green.airline.handler.AuthInterceptorForManager;
import com.green.airline.utils.Define;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	@Autowired
    private ServletContext context;
	@Autowired
	private AuthInterceptor authInterceptor;
	
	@Autowired
	private AuthInterceptorForManager authInterceptorForManager;
	
	 // 학원 이미지 경로
	  @Override public void addResourceHandlers(ResourceHandlerRegistry registry) {
	  registry.addResourceHandler("/uploadImage/**")
	  .addResourceLocations("file:"+context.getRealPath(Define.UPLOAD_DIRECTORY));
	  
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
	  
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(authInterceptor).addPathPatterns(Define.PATHS);
		registry.addInterceptor(authInterceptorForManager).addPathPatterns(Define.MANAGER_PATHS);
	}

	@Bean
	public CommonsMultipartResolver multipartResolver() {
		  CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver();
		  commonsMultipartResolver.setDefaultEncoding("UTF-8");
		  commonsMultipartResolver.setMaxUploadSizePerFile(5 * 1024 * 1024);
		  return commonsMultipartResolver;
	}
	
}
