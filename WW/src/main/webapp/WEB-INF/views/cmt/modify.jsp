<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />

<%@include file="../common/header.jsp"%>


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-1 text-gray-800">근태 수정</h1>
	<p class="mb-4">근무 시간 수정 요청</p>


	<!-- 주간 근무 테이블 -->
	<div class="card shadow mb-4">
		<div class="dropdown card-header py-3">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    조회 월 입력
		  </button>
		  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
		    <a class="dropdown-item" href="#">${ cmt.cmt_month }월</a>
		    <a class="dropdown-item" href="#">1월</a>
		    <a class="dropdown-item" href="#">2월</a>
		  </div>
		</div>	
		<div class="card-body">
			<div class="table-responsive">
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
							<th colspan="3">총 합계</th>
							<th>36h</th>

						</tr>
					</tfoot>
					<tbody>
						<tr>
							<td>${ todayDate }</td>
							<td class="editable">${ cmt.cmt_srt }</td>
							<td class="editable">${ cmt.cmt_end }</td>
							<td>${ todayHours }시간 ${ todayMinutes }분</td>
						</tr>
					</tbody>
				</table>
				<a href="">
					<div class="col-12">
						<a class="btn float-right btn-primary btn-sm" data-target="#modal3" data-toggle="modal">수정 요청</a>
						
					</div>
				</a>
			</div>
		</div>
	</div>

</div>
<div class="col-lg-10"></div>

</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- 수정 요청 완료 알림 -->
<div class="row">
	<div class="modal" id="modal3" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					알림
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					수정 요청이 완료되었습니다.
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../common/footer.jsp"%>