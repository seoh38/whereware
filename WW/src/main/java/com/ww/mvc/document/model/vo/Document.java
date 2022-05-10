package com.ww.mvc.document.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Document {
	
	private int rownum;
	private int doc_id;
	private int emp_no;
	private String emp_id;
	private String doc_titile;
	private String doc_content;
	private String doc_emergency;
	private Date doc_date;
	private Date doc_complet_date;
	
	private int link_num;
	private String link_type;
	private String link_id;
	private Date link_date;

	private int attach_num;
	private String attach_origin;
	private String attach_rename;
	private String attach_ext;
	private long attach_size;
	
	private String doc_status_code;
	private String doc_status;
	
	
	private String job_code;
	private String dept_code;
	private String emp_name;
	private String admin_yn;
	
	private String emp_job_name;
	private String like_name;
	private String link_job_name;
	private int link_no;

}