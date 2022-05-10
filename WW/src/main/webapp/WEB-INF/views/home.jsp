<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="./common/header.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">



<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

<p>
	<a href="${ path }/calendar">
		일정관리
	</a>

<p>

<p>
	<a href="http://localhost:80" target = "_blank">
		채팅방 접속
	</a>

</p>


</div>
<%@include file="./common/footer.jsp" %>

