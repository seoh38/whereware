<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />


<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Custom fonts for this template-->
    <link href="${ path }/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${ path }/resources/css/sb-admin-2.min.css" rel="stylesheet">

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
    </style>
   <title>WhereWare</title>
</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper" >

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar bg-base-color sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${path}/" >
                <div class="sidebar-brand-icon rotate-n-15">
                </div>
                <div class="sidebar-brand-text mx-3">WhereWare</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                    <!-- Nav Item - User Information -->
                <li class="nav-item no-arrow">
                    <a class="nav-link" href="${path}/member/mypageModify" >
                       <c:choose>
                        <c:when test="${ loginMember.renamedProfilename == null }">
                           <img class="rounded-circle" src="${path}/resources/upload/profileUpload/default_profile.jpg"
                           style="width: 100%; height:100%; border-radius: 100px; object-fit: cover;" accept=".gif, .jpg, .png">
                        </c:when>
                        <c:otherwise>
                       <img class="rounded-circle" alt="x" src="${path}/upload/profileUpload/${loginMember.renamedProfilename}"
                       style="width: 100%; height:100%; border-radius: 100px; object-fit: cover;" accept=".gif, .jpg, .png">
                     </c:otherwise>
                     </c:choose>
                    </a>
                </li>
               
               <c:if test="${ !empty loginMember }">
                    <div class="py-2 rounded" style="background-color: rgb(200, 204, 255) ;width: 90%; margin-left: 5%;">
                        <a class="profile-nav">${ loginMember.name }</a>
                    </div>
               </c:if>
            </li>
            
            
            <!-- Divider 매뉴 구분 줄-->
            <hr class="sidebar-divider">

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#employeeMeun" aria-expanded="true"
                    aria-controls="employeeMeun">
                    <i class="fas fa-fw fa-address-card"></i>
                    <span>사원 관리</span>
                </a>
                <div id="employeeMeun" class="collapse" aria-labelledby="headingPages"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/mvc/member/list">사원 검색</a>
                        <a class="collapse-item" href="">사원 수정</a>
                        <a class="collapse-item" href="">가입 승인</a>
                    </div>
                </div>
            </li>

            
            <!-- Divider 매뉴 구분 줄-->
            <hr class="sidebar-divider">

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item ">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#documentMenu" aria-expanded="true"
                    aria-controls="documentMenu">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>문서 관리</span>
                </a>
                    <div id="documentMenu" class="collapse" aria-labelledby="headingPages"
                        data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <a class="collapse-item" href="/mvc/document/list">수신 문서</a>
                            <a class="collapse-item" href="/mvc/document/list">발신 문서</a>
                            <a class="collapse-item" href="/mvc/document/list">문서 검색</a>
                        </div>
                    </div>
            </li>
            
                        
            <!-- Divider 매뉴 구분 줄-->
            <hr class="sidebar-divider">


            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#boardMenu" aria-expanded="true"
                    aria-controls="boardMenu">
                    <i class="fas fa-fw fa-address-card"></i>
                    <span>게시판</span>
                </a>
                <div id="boardMenu" class="collapse" aria-labelledby="headingPages"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/mvc/board/list">사내 게시판</a>
                    </div>
                </div>
            </li>
                        
            <!-- Divider 매뉴 구분 줄-->
            <hr class="sidebar-divider">


            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#calenderMemu" aria-expanded="true"
                    aria-controls="calenderMemu">
                    <i class="fas fa-fw fa-address-card"></i>
                    <span>일정관리</span>
                </a>
                <div id="calenderMemu" class="collapse" aria-labelledby="headingPages"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/mvc/calendar">캘린더</a>
                    </div>
                </div>
            </li>
                        
            <!-- Divider 매뉴 구분 줄-->
            <hr class="sidebar-divider">


            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item ">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#cmtMenu" aria-expanded="true"
                    aria-controls="cmtMenu">
                    <i class="fas fa-fw fa-address-card"></i>
                    <span>근태 관리</span>
                </a>
                <div id="cmtMenu" class="collapse" aria-labelledby="headingPages"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="/mvc/cmt/dashboard">근태 확인</a>
                        <a class="collapse-item" href="/mvc/cmt/modify" style="display:none;">근태 수정</a>
                        <a class="collapse-item" href="/mvc/cmt/monthly">월별 근태</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>



                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <c:if test="${ !empty loginMember }">
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="${ path }/member/logout" id="messagesDropdown" role="button">
                               <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                                  <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                  <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                </svg>
                                LOGOUT
                            </a>
                        </li>
                        </c:if>

                        <div class="topbar-divider d-none d-sm-block"></div>
                    </ul>
                </nav>
