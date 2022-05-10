<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="path" value="${ pageContext.request.contextPath }" />
<%
String ctxPath = request.getContextPath();
%>
<%
Date nowTime = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@include file="../common/header.jsp"%>


<!-- Begin Page Content -->
<section>
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-1 text-gray-800">월별 근태 내역</h1>
	<p class="mb-4">월별 근태 내역 확인</p>

	<!-- 월별 근태 테이블 -->
	<div class="card shadow mb-4">
		<div class="dropdown card-header py-3">
			<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false" value="none">3월</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" name="month">
				<a class="dropdown-item" href="#" value="3">3월</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table-responsive">
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>날짜</th>
							<th>출근</th>
							<th>퇴근</th>
							<th>근무시간</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th colspan="3">월 근무 총 합계</th>
							<th>${totalHours}시간 ${ totalMinutes }분</th>
						</tr>
					</tfoot>
					<tbody>
						<c:if test="${ empty list }">
							<tr>
								<td colspan="4">조회된 일정이 없습니다.</td>
							</tr>
						</c:if>
						<c:if test="${ !empty list }">
							<c:forEach var="cmt" items="${ list }">
								<tr>
									<td>${ cmt.cmt_no }</td>
									<td>${ cmt.cmt_srt }</td>
									<td>${ cmt.cmt_end }</td>
									<td>${ cmt.cmt_time }</td>
								</tr>
							</c:forEach>
						</c:if>
						
					</tbody>
				</div>
			</table>
			<a href="${ path }/cmt/modify">
				<div class="col-12">
					<input type="button"
						style="color: #4e73df !important; font-weight: bold"
						class="btn float-right" value="근무 수정">
				</div>
			</a>
		</div>
	</div>
</div>

<div class="col-lg-10"></div>
</section>

<script type="text/javascript">
	$(document).ready(function() {
		$.ajax({
			url : "getMonthlyPageInfoByMember",
			type : "get",
			dataType : "json",
			data : {
				emp_no : "4",
				page : "1",
				month : ${month}
			},
			success : function(data) {
				console.log(data);
			},
			error : function(request, status, errorData) {
				console.log("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
			}
		});
	});
</script>
<!-- /.container-fluid -->

<!-- End of Main Content -->

<%@include file="../common/footer.jsp"%>