package com.ww.mvc.cmt.model.vo;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Component
public class Rest {
	private static final long serialVersionUID = 1112L;
	private int rs_no;
	private int cmt_no;
	private int emp_no;
	private String rs_srt;
	private String rs_end;
	
	public Rest(int rs_no, int cmt_no, int emp_no, String rs_srt, String rs_end) {
		super();
		this.rs_no = rs_no;
		this.cmt_no = cmt_no;
		this.emp_no = emp_no;
		this.rs_srt = rs_srt;
		this.rs_end = rs_end;
	}

}
