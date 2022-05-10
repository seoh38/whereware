package com.ww.mvc.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardAttach {

	private String fileNo;
	
	private int boardNo;
	
	private int empNo;
	
	private String originalFileName;
	
	private String renamedFileName;
	
	private String uploadPath;
	
	private long fileSize;
	
	private boolean fileType;
	
	private Date regDate;
}
