<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Circle</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/sign/signList.css">
</head>
<body>
	<div class="wrap">
		<div class="header">
			<jsp:include page="../common/menuTopBar.jsp" />
			<jsp:include page="../common/menuAlertBar.jsp" />
		</div>
		<div class="leftBar">
			<jsp:include page="../sign/signLeftBar.jsp" />
		</div>
		<div class="container">
			<div class="contentBar">
				<jsp:include page="../sign/signHomeBar.jsp" />
				<jsp:include page="../sign/signHomeListBar.jsp" />
			</div>
			<div class="content">
				<div class="resultArea1">
					<table id="listArea">
						<c:forEach var="sign" items="${list}">
							<tr id="result">
								<th><input type="text" style="display: none" value="${sign.sign_code}" id="signCode"></th>
								<th class="imgBox1"><img src="${pageContext.request.contextPath}/resources/img/sign/chat.png" class="img0"></th>
								<th class="textBox1"><br><c:out value="${sign.sign_type_name}"/><br><br><c:out value="${sign.sign_title}"/></th>
								<th class="textBox4"><br><c:out value="${sign.sign_edat}"/><br><br><c:out value="${sign.sign_ehour}"/></th>
								<th class="textBox4"><br><c:out value="${sign.sign_wdat}"/><br><br><c:out value="${sign.sign_whour}"/></th>
								<th class="textBox3"><img src="${pageContext.request.contextPath}/resources/img/sign/share.png" id="signWatcher"></th>
								<th class="textBox3"><img src="${pageContext.request.contextPath}/resources/img/sign/add-contact.png" id="signJoiner">
									<div id="signListJoinerForm">
										<table id="signListJoiner">
											<tbody>
											</tbody>
										</table>
									</div>
								</th>				
								<th class="textBox3"><input type="text" id="signCount" readonly></th>
								<th class="textBox2"><br><c:out value="${sign.emp_info_name}"/><br><br><c:out value="${sign.job_info_name}"/></th>	
							</tr>
						</c:forEach>
					</table>
				</div>
				<div>
					<jsp:include page="../sign/signHomeListBar2.jsp" />
				</div>
				<div class="resultArea1">
				</div>
			</div>
		</div>
	</div>
<!-- 왼쪽바 고정 추가 옵션 시작-->
	<script>
		$(function() {
    		var leftBar = $(".leftBar").offset().top;
    			$(window).scroll(function() {
    		var window = $(this).scrollTop();
    		if(leftBar <= window) {
    			$(".leftBar").addClass("fixed");
    		} else {
    			$(".leftBar").removeClass("fixed");
    			}
    		})
    	});
    </script>
<!-- ajax 구간 -->
	<script>
		
	</script>
<!-- 1. 남은 결재 카운트 -->
	<script>
		$(function() {
			var base = "${pageContext.request.contextPath}";
			var signCode = $("#signCode").val();
			$.ajax({
				url: base + "/signResult/signListJoinerCount",
				type: "get",
				data: {signCode : signCode},
				dataType: "json",
				success: function(json) {
					$('#signCount').val(json.count);
				}
			});
		});
	</script>
<!-- 2. 결재자 카운트 및 조회 -->
<!-- 	<script>
		$("#signJoiner").mouseenter(function(){
			var base = "${pageContext.request.contextPath}";
			var signCode = $("#signCode").val();
			$.ajax({
				url: base + "/signResult/signListJoiner",
				type: "get",				
				data: {signCode : signCode},
				dataType: "json",
				success: function(data) {
 					var $signListJoiner = $("#signListJoiner tbody");
					$signListJoiner.html('');
					
					for(var key in data) {
						var $tr = $("<tr>");
						var $JoinerNameTd = $("<td class='tName'>").text(data[key].JoinerName);
						var $JoinerClassTd = $("<td class='tClass'>").text(data[key].JoinerClass);
						
						$tr.append($JoinerNameTd);
						$tr.append($JoinerClassTd);
						
						$signListJoiner.append($tr);
					}
					console.log("success");
				},
			});
		});
	</script> -->
<!-- 3. 참조자 카운트 및 조회 -->
	<script>
	</script>
</body>
</html>