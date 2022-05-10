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
					 <c:if test="${ !empty loginMember && (loginMember.no == board.empNo) }">
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
                               <c:forEach var="boardAttach" items="${ boardAttachlist }">
	                               <a href="javascript:fileDownload('${ boardAttach.originalFileName }', '${ boardAttach.renamedFileName }')">
	                              		${ boardAttach.originalFileName }
	                               </a>
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
									<div class="header">
										<c:if test="${ !empty loginMember && (loginMember.no == reply.empNo) }">
										<button class="btn float-right btn-default btn-xs" onclick="location.href='${ path }/board/replyDelete?no=${ reply.no }'">삭제</button>
										<button class="btn float-right btn-default btn-xs" id="replyUpdate" onclick="location.href='${ path }/board/replyEdit?no=${ board.no }'">수정</button>
										</c:if>
											<input type="hidden" id="replyNo" name="no" value="${ reply.no }">
											<strong class="primary-font"><c:out value="${ reply.writer }"/></strong>
											<small class="pull-right text-muted">
												<fmt:formatDate type="date" value="${ reply.createDate }" pattern="yyyy-MM-dd(E) a HH:mm:ss"/>
											</small>										
										<p id="rp"><c:out value="${ reply.content }" /></p>
									</div>
									<hr>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- 댓글 작성 영역 -->
			<c:if test="${ !empty loginMember }">
			<div class="card-body">
				<ul class="list-group list-group-flush">
				    <li class="list-group-item">
						<form id="replyForm" name="replyForm" method="get" action="${ path }/board/reply">
							<input type="hidden" name="no" value="${ board.no }" /> 
							<input type="hidden" name="writer" value="${ loginMember.name }" />
							<div class="form-inline mb-2">
								<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
								<input type="text" class="form-control ml-2" placeholder="사원 ID" id="replyId" name="writer" value="<c:out value="${ loginMember.name }"/>" readonly>
							</div>
							<textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="3"></textarea>
							<button type="button" onclick="checkReplyConfirm()" class="btn btn-dark mt-3" style="background:#2A3D72;">댓글 작성</button>
						</form>
				    </li>
				</ul>
			</div>
			</c:if>
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


<script>
	function checkReplyConfirm(){
		
		Swal.fire({
			  title: '댓글을 등록하시겠습니까?',
			  text: "작성한 댓글이 게시판에 등록됩니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '등록',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire(
			      '댓글 등록완료!',
			      '게시글을 확인하세요.',
			      'success'
			    );
			    $('#replyForm').submit();
			  }
			})
	}

	
</script>
<script>
function fileDownload(oname, rname) {
	
	// encodeURIComponent()
	//  - 아스키문자(a~z, A~Z, 1~9, ... )는 그대로 전달하고 기타 문자(한글, 특수 문자 등)만 %XX(16진수 2자리)와 같이 변환된다.
	location.assign("${ pageContext.request.contextPath }/board/fileDown?oname=" + encodeURIComponent(oname) + "&rname=" + encodeURIComponent(rname));
}
</script>


<%@include file="../common/footer.jsp"%>