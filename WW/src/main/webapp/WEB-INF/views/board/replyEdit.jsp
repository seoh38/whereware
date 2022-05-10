<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />

<%@include file="../common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/main.css">
<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/util.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
					 <c:if test="${ !empty loginMember && (loginMember.name == board.writer) }">
					<a class="dropdown-item" href="/mvc/board/edit?no=${ board.no }">게시글 수정</a>
					<a class="dropdown-item" onclick="boardDelete()" >게시글 삭제</a>
					</c:if>
					<!-- 
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">게시글 스크랩</a>
					 -->
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
                               <fmt:formatDate type="date" value="${ board.createDate }" pattern="yyyy-MM-dd(E) a HH:mm:ss"/>
                               </td>
                           </tr>
                           <tr>
                               <td>
                               첨부파일
                               </td>
                               <td>
                               <c:forEach var="boardAttach" items="${ board.attachList }">
	                               <div class="uploadResult">
	                              		${ boardAttach.originalFileName }
	                               </div>
	                           </c:forEach>
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

			<!-- 댓글 리스트 -->
			<div class="card-header bg-light">
			        <i class="fa fa-comment fa">댓글</i>
			        <c:if test="${ board.replyCount != 0 }">
			        <span>
			        	[&nbsp;<c:out value="${ board.replyCount }" />&nbsp;]
			        </span>
			        </c:if> 
			</div>
			<div class="card-body">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="chat">
								<c:forEach var="reply" items="${ board.replies }">
								<li class="left clearfix">
								<form id="updateForm" name="updateForm" method="POST" action="${ path }/board/replyUpdate">
									<input type="hidden" name="no" value="${ reply.no }">
									<input type="hidden" name="boardNo" value="${ board.no }">
									<div>
										<div class="header">											
											<strong class="primary-font"><c:out value="${ reply.writer }"/></strong>
											<small class="pull-right text-muted"><fmt:formatDate type="date" value="${ reply.createDate }" pattern="yyyy-MM-dd(E) a HH:mm:ss"/></small>
											<c:if test="${ !empty loginMember && (loginMember.no == reply.empNo) }">
											<textarea class="form-control" id="content" name="content" rows="3"><c:out value="${ reply.content }" /></textarea>
											</c:if>										
											
											<c:if test="${ !empty loginMember && (loginMember.no == reply.empNo) }">
												<button type="submit" onclick="location.href='${ path }/board/replyUpdate" class="update_btn btn btn-dark mt-3" style="background:#2A3D72;">댓글 수정</button>
												<button type="reset" onclick="location.href='${ path }/board/view?no=${ board.no }'" class="cancel_btn btn btn-dark mt-3" style="background:#808080;">취소</button>
											</c:if>
										</div>
										<hr>
									</div>
								</form>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>


<script>

	function boardDelete(){
		
		const swalWithBootstrapButtons = Swal.mixin({
			  customClass: {
			    confirmButton: 'btn btn-success',
			    cancelButton: 'btn btn-danger'
			  },
			  buttonsStyling: false
			})

			swalWithBootstrapButtons.fire({
			  title: '게시글을 삭제하시겠습니까?',
			  text: "삭제한 게시글은 복구가 불가능합니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소',
			  reverseButtons: true
			}).then((result) => {
			  if (result.isConfirmed) {
			    swalWithBootstrapButtons.fire(
			      '게시글 삭제 완료!',
			      '게시글이 삭제 완료되었습니다. <br> 이용해주셔서 감사합니다.',
			      'success'
			    )
			    window.location.href='/mvc/board/delete?no=${ board.no }';
			  } else if (
			    /* Read more about handling dismissals below */
			    result.dismiss === Swal.DismissReason.cancel
			  ) {
			    swalWithBootstrapButtons.fire(
			      '게시글 삭제 취소',
			      '다시 생각해보고 삭제하세요 :)',
			      'error'
			    )
			  }
			})
	}

</script>

<!-- 
<script>
	function editReplyConfirm(){
		
		Swal.fire({
			  title: '댓글을 수정하시겠습니까?',
			  text: "작성한 댓글이 수정됩니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '수정',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire(
			      '댓글 수정완료!',
			      '게시글을 확인하세요.',
			      'success'
			    );
			    $('#replyForm').submit();
			  }
			})
	}

	
</script>
 <script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(".cancel_btn").on("click", function(){
				location.href = "/board/view?no=${ board.no }";
			})
			
		})
		
		function editReplyConfirm() {
			var yn = confirm("댓글을 수정 하시겠습니까?");
			if (yn == true) {
				$.ajax({
					
					url : "${ path }/board/replyUpdate",
					data    : $("#updateForm").serialize(),
					cache : false,
					async : true,
					type : 'POST',
					success : function(str) {
						replyUpdateCallBack(str);
					},
					error : function (request, error) {
						alert("code:" + request.status + "message:" + request.responseText);
					}
				});	
			}
		}
		
		function replyUpdateCallBack(str) {
			if (str != null) {
				var result = str;
				
				if (result == "SUCCESS") {
					alert("댓글을 수정하였습니다.");
					location.href = "${ path }/board/view?no=${board.no}";
				} else {
					alert("댓글 수정에 실패하였습니다.");
					return;
				}
			}
		}
		
	</script>
 -->



<%@include file="../common/footer.jsp"%>