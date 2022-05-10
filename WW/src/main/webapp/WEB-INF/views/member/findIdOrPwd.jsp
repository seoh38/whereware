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
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/findIdOrPwd.css">
</head>
<body>
	 <div class="wrapper">
        <div class="container">
            <form class="form" action="${path}/member/findIdOrPwd" method="post">

             <button type="button" onclick="location.href='${path}/member/findId'"  id="login-button">아이디 찾기</button>
     		<button type="button" onclick="location.href='${path}/member/findPwd'"  id="login-button">비밀번호 찾기</button>

            </form>
        </div>
    </div>
</body>
</html>