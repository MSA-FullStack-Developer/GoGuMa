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
	
	<style>
		table {
			text-align: center;
		}
		
		tr {
			height: 45px;
		}
		
		th {
			vertical-align: middle;
			height: 50px;
		}
		
		td {
			vertical-align: middle;
			height: 50px;
		}
		
		th.detail {
			vertical-align: middle;
		}
		
		tr.detail {
		    display: none;
		    width: 100%;
		}
		
		tr.detail div {
		    display: none;
		}
		
		.showmore:hover {
		    cursor: pointer;
		    color: #FF493C;
		}
		
		.pagination {
			--bs-pagination-color: black;
		}
	</style>
	<script>
		function openCnslPup() {
		   if (`${memberDTO}`) {
			   window.open("../oneCnslPup", "popup01", "width=800, height=700");
	       } else {
	    	   location.href="${contextPath}/member/login.do";
		   }
	    }
		
		$(document).ready(function() {
			$(".detail").hide();
			
			$("a.showmore").click(function (e) {
				e.preventDefault();
			    var targetrow = $(this).closest('tr').next('.detail');
			    targetrow.show().find('div').slideToggle(0, function(){
			    	if (!$(this).is(':visible')) {
			        	targetrow.hide();
			      	}
			    });
			});
		});
	</script>
</head>

<body>
	<%@ include file="../header.jsp" %>
	
	<main class="cmain customer" role="main" id="mainContents" style="height: 100%;">
		<div class="container">
	    	<!-- .side-menu-list -->
	       	<div class="side-content">
	            <h2 class="side-menu-title" onclick='javascript:location.href="${contextPath}/serviceclient/"' style="cursor:pointer;">고객센터</h2>
	            <div class="side-menu-list">
                    <ul>
                        <li><a href="${contextPath}/serviceclient/">자주 묻는 질문</a></li>
                        <li><a href="#" onclick="openCnslPup(); return false;">1:1 문의하기</a></li>
                        <li><a href="${contextPath}/serviceclient/myService/1">내 상담내역 조회</a></li>
                        <li><a href="https://www.hmall.com/p/ccb/noticeList.do">공지사항</a></li>
                    </ul>
                </div>
	         </div>
	         <div class="contents" style="height: 100%;">
	         	<div class="cus-wrap">
                    <h3>내 상담내역 조회</h3>
                    <p style="font-size: 10pt; color: #ccc;">제목을 누르면 상담 내용을 확인할 수 있습니다.</p>
                </div>
                <div style="margin-top: 20px;">
                	
					<table class="table table-sm">
				 		<thead>
					    	<tr>
					      		<th width="10%">NO</th>
					      		<th>문의 유형</th>
					      		<th>제목</th>
					    		<th>문의일</th>
					    		<th>문의상태</th>
					    	</tr>
				 		</thead>
				 		<tbody>
				 			<c:if test="${myQnaList.size() < 1}">
		                		<tr style="text-align: center;" >
		                			<td colspan="5">
			   						<img class="no-review-img" src="https://image.hmall.com/p/img/co/icon/ico-nodata-type12-1x.svg" />
			   						<h5 class="no_result">상담내역이 없습니다.</h5>
			   						</td>
		   						</tr>
                			</c:if>
				 			<c:forEach items="${myQnaList}" var="qna" varStatus="status">
						   		<tr>
						      		<th scope="row">${status.count+((pg-1)*10)}</th>
						      		<td>${qna.categoryName}</td>
						      		<td><a class="showmore">${qna.qnaTitle}</a></td>
						      		<td><fmt:formatDate value="${qna.createdAt}" pattern="yyyy-MM-dd" /></td>
						      		<td>
						      			<c:if test="${qna.answerStatus == 0}">
						      				처리중
						      			</c:if>
						      			<c:if test="${qna.answerStatus == 1}">
						      				답변완료
						      			</c:if>
					      			</td>
						    	</tr>
						    	<tr class="detail">
						    		<th>내용</th>
						    		<td colspan="4">
						    			<div>${qna.qnaContent}</div>
						    		</td>
						    	</tr>
					    	</c:forEach>
						</tbody>
					</table>
				</div>
				<ul class="pagination justify-content-center" style="margin-top: 30px;">
                	<c:if test="${startPage != 1}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/serviceclient/myService/${startPage-1}" aria-label="Previous">
	                			<span aria-hidden="true">&laquo;</span>
	                		</a>
                		</li>
                	</c:if>
                	<c:forEach begin="${startPage}" end="${endPage}" var="p">
						<c:if test="${p == pg}">
							<li class="page-item active">
								<a class="page-link">${p}</a>
							</li>
						</c:if>
						<c:if test="${p != pg}">
							<li class="page-item">
								<a class="page-link" href="${contextPath}/serviceclient/myService/${p}">${p}</a>
							</li>
						</c:if>
					</c:forEach>
                	<c:if test="${endPage != pageCount}">
                		<li class="page-item">
                			<a class="page-link" href="${contextPath}/serviceclient/myService/${endPage+1}">
					    		<span aria-hidden="true">&raquo;</span>
					    	</a>
                		</li>
                	</c:if>
                </ul>
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