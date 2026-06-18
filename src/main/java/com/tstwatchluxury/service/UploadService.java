package com.tstwatchluxury.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaverUploadFile(MultipartFile file, String targetFolder) {
        if (file.isEmpty()) {
            return "";
        }
        
        // Tạo tên file an toàn
        String fileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
        byte[] bytes;
        try {
            bytes = file.getBytes();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }

        // Định nghĩa các đường dẫn ghi file tiềm năng
        // 1. Đường dẫn runtime Tomcat
        String contextPath = this.servletContext.getRealPath("/resources/images");
        
        // 2. Đường dẫn folder source code dự án (để lưu trữ bền vững)
        String userDir = System.getProperty("user.dir");
        String devPath = null;
        String targetPath = null;
        
        if (userDir != null) {
            devPath = userDir + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "resources" + File.separator + "images";
            targetPath = userDir + File.separator + "target" + File.separator + "tstWatchLuxury" + File.separator + "resources" + File.separator + "images";
        }

        boolean savedSuccess = false;

        // Ghi vào thư mục nguồn phát triển (src/main/webapp) nếu tồn tại
        if (devPath != null) {
            try {
                File dir = new File(devPath + File.separator + targetFolder);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
                try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
                    stream.write(bytes);
                }
                savedSuccess = true;
                System.out.println(">>> Luu anh vao source thanh cong: " + serverFile.getAbsolutePath());
            } catch (Exception e) {
                System.err.println(">>> Khong the luu vao source folder: " + e.getMessage());
            }
        }

        // Ghi vào thư mục target build (để Tomcat phục vụ tức thì)
        if (targetPath != null) {
            try {
                File dir = new File(targetPath + File.separator + targetFolder);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
                try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
                    stream.write(bytes);
                }
                savedSuccess = true;
                System.out.println(">>> Luu anh vao target thanh cong: " + serverFile.getAbsolutePath());
            } catch (Exception e) {
                System.err.println(">>> Khong the luu vao target folder: " + e.getMessage());
            }
        }

        // Ghi vào servlet context path nếu 2 bước trên chưa ghi được hoặc để dự phòng
        if (contextPath != null) {
            try {
                File dir = new File(contextPath + File.separator + targetFolder);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
                try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
                    stream.write(bytes);
                }
                savedSuccess = true;
                System.out.println(">>> Luu anh vao servlet context thanh cong: " + serverFile.getAbsolutePath());
            } catch (Exception e) {
                System.err.println(">>> Khong the luu vao servlet context: " + e.getMessage());
            }
        }

        if (savedSuccess) {
            return fileName;
        } else {
            return "";
        }
    }
}
