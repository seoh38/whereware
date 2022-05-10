package com.ww.mvc.board.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	
	private int no;
	
	private int empNo;
	
	private String writer;
	
	private String title;
	
	private String content;
	
	private Date createDate;
	
	private Date modifyDate;
	
	private int hits;
	
	private int rowNum;
	
	private List<Reply> replies;
	
	private int replyCount;
	
	private List<BoardAttach> attachList;
	
	public void setNo(int no) {
		this.no = no; 
		
		if(attachList != null) {
			for (BoardAttach boardAttach : attachList) {
			boardAttach.setBoardNo(no);
			}
		}

	}
	
}
