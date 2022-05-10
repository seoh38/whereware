package com.ww.mvc.common.util;

import lombok.Getter;

@Getter
public class PageInfoByMonth {
	
	private int emp_no;
	
	private int currentPage;
	
	private int listLimit;
	
	private String month;
	
	/**
	 * 
	 * @param currentPage 현재 페이지
	 * @param pageLimit 한 페이지에 보이는 페이지의 수 
	 * @param listCount 전체 리스트의 수
	 * @param listLimit 한 페이지에 표시될 리스트의 수
	 */
	
	public PageInfoByMonth(int emp_no, int currentPage, int listLimit, String month) {
		this.emp_no = emp_no;
		this.currentPage = currentPage;
		this.listLimit = listLimit;
		this.month = month;
	}
	
	
	/**
	 * 
	 * @return 현재 페이지
	 */ 
	public int getCurrentPage() {
		return this.currentPage;
	}
	
	/**
	 * 
	 * @return 이전 페이지
	 */ 
	public int getPrevPage() {
		int prevPage = this.getCurrentPage() - 1;
		
		return prevPage < 1 ? 1 : prevPage;
	}
	
	/**
	 * 
	 * @return 페이지의 시작 리스트 
	 */ 	
	public int getStartList() {
		return (this.getCurrentPage() - 1) * this.listLimit + 1;
	}
	
}