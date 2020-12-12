<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Circle</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/reset.css">
</head>
<body>
	<div class="wrap">
		<div class="header">
			<jsp:include page="../common/menuTopBar.jsp" />
			<jsp:include page="../common/menuAlertBar.jsp" />
		</div>
		<div class="leftBar">
			<jsp:include page="../project/projSidebar.jsp" />
		</div>
		<div class="container">
			<div class="contentBar">
				<jsp:include page="../project/projHomebar.jsp" />
			</div>
			<div class="content">

				<!-- 본문 -->

				<!-- 개수로 보기 -->
				<div style="float: right;">
					<select id="cntPerPage" name="sel" onchange="selChange()">
						<option value="5"
							<c:if test="${projCount.cntPerPage == 5}">selected</c:if>>5줄
							보기</option>
						<option value="10"
							<c:if test="${projCount.cntPerPage == 10}">selected</c:if>>10줄
							보기</option>
						<option value="15"
							<c:if test="${projCount.cntPerPage == 15}">selected</c:if>>15줄
							보기</option>
						<option value="20"
							<c:if test="${projCount.cntPerPage == 20}">selected</c:if>>20줄
							보기</option>
					</select>
				</div>
				<!-- 전체 게시판 불러오기 -->
				<table class="projParts">
					<tr>
						<th class="iss_code">업무 코드</th>
						<th class="iss_title">업무명</th>
						<th class="pro_title">프로젝트명</th>
						<th class="prog_title">업무 진행단계</th>
						<th class="situ_title">업무 상황</th>
					</tr>
					<c:forEach var="projissAll" items="${projissAll}">
						<tr>
							<td>${projissAll.iss_code}</td>

							<td><a
								href='<c:url value='/project/projIssMain?iss_code=${projissAll.iss_code}'/>'>${projissAll.iss_title}</a></td>
							<td><a
								href='<c:url value='/project/projIssMain?pro_code=${projissAll.pro_code}'/>'>${projissAll.pro_title}</a></td>
							<td>${projissAll.prog_title}</td>
							<td>${projissAll.situ_title}</td>
						</tr>
					</c:forEach>
				</table>

				<!-- 뷰 페이징 처리 -->
				<div>
					<c:set var="Post" />
					<c:if test="${paging.startPage != 1}">
						<a
							href="${pageContext.request.contextPath}/project/projissAll?nowPage=${paging.startPage - 1}&cntPerPage${paging.cntPerPage}">&lt;</a>
					</c:if>
					<c:forEach begin="${paging.startPage }" end="${paging.endPage}"
						var="p">
						<c:choose>
							<c:when test="${p == paging.nowPage }">
								<b>${p}</b>
							</c:when>
							<c:when test="${ p != paging.nowPage }">
								<a
									href="${pageContext.request.contextPath}/project/projissAll?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
							</c:when>

						</c:choose>
					</c:forEach>
					<c:if test="${paging.endPage != paging.lastPage }">
						<a
							href="${pageContext.request.contextPath}/project/projissAll?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
					</c:if>

				</div>
				<br>




				<!-- 검색 -->

				<div id="projissAllSearch">
					<form id="searchForm" method="get"
						action="${pageContext.request.contextPath}/project/projSearch">
						<select name="type">
							<option value="">선택하기</option>
							<option value="pro_title">제목</option>
							<option value="pro_intro">내용</option>
							<option value="pro_manager">관리자</option>

						</select> <input type="search" name="keyword"> <input type="submit"
							id="searchBtn" value="검색">
					</form>

				</div>
				<!--  본문 종료 -->
			</div>
		</div>
	</div>


</body>
</html>

