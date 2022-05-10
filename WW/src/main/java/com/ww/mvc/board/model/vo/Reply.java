package com.ww.mvc.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {

	private int no;
	
	private int boardNo;
	
	private int empNo;
	
	private String writer;
	
	private String content;
	
	private Date createDate;
	
	private Date modifyDate;
}
