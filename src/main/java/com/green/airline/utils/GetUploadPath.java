package com.green.airline.utils;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;

public class GetUploadPath {

	//프로퍼티 객체를 가져와서 해당 프로퍼티있는쪽에 경로를 주고
		private static Properties properties = new Properties(); 
		
		static {
			String resource = "com/jquery/properties/uploadPath.properties"; 
			try {
				//리더를 통해 해당파일을 읽어내면 서 프로퍼티를생성 >> 그럼 그냥 get할수있음
				Reader reader = Resources.getResourceAsReader(resource);
				properties.load(reader);
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//겟업로드패스는 같은 키값으로 프로퍼티에서 겟하는거임
		public static String getUploadPath(String key) {
			String uploadPath = null;
			uploadPath = properties.getProperty(key);
			uploadPath=uploadPath.replace("/", File.separator);
			return uploadPath;
		}
	
}
