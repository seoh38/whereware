package com.ww.mvc.cmt.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ww.mvc.board.model.vo.Board;
import com.ww.mvc.cmt.model.service.CmtService;
import com.ww.mvc.cmt.model.vo.Cmt;
import com.ww.mvc.cmt.model.vo.Rest;
import com.ww.mvc.common.util.PageInfo;
import com.ww.mvc.common.util.PageInfoByMember;
import com.ww.mvc.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cmt")
public class CmtController {
	@Autowired
	private CmtService service;

	@Autowired
	private ResourceLoader resourceLoader;

	@GetMapping("/modify")
	public String cmtModify() {
		return "/cmt/modify";
	}

	// 개인 근무관리 메인페이지
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView CmtDashboard(ModelAndView mv, HttpSession session,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "5") int count) {

		Member loginMember = (Member) session.getAttribute("loginMember");

		try {
			// setInterval용도 date 읽어오기
			String attStart = null;
			attStart = service.getAttStart(loginMember.getNo());
			mv.addObject("attStart", attStart);

			// 퇴근시각 읽어오기
			String attEndFormat = null;
			attEndFormat = service.getAttEnd(loginMember.getNo());
			mv.addObject("attEndFormat", attEndFormat);

			// 오늘 날짜 Attendance 테이블 읽어오기 + 총 휴식시간 포함
			Cmt cmt = null;
			cmt = service.getTodayAttendance(loginMember.getNo());
			mv.addObject("cmt", cmt);
			System.out.println("출근시간 : " + cmt.getCmt_srt());

			Rest wb = null;
			if (cmt != null) {
				// attNo설정하기
				int thisAttNo = cmt.getCmt_no();

				// 매개변수로 사용할 cmt_no & emp_no 매핑
				Map<String, Object> mapMS = new HashMap<String, Object>();
				mapMS.put("emp_no", loginMember.getNo());
				mapMS.put("thisAttNo", thisAttNo);

				// 오늘 출퇴근 경과시간 읽어오기
				Map<String, Object> elapsedWTime = new HashMap<String, Object>();
				if (cmt.getCmt_end() != null) {
					elapsedWTime = service.getElapsedWTime(mapMS);
					String todayHours = String.valueOf(elapsedWTime.get("EH"));
					String todayMinutes = String.valueOf(elapsedWTime.get("EM"));
					mv.addObject("todayHours", todayHours);
					mv.addObject("todayMinutes", todayMinutes);
				}

				// 조회할 날짜 가져오기
				Map<String, Object> cmtDate = new HashMap<String, Object>();
				if (cmt.getCmt_end() != null) {
					cmtDate = service.getCmtDate(mapMS);
					String thisDate = String.valueOf(cmtDate.get("WD"));
					mv.addObject("thisDate", thisDate);
				}

				// 오늘 날짜 WORK_BREAK 읽어오기
				wb = service.getLatestWB(mapMS);
				mv.addObject("wb", wb);

				// 최근 5개 근태내역 가져오기
				PageInfo pageInfo = null;
				List<Cmt> list = null;

				pageInfo = new PageInfo(page, 5, service.getMonthlyCount(), count);
				list = service.getAttList(loginMember.getNo());
				
				mv.addObject("pageInfo", pageInfo);
				mv.addObject("list", list);
				mv.setViewName("cmt/dashboard");

				log.info("dashboard의 최근 근무 list : " + list.toString());
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return mv;
	}

	// 개인 근무관리 메인페이지 - 초기 정보 세팅
	@RequestMapping(value = "attmaingetdata", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String attMainGetDataMethod(HttpSession session) {
		Gson gson = new Gson();
		Map<String, Object> mapM = new HashMap<String, Object>();

		// emp_no 받아오기
		Member loginMember = (Member) session.getAttribute("loginMember");

		int emp_no = loginMember.getNo();

		// 오늘 날짜 Cmt 테이블 읽어오기 + 휴식시간 포함
		Cmt cmt = null;
		cmt = service.getTodayAttendance(emp_no);
		System.out.println("화면진입 시 cmt폼의 결과는?: " + cmt);
		mapM.put("cmt", cmt);

		Rest wb = null;
		if (cmt != null) {
			// cmt_no 설정하기
			int thisAttNo = cmt.getCmt_no();

			// 매개변수로 사용할 cmt_no, emp_no 매핑
			Map<String, Object> mapMS = new HashMap<String, Object>();
			mapMS.put("emp_no", emp_no);
			mapMS.put("thisAttNo", thisAttNo);

			// setInterval용도 date 읽어오기
			String attStartDateTime = service.getAttStartDateTime(mapMS);
			mapM.put("attStartDateTime", attStartDateTime);

			// 근무시간 읽어오기
			Map<String, Object> elapsedWTime = new HashMap<String, Object>();
			if (cmt.getCmt_end() != null) {
				elapsedWTime = service.getElapsedWTime(mapMS);
				String hours = String.valueOf(elapsedWTime.get("EH"));
				String minutes = String.valueOf(elapsedWTime.get("EM"));
				String seconds = String.valueOf(elapsedWTime.get("ES"));
				String elapsedWTBefore = hours + ":" + minutes + ":" + seconds;
				String elapsedWTAfter = elapsedWTBefore.replace(" ", "");
				mapM.put("elapsedWTime", elapsedWTAfter);
			}

			// 오늘 날짜 WORK_BREAK 읽어오기
			wb = service.getLatestWB(mapMS);

		}
		if (wb != null) {
			mapM.put("wb", wb);
		}

		String result = gson.toJson(mapM);
		return result;
	}

	// 출근등록 ajax
	@RequestMapping(value = "checkin", method = RequestMethod.POST)
	@ResponseBody
	public String checkinMethod(@RequestParam(value = "emp_no") int emp_no) throws IOException {

		String result = "";

		// 동일 날짜 출근여부 확인
		String attStartFormat = service.getAttStart(emp_no);

		if (attStartFormat == null) {
			int resultOfCheckin = service.insertCheckin(emp_no); // 출근등록
			if (resultOfCheckin > 0) {
				attStartFormat = service.getAttStart(emp_no); // 출근시각 읽어오기
				result = attStartFormat;
				System.out.println("출근 등록 완료");
			} else {
				System.out.println("출근 등록 실패");
				result = ""; // 출근 insert 실패
			}
		} else {
			result = attStartFormat;
		}

		return result;
	}

	// 퇴근 등록
	@RequestMapping(value = "checkout", method = RequestMethod.POST)
	@ResponseBody
	public String checkoutMethod(@RequestParam(value = "emp_no") int emp_no) throws IOException {

		String result = "";
		
		// 동일 날짜 퇴근여부 확인
		String attEndFormat = service.getAttEnd(emp_no);
		
		if (attEndFormat == null) {
			int resultOfCheckout = service.updateCheckout(emp_no); // 퇴근등록
			if (resultOfCheckout > 0) {
				attEndFormat = service.getAttEnd(emp_no); // 퇴근시간 읽어오기
				result = attEndFormat;
				System.out.println("퇴근 등록 완료");
			} else {
				System.out.println("퇴근 등록 실패");
				result = ""; // 퇴근 update 실패
			}
		} else {
			result = attEndFormat;
		}

		return result;
	}

	// 휴식시작 ajax
	@RequestMapping(value = "restin", method = RequestMethod.POST)
	@ResponseBody
	public String restinMethod(@RequestParam(value = "emp_no") int emp_no) throws IOException {

		String result = "";

		// 휴식시작 insert
		int resultOfRestin = service.insertRestin(emp_no);

		if (resultOfRestin > 0) {
			Rest wb = service.getRestStart(emp_no);
			Gson gson = new Gson();
			result = gson.toJson(wb);
		}

		return result;
	}

	// 근무내역 ajax
	@RequestMapping(value = "getattlist", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getAttListMethod(@RequestParam(value = "emp_no") int emp_no,
			HttpSession session,
			@RequestParam(value = "currentPage", required = false) String currentpage) {
				// 최근 근무 내역 5건 조회
				List<Cmt> attList = null;
				attList = service.getAttList(emp_no);

				Map<String, Object> mapM = new HashMap<String, Object>();
				mapM.put("attList", attList);

				Gson gson = new Gson();
				String r = gson.toJson(mapM);
				return r;
//		Map<String, Object> mapM = new HashMap<String, Object>();
//
//		int currentPage = 1;
//		int limitInOnePage = 5;
//		if (currentpage != null) {
//			currentPage = Integer.parseInt(currentpage);
//		}
//		// 전체 게시글 수
//		int attListCount = service.countAttList(emp_no);
//		// 총 페이지 수 계산
//		int maxPage = (int) ((double) attListCount / limitInOnePage + 0.9);
//		// 현재 페이지에 보여줄 시작 페이지 번호
//		int startPage = (((int) ((double) currentPage / limitInOnePage + 0.9)) - 1) * limitInOnePage + 1;
//		int endPage = startPage + limitInOnePage - 1;
//		if (maxPage < endPage) {
//			endPage = maxPage;
//		}

//		// 근무내역 상세내역
//		List<Cmt> attList = null;
//		attList = service.getAttList(emp_no, currentPage, limitInOnePage);
//
//		mapM.put("attList", attList);
//		mapM.put("currentPage", currentPage);
//		mapM.put("maxPage", maxPage);
//		mapM.put("startPage", startPage);
//		mapM.put("endPage", endPage);
//
//		Gson gson = new Gson();
//		String r = gson.toJson(mapM);
//		return r;
	}

	// 당일 근무시간 조회
	private String myFormatedTime(Map<String, Object> elapsedTime) {
		String hours = String.valueOf(elapsedTime.get("EH"));
		String minutes = String.valueOf(elapsedTime.get("EM"));
		String seconds = String.valueOf(elapsedTime.get("ES"));
		String elapsedTBefore = hours + ":" + minutes + ":" + seconds;
		String elapsedTAfter = elapsedTBefore.replace(" ", "");
		System.out.println("elapsedRTime: " + elapsedTAfter);

		return elapsedTAfter;
	}

	// monthly 리스트
	@GetMapping("/monthly")
	public ModelAndView list(ModelAndView model, HttpSession session,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "31") int count,
			@RequestParam(defaultValue = "3") int month) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		try {
		PageInfoByMember pageInfoByMember = null;
		List<Cmt> list = null;

		pageInfoByMember = new PageInfoByMember(loginMember.getNo(), page, 31, service.getMonthlyCount(), count, month);
		System.out.println("monthly + emp_no : " + pageInfoByMember.getEmp_no());
		System.out.println("monthly + month : " + pageInfoByMember.getMonth());

		list = service.getMonthlyList(pageInfoByMember);
		
		model.addObject("pageInfoByMember", pageInfoByMember);
		model.addObject("list", list);
		System.out.println("근태내역" + list);
		model.setViewName("cmt/monthly");
		
		Map<String, Object> mapMS = new HashMap<String, Object>();
		mapMS.put("emp_no", loginMember.getNo());
		mapMS.put("month", month);
		
		Map<String, Object> monthlyTotalTime = new HashMap<String, Object>();
		monthlyTotalTime = service.getMonthlyTotal(mapMS);
		String totalHours = String.valueOf(monthlyTotalTime.get("TH"));
		String totalMinutes = String.valueOf(monthlyTotalTime.get("TM"));
		model.addObject("totalHours", totalHours);
		model.addObject("totalMinutes", totalMinutes);
		
		
		} catch (Exception e) {
	         e.printStackTrace();
	    }
		
		return model;
	
	}
	
	// 근무내역 ajax
	@RequestMapping(value = "getMonthlyPageInfoByMember", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getAttListMethod(HttpSession session,
			@RequestParam(value = "month") int month, @RequestParam(value = "page") String page) {

		// emp_no 받아오기
		Member loginMember = (Member) session.getAttribute("loginMember");

		int emp_no = loginMember.getNo();
		
		if (loginMember == null) {
			System.out.println("**** 로그인 정보 없음 **** ");
		}
		
		// 리턴해줄 데이터 Map
		Map<String, Object> mapM = new HashMap<String, Object>();
		
		// 월별 사용자 근무기록 조회
		PageInfoByMember pageInfoByMember = null;
		pageInfoByMember = new PageInfoByMember(loginMember.getNo(), Integer.parseInt(page), 31, service.getMonthlyCount(), 10, month);
		
		System.out.println("getMonthlyPageInfoByMember + emp_no : " + pageInfoByMember.getEmp_no());
		System.out.println("getMonthlyPageInfoByMember + month : " + pageInfoByMember.getMonth());
		
		List<Cmt> list = null;
		list = service.getMonthlyList(pageInfoByMember);
		System.out.println(list);
		mapM.put("list", list);

		Gson gson = new Gson();
		String r = gson.toJson(mapM);
		return r;
	}
	
	
}