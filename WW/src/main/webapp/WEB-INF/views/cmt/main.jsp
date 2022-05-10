<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- 이모티콘 -->
<script src="https://kit.fontawesome.com/616f27e0c4.js"
	crossorigin="anonymous"></script>

<!-- css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/ldit_header.css" />
<!-- header css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/ldit_aside.css" />
<!-- main css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/basic.css" />
<!-- basic css -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/main.css" />
<!-- main css -->

<!-- jquery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<title>Insert title here</title>
</head>
<body>
	<section>
		<article id="article_a">
			<h1>
				<br>출퇴근 등록
			</h1>
			<div class="div_checkin">
				<div class="div_title">
					<p>Today's 근무시간</p>
				</div>
				<div class="div_time">
					<p id="working_time">00:00:00</p>
				</div>
				<div class="div_title">
					<p>Today's 출근시각</p>
				</div>
				<div class="div_time">
					<p id="checkin_time">00:00:00</p>
				</div>
				<div class="div_title">
					<p>Today's 퇴근시각</p>
				</div>
				<div class="div_time">
					<p id="checkout_time">00:00:00</p>
				</div>
				<div class="div_btn">
					<a href="javascript:fnCheckin()" class="btn_click" id="btn_check">출근</a>
				</div>
			</div>


		</article>
		<!--		<article id="article_b">
		
			<h1>차트</h1>
			
		</article>   -->


		<article id="article_e">
			<h1>
				<br>근태조회 상세내역
			</h1>
			<div>
				<div class="div_wh_title">
					<div class="div_wh_closer">
						<ul class="wh_ul_title">
							<li><a href="javascript:wh_showhide();" class="btn_i"><i
									class="fas fa-minus"></i></a></li>
							<li>근무일자</li>
							<li>총 근무시간</li>
							<li>출근시간</li>
							<li>퇴근시간</li>
							<li>휴식시간</li>
						</ul>
					</div>
				</div>
				<div class="div_wh_contents" id="div_wh_contents"></div>
				<div class="div_wh_paging" id="div_wh_paging">
					<ul></ul>
				</div>
			</div>

		</article>
	</section>


	<script>
		let ckInterval = "";
		let attNoFormat = "";
		let attStartFormat = "";
		let attEndFormat = "";
		let restStartFormat = "";
		let restEndFormat = "";
		let attStartDateTime = "";
		let calAplT = "";
		let calAplU = "";
		let elapsedWTime = "";
		let elapsedRTime = "";
		let brNo = "";
		let XiuApl = [];

		let today = new Date();
		let tomorrow = new Date(today.setDate(today.getDate() + 1));
		let tomorrowYear = tomorrow.getFullYear();
		let tomorrowMonth = (tomorrow.getMonth() + 1);
		let tomorrowDate = tomorrow.getDate();
		let minDate = tomorrowYear + "-" + tomorrowMonth + "-" + tomorrowDate;
		$("#xaStart").attr('min', minDate);
		$("#xaEnd").attr('min', minDate);
		$("#whStart").attr('min', minDate);
		$("#whEnd").attr('min', minDate);

		$(function() {
			if ("${chooseID}" != null) {
				location.href = "#${chooseID}";
			}
		});


		$(document)
				.ready(
						function() {
							$
									.ajax({
										url : "attmaingetdata",
										type : "post",
										dataType : "json",
										success : function(data) {
											if (!isNull(data.cmt)) {
												attStartFormat = data.cmt.cmt_srt;
												attEndFormat = data.cmt.cmt_end;
												elapsedRTime = data.cmt.cmt_rs;
											}
											attStartDateTime = data.attStartDateTime;
											elapsedWTime = data.elapsedWTime;
											if (!isNull(data.wb)) {
												restStartFormat = data.wb.rs_srt;
												restEndFormat = data.wb.rs_end;
												brNo = data.wb.rs_no;
											}
											
											if (!isNull(attStartFormat)
													&& isNull(attEndFormat)) {
												ckInterval = setInterval(
														countTime, 1000);
												$("#btn_check")
														.attr('href',
																"javascript:fnCheckOut()");
												$("#btn_check").html("퇴근");
											}
											if (!isNull(attStartFormat)
													&& !isNull(attEndFormat)) {
												$("#btn_check").attr('href',
														"#");
												$("#btn_check").addClass(
														'notable');
												$("#btn_check").html("출근");
												$("#btn_rest")
														.attr('href', "#");
												$("#btn_rest").addClass(
														'notable');
												$("#btn_rest").html("휴식 시작");
											}
											if (!isNull(restStartFormat)
													&& isNull(restEndFormat)) {
												$("#btn_rest")
														.attr('href',
																"javascript:fnRestOut()");
												$("#btn_rest").html("휴식 종료");
											}

											$("#checkin_time")
													.html(
															setDefaultValueAtNull(attStartFormat));
											$("#checkout_time")
													.html(
															setDefaultValueAtNull(attEndFormat));
											$("#restin_time")
													.html(
															setDefaultValueAtNull(restStartFormat));
											$("#restout_time")
													.html(
															setDefaultValueAtNull(restEndFormat));

											$("#working_time")
													.html(
															setDefaultValueAtNull(elapsedWTime));
											if (elapsedRTime == "::") {
												elapsedRTime = "00:00:00";
											}
											$("#rest_time")
													.html(
															setDefaultValueAtNull(elapsedRTime));

											$("#calAplT").html(calAplT);
											$("#calAplU").html(calAplU);
											$("#calApl")
													.html(calAplT - calAplU);

										},
										error : function(request, status,
												errorData) {
											alert("error code : "
													+ request.status + "\n"
													+ "message : "
													+ request.responseText
													+ "\n" + "error : "
													+ errorData);
										}
									});

						});

		function isNull(obj) {
			return (typeof obj != "undefined" && obj != null && obj != "") ? false
					: true;
		}
		function setDefaultValueAtNull(obj) {
			return (typeof obj != "undefined" && obj != null && obj != "") ? obj
					: "00:00:00";
		}

		function countTime() {
			var nowDate = new Date();
			var str;
			console.log(nowDate);
			if (attStartDateTime.length < 7) {
				attStartFormat = attStartFormat.replaceAll(":", "");
				str = nowDate.getFullYear() + addZero(nowDate.getMonth(), 2)
						+ addZero(nowDate.getDate(), 2) + attStartFormat;
			} else {
				str = attStartDateTime;
			}
			var by = str.substr(0, 4);
			var bmm = str.substr(4, 2) - 1;
			var bd = str.substr(6, 2);
			var bh = str.substr(8, 2);
			var bm = str.substr(10, 2);
			var bs = str.substr(12, 2);
			var checkinDate = new Date(by, bmm, bd, bh, bm, bs);
			console.log(checkinDate);
			var gapTime = nowDate.getTime() - checkinDate.getTime();
			console.log(gapTime);
			var wh = Math.floor((gapTime % (1000 * 60 * 60 * 24))
					/ (1000 * 60 * 60));
			var wm = Math.floor((gapTime % (1000 * 60 * 60)) / (1000 * 60));
			var ws = Math.floor((gapTime % (1000 * 60)) / 1000);
			var totalWorkingTime = addZero(wh, 2) + ":" + addZero(wm, 2) + ":"
					+ addZero(ws, 2);
			$("#working_time").html("");
			$("#working_time").html(totalWorkingTime);
		}

		function addZero(num, digits) {
			var zero = '';
			num = num.toString();
			if (num.length < digits) {
				for (var i = 0; i < digits - num.length; i++)
					zero += '0';
			}
			return zero + num;
		}

		getPageRest(1);
		$("input[name=check_able1]").change(function() {
			if ($(this).is(":checked")) {
				getPageRest(1);
			} else {
				getPageRest(1);
			}
		});


		getPageWork(1);
		function getPageWork(page) {
			$
					.ajax({
						url : "getattlist",
						data : {
							emp_no : "${loginMember.no}",
							currentPage : page
						},
						type : "get",
						dataType : "json",
						success : function(data) {
							var restCode = data.restCode;
							var result = data.attList;
							let totalWorkTime = "";
							if (result.length == 0) {
								$("#div_wh_contents").html("");
								$("#div_wh_contents")
										.html(
												'<ul><li class="li_no_xaList">근무 내역이 없습니다.</li></ul>');
							} else {
								<!--리스트불러오기-->
								var r = '';
								$
										.each(
												result,
												function(i) {
													let restAllTime = result[i].attRestAll;
													let attSTime = "";
													let attETime = "";
													if (restAllTime == "::"
															|| isNull(restAllTime)) {
														restAllTime = null;
													}
													r += '<div>';
													r += '<ul>';
													r += '<li>'
															+ result[i].attNo
															+ '</li>'; //근무일자
													if (restCode == 1
															&& isNull(restAllTime)) {
														attSTime = attTimeFormat(result[i].attStart);
														attETime = attTimeFormat(result[i].attEnd);
														totalWorkTime = calTimeTwo(
																attSTime,
																attETime);
													} else if (restCode == 1
															&& !isNull(restAllTime)) {
														attSTime = attTimeFormat(result[i].attStart);
														attETime = attTimeFormat(result[i].attEnd);
														totalWorkTime = calTimeThree(
																attSTime,
																attETime,
																restAllTime);
													} else {
														attSTime = attTimeFormat(result[i].attStart);
														attETime = attTimeFormat(result[i].attEnd);
														totalWorkTime = calTimeTwo(
																attSTime,
																attETime);
													}
													r += '<li>' + totalWorkTime
															+ '</li>'; //총근무시간
													r += '<li>'
															+ timeFormat(result[i].attStart)
															+ '</li>'; //출근시각					
													r += '<li>'
															+ timeFormat(result[i].attEnd)
															+ '</li>'; //퇴근시각
													if (isNull(restAllTime)) {
														restAllTime = "00:00:00";
													}
													r += '<li>' + restAllTime
															+ '</li>';
													r += '</ul>';
													r += '</div>';
												})
								$("#div_wh_contents").html("");
								$("#div_wh_contents").html(r);
								<!--페이징처리-->
								var p = '';
								for (var d = data.startPage; d <= data.endPage; d++) {
									if (d == data.currentPage) {
										p += '<li>'
												+ '<a href="javascript:getPageWork('
												+ d
												+ ')" name="a_current" class="a_current">'
												+ d + '</a>' + '</li>';
									} else {
										p += '<li>'
												+ '<a href="javascript:getPageWork('
												+ d + ')">' + d + '</a>'
												+ '</li>';
									}
								}
								$("#div_wh_paging > ul").html("");
								$("#div_wh_paging > ul").html(p);
							}
						},
						error : function(request, status, errorData) {
							alert("error code : " + request.status + "\n"
									+ "message : " + request.responseText
									+ "\n" + "error : " + errorData);
						}
					});
		}

		function timeFormat(e) {
			let getTime = e;
			let getTimeH = getTime.substr(8, 2);
			let getTimeM = getTime.substr(10, 2);
			let getTimeS = getTime.substr(12, 2);
			let formattedTime = getTimeH + ":" + getTimeM + ":" + getTimeS;
			return formattedTime;
		}

		function attTimeFormat(e) {
			var str = e;
			var by = str.substr(0, 4);
			var bmm = str.substr(4, 2) - 1;
			var bd = str.substr(6, 2);
			var bh = str.substr(8, 2);
			var bm = str.substr(10, 2);
			var bs = str.substr(12, 2);
			let attTimeAfter = new Date(by, bmm, bd, bh, bm, bs);
			return attTimeAfter;
		}

		function calTimeTwo(x, y) {
			var gapTime = y - x;
			var wh = Math.floor((gapTime % (1000 * 60 * 60 * 24))
					/ (1000 * 60 * 60));
			var wm = Math.floor((gapTime % (1000 * 60 * 60)) / (1000 * 60));
			var ws = Math.floor((gapTime % (1000 * 60)) / 1000);
			var totalWorkingTime = addZero(wh, 2) + ":" + addZero(wm, 2) + ":"
					+ addZero(ws, 2);
			return totalWorkingTime
		}

		function calTimeThree(x, y, z) {
			//퇴근시간-출근시간
			var gapTime = y - x;
			var wh = Math.floor((gapTime % (1000 * 60 * 60 * 24))
					/ (1000 * 60 * 60));
			var wm = Math.floor((gapTime % (1000 * 60 * 60)) / (1000 * 60));
			var ws = Math.floor((gapTime % (1000 * 60)) / 1000);
			var calculatedTime = addZero(wh, 2) + ":" + addZero(wm, 2) + ":"
					+ addZero(ws, 2);
			//휴식시간 포맷바꾸기
			var nowDate = new Date();
			let restTimeBefore = z.replaceAll(":", "");
			var str = nowDate.getFullYear() + addZero(nowDate.getMonth(), 2)
					+ addZero(nowDate.getDate(), 2) + restTimeBefore;
			var ry = str.substr(0, 4);
			var rmm = str.substr(4, 2) - 1;
			var rd = str.substr(6, 2);
			var rh = str.substr(8, 2);
			var rm = str.substr(10, 2);
			var rs = str.substr(12, 2);
			let restTimeAfter = new Date(ry, rmm, rd, rh, rm, rs);
			//calculatedTime 포맷바꾸기
			let calTimeBefore = calculatedTime.replaceAll(":", "");
			var str = nowDate.getFullYear() + addZero(nowDate.getMonth(), 2)
					+ addZero(nowDate.getDate(), 2) + calTimeBefore;
			var cy = str.substr(0, 4);
			var cmm = str.substr(4, 2) - 1;
			var cd = str.substr(6, 2);
			var ch = str.substr(8, 2);
			var cm = str.substr(10, 2);
			var cs = str.substr(12, 2);
			let calTimeAfter = new Date(cy, cmm, cd, ch, cm, cs);
			//퇴근시간-출근시간-휴식시간
			var gapTime = calTimeAfter - restTimeAfter;
			var wh = Math.floor((gapTime % (1000 * 60 * 60 * 24))
					/ (1000 * 60 * 60));
			var wm = Math.floor((gapTime % (1000 * 60 * 60)) / (1000 * 60));
			var ws = Math.floor((gapTime % (1000 * 60)) / 1000);
			var totalWorkingTime = addZero(wh, 2) + ":" + addZero(wm, 2) + ":"
					+ addZero(ws, 2);
			return totalWorkingTime
		}

		function fnCheckin() {
			$
					.ajax({
						url : "checkin",
						data : {
							emp_no : "${loginMember.no}"
						},
						type : "post",
						success : function(data) {
							console.log(data);

							if (!isNull(data)) {
								attStartDateTime = "";
								attStartFormat = data;
								ckInterval = setInterval(countTime, 1000);
								$("#btn_check").attr('href',
										"javascript:fnCheckOut()");
								$("#btn_check").html("퇴근");
								$("#checkin_time").html(attStartFormat);
							} else {
								alert("출근 등록에 실패했습니다.");
							}
						},
						error : function(request, status, errorData) {
							alert("error code : " + request.status + "\n"
									+ "message : " + request.responseText
									+ "\n" + "error : " + errorData);
						}
					});
		}

		function fnCheckOut() {
			console.log("버튼눌림");
			$.ajax({
				url : "checkout",
				data : {
					emp_no : "${loginMember.no}"				},
				type : "post",
				success : function(data) {
					console.log(data);
					if (!isNull(data)) {
						$("#btn_check").attr('href', "#");
						$("#btn_check").addClass('notable');
						$("#btn_check").html("출근");
						$("#checkout_time").html(data);
						clearInterval(ckInterval);
						// 휴식종료기능 controller에서 되고 "휴식 시작" 버튼 눌려지지 않도록 함.
						$("#btn_rest").attr('href', "#");
						$("#btn_rest").addClass('notable');
						$("#btn_rest").html("휴식 시작");
					} else {
						alert("퇴근등록에 실패했습니다.");
						location.reload();
					}
				},
				error : function(request, status, errorData) {
					alert("error code : " + request.status + "\n"
							+ "message : " + request.responseText + "\n"
							+ "error : " + errorData);
				}
			});
		}


		$(".div_tab > button").on('click', function() {
			var thisOne = $(this);
			var idx = thisOne.index();
			var pOne = thisOne.closest('.modal_content');
			pOne.find('.div_tab button').removeClass('on');
			pOne.find('.div_tabcontent').removeClass('on');
			pOne.find('.div_tabcontent:eq(' + idx + ')').addClass('on');
			thisOne.addClass('on');
		});

		var modal = document.getElementById("modal_wrapper");

		function fnApply() {
			$("#btn_m_first").addClass('on');
			$("#div_m_restapply").addClass('on');
			modal.style.display = "block";
			modal.style.display = "flex";
		}

		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}

		window.addEventListener("keyup", function(e) {
			if (modal.style.display = "block" && e.key === "Escape") {
				modal.style.display = "none";
			}
		});

		function restin_showhide() {
			var t_drc = $("#div_restin_contents");
			t_drc.toggle();
		}

		function home_showhide() {
			var t_drc = $("#div_home_contents");
			t_drc.toggle();
		}

		function wh_showhide() {
			var t_drc = $("#div_wh_contents");
			t_drc.toggle();
		}
	</script>
</body>
</html>