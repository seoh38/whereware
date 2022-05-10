<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/> 

<%@include file="../common/header.jsp"%>

<link rel="stylesheet" href="${ path }/resources/css/mypageModify.css">

	<c:set var="adressArr" value="${ loginMember.address }"></c:set>
	<c:set var="arr" value="${fn:split(adressArr,',')}"/>
	
	<!-- 사이드 -->
	<nav>
	<div class="EPay-index_section">
	    <h2 ><a style="margin-left:20px; font-family: 'InfinitySans-RegularA1';">마이페이지</a></h2>
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
	</nav>

	<section>
    <div id="container">
	<form method="post" action="${path}/member/mypageModify" enctype="multipart/form-data" name="mapageModify">
            <table style="border: 1px soild black; "> <!-- border="1px soild black;" -->
                <tr>
                    <th colspan="3"><h1 style="color: rgb(61, 83, 143);">회원 정보 수정</h1></th>
                </tr>

                <!-- 이미지 파일 수정 영역 -->
                <tr>
					<td>
						<label for="modify_img" class="updateInfo">프로필 사진</label>
					</td>
                    
					<th colspan="3">	
						<c:choose>
				      	    <c:when test="${ loginMember.renamedProfilename == null }">
				            	<div id="image_container" style="margin-left: 20px;">
					            	<div id="myImgDiv">
					            		<img alt="x" src="${path}/resources/upload/profileUpload/default_profile.jpg" class="firstImg"
					            			style="width: 100px; height:100px; border-radius: 100px; object-fit: cover;" accept=".gif, .jpg, .png">
					            	</div>
				            	</div>
				            </c:when>
				            
				            <c:otherwise>
					            <div id="image_container" style="margin-left: 20px;">
					            	<div id="myImgDiv2">
								        <img class="UserModifyImg" src="${path}/resources/upload/profileUpload/${loginMember.renamedProfilename}"  class="firstImg"
								    		style="width: 100px; height:100px; border-radius: 100px; object-fit: cover;" accept=".gif, .jpg, .png">
					            	</div>
	    						</div>
				            </c:otherwise>
				      	</c:choose>
					</th>
				</tr>
				<tr>
					<td></td>
				    <td id="imgTd" colspan="3">
				      		<c:choose>
				      		<c:when test="${ loginMember.renamedProfilename == null }">
							    <input type="file" id="image" accept="image/*" name="upload_profile" onchange=""/> 
					    	</c:when>
					    	 <c:otherwise>
					    	 	<input type="file" id="image" accept="image/*" name="upload_profile" onchange=""/> 
					    	 </c:otherwise>
					    </c:choose>

					</td>
				</tr>
                
                    <!-- 기본정보 수정 페이지 -->
                <tr>
                    <td>
                        <div class="updateInfo" >사원명</div>
                    </td>
                    <td>&nbsp;</td>
                    <td><input type="text" id="userName" class="Input" name="name" value="${loginMember.name}" /></td>
                </tr>

                <tr>
                    <td>
                        <div class="updateInfo" >아이디</div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input type="text" name="id" id="userId" class="Input_2" value="${loginMember.id}"/>
                        <input type="button" id="id_chkBtn" value="중복 체크">
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="updateInfo">전화번호</div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input type="text" name="phone" id="userPhone" class="Input" value="${loginMember.phone}"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="updateInfo" id="">이메일</div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input type="text" name="email" id="userEmail" class="Input" value="${loginMember.email}"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="updateInfo">주소</div>
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input type="text" name="address" id="userAddress" class="Input_2" value="${arr[0]}"/>
                        <input type="button" id="searchAdd" value="주소찾기" onclick="sample6_execDaumPostcode()">
                        <br>
                        <input type="text" name="address" id="address1" class="Input" value="${arr[1]}"/>
                        <br>
                        <input type="text" name="address" id="address2" class="Input" value="${arr[2]}"/>
                    </td>
                </tr>

                <tr>
                    <th colspan="3"><br><br>
                        <div class="btn_area">
                        <input type="button" id="notupdateBtn" onclick="location.href='${path}/cmt/dashboard'" value="홈으로">
                        <input type="submit" id="goUpdateBtn" onclick="location.href='${path}/member/mypageModify'" value="회원정보수정">
                        </div>
                    </th>
                </tr>
            </table>
    	</form>	
        </div>
     	</section>
	
		<!-- 스크립트 부분 -->
	<script src="${ path }/resources/js/jquery-3.6.0.js"></script>
	<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.min.css"> 
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.9/dist/sweetalert2.all.min.js"></script>
	 
	<script>
	// 아이디 중복 확인
	$(document).ready(() => {
		$("#id_chkBtn").on("click", () => {
			let userId = $("#userId").val().trim();
			
			$.ajax({
				type: "post",
				url: "${ path }/member/idCheck",
				dataType: "json",
				data: {
					userId
				},
				success: (data) => {
					console.log(data);
					
					if(data.duplicate === true) {
						alert("이미 사용중인 아이디 입니다.");
					} else {
						alert("사용 가능한 아이디 입니다.");						
					}
					
				},
				error: (error) => {
					console.log(error);
				}
			});
		});	
	});
</script>

<script>
//썸네일 미리보기 (loginMember.renamedProfilename == null)
function setThumbnail(event) { 
    var reader = new FileReader();
    const div = document.getElementById('myImgDiv');
    
    div.remove();
    
    reader.onload = function(event) { 
        var img = document.createElement("img"); 
        img.setAttribute("src", event.target.result); 
        document.querySelector("div#image_container").appendChild(img); 
    }; 
    
    reader.readAsDataURL(event.target.files[0]); 
}

// 썸네일 미리보기
function setThumbnail2(event) { 
    var reader = new FileReader();
    const div2 = document.getElementById('myImgDiv2');
    
    div2.remove();
    
    reader.onload = function(event) { 
        var img = document.createElement("img"); 
        img.setAttribute("src", event.target.result); 
        document.querySelector("div#image_container").appendChild(img); 
    }; 
    
    reader.readAsDataURL(event.target.files[0]); 
}
</script>

<!-- 카카오주소 찾기? 왜 안먹냐..... -->
	<script>
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("address2").value = extraAddr;
	            
	            } else {
	                document.getElementById("address2").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('userAddress').value = data.zonecode;
	            document.getElementById("address1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("address2").focus();
	        }
	    }).open();
	}
	</script>
	
<%@include file="../common/footer.jsp"%>