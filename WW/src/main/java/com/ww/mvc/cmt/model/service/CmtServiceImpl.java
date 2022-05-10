package com.ww.mvc.cmt.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ww.mvc.cmt.model.dao.CmtMapper;
import com.ww.mvc.cmt.model.vo.Cmt;
import com.ww.mvc.cmt.model.vo.Rest;
import com.ww.mvc.common.util.PageInfoByMember;

@Service
public class CmtServiceImpl implements CmtService {
	@Autowired
	private CmtMapper mapper;

	@Override
	public Cmt getTodayAttendance(int emp_no) {
		return mapper.getTodayAttendance(emp_no);
	}

	@Override
	public Map<String, Object> getElapsedWTime(Map<String, Object> mapMS) {
		return mapper.getElapsedWTime(mapMS);
	}
	

	@Override
	public Rest getLatestWB(Map<String, Object> mapMS) {
		return mapper.getLatestWB(mapMS);
	}

	@Override
	public int countAttStart(int emp_no) {
		return mapper.countAttStart(emp_no);
	}

	@Override
	public String getAttStart(int emp_no) {
		return mapper.getAttStart(emp_no);
	}

	@Override
	public int insertCheckin(int emp_no) {
		return mapper.insertCheckin(emp_no);
	}

	@Override
	public int updateCheckout(int emp_no) {
		int result = 0;
		result = mapper.updateCheckout(emp_no);

		if (result > 0) {
			Cmt cmt = mapper.getTodayAttendance(emp_no);
			int thisAttNo = cmt.getCmt_no();

			Map<String, Object> mapS = new HashMap<String, Object>();
			mapS.put("emp_no", emp_no);
			mapS.put("thisAttNo", String.valueOf(thisAttNo));
			
			//휴식 강제종료
			mapper.updateBrEndForce(mapS); 
			
			//휴식총시간 가져오기
			String filter = "::";
			String restAll = mapper.getRestAll(mapS);
			if(restAll.equals(filter)) {
				restAll = "00:00:00";
			}
			mapS.put("restAll", restAll);
			//attendance 테이블 attrestall update
			mapper.updateRestAll(mapS);
		}
		return result;
	}

	@Override
	public String getAttEnd(int emp_no) {
		return mapper.getAttEnd(emp_no);
	}

	@Override
	public int insertRestin(int emp_no) {
		return mapper.insertRestin(emp_no);
	}

	@Override
	public Rest getRestStart(int emp_no) {
		return mapper.getRestStart(emp_no);
	}

	@Override
	public int updateBrEnd(int rs_no) {
		return mapper.updateBrEnd(rs_no);
	}

	@Override
	public Rest getWorkBreak(int rs_no) {
		return mapper.getWorkBreak(rs_no);
	}

	@Override
	public Map<String, Object> getElapsedRTime(Map<String, Object> mapMS) {
		return mapper.getElapsedRTime(mapMS);
	}

	@Override
	public int countAttList(int emp_no) {
		return mapper.countAttList(emp_no);
	}

	@Override
	public List<Cmt> getAttList(int emp_no) {
		return mapper.getAttList(emp_no);
	}

	@Override
	public Map<String, Object> getCmtMonth(Map<String, Object> mapMS) {
		// TODO Auto-generated method stub
		return mapper.getCmtMonth(mapMS);
	}

	@Override
	public Map<String, Object> getCmtDate(Map<String, Object> mapMS) {
		// TODO Auto-generated method stub
		return mapper.getCmtDate(mapMS);
	}

	@Override
	public String getAttStartDateTime(Map<String, Object> mapMS) {
		// TODO Auto-generated method stub
		return null;
	}

	// 월별 게시글 개수
	@Override
	public int getMonthlyCount() {
		
		return mapper.getMonthlyCount();
	}
	
	// 게시글 목록
	@Override
	public List<Cmt> getMonthlyList(PageInfoByMember pageInfoByMember) {
		
		 int offset = (pageInfoByMember.getCurrentPage() - 1 ) * pageInfoByMember.getListLimit();
		 int limit = pageInfoByMember.getListLimit();
		 RowBounds rowBounds = new RowBounds(offset, limit);

		 return mapper.getMonthlyList(pageInfoByMember);
	}

	@Override
	public List<Cmt> getMonthlyListAjax() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Cmt getAllElapsedWTime(int emp_no) {
		return mapper.getAllElapsedWTime(emp_no);
	}

	@Override
	public String getAllAttStart(int emp_no) {
		return mapper.getAllAttStart(emp_no);

	}

	@Override
	public String getAllAttEnd(int emp_no) {
		return mapper.getAllAttEnd(emp_no);

	}

	@Override
	public Cmt getAllAttendance(int emp_no) {
		return mapper.getAllAttendance(emp_no);

	}

	@Override
	public Map<String, Object> getAllElapsedWTime(Map<String, Object> mapMS) {
		return mapper.getAllElapsedWTime(mapMS);
	}

	@Override
	public Cmt getMonthAttendance(int emp_no, int cmt_month) {
		return mapper.getMonthAttendance(emp_no, cmt_month);
	}

	@Override
	public Map<String, Object> getMonthlyTotal(Map<String, Object> mapMS) {
		return mapper.getMonthlyTotal(mapMS);
	}


}
