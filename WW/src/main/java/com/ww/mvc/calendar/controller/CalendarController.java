package com.ww.mvc.calendar.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.ww.mvc.calendar.model.service.CalendarService;
import com.ww.mvc.calendar.model.vo.Calendar;
import com.ww.mvc.member.model.vo.Member;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarService service;
	
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public ModelAndView getCalendarList(@SessionAttribute(name = "loginMember") Member loginMember, ModelAndView mv, Calendar calen, HttpServletRequest request) {
		String viewpage = "calendar/calendar";
		List<Calendar> calendar = null;
		try {
			calendar = service.getCalendar(loginMember);
			
			System.out.println(loginMember);
			
			request.setAttribute("calendarList", calendar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName(viewpage);
		return mv;
	}
	
	@RequestMapping(value = "/calendarinsert", method = RequestMethod.POST)
	public Model setCalendarList(@SessionAttribute(name = "loginMember") Member loginMember, @RequestParam("calendarTitle") String calendarTitle, @RequestParam("calendarStart") String calendarStart, @RequestParam("calendarEnd") String calendarEnd, Model model, Calendar calen, HttpServletRequest request) {
		List<Calendar> calendar = null;
		try {
			calendar = service.setCalendar(calen);
			
			request.setAttribute("calendarInsert", calendar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute(calendarTitle);
		model.addAttribute(calendarStart);
		model.addAttribute(calendarEnd);
		
		System.out.println(calendarTitle);
		System.out.println(calendarStart);
		System.out.println(calendarEnd);

		return model;
	}
	
	@RequestMapping(value = "/calendardelete", method = RequestMethod.GET)
	public Model delCalendarList(Model model, Calendar calen, HttpServletRequest request) {
		List<Calendar> calendar = null;
		try {

			calendar = service.delCalendar(calen.getCalendarNo());
			
			
			
			request.setAttribute("calendarDelete", calendar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		

		return model;
	}
}