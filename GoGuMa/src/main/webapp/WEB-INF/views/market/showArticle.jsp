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
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.3/moment-with-locales.min.js" integrity="sha512-vFABRuf5oGUaztndx4KoAEUVQnOvAIFs59y4tO0DILGWhQiFnFHiR+ZJfxLDyJlXgeut9Z07Svuvm+1Jv89w5g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data-10-year-range.js" ></script>
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
	
	.reply-edit, .reply-delete, .reply-child-edit, .reply-child-delete  {
		cursor: pointer;
	}
	
	.btn-success {
        --bs-btn-color: #fff;
        --bs-btn-bg: #6426DD;
        --bs-btn-border-color: #6426DD;
        --bs-btn-hover-color: #fff;
        --bs-btn-hover-bg: #6426DD;
        --bs-btn-hover-border-color: #6426DD;
        --bs-btn-focus-shadow-rgb: 100, 38, 221;
        --bs-btn-active-color: #fff;
        --bs-btn-active-bg: #6426DD;
        --bs-btn-active-border-color: #6426DD;
        --bs-btn-active-shadow: inset 0 3px 5pxrgba(0, 0, 0, 0.125);
        --bs-btn-disabled-color: #fff;
        --bs-btn-disabled-bg: #6426DD;
        --bs-btn-disabled-border-color: #6426DD;
    }
    
    .text-success-reply {
	    --bs-text-opacity: 1;
	    color: rgb(100, 38, 221);
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
				
				//댓글 제출 버튼 클릭 핸들러
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
				
			
				//답글 보기/닫기 토글 버튼 클릭 이벤트 핸들러
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
				
				
				//답글 작성 버튼 클릭 이벤트 핸들러
				$("button[name='submit-create-child-reply']").click(function() {
					var textArea = $(this).parents(".reply-child-form-area").find("textarea[name='reply-child-textarea']");
					var replyId = $(this).parents(".reply-child-form-area").data("replyId");
					
					var formArea = $(this).parents(".reply-child-form-area ");
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
		        			var elem = "";
		        			elem += "<div class='reply-child-item pt-2 pb-2 border-bottom border-secondary mb-2' data-reply-id='"+ data.replyId + "'>"
							elem += "<div class='row mb-4'>";
			
							elem +=	"<div class='col-1'>";
							elem +=	"<img class='w-100 rounded-circle' src='" + data.member.profileImage + "' style='object-fit: cover;' />";
							elem += "</div>";
							elem += "<div class='col'>";
							elem +=	"<div name='user-nick-name'>";
							elem +=	"<strong>" + data.member.nickName + "</strong>";
							elem +=	"</div>";
							elem +=	"<div name='reg-date'>";
							elem +=	"<span class='text-secondary' style='font-size: 0.8rem;'>";
							elem +=	 "방금 전"
							elem +=	"</span>";
							elem +=	"</div>"; // regDate end
							elem +=	"</div>"; // <div class='col'> end
							elem += "<div class='reply-child-button-wrapper col-2 d-flex justify-content-end'>";
							elem += "<span class='reply-child-edit text-secondary'>수정</span>";
							elem += "<span class='reply-child-delete text-secondary ms-1'>삭제</span>";
							
							elem += "</div>" //<div class='col-2 d-flex justify-content-end'> end;
						
							elem += "</div>"; //<div class='row mb-4'> end
						
							elem += "<div>"
							elem += "<p class='reply-child-content'>" + data.replyContent + "</p>"
							elem += "<div class='reply-child-edit-form-area' data-reply-id='" + data.replyId + "' style='display: none;'>";
							elem += "<textarea name='reply-child-edit-textarea' class='w-100 p-2 border border-secondary rounded' style='resize: none; height: 70px;' placeholder='댓글을 작성하세요.'> </textarea>";
							elem +=  "<div class='button-wrapper mt-2 d-flex justify-content-end'>"; 
							elem += "<button name='close-edit-child-reply' type='button' class='btn btn-outline-success me-2'>취소</button>"
							elem += "<button name='submit-edit-child-reply' type='button' class='btn btn-success'>수정하기</button>";
							elem += "</div> </div>";
							
						
							
							formArea.before(elem);
							textArea.val("");
							
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
				
				//댓글 [수정] 클릭 이벤트 핸들러
				$(".reply-edit").click(function() {
					
					var replyItem = $(this).parents(".reply-item");
					var buttonWrapper = replyItem.find(".reply-button-wrapper");
					var replyContentParagraph = replyItem.find(".reply-content");
					var editForm = replyItem.find(".reply-edit-form-area");
					var editTextArea = editForm.find("textarea[name=reply-edit-textarea]").val(replyContentParagraph.text());
					
					
					buttonWrapper.addClass("d-none");
					replyContentParagraph.hide();
					editForm.show();
					
				});
				
				//댓글 [삭제] 클릭 이벤트 핸들러
				$(".reply-delete").click(function() {
					
					var replyItem = $(this).parents(".reply-item");
				
					var replyId = replyItem.data("replyId");
					
					var isParentReply = $(this).data("reply");
					
					var data = {
						replyId
					};
					
					if(confirm('정말로 삭제하시겠습니까?')){
						deleteReply(data, replyItem, isParentReply);
					}
					
				});
				
				
				//댓글 수정 취소 버튼 클릭 이벤트 핸들러
				$("button[name='close-edit-reply']").click(function() {
					
					var replyItem = $(this).parents(".reply-item");
					var editForm = replyItem.find(".reply-edit-form-area");
					var buttonWrapper = replyItem.find(".reply-button-wrapper");
					var replyContentParagraph  = replyItem.find(".reply-content");
					var editTextArea = editForm.find("textarea[name=reply-edit-textarea]").val("");
					
					editForm.hide();
					buttonWrapper.removeClass("d-none");
					replyContentParagraph.show();
				})
				
				//댓글 [수정 하기] 버튼 클릭 이벤트 핸들러
				$("button[name=submit-edit-reply]").click(function() {
					var replyItem = $(this).parents(".reply-item");
					var editForm = replyItem.find(".reply-edit-form-area");
					var buttonWrapper = replyItem.find(".reply-button-wrapper");
					var replyContentParagraph  = replyItem.find(".reply-content");
					var editTextArea = editForm.find("textarea[name=reply-edit-textarea]");
					
					var replyContent = editTextArea.val();
					var replyId = replyItem.data("replyId");
					if(!replyContent) {
						alert("내용을 입력해주세요.");
						return;
					}
					var data = {
						replyId,
						replyContent
					};
					
					console.log(data);
					updateReply(data,replyContentParagraph,editForm,buttonWrapper);
				
				})
				
				
				//답글 [수정] 클릭 이벤트 핸들러
				$(".reply-reply-list").on("click",".reply-child-button-wrapper .reply-child-edit", function() {
					var replyItem = $(this).parents(".reply-child-item");
					var buttonWrapper = replyItem.find(".reply-child-button-wrapper");
					var editForm = replyItem.find(".reply-child-edit-form-area");
					var replyChildContentParagraph = replyItem.find(".reply-child-content");
					var editTextArea = replyItem.find("textarea[name=reply-child-edit-textarea]");
					
					editTextArea.val(replyChildContentParagraph.text());
					buttonWrapper.addClass("d-none");
					replyChildContentParagraph.hide();
					editForm.show();
					
					
				});
				
				//답글 [수정 취소] 버튼 클릭 이벤트 핸들러
				$(".reply-reply-list").on("click","button[name=close-edit-child-reply]", function() {
					var replyItem = $(this).parents(".reply-child-item");
					var buttonWrapper = replyItem.find(".reply-child-button-wrapper");
					var editForm = replyItem.find(".reply-child-edit-form-area");
					var replyChildContentParagraph = replyItem.find(".reply-child-content");
					var editTextArea = replyItem.find("textarea[name=reply-child-edit-textarea]");
					
					editTextArea.val("");
					editForm.hide();
					buttonWrapper.removeClass("d-none");
					replyChildContentParagraph.show();
					
				});
				
				//답글 [수정 하기] 버튼 클릭 이벤트 핸들러
				$(".reply-reply-list").on("click","button[name=submit-edit-child-reply]", function() {
					var replyItem = $(this).parents(".reply-child-item");
					var buttonWrapper = replyItem.find(".reply-child-button-wrapper");
					var editForm = replyItem.find(".reply-child-edit-form-area");
					var replyChildContentParagraph = replyItem.find(".reply-child-content");
					var editTextArea = replyItem.find("textarea[name=reply-child-edit-textarea]");
					
					var replyContent = editTextArea.val();
					if(!replyContent) {
						alert("내용을 입력해주세요.");
						return;
					}
					
					var data = {
						replyId: replyItem.data("replyId"),
						replyContent: replyContent
					}
					
					updateReply(data,replyChildContentParagraph,editForm,buttonWrapper);
					
				});
				
				//답글 [삭제] 클릭 이벤트 핸들러
				
				$(".reply-reply-list").on("click",".reply-child-button-wrapper .reply-child-delete", function() {
					
					var replyItem = $(this).parents(".reply-child-item");
				
					var replyId = replyItem.data("replyId");
					
					var data = {
						replyId
					};
					
					if(confirm('정말로 삭제하시겠습니까?')){
						deleteReply(data, replyItem);
					}
					
				});
				
			} else {
				console.log("카카오 JDK 초기화 실패")
			}
			
			function dateformat(date) {
				console.log(date)
				var locatDate = new moment(date).tz("Asia/Seoul");
				var formattedDate = locatDate.format('yyyy-MM-DD HH:mm');
				return formattedDate;
			}
			
			//댓글 & 답글 수정 AJAX 호출 함수
			function updateReply(data,replyContentParagraph,editForm,buttonWrapper) {
				$.ajax({
					url: "${contextPath}/market/api/updateReply.do",
					method: "put",
					contentType: "application/json; charset=utf-8;",
	        		dataType: "json",
	        		data: JSON.stringify(data),
	        		beforeSend : function(xhr) {
			            xhr.setRequestHeader(header, token);
			        },
			        success: function() {
			        	replyContentParagraph.text(data.replyContent);
			        	
			        },
			        error: function(xhr, status, error) {
	        			console.log(xhr.status);
	        			var status = xhr.status;
	        			if(status === 401) {
	        				alert("로그인 후 이용이 가능합니다.");
	        			} else if(status === 403) {
	        				alert("댓글을 작성할 권한이 없습니다.");
	        			} else if(status === 404) {
	        				alert("이미 삭제된 댓글 입니다.");
	        			}  else {
	        				alert("서버 오류가 발생했습니다.");
	        			}
	        		},
	        		complete: function() {
						editForm.hide();
						buttonWrapper.removeClass("d-none");
						replyContentParagraph.show();
	        		}
				});
			}
			
			//댓글 & 답글 삭제 AJAX 호출 함수
			function deleteReply(data, replyItem, isParentReply) {
			
				$.ajax({
					url: "${contextPath}/market/api/deleteReply.do",
					method: "post",
	        		dataType: "json",
	        		data: data,
	        		beforeSend : function(xhr) {
			            xhr.setRequestHeader(header, token);
			        },
			        success: function() {
			        	if (isParentReply == true) {
				        	var replyCount = $("#reply-count").text() - 1;
				        	$("#reply-count").text(replyCount);
			        	}
			        	replyItem.remove();
			        },
			        error: function(xhr, status, error) {
	        			console.log(xhr.status);
	        			var status = xhr.status;
	        			if(status === 401) {
	        				alert("로그인 후 이용이 가능합니다.");
	        			} else if(status === 403) {
	        				alert("댓글을 작성할 권한이 없습니다.");
	        			} else if(status === 404) {
	        				alert("이미 삭제된 댓글 입니다.");
	        			}  else {
	        				alert("서버 오류가 발생했습니다.");
	        			}
	        		}
				});
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
					<strong>${article.market.marketName}</strong>
					<span class="badge text-light" style="background-color: #FF493C;">${article.market.category.categoryName}</span>
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
				<h5><span id="reply-count">${fn:length(replies)}</span>개 댓글</h5>
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
					<div class="reply-item pt-4 pb-4 border-bottom border-secondary" data-reply-id="${reply.replyId}" >
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
							<c:if test="${me.id eq reply.member.id}">
								<div class="reply-button-wrapper col-2 d-flex justify-content-end">
									<span class="reply-edit text-secondary">수정</span>
									<span class="reply-delete text-secondary ms-1" data-reply="true">삭제</span>
								</div>
							</c:if>
						</div>
						<!-- 프로필 영역 끝 -->
						<div>
							<p class="reply-content">${reply.replyContent}</p>
							<c:if test="${me.id eq reply.member.id}">
								<div class="reply-edit-form-area" data-reply-id="${reply.replyId}" style='display: none;'>
									<textarea name='reply-edit-textarea' class='w-100 p-2 border border-secondary rounded' style='resize: none; height: 70px;' placeholder='댓글을 작성하세요.'> </textarea>
									<div class='reply-edit-button-wrapper mt-2 d-flex justify-content-end'> 
										<button name='close-edit-reply' type='button' class='btn btn-outline-success me-2'>취소</button>
										<button name='submit-edit-reply' type='button' class='btn btn-success'>수정하기</button>
									</div>
								</div>
							</c:if>
						</div>

						<div class="reply-reply-area">
							<!-- 답글 영역 시작 -->
							<div class="reply-btn-area">
								<div class="reply-toggle-btn" data-toggle="false">
									<span><i class="bi bi-plus-square text-success-reply"></i></span>
									<span class="reply-btn text-success-reply">답글 보기</span>
								</div>
							</div>

							<div class="reply-reply-list w-100 p-3 bg-light rounded" style="display: none;">
								<!-- 답글 리스트 영역 시작-->
								<c:forEach items="${reply.childReplies}" var="childReply">
								<div class="reply-child-item pt-2 pb-2 border-bottom border-secondary mb-2" data-reply-id="${childReply.replyId}">
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
										<c:if test="${me.id eq childReply.member.id}">
											<div class="reply-child-button-wrapper col-2 d-flex justify-content-end">
												<span class="reply-child-edit text-secondary">수정</span>
												<span class="reply-child-delete text-secondary ms-1" data-reply="false">삭제</span>
											</div>
										</c:if>
									</div>
									<!-- 프로필 영역 끝 -->
									<div>
										<p class="reply-child-content">${childReply.replyContent}</p>
										<c:if test="${me.id eq reply.member.id}">
											<div class="reply-child-edit-form-area" data-reply-id="${reply.replyId}" style='display: none;'>
												<textarea name='reply-child-edit-textarea' class='w-100 p-2 border border-secondary rounded' style='resize: none; height: 70px;' placeholder='댓글을 작성하세요.'> </textarea>
												<div class='reply-edit-button-wrapper mt-2 d-flex justify-content-end'> 
													<button name='close-edit-child-reply' type='button' class='btn btn-outline-success me-2'>취소</button>
													<button name='submit-edit-child-reply' type='button' class='btn btn-success'>수정하기</button>
												</div>
											</div>
										</c:if>
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