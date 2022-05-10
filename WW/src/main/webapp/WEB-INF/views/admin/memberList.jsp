<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="path" value="${ pageContext.request.contextPath }" /><%@ taglib
	uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@include file="../common/header.jsp"%>

    <style>
        .profile-nav{
            white-space: nowrap;
            text-transform: uppercase;
            font-weight: 800;
            font-size: 0.8rem;
            text-align: center;
            display: block;
            padding: 0.5rem;
            margin: 0 0.5rem;
            color: #3a3b45;
            border-radius: 0.35rem;
        }

        .profile-nav:hover {
            background-color: #eaecf4;
            color: #3a3b45;
            text-decoration: none;
        }

        .bg-base-color {background-color: #2A3D72;}

        .listButton{
            width: 30px; height: 30px;
            font-size: 14px; color:#2A3D72;
            box-shadow: 0px 1px 1px rgb(202, 202, 202),0px -1px 1px rgb(202, 202, 202);
        }

        .board-list-body tr:hover, .listButton:hover {
            background-color: #2A3D72;
            color: white;
            cursor:pointer;
        }
        
        #selectListButton {
            background-color: #2A3D72;
            color: white;
        }

    </style>
    
<!-- Begin Page Content -->
<div class="container-fluid">

                        <!-- Page Heading -->

                    <div class="h3 mb-4 text-gray-800 "> 사원 검색 </div>

<form method="get" action="${ path }/member/list">
                    <table style="width: 100%; ; margin-bottom: 20px;">

                        <tr>
                            <td>
                                <select name="pages">
                                    <option value="10">10개씩</option>
                                    <option value="20">20개씩</option>
                                    <option value="30">30개씩</option>
                                    <option value="40">40개씩</option>
                                    <option value="50">50개씩</option>
                                </select>
                            </td>
                            <td style="width: 10%;">
                                <select name="type">
                                    <option value="name">이름</option>
                                    <option value="dept">부서</option>
                                    <option value="jod">직급</option>
                                    <option value="phone">전화번호</option>
                                    <option value="email">이메일</option>
                                </select>
                            </td>
                            <td>
                                <div class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="width: 97%;">
                                    <div class="input-group">
									    <input type="text" class="form-control bg-white border-0 " name="search" placeholder="검색">
									    <div class="input-group-append">
									        <button class="btn btn-primary" type="submit">
			                                	<i class="fas fa-search fa-sm"></i>
			                                </button>
									    </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
</form>




                        <div id="board-list-container"
                        style="padding-bottom: 1px; text-align: center; box-shadow: 0 0 3px #333 ; border-radius: 15px;">
    
                    
                            <table style="margin: auto; width: 100%; ">
                                <thead style="background-color: #2A3D72; ">
                                    <tr style="height: 50px; color: white;" >
                                        <th style="border-top-left-radius: 15px;">번호</th>
                                        <th>이름</th>
                                        <th>부서</th>
                                        <th>직급</th>
                                        <th>전화번호</th>
                                        <th style="border-top-right-radius: 15px;">이메일</th>
                                    </tr>
                                </thead>
    
                                <tbody class="board-list-body">
									
									<c:if test="${ !empty memberList }">
										<c:forEach var="member" items="${ memberList }">
		                                    <tr onclick="location.href='www.naver.com'" >
		                                        <td><c:out value="${ member.rownum }"/></td>
		                                        <td><c:out value="${ member.name }"/></td>
		                                        <td><c:out value="${ member.deptCode }"/></td>
		                                        <td><c:out value="${ member.jobCode }"/></td>
		                                        <td><c:out value="${ member.email }"/></td>
		                                        <td><c:out value="${ member.rownum }"/></td>
		                                    </tr>
	                                    </c:forEach>
	        						</c:if>
	        						
                                </tbody>
    
                            </table>
                            

                            <table  style="margin: 15px; text-align: center; margin-left: auto;">
                                <tr>
                                	<!-- 처음 페이지로 -->
                                    <td 
                                    onclick="location.href='${ path }/document/list?page=${ pageInfo.prevPage }&pages=${ pageInfo.listLimit }&type=${ searchMap.type }&search=${ searchMap.search }'"
                                    style="border-top-left-radius: 10px; border-bottom-left-radius: 10px;
                                    box-shadow: 0px 1px 1px rgb(202, 202, 202),0px -1px 1px rgb(202, 202, 202), -1px 0px 1px rgb(202, 202, 202)  ;"
                                    class="listButton"
                                    > &lt; </td>

									<!-- 이전 페이지로 -->
                                    <td class="listButton" onclick="location.href='${ path }/document/list?page=${ pageInfo.prevPage }&pages=${ pageInfo.listLimit }&type=${ searchMap.type }&search=${ searchMap.search }'"> &lt; </td>
									
									<!--  10개 페이지 목록 -->
									<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
									<c:if test="${ status.current == pageInfo.currentPage }">
									<td id="selectListButton" class="listButton" >${status.current}</td>
									</c:if>
                                    
                                    <c:if test="${ status.current != pageInfo.currentPage }">
                                    <td class= "listButton" onclick="location.href='${ path }/document/list?page=${ status.current }&pages=${ pageInfo.listLimit }&type=${ searchMap.type }&search=${ searchMap.search }'">${ status.current }</td>
                                    </c:if>
                                    </c:forEach>
                                    
                                    <!-- 다음 페이지로 -->
                                    <td class="listButton" onclick="location.href='${ path }/document/list?page=${ pageInfo.nextPage }&pages=${ pageInfo.listLimit }&type=${ searchMap.type }&search=${ searchMap.search }'">&gt;</td>
									
									<!-- 마지막 페이지로 -->
                                    <td 
                                    onclick="location.href='${ path }/board/list?page=${ pageInfo.maxPage }&pages=${ pageInfo.listLimit }&type=${ searchMap.type }&search=${ searchMap.search }'"
                                    style="border-top-right-radius: 10px; border-bottom-right-radius: 10px ;
                                    box-shadow: 0px 1px 1px rgb(202, 202, 202),0px -1px 1px rgb(202, 202, 202), 1px 0px 1px rgb(202, 202, 202);"
                                    class="listButton">&gt;&gt;</td>
                                    
                                </tr>
                            </table>

                        </div>
    
</div>
<%@include file="../common/footer.jsp" %>