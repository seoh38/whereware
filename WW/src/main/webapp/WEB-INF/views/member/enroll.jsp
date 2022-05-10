<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="${ path }/resources/css/enroll.css">
	
	<!-- 파일 업로드 css -->
	<style type="text/css">
			@font-face {
	    	font-family: 'InfinitySans-RegularA1';
	    	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
	    	font-weight: normal;
	    	font-style: normal;
			}
	
			#profile_img_upload{
			    width: 0.1px;
				height: 0.1px;
				opacity: 0;
				overflow: hidden;
				position: absolute;
				z-index: -1;
			}
			
			#profile_img_upload + label {
			    border: 1px solid #d9e1e8;
			    background-color: #fff;
			    color: #2b90d9;
			    border-radius: 2rem;
			    padding: 8px 17px 8px 17px;
			    font-weight: 500;
			    font-size: 15px;
			    box-shadow: 1px 2px 3px 0px #f2f2f2;
			    outline: none;
			}
			
			#profile_img_upload:focus + label,
			#profile_img_upload + label:hover {
			    cursor: pointer;
			}
	</style>
<title>enroll</title>
</head>

<body>
	<div id="wrapper">
		<div id="content">
            <div class="logo">
                <h2 id="logo">Sign Up To WhereWare</h2>
            </div>
            
            <!-- 이미지 파일 넘겨줄거임 enctype="multipart/form-data" -->
            <!-- 회원가입 폼 -->
            <form name="memberEnrollFrm" action="${ path }/member/enroll" enctype="multipart/form-data" method="post" >
                <h3>
                        <label for="originalProfilename">프로필 사진</label>
                    </h3>
                <!-- 이미지 업로드 -->
                <input type="file" name="upload_profile" id="originalProfilename" style="padding: 6px 35px; font-size: 13px;" accept=".gif, .jpg, .png">
                               
                <div class="form-group">
                    <h3>
                        <label for="userId">아이디</label>
                    </h3>
                    <span class="box_int">
                        <input type="text" id="userId" name="id" placeholder="아이디를 입력하세요"/>
                </span>
                <button type="button" id="idCheckBtn">확인</button>
                <p class="error_id" ></p>
			</div>
			<div class="form-group">
                <h3>
                    <label for="userPwd">비밀번호</label>
                </h3>
                <span class="box int_pwd">
                    <input type="password" id="userPwd" name="password" placeholder="비밀번호를 입력하세요."/>
                </span>
                <span class="error_pwd"></span>
			</div>
			<div class="form-group">
                <h3>
                    <label for="userPwdCheck">비밀번호 재확인</label>
                </h3>
                <span class="box int_pwd_check">
                    <input type="password" id="userPwdCheck" placeholder="비밀번호를 다시 입력하세요"/>
                </span>
                <span class="error_pwdCk"></span>
			</div>
			<div class="form-group">
                <h3>
                    <label for="userName">이름</label>
                </h3>
                <span class="box int_name">
                    <input type="text" id="userName" name="name" placeholder=""/>
                </span>
                <span class="error_name"></span>
			</div>
            <div class="form-group">
                <h3>
                    <label for="userPhone">전화번호</label>
                </h3>
                <span class="box int_phone">
                    <input type="text" id="userPhone" name="phone" placeholder="‘-’ 를 제외한 11자리를 입력해주세요"/>
                </span>
                <span class="error_phone"></span>
			</div>
            <div class="form-group">
                <h3>
                    <label for="userEmail">이메일</label>
                </h3>
                <span class="box int_email">
                    <input type="text" id="userEmail" name="email" placeholder="you@ssss.com"/>
                </span>
                <span class="error_email"></span>
			</div>
            <div class="form-group">
                <h3>
                    <label for="userEddress">주소</label>
                </h3>
                <span class="box_int">
                    <input type="text" id="userAddress" placeholder="우편번호" name="address" />
                </span>
                <span class="error_eddress"></span>
                <button type="button" id="addressBtn" class="modify_input" onclick="sample6_execDaumPostcode();">찾기</button>
                <span class="box int_address">
                    <input type="text" id="address1" placeholder="주소"  class="modify_input" name="address"/>
                </span>
                <span class="box int_address">
                    <input type="text" id="address2" placeholder="상세주소"  class="modify_input" name="address"/>
                </span>
                <span class="error_email"></span>
			</div>
            
            <!-- BIRTH -->
            <div class="form-group">
                <h3><label for="yy">생년월일</label></h3>
                
                <div id="bir_wrap">
                
                    <!-- BIRTH_YY -->
                    <div id="bir_yy">
                        <span class="box">
                            <input type="text" id="yy" name="birth" class="int" maxlength="4" placeholder="년(4자)">
                        </span>
                    </div>
                    
                    <!-- BIRTH_MM -->
                    <div id="bir_mm">
                        <span class="box">
                            <select id="mm">
                                <option>월</option>
                                <option value="01">1</option>
                                <option value="02">2</option>
                                <option value="03">3</option>
                                <option value="04">4</option>
                                <option value="05">5</option>
                                <option value="06">6</option>
                                <option value="07">7</option>
                                <option value="08">8</option>
                                <option value="09">9</option>                                    
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                            </select>
                        </span>
                    </div>
                    
                    <!-- BIRTH_DD -->
                    <div id="bir_dd">
                        <span class="box">
                            <input type="text" id="dd" class="int" maxlength="2" placeholder="일">
                        </span>
                    </div>

                </div>
                <span class="error_birth"></span>    
            </div>
            <!-- 
            <div id="terms_area">
                <input type="checkbox" name="terms" id="terms" >
                <label for="terms">WhereWare에서 제공하는 서비스 약관에 동의합니다.</label>
                <button type="button" id="open_joinForm"> 
                	<a > 약관보기 </a>
                </button>
            </div>
             -->
            <div class="btn_area">
                <button type="submit" id="enroll_btn" >
                    <span>가입하기</span>
                </button>
            </div>
       </form>
		</div>
	</div>
	
	<!-- 스크립트 부분 -->
	<script src="${ path }/resources/js/jquery-3.6.0.js"></script>
	<script src="${ path }/resources/js/enroll.js"></script>
	<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	 
	<script>
	// 아이디 중복 확인
	$(document).ready(() => {
		$("#idCheckBtn").on("click", () => {
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

	<!-- 카카오주소 찾기 -->
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
	
	
	$("input[id=originalProfilename]").change(function(){
		 
		if($(this).val() != ""){
			// 확장자 체크
			var ext = $(this).val().split(".").pop().toLowerCase();
		
			if($.inArray(ext, ["gif","jpg","jpeg","png"]) == -1){
				/* alert("gif, jpg, jpeg, png 파일만 업로드 해주세요."); */
				Swal.fire({
					  icon: 'error',
					  title: '이미지 확장자 틀림!',
					  text: 'gif, jpg, jpeg, png 파일만 업로드 해주세요.'
					})
			    $(this).val("");
			    return;
			}
	          
			// 용량 체크
			for (var i=0; i<this.files.length; i++) {
				var fileSize = this.files[i].size;
				var fSMB = (fileSize / (1024 * 1024)).toFixed(2);
				var maxSize = 1024 * 1024 * 5;
				var mSMB = (maxSize / (1024 * 1024));
				
				if(fileSize > maxSize){
					alert(this.files[i].name + "(이)가 용량 5MB을 초과했습니다.\n\n<font color='red'>" + fSMB + "MB</font> / " + mSMB + "MB");
					
					$(this).val("");    
				}
			}
 		}
	});
</script>
	</script>
	
</body>
</html>