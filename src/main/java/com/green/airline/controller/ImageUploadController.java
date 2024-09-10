package com.green.airline.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.green.airline.utils.Define;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;

@RestController
public class ImageUploadController {

	@Autowired
    private ServletContext context;
    private static final String UPLOAD_DIR = Define.UPLOAD_DIRECTORY;

    @PostMapping("/uploadImage")
    public String uploadImage(@RequestParam("file") MultipartFile file) {
        try {
            // 파일 이름 설정
            String fileName = StringUtils.cleanPath(file.getOriginalFilename());
            Path uploadPath = Paths.get(context.getRealPath(Define.UPLOAD_DIRECTORY));

            // 업로드 디렉토리가 없으면 생성
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            
            String uploadPath2 = context.getRealPath(Define.UPLOAD_DIRECTORY) + File.separator + fileName;

			File destination = new File(uploadPath2);

			file.transferTo(destination);
            System.out.println("uploadImage::"+uploadPath2);
            // 저장된 파일 경로 반환
            return UPLOAD_DIR + fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return "Error";
        }
    }
}
