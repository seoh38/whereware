package com.ww.mvc.calendar.model.service;

import java.util.List;

import com.ww.mvc.calendar.model.vo.Calendar;
import com.ww.mvc.member.model.vo.Member;

public interface CalendarService {
	List<Calendar> getCalendar(Member loginMember) throws Exception;

	List<Calendar> setCalendar(Calendar calen) throws Exception;

	List<Calendar> delCalendar(int calendarNo) throws Exception;


	
}
