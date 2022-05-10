<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <script src="${path}/resources/js/jquery-3.5.1.js"></script>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css"> 
	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.all.min.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="${path}/resources/css/findPwd.css">
    
    <style type="text/css">
    	.content {
    		background-color: fff;
    		width: 500px;
    		height: 450px;
    		text-align: center;
    		margin: auto;
    		margin-top: 200px;
    		
    	}
    </style>
</head>
<body>
	<div class="wrapper">
		<div class="content">
        <div id="title">
            <h1><a href="${path}/member/findPwd">WHEREWARE</a></h1>
        </div>
        <div>
        	<h5>비밀번호를 잊으셨나요? 
        		<br>
        	이메일로 임시 비밀번호를 받으세요!</h5>
        </div>
        <div class="container">
            <form class="form" action="${path}/member/findPwd" method="post">
                <input type="text" id="id" name="id" placeholder="User ID ">
                <input type="email"id="email" name="email"placeholder="E-mail">

                <button type="submit" id="login-button">비밀번호 발급</button>
            </form>
        </div>
    </div>
		</div>
    <div class="wrap-loading display-none">

  <%--   <div><img src="${path}/images/loadingmark.gif" /></div> --%>
	<div><img src="${path}/img/ajax_loader6.gif" /></div>
</div>    
	
</body>

<!-- 비밀번호 찾기 스크립트! -->
<script>
	$("#login-button").click(function(){
		$.ajax({
			url : "${path}/member/findPwd",
			type : "POST",
		    dataType: "text",
			data : {
				userId : $("#id").val(),
				email : $("#email").val()
			},
			success : function(result) {				
				swal.fire({
					text:"메일 발송!메일이 안왔다면 이메일을 확인하시고 다시 시도하세요",
					confirmButtonText: '확인',	
			  	  }).then((result) => {
			    	//확인을 눌렀을 때 수행할 일
			    	location.replace("${path}/member/login");	
			      })
			}
			, beforeSend: function () {
				
				 $('.wrap-loading').removeClass('display-none');
	           }
		   , complete: function () {
			   $('.wrap-loading').addClass('display-none');
               },
			error:function(xhr) {
				console.log(xhr)
				swal.fire({
					text:"아이디가 확실한가요?",
					confirmButtonText: '확인',	
			   }).then((result) => {
			    	//확인을 눌렀을 때 수행할 일
			    	location.replace("${path}/");	
			      })
			    }
		})
	});
    
    
</script>

</html>