<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<head>
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
    <title>고구마 - 고객과 구성하는 마켓</title>
    
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>
	
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	
	<link rel="stylesheet"
		href="${contextPath}/resources/css/serviceclient.css">
	
	<link rel="stylesheet"
		href="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.css">
		
	<script type="text/javascript"
		src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
		
	<script type="text/javascript"
	src="${contextPath}/webjars/jquery-ui/1.13.0/jquery-ui.js"></script>
	
	<script>
	   function openCnslPup(){
	     
	     if(`${memberDTO}`){
	       //로그인 한 경우
	       window.open("oneCnslPup/1", "popup01", "width=800, height=700");
	     }else{
	       location.href="${contextPath}/member/login.do";
	     }
	   }
	   
	   $(document).ready(function () {
	     
	   });
	</script>
</head>

<body>
	<%@ include file="../header.jsp" %>
	
	<main class="cmain customer" role="main" id="mainContents">
		<div class="container">
	    	<!-- .side-menu-list -->
	       	<div class="side-content">
	            <h2 class="side-menu-title" onclick='javascript:location.href="${contextPath}/serviceclient/"' style="cursor:pointer;">고객센터</h2>
	            <div class="side-menu-list">
                    <ul>
                        <li><a href="${contextPath}/serviceclient/">자주 묻는 질문</a></li>
                        <li><a href="#" onclick="openCnslPup(); return false;">1:1 문의하기</a></li>
                        <li><a href="${contextPath}/serviceclient/myService">내 상담내역 조회</a></li>
                        <li><a href="/p/ccb/noticeList.do">공지사항</a></li>
                    </ul>
                </div>
	         </div>
	         <div class="contents" style="height: 100%; margin-top: 50px;">
				<table class="table table-sm" style="text-align: center;">
			 		<thead>
				    	<tr>
				      		<th>NO</th>
				      		<th>문의 유형</th>
				      		<th>제목</th>
				    		<th>문의일</th>
				    		<th>문의상태</th>
				    	</tr>
			 		</thead>
			 		<tbody>
				   		<tr>
				      		<th scope="row">1</th>
				      		<td>Mark</td>
				      		<td>Otto</td>
				      		<td>@mdo</td>
				      		<td>@mdo</td>
				    	</tr>
				    	<tr>
					      	<th scope="row">2</th>
					      	<td>Jacob</td>
					      	<td>Thornton</td>
					      	<td>@fat</td>
					      	<td>@mdo</td>
				    	</tr>
					</tbody>
				</table>
	        </div>
	    </div>
	</main>
	<%@ include file="../footer.jsp" %>
	<!-- CLOUDTURING -->
	<script>
	    window.dyc = {
	        chatbotUid: "e38640306adb39e9"
	    };
	</script>
	<script async src="https://cloudturing.chat/v1.0/chat.js"></script>
	<!-- End CLOUDTURING -->
</body>

</html>