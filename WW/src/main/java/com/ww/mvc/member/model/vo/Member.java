package com.ww.mvc.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private int no;
	
	private String jobCode;
	
	private String deptCode;
	
	private String id;
	
	private String password;
	
	private String name;
	
	private String email;
	
	private String phone;
	
	private String address;
	
	private String birth;
	
	private int salary;
	
	private Date hireDate;
	
	private Date endDate;
	
	private String endStatus;
	
	private String adminStatus;
	
	private String enrollStatus;
	
	private String originalProfilename;

	private String renamedProfilename;
	
	private String status; // 가입여부
	
	public Member(String id, String password, String name) {
		this.id = id;
		this.password = password;
		this.name = name;
	}
	
	private int rownum;
}
