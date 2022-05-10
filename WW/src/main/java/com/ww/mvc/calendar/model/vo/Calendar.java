package com.ww.mvc.calendar.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Calendar {
	private int empNo;
	private int calendarNo;
	private String calendarTitle;
	private String calendarMemo;
	private String calendarStart;
	private String calendarEnd;
}
