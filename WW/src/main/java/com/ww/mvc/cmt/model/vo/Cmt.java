package com.ww.mvc.cmt.model.vo;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cmt {
	private int cmt_no;
	
	private int emp_no;
	
	private String cmt_srt;
	
	private String cmt_end;
	
	private String cmt_rs;
	
	private int cmt_month;
	
	private String cmt_time;
	
}
