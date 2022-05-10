package com.ww.mvc.calendar.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ww.mvc.calendar.model.dao.CalendarDao;
import com.ww.mvc.calendar.model.vo.Calendar;
import com.ww.mvc.member.model.vo.Member;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDao calendardao;
	
	@Override
	public List<Calendar> getCalendar(Member loginMember) throws Exception {
		return calendardao.getCalendar(loginMember);
	}
	
	@Override
	public List<Calendar> setCalendar(Calendar calen) throws Exception {
		return calendardao.setCalendar(calen);
	}

	@Override
	public List<Calendar> delCalendar(int calendarNo) throws Exception {
		return calendardao.delCalendar(calendarNo);
	}


}
