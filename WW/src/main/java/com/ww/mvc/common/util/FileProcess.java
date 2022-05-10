package com.ww.mvc.common.util;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileProcess {
	
	public static String save(MultipartFile upfile, String location) {
		String renamedFileName = null;
		String originalFileName = upfile.getOriginalFilename();
		
		log.info("Upfile Name : {}", originalFileName);
		log.info("저장 location : {}", location);
		
//		location이 실제로 존재하지 않으면 폴더를 생성하는 로직
		
		File folder = new File(location);
		
		// folder가 없으면, mkdirs() 해라
		if(!folder.exists()) {
			folder.mkdirs();
		} 
		
		// 사용자가 업로드한 파일명을 renamedFileName으로 이렇게 바꾸겠다.
		renamedFileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + 
				originalFileName.substring(originalFileName.lastIndexOf("."));
		
		try {
			// 사용자가 업로드한 파일 데이터를 지정한 파일에(새로운 File 객체에, 메모리상에 올려져있는 객체(아직 저장x)) 새로 저장한다.
			upfile.transferTo(new File(location + "/" + renamedFileName));
		} catch (IllegalStateException | IOException e) {
			log.error("파일 전송 에러");
			e.printStackTrace();
		}	
		
		return renamedFileName;
	}

	public static void delete(String fileName, HttpServletRequest request) {
		
		String rootPath = request.getSession().getServletContext().getRealPath("resources");
		String savePath = rootPath + "/upload/board";
		
		// 전달받은 location 정보로 새로운 파일 객체 만들기
		File file = new File(savePath + "/" + fileName);
		
		if(file.exists()) {
			file.delete();
		}
		
	}
	
}