package com.ww.mvc.cmt.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.cmt.model.vo.Cmt;
import com.ww.mvc.cmt.model.vo.Rest;
import com.ww.mvc.common.util.PageInfoByMember;

@Mapper
public interface CmtMapper {

	Cmt getTodayAttendance(int emp_no);

	Map<String, Object> getElapsedWTime(Map<String, Object> mapMS);
	
	Rest getLatestWB(Map<String, Object> mapMS);

	int countAttStart(int emp_no);

	String getAttStart(int emp_no);

	int insertCheckin(int emp_no);

	int updateCheckout(int emp_no);

	void updateBrEndForce(Map<String, Object> mapS);

	String getRestAll(Map<String, Object> mapS);

	void updateRestAll(Map<String, Object> mapS);

	String getAttEnd(int emp_no);

	int insertRestin(int emp_no);

	Rest getRestStart(int emp_no);

	int updateBrEnd(int rs_no);

	Rest getWorkBreak(int rs_no);

	Map<String, Object> getElapsedRTime(Map<String, Object> mapMS);
	
	int countAttList(int emp_no);

	List<Cmt> getAttList(int emp_no);
	
	Map<String, Object> getCmtMonth(Map<String, Object> mapMS);

	Map<String, Object> getCmtDate(Map<String, Object> mapMS);

	int getMonthlyCount();

	List<Cmt> getMonthlyList(PageInfoByMember pageInfoByMember);

	List<Cmt> getMonthlyListAjax();

	Cmt getAllElapsedWTime(int emp_no);

	String getAllAttStart(int emp_no);

	String getAllAttEnd(int emp_no);

	Cmt getAllAttendance(int emp_no);
	
	Map<String, Object> getAllElapsedWTime(Map<String, Object> mapMS);

	Map<String, Object> getMonthlyTotal(Map<String, Object> mapMS);

	Cmt getMonthAttendance(int emp_no, int cmt_month);

	
}
