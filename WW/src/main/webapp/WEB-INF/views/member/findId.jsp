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
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="${path}/resources/css/findId.css">
</head>
<body>
	<div class="wrapper">
        <div id="title">
            <h1>WHEREWARE</h1>
        </div>
        <div class="container">
            <form class="form" action="${path}/member/findId" method="post">
                <input type="text" name="name" id="name" placeholder="User Name ">
                <input type="email"name="email" id="email" placeholder="E-mail">
                <button type="submit" id="login-button" >아이디 찾기</button>
            </form>
        </div>
        
        <div id="result_id"></div>
    </div>
</body>

<script type="text/javascript">
        $(document).ready(function () {
            $('#login-button').click(function () {
                var name = $("#name").val();
                var email = $("#email").val();

                $.ajax({
                    type: "POST",
                    url: "${path}/member/findId",
                    dataType: "json",
                    data: {
                        'name': name,
                        'email': email,
                        'csrfmiddlewaretoken': '{{csrf_token}}',
                    },
                    success: function (response) {
                        $('#result_id').replaceWith(
                            '<div id="result_id"><hr><div><span>입력된 정보로 가입된 아이디는 </span><span id="result_id">' +
                                response.result_id +'</span><span> 입니다.</span></div><hr></div>')
                    },
                    error: function () {
                        if (name == "" || email == "") {
                            alert('이름와 이메일을 입력해주세요.');
                        } else {
                            alert('입력하신 정보가 일치하지 않거나 존재하지 않습니다.');
                        }
                    },
                });
            })
        });
    </script>


</html>