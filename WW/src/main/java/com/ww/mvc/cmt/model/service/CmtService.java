package com.ww.mvc.cmt.model.service;

import java.util.List;
import java.util.Map;

import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.cmt.model.vo.Cmt;
import com.ww.mvc.cmt.model.vo.Rest;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.common.util.PageInfoByMember;

public interface CmtService {

	Cmt getTodayAttendance(int emp_no);

	Map<String, Object> getElapsedWTime(Map<String, Object> mapMS);

	Rest getLatestWB(Map<String, Object> mapMS);

	int countAttStart(int emp_no);

	String getAttStart(int emp_no);

	int insertCheckin(int emp_no);

	int updateCheckout(int emp_no);

	String getAttEnd(int emp_no);

	int insertRestin(int emp_no);

	Rest getRestStart(int emp_no);

	int updateBrEnd(int rs_no);

	Rest getWorkBreak(int rs_no);

	Map<String, Object> getElapsedRTime(Map<String, Object> mapS);

	int countAttList(int emp_no);

	List<Cmt> getAttList(int emp_no);

	int getMonthlyCount();

	Map<String, Object> getCmtMonth(Map<String, Object> mapMS);

	Map<String, Object> getCmtDate(Map<String, Object> mapMS);

	String getAttStartDateTime(Map<String, Object> mapMS);

	List<Cmt> getMonthlyList(PageInfoByMember pageInfoByMember);

	List<Cmt> getMonthlyListAjax();

	Cmt getAllElapsedWTime(int no);

	String getAllAttStart(int no);

	String getAllAttEnd(int no);

	Cmt getAllAttendance(int no);

	Map<String, Object> getAllElapsedWTime(Map<String, Object> mapMS);

	Map<String, Object> getMonthlyTotal(Map<String, Object> mapMS);

	Cmt getMonthAttendance(int no, int cmt_month);

}
