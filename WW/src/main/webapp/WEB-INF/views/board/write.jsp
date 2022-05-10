<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />


<%@include file="../common/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/write.css">
<link rel="stylesheet" type="text/css" href="${ path }/resources/css/board/utilwrite.css">

<script src="//cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
	.ck-editor__editable_inline {
	    min-height: 600px;
	}
</style>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-1 text-gray-800">Whereware 게시판</h1>
	<p class="mb-4">서로 존중하는 공간입니다.</p>
	

	<div class="container-contact100">
		<div class="wrap-contact100">
			<form action="${ path }/board/write" method="post" enctype="multipart/form-data" class="contact100-form validate-form" id="writeForm">
				<span class="contact100-form-title">
					WhereWare
				</span>
				
				<label class="label-input100">Your Name *</label>
				<div class="wrap-input100 validate-input">
					<input id="first-name" class="input100" type="text" name="writer" placeholder="사원명" value="<c:out value="${ loginMember.name }"/>" readonly>
					<span class="focus-input100"></span>
				</div>

				<label class="label-input100">Title *</label>
				<div class="wrap-input100 validate-input">
					<input id="title" class="input100" type="text" name="title" placeholder="제목을 입력하세요.">
					<span class="focus-input100"></span>
				</div>

				<label class="label-input100">Content(4000자) *</label>
				<div class="wrap-input100 validate-input">
					<textarea id="boardContent" name="content"></textarea>
					<script>
						CKEDITOR.replace('boardContent', {
							height: '300px',
							filebrowserUploadMethod: 'form',
							filebrowserUploadUrl : "${ pageContext.request.contextPath }/board/ckUpload"
						});
					</script>
				<span class="focus-input100"></span>
				</div>
				
				<label class="label-input100">첨부파일</label>
					<div class="form-group" id="file-list">
						<a href="#this" onclick="addFile()">파일 추가</a>	
					<div class="file-group">
						<input id="upfile" type="file" name="upfile" multiple="multiple"><a href='#this' name="file-delete">삭제</a>
					</div>
					<span class="focus-input100"></span>
					</div>

				 
				<div class="container-contact100-form-btn">
					<button type="reset" onclick="location.href='${ pageContext.request.contextPath }/board/list'" class="contact100-form-btn">
						취소
					</button>
					<button type="button" onclick="checkConfirm()" class="contact100-form-btn">
						등록
					</button>
				</div>
			</form>
		</div>
	</div>


</div>

<!-- Scripts -->

<script type="text/javascript">
    $(document).ready(function() {
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    })
 
    function addFile() {
        var str = "<div class='file-group'><input type='file' name='file' multiple='multifle'><a href='#this' name='file-delete'>삭제</a></div>";
        $("#file-list").append(str);
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    }
 
    function deleteFile(obj) {
        obj.parent().remove();
    }
</script>

<script>
	function checkConfirm(){
		
		Swal.fire({
			  title: '게시글을 등록하시겠습니까?',
			  text: "작성한 글이 게시판에 등록됩니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '등록',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
			    Swal.fire(
			      '게시글 등록완료!',
			      'Whereware 자유게시판을 확인하세요.',
			      'success'
			    );
			    $('#writeForm').submit();
			  }
			})
	}

	
</script>


 
<%@include file="../common/footer.jsp"%>