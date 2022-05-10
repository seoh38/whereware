<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="../common/header.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.ww.mvc.calendar.model.vo.Calendar"%>


<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='${ path }/resources/css/calendar.css' rel='stylesheet' />
<script src='${ path }/resources/js/calendar.js'></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css"> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.all.min.js"></script>
<style>


  #calendar {
    max-width: 1100px;
    margin: 0 auto;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

</style>
</head>
<body>

  <div id='calendar'></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	// new FullCalendar.Calendar(대상 DOM객체, {속성:속성값, 속성2:속성값2..})
	var calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay' 
			}, 
			locale: "ko",
			navLinks: true, // can click day/week names to navigate views 
			selectable: true, 
			selectMirror: true, // 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용.. 
			select: function(arg) {
				console.log(arg);
				
			var title = prompt('입력할 일정:');
			
			
			// title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가 
			if (title) {
				$.ajax({
					url : "http://localhost:8088/mvc/calendarinsert",
					type : 'post',
					data : {
						empNo : ${loginMember.no},
						calendarTitle : title,
						calendarStart : moment(arg.start).format('YYYY-MM-DD HH:mm'),
						calendarEnd : moment(arg.end).format('YYYY-MM-DD HH:mm')
					},
					
				});
				
				calendar.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
					}) 
				} 
			calendar.unselect() 
			}, 
			eventClick: function(arg) {
				// 있는 일정 클릭시, 
				console.log("#등록된 일정 클릭#"); 
				console.log(arg.event); 
				if (confirm('일정을 삭제하시겠습니까?')) {
					$.ajax({
						url : "http://localhost:8088/mvc/calendardelete",
						type : 'get',
						data : {
						},
						
					});
					arg.event.remove()
					} 
				}, 
			editable: true, 
			dayMaxEvents: true, 
			// allow "more" link when too many events 
			events: [
				<%List<Calendar> calendarList = (List<Calendar>) request.getAttribute("calendarList");%>
	            <%if (calendarList != null) {%>
	            <%for (Calendar vo : calendarList) {%>
	            {
	            	title : '<%=vo.getCalendarTitle()%>',
	                start : '<%=vo.getCalendarStart()%>',
	                end : '<%=vo.getCalendarEnd()%>',
	                color : '#' + Math.round(Math.random() * 0xffffff).toString(16)
	             },
		<%}
	}%>
			]

			}); 
	calendar.render();
	});

</script>
</body>
</html>
<%@include file="../common/footer.jsp"%>
