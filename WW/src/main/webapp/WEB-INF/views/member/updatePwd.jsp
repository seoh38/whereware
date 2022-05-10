<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/> 


<%@include file="../common/header.jsp"%>    

<!-- css -->
<style>
	@font-face {
	    font-family: 'InfinitySans-RegularA1';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	h1 { 
		font-family: 'InfinitySans-RegularA1'; 
		font-size: 45px; 
		letter-spacing: -2px; 
		height: 35px;
		margin-bottom: 20px;	
	}
	
	.withDrawal {
		display: flex;
		justify-content: center;
		/* height: 800px; */
		
	}
	
	/* #haeder { color: #5b18ff; font-family: 'InfinitySans-RegularA1'; font-size: 22px; } */
	
	.updateInfo { 
		font-size: 17px; 
		font-family: 'InfinitySans-RegularA1'; 
		height: 50px;
	}
	
	#haeder_side {
		font-family: 'InfinitySans-RegularA1';
		font-size: 15px;
		color: gray;
		text-align: center;
	}
	#goUpdatePassBtn {
		font-family: 'InfinitySans-RegularA1';
		font-size: 18px;
		margin: 35px 0 0 15px;
		border: 1px solid #5b18ff;
		border-radius: 3px;
		background-color: rgb(61, 83, 143);
		color: #fff;
		width: 150px;
		height: 48px;
	}
	#goUpdatePassBtn:hover { 
		border: 1px solid #5b18ff;
	    background: linear-gradient(to right, #5b18ff, #8b5dff);
	    color: white; 
    }
    
    #notupdatePassBtn {
    	font-family: 'InfinitySans-RegularA1';
		font-size: 18px;
		margin-top: 35px;
		border: 1px solid rgb(61, 83, 143);
		border-radius: 3px;
		background-color: #fff;
		color: rgb(61, 83, 143);
		width: 120px;
		height: 48px;
    }
    #notupdatePassBtn:hover { 
		border: 1px solid rgb(61, 83, 143);
	    background: linear-gradient(to right, #fff, #e1daf6);
	    color: #5b18ff; 
    }
    .passInput {
    	width: 250px;
    }
    .updateInfo {
    	text-align: right;
    	padding: 13px 0 0 0;
    }
    
    input[type=password]{
    	border: 1px solid rgb(61, 83, 143);
    	border-radius: 3px;
    	margin: 8px 0;
    	outline: none;
    	padding: 8px;
    	box-sizing: border-box;
    	transition: .3s;
    }
    input[type=password]:focus {
    	border-color: rgb(61, 83, 143);
    	box-shadow: 0 0 8px 0 rgb(61, 83, 143);
    }
    #checkPwd { font-family: 'InfinitySans-RegularA1'; color : red; }
    
	.EPay-index_section {
		margin-left: 20px;
	}
	
	.memDA {
		margin-left: 40px;
		margin-top: 10px;
	}
	
	li {
   		list-style:none;
   	}
   	
   	#title {
   		margin-bottom: 30px;
   	}
   	
   	.btn_area {
   		text-align: center;
   	}
</style>


<div class="EPay-index_section">
    <h2 style="margin-left:19px;"><a style="font-family: 'InfinitySans-RegularA1';">마이페이지</a></h2>
    <li class="memDA EPay-form">
        <a href="${path}/member/mypageModify" style="color:rgb(61, 83, 143); font-family: 'InfinitySans-RegularA1';">회원 수정</a>
    </li>
    <li class="memDA EPay-list">
        <a href="${path}/member/updatePwd" style="color:rgb(61, 83, 143); font-family: 'InfinitySans-RegularA1';">비밀번호 수정</a>
    </li>
    <li class="memDA EPay-box">
        <a href="${path}/member/deleteMember" style="color:rgb(61, 83, 143); font-family: 'InfinitySans-RegularA1';">회원 탈퇴</a>
    </li>
</div>

<form method="post" action="${path}/member/updatePwd" name="updatePwd">
	<div class="withDrawal">
		<table> <!-- border="1px soild black;" -->
			<tr>
				<th colspan="3"><h1 style="color: rgb(61, 83, 143);">비밀번호 변경</h1></th>
			</tr>
			<tr>
				<td colspan="3">
					<div id="haeder_side">
						비밀번호는 7~15자리의 대문자, 소문자, 숫자, 특수문자 중 2종류 이상 조합하여 사용해야 합니다.<br>
						또한, 동일한 숫자 또는 문자를 3번 연속 사용할 수 없으며 아이디와 일치할 수 없습니다.
						<br><br><br>
					</div>
				</td>
			</tr>
			
			<tr>
				<input type="hidden" id="userId" value="${ loginMember.id }">
				<td><div class="updateInfo" id="updatePass">변경할 비밀번호</div></td>
				<td>&nbsp;</td>
				<td><input type="password" id="userPwd" class="passInput" name="password" /></td>
			</tr>
			<tr>
				<td><div class="updateInfo" id="updatePassChk">비밀번호 확인</div></td>
				<td>&nbsp;</td>
				<td>
					<input type="password" name="newPassChk" id="newPassChk" class="passInput"  onkeyup="checkPwd()"/>
					<div id="checkPwd">동일한 암호를 입력하세요.</div>					
				</td>
			</tr>
			<tr>
				<th colspan="3"><br><br>
					<div class="btn_area">
					<input type="button" id="notupdatePassBtn" onclick="location.href='${path}/home'" value="홈으로">
					<input type="button" id="goUpdatePassBtn" onclick="chekPassword();" value="비밀번호 변경">
					</div>
				</th>
			</tr>
		</table>
	</div>
</form>	

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css"> 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.all.min.js"></script>

<script>
	// 안내 멘트
	function checkPwd(){
		var f1 = document.forms[0];
		var pw1 = f1.password.value;
		var pw2 = f1.newPassChk.value;
		  
		if(pw1!=pw2){
			document.getElementById('checkPwd').style.color = "red";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
		} else {
			document.getElementById('checkPwd').style.color = "#32CD32";
			document.getElementById('checkPwd').innerHTML = "암호가 확인되었습니다.";
		}
	}
	
	// 가입 넘어가기전 alert 경고
	function chekPassword(){
		var mbrId = $("#userId").val();   // id 값 입력
		var mbrPwd = $("#userPwd").val();  // pw 입력
		var check1 = /^(?=.*[a-zA-Z])(?=.*[0-9]).{7,15}$/.test(mbrPwd);   //영문,숫자
		var check2 = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{7,15}$/.test(mbrPwd);  //영문,특수문자
		var check3 = /^(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{7,15}$/.test(mbrPwd);  //특수문자, 숫자
		var updateForm = document.updatePwd;
	
		if(!(check1||check2||check3)){
			/* alert("사용할 수 없은 조합입니다.\n패스워드 설정안내를 확인해 주세요."); */
			Swal.fire({
				  icon: 'error',
				  title: '비밀번호 변경 실패!',
				  text: '사용할 수 없은 조합입니다.'
			})
	
			return false;
		}
	
		if(/(\w)\1\1/.test(mbrPwd)){
			/* alert('같은 문자를 3번 이상 사용하실 수 없습니다.\n패스워드 설정안내를 확인해 주세요.'); */
			Swal.fire({
				  icon: 'error',
				  title: '비밀번호 변경 실패!',
				  text: '같은 문자를 3번 이상 사용하실 수 없습니다.'
			})
	
			return false;
		}
	
		if(mbrPwd.search(mbrId)>-1){
			/* alert("비밀번호에 아이디가 포함되었습니다.\n패스워드 설정안내를 확인해 주세요."); */
			Swal.fire({
				  icon: 'error',
				  title: '비밀번호 변경 실패!',
				  text: '비밀번호에 아이디가 포함되었습니다.'
			})
	
			return false;
		}
		
		updateForm.submit();
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
