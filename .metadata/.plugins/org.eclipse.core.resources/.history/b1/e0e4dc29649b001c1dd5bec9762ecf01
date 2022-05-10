<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />

<%@include file="../common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/main.css">
<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/util.css">


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-1 text-gray-800">Whereware 게시판</h1>
	<p class="mb-4">서로 존중하는 공간입니다.</p>

	<!-- Dropdown Card Example -->
	<div class="card shadow mb-4">
		<!-- Card Header - Dropdown -->
		<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold text-primary">게시글 상세보기</h6>
			<div class="dropdown no-arrow">
				<a class="dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">
				<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
				</a>
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
					aria-labelledby="dropdownMenuLink">
					<div class="dropdown-header">게시글 옵션</div>
					<a class="dropdown-item" href="/mvc/board/edit?no=${ board.no }">게시글 수정</a>
					<a class="dropdown-item" href="#">게시글 삭제</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">게시글 스크랩</a>
				</div>
			</div>
		</div>
		<!-- Card Body -->
		<div class="card-body">
		
		<!-- 게시글 상세보기 -->
        <div class="container">
           <a href="${ path }/board/list" class="btn btn-light btn-icon-split">
               <span class="text">목록으로</span>
           </a>
           <div class="board-write-body">
               <div class="card-body">
                   <table class="table table-condensed">
                       <thead>
                           <tr align="center">
                               <th width="10%">${ board.no }</th>
                               <th width="60%">${ board.title }</th>
                           </tr>
                       </thead>
                       <tbody>
                           <tr>
                               <td>
                               글쓴이
                               </td>
                               <td>
                               ${ board.writer }
                               </td>
                           </tr>
                           <tr>
                               <td>
                               작성일
                               </td>
                               <td>
                               <fmt:formatDate type="date" value="${ board.createDate }" pattern="yyyy-MM-dd(E) a HH:mm:ss"/> <span style='float:right'>조회수 : ${ board.hits }</span>
                               </td>
                           </tr>
                           <tr>
                               <td>
                               첨부파일
                               </td>
                               <td>
	                               <div class="uploadResult">
	                              		
	                               </div>
                               </td>
                           </tr>
                           <tr>
                               <td colspan="2">
                                   <div>${ board.content }</div>
                               </td>
                           </tr>
                       </tbody>
                   </table>
				</div>
			</div>

			<!-- 댓글 -->
			<div class="card-header bg-light">
			        <i class="fa fa-comment fa">댓글</i> <span> [0] </span>
			</div>

			<div class="card-body">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="chat">
								<c:forEach var="reply" items="${ board.replies }">
								<li class="left clearfix">
									<div>
										<div class="header">
											<strong class="primary-font"><c:out value="${ reply.writer }"/></strong>
											<small class="pull-right text-muted"><fmt:formatDate type="date" value="${ reply.createDate }" pattern="yyyy-MM-dd(E) a HH:mm:ss"/></small>
											<button class="btn float-right btn-default btn-xs">삭제</button>
											<button class="btn float-right btn-default btn-xs">수정</button>
										</div>
										<p><c:out value="${ reply.content }"/></p>
										<hr>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
				    
			<div class="card-body">
				<ul class="list-group list-group-flush">
				    <li class="list-group-item">
					<div class="form-inline mb-2">
						<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
						<input type="text" class="form-control ml-2" placeholder="사원 ID" id="replyId">
						<label for="replyPassword" class="ml-4"><i class="fa fa-unlock-alt fa-2x"></i></label>
						<input type="password" class="form-control ml-2" placeholder="비밀번호 입력" id="replyPassword">
					</div>
					<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
					<button type="button" class="btn btn-dark mt-3" style="background:#2A3D72;">댓글 작성</button>
				    </li>
				</ul>
			</div>
		</div>
</div>

<script>
	var uploadResult = $(".uploadResult div");
	
		function showFiles(uploadResultArr){
			var str = "";
			
			$(uploadResultArr).each(function(i, obj)){
				str += "<span>" + obj.originalFileName + "<span>";
			});
			
			uploadResult.append(str);
		};
		

</script>


<%@include file="../common/footer.jsp"%>