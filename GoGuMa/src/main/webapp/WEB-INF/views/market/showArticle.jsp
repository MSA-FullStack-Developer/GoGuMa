<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>게시글 작성 - 고구마</title>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- kakao JDK -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- bootstrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">

<!-- bootstrap js -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
	crossorigin="anonymous"></script>

<!-- bootstrap icon -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
.profile-img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	margin-right: 10px;
	border-radius: 50%;
	margin-left: 25px;
}

.reply-toggle-btn {
	cursor: pointer;
}
</style>

</head>

<body>
	<%@ include file="../market/marketHeader.jsp" %>
	<script type="text/javascript">
	
		$(document).ready(function(){
			
			var token = $("meta[name='_csrf']").attr("content");
		    var header = $("meta[name='_csrf_header']").attr("content");
			
			var tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
			var tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
			
			Kakao.init("86e9cfc5f205d9ffa1a907baecda8000");
			
			if(Kakao.isInitialized()) {
				
				Kakao.Link.createDefaultButton({
					container: "#kakao-share-btn",
					 objectType : 'feed',
					  content : {
						title : "${article.articleTitle}",
						description : "${article.market.category.categoryName}",
						imageUrl : "${article.thumbnail.imagePath}",
						link : {
							mobileWebUrl : "http://localhost:8090/goguma/market/article/${article.articleId}/show.do",
							webUrl : "http://localhost:8090/goguma/market/article/${article.articleId}/show.do",
						},
					  },
					 
					  buttons : [
						{
							title : '웹으로 보기',
							link : {
								mobileWebUrl : "http://localhost:8090/goguma/market/article/${article.articleId}/show.do",
								webUrl : "http://localhost:8090/goguma/market/article/${article.articleId}/show.do",
							},
						}]
				});
				
				$("#submit-create-reply").click(function() {
					var articleId = "${article.articleId}";
					var replyTextArea = $("#reply-textarea");
					var replyContent = replyTextArea.val();
					
					if(!replyContent) {
						alert("내용을 입력해주세요.");
						return;
					}
					var data = {
						articleId: articleId,
						replyContent: replyContent
					};
					
					$.ajax({
						url: "${contextPath}/market/api/createReply.do",
						method: "post",
		        		dataType: "json",
		        		data: data,
		        		beforeSend : function(xhr) {
				            xhr.setRequestHeader(header, token);
				        },
		        		success: function(data) {
		        			window.location.reload();
		        		},
		        		error: function(xhr, status, error) {
		        			console.log(xhr.status);
		        			var status = xhr.status;
		        			if(status === 401) {
		        				alert("로그인 후 이용이 가능합니다.");
		        			} else if(status === 403) {
		        				alert("댓글을 작성할 권한이 없습니다.");
		        			} else {
		        				alert("서버 오류가 발생했습니다.");
		        			}
		        		}
					})
				});
				
			
				$(".reply-toggle-btn").click(function() {
				
					var toggle = $(this).data("toggle");
					$(this).closest(".reply-btn-area").siblings("div").toggle();
	
					if(!toggle) {
						$(this).find(".reply-btn").text("답글 닫기");
					
					} else {
						$(this).find(".reply-btn").text("답글 보기");
					}
					toggle = !toggle;
					$(this).data("toggle", toggle);
					
				});
				
				$("button[name='submit-create-child-reply']").click(function() {
					var textArea = $(this).parents(".reply-child-form-area").find("textarea[name='reply-child-textarea']");
					var replyId = $(this).parents(".reply-child-form-area").data("replyId");
					if(!textArea.val()) {
						alert("내용을 입력해주세요.");
						return;
					}
					var articleId = "${article.articleId}";
					var data = {
						replyId,
						articleId,
						replyContent: textArea.val()
					};
					
					$.ajax({
						url: "${contextPath}/market/api/createChildReply.do",
						method: "post",
		        		dataType: "json",
		        		data: data,
		        		beforeSend : function(xhr) {
				            xhr.setRequestHeader(header, token);
				        },
		        		success: function(data) {
		        			console.log(data);
		        		},
		        		error: function(xhr, status, error) {
		        			console.log(xhr.status);
		        			var status = xhr.status;
		        			if(status === 401) {
		        				alert("로그인 후 이용이 가능합니다.");
		        			} else if(status === 403) {
		        				alert("댓글을 작성할 권한이 없습니다.");
		        			} else {
		        				alert("서버 오류가 발생했습니다.");
		        			}
		        		}
					})
					
				});
				
			} else {
				console.log("카카오 JDK 초기화 실패")
			}
		});
	</script>
	<section class="container">
		<div class="w-50 m-auto p-5" style="min-width: 970px;">

			<div class="d-flex justify-content-between">

				<h1>${article.articleTitle}</h1>
				<button type="button" id="kakao-share-btn"
					class="border-0 bg-transparent" data-bs-toggle="tooltip"
					data-bs-placement="top" data-bs-custom-class="custom-tooltip"
					title="카카오톡 링크 공유하기">
					<img
						src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
						alt="카카오톡 공유 보내기 버튼" style="width: 40px; height: 40px;" />
				</button>
			</div>
			<div class="d-flex justify-content-between">
				<p>
					<strong>${article.market.marketName}</strong> <span
						class="badge text-bg-info ms-1">${article.market.category.categoryName}</span>
				</p>
				<span class="ms-1 text-secondary"><fmt:formatDate
						value="${article.regDate}" pattern="yyyy-MM-dd HH:mm" /></span>
			</div>

			<div id="article-area">
				<c:if test="${isMyArticle}">
					<a class="text-decoration-none text-secondary"
						href="${contextPath}/market/${article.market.marketId}/article/${article.articleId}/edit.do">
						수정 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-pencil-square"
							viewBox="0 0 16 16">
  						<path
								d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
 	 					<path fill-rule="evenodd"
								d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
						</svg>
					</a>
				</c:if>
				<div class="accordion mb-3 mt-3" id="accordionSelectedProducts">
					<div class="accordion-item">
						<h2 class="accordion-header" id="headingOne">
							<button class="accordion-button" type="button"
								data-bs-toggle="collapse" data-bs-target="#collapseOne"
								aria-expanded="true" aria-controls="collapseOne">상품 목록
							</button>
						</h2>
						<div id="collapseOne" class="accordion-collapse collapse show"
							aria-labelledby="headingOne" data-bs-parent="#accordionExample">
							<div class="accordion-body">
								<ul id="selectedProducts" class="list-group">
									<c:forEach items="${article.products}" var="product">
										<li class="list-group-item list-group-item-action">
											<a href="${contextPath}/category/1/${product.categoryId}/detail/${product.parentId}" class="text-decoration-none text-dark">
												<div class="row">
													<div class="col-2" style="padding-right: 0px;">
														<img src="${product.prodImgUrl}" class="w-100 h-100" />
													</div>
													<div class="col"
														style="margin-top: 12px; margin-left: 10px;">
														<p>${product.productName}</p>
														<p class="text-secondary">${product.optionName}</p>
														<p class="text-text-secondary">
															<fmt:formatNumber value="${product.productPrice}" />
															원
														</p>
													</div>
												</div>
											</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div id="content-area" style="padding: 10px;">
					${article.articleContent}</div>
			</div>
			<!-- article-area 끝 -->
			<div id="market-info-area" class="row mt-2">
				<div class="col-2">
					<a
						href="${contextPath}/market/show.do?marketNum=${article.market.marketId}"
						class="h4 text-decoration-none text-dark"> <img
						class="border border-secondary rounded-circle profile-img"
						src="${article.market.marketThumbnail}" />
					</a>
				</div>
				<div class="col d-flex flex-column justify-content-center">
					<a
						href="${contextPath}/market/show.do?marketNum=${article.market.marketId}"
						class="h4 text-decoration-none text-dark">${article.market.marketName}</a>
					<p class="text-secondary mt-1">${article.market.marketDetail}</p>
				</div>
			</div>
			<!-- market-info-area 끝 -->
			<div id="reply-area" class="w-100 mt-5">
				<h5>${fn:length(replies)}개 댓글</h5>
				<div class="mt-4">
					<textarea id="reply-textarea" class="w-100 p-2 border border-secondary rounded"
						style="resize: none; height: 70px;" placeholder="댓글을 작성하세요."></textarea>
					<div id="button-wrapper" class="mt-2 d-flex justify-content-end">
						<button id="submit-create-reply" type="button"
							class="btn btn-success">댓글 작성</button>
					</div>
				</div> <!-- 댓글 작성 폼 영역 끝-->
				<div class="mt-3"> <!-- 댓글 리스트 영역 시작-->
					<c:forEach items="${replies}" var="reply">
					<div class="pt-4 pb-4 border-bottom border-secondary">
						<!-- 댓글 아이템 시작 -->
						<div class="row mb-4">
							<!-- 프로필 영역 시작 -->
							<div class="col-1">
								<img class="w-100 rounded-circle" src="${reply.member.profileImage}"
									style="object-fit: cover;" />
							</div>
							<div class="col">
								<div name="user-nick-name">
									<strong>${reply.member.nickName}</strong>
								</div>
								<div name="reg-date">
									<span class="text-secondary" style="font-size: 0.8rem;">
										 <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd HH:mm" />
									</span>
								</div>
							</div>
						</div>
						<!-- 프로필 영역 끝 -->
						<div>
							<p>${reply.replyContent}</p>
						</div>

						<div class="reply-reply-area">
							<!-- 답글 영역 시작 -->
							<div class="reply-btn-area">
								<div class="reply-toggle-btn" data-toggle="false">
									<span><i class="bi bi-plus-square fa-2x text-success"></i></span>
									<span class="reply-btn text-success">답글 보기</span>
								</div>
							</div>

							<div class="w-100 p-3 bg-light rounded" style="display: none;">
								<!-- 답글 리스트 영역 시작-->
								<c:forEach items="${reply.childReplies}" var="childReply">
								<div class="pt-2 pb-2 border-bottom border-secondary mb-2">
									<!-- 답글 아이템 시작 -->

									<div class="row mb-4">
										<!-- 프로필 영역 시작 -->
										<div class="col-1">
											<img class="w-100 rounded-circle" src="${childReply.member.profileImage}"
												style="object-fit: cover;" />
										</div>
										<div class="col">
											<div name="user-nick-name">
												<strong>${childReply.member.nickName}</strong>
											</div>
											<div name="reg-date">
												<span class="text-secondary" style="font-size: 0.8rem;">
													 <fmt:formatDate value="${childReply.createdAt}" pattern="yyyy-MM-dd HH:mm" />
												</span>
											</div>
										</div>
									</div>
									<!-- 프로필 영역 끝 -->
									<div>
										<p>${childReply.replyContent}</p>
									</div>
								</div>
								<!-- 답글 아이템 끝-->
								</c:forEach>
								<div class="reply-child-form-area mt-2" data-reply-id="${reply.replyId}" class="mt-4">
									<textarea name="reply-child-textarea" class="w-100 p-2 border border-secondary rounded"
										style="resize: none; height: 70px;" placeholder="댓글을 작성하세요."></textarea>
									<div class="button-wrapper mt-2 d-flex justify-content-end">
						
										<button name="submit-create-child-reply" type="button"
											class="btn btn-success">댓글 작성</button>
									</div>
								</div>
								<!-- 댓글 작성 폼 영역 끝-->
							</div>
							<!-- 답글 리스트 영역 끝 -->
						</div>
						<!-- 답글 영역 끝 -->
					</div>
					<!-- 댓글 아이템 끝 -->
					</c:forEach>
				</div>
				<!-- 댓글 리스트 영역 끝-->
				
			</div>
		</div>
	</section>
</body>
</html>