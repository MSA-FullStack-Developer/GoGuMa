<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>

<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>마켓 - 고구마</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
        crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

    <!-- jquery -->
    <script type="text/javascript"
        src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
    <style>
        <%@ include file="/resources/css/bootstrap-custom.css" %>
        
        .btn-primary {
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
            --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            --bs-btn-disabled-color: #fff;
            --bs-btn-disabled-bg: #6426DD;
            --bs-btn-disabled-border-color: #6426DD;
        }

        .btn-secondary {
            --bs-btn-color: #fff;
            --bs-btn-bg: #FF493C;
            --bs-btn-border-color: #FF493C;
            --bs-btn-hover-color: #fff;
            --bs-btn-hover-bg: #FF493C;
            --bs-btn-hover-border-color: #FF493C;
            --bs-btn-focus-shadow-rgb: 255, 73, 60;
            --bs-btn-active-color: #fff;
            --bs-btn-active-bg: #FF493C;
            --bs-btn-active-border-color: #FF493C;
            --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            --bs-btn-disabled-color: #fff;
            --bs-btn-disabled-bg: #FF493C;
            --bs-btn-disabled-border-color: #FF493C;
        }
        
        .articleWriteBtn {
        	width: 100px;
		    height: 40px;
		    background-color: #6426DD;
		    color: white;
        }
        
		.card-img-top {
		    width: 100%;
		    height: 286px;
		    object-fit: cover;
		}
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            var marketId = $("input[name=marketId]").val();

            $("#follow-btn").click(function () {
                var data = {
                    marketId: marketId,
                    _csrf: token
                };
                var btn = $(this);

                $.ajax({
                    url: '${contextPath}/market/api/updateFollow.do',
                    type: 'POST',
                    data: data,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(header, token);
                    },
                    success: function (result) {
                        console.log(result);
                        var message = result.message;

                        if (message === 'follow') {
                            btn.removeClass();
                            btn.addClass("btn btn-secondary");
                            btn.html("팔로잉");
                        } else {
                            btn.removeClass();
                            btn.addClass("btn btn-primary");
                            btn.html("팔로우");
                        }

                    },
                    error: function (req, status, error) {
                        if (req.status == 401) {
                            alert("로그인 후 이용 할 수 있습니다.");
                        } else {
                            alert("데이터 전송 중 문제가 발생하였습니다.");
                        }
                    }
                });
            })
        }); 	
    </script>
</head>
<body>
	<%@ include file="../market/marketHeader.jsp" %>
	<div class="container pt-3 pb-3">
		<input name="marketId" type="hidden" value="${market.marketId}" />
        <section name="head-area" class="w-100 border border-secondary rounded">
            <div class="w-100"
                style="background-image: url(${market.marketBanner}); background-repeat: no-repeat; background-size: cover; background-position: center center; height: 200px;">
            </div>
            
            <div class="row p-4">
                <div class="col-1">
                    <img class="border border-secondary rounded-circle" src="${market.marketThumbnail}" style="width: 100px; height: 100px; object-fit: cover; margin-right: 10px;"/>
                </div>
                
                <div class="col-9" style="margin-left: 10px;">
                    <h5>${market.marketName}</h5>
                    <p class="text-secondary">${market.marketDetail}</p>
                    <span class="badge text-light" style="background-color: #FF493C;">${market.category.categoryName}</span>
                </div>
                
                <div class="col d-flex justify-content-center align-items-center">
                	<c:if test="${not isAlreadyFollow}">
                		<button id="follow-btn" type="button" class="btn btn-primary">팔로우</button>
                	</c:if>
                	<c:if test="${isAlreadyFollow}">
                		<button id="follow-btn" type="button" class="btn btn-secondary">팔로잉</button>
                	</c:if>
                </div>
            </div>
        </section>
        
        <section name="content-area" class="w-100 mt-3">
            <div class="d-flex justify-content-between">
                <h2>${market.marketName}의 진열대</h2>
                <c:if test="${isMine}">
                	 <a type="button" class="btn articleWriteBtn" href="${contextPath}/market/${market.marketId}/article/write.do">글 작성하기</a>
                </c:if>
            </div>
            <c:if test="${fn:length(pagination.data) == 0}">
            	<div name="no-data" class="h-50 d-flex flex-column align-items-center">
	                <div style="margin-top: 100px; margin-bottom: 30px;">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor"
	                        class="bi bi-exclamation-circle" viewBox="0 0 16 16">
	                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
	                        <path
	                            d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z" />
	                    </svg>
	                </div>
	                <p class="fs-3">등록한 게시글이 없습니다. 글을 작성해주세요.</p>
	            </div> 
            </c:if>
            
          	<c:if test="${fn:length(pagination.data) > 0}">
            <div class="d-flex flex-wrap">
            	<c:forEach items="${pagination.data}" var="article" varStatus="articleStatus">
	            	<c:if test="${articleStatus.index % 4 == 0}">
	            	<div class="card border border-dark mt-2" style="width: 18rem;">
	            	</c:if>
					<c:if test="${articleStatus.index % 4 != 0}">
	                <div class="card border border-dark mt-2 ms-5" style="width: 18rem;">
	                </c:if>
	                    <a href="${contextPath}/market/article/${article.articleId}/show.do"
	                        class="text-decoration-none text-dark">
	                        <img src="${article.thumbnail.imagePath}"
	                            class="card-img-top" alt="...">
	                        <div class="card-body">
	                            <p class="card-text text-truncate">${article.articleTitle}</p>
	                        </div>
	                    </a>
	                    <div class="card-footer bg-dark">
							<!-- carouselProducts 아이디 교유하게 하기 -->
	                        <div id="carouselProducts${articleStatus.index}" class="carousel slide" data-bs-touch="false"
	                            data-bs-interval="false">
	                            <div class="carousel-inner">
	                            	<c:forEach items="${article.products}" var="product" varStatus="status">
	                            	<c:if test="${status.first}">
	                                	<div class="carousel-item active">
	                                </c:if>
	                                <c:if test="${not status.first}">
	                                	<div class="carousel-item">
	                                </c:if>
	                                    <a class="text-decoration-none text-light" href="${contextPath}/category/1/${product.categoryId}/detail/${product.parentId}">
	                                        <div class="row d-flex align-items-center">
	                                            <div name="prod-thumb" class="col">
	                                                <img class="w-100 rounded" src="${product.prodImgUrl}" />
	                                            </div>
	                                            <div name="prod-name" class="col-8">
	                                                <p class="text-truncate mb-0">${product.productName}</p>
	                                                <p class="text-secondary text-truncate mb-0" style="font-size: 13px;">${product.optionName}</p>
	                                                <span  style="font-size: 10px;"><fmt:formatNumber value="${product.productPrice}"/>원</span>
	                                            </div>
	                                        </div>
	                                    </a>
	                            		</div>
	                                </c:forEach>
	                            </div>
	                         
	                          	<c:if test="${fn:length(article.products) > 1}">
	                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts${articleStatus.index}"
	                                data-bs-slide="prev">
	                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                                <span class="visually-hidden">Previous</span>
	                            </button>
	                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts${articleStatus.index}"
	                                data-bs-slide="next">
	                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                                <span class="visually-hidden">Next</span>
	                            </button>
	                            </c:if>
	                        </div> <!--carouselProducts 끝-->
	                    </div> <!-- card footer 끝-->
	                </div> <!--card 영역 끝-->
                </c:forEach>
            </div>
            </c:if>
        </section>
        <c:if test="${fn:length(pagination.data) > 0}">
        <section name="pagination-area" class="w-100 mt-3 d-flex justify-content-center">
            <nav>
                <ul class="pagination">
                  <c:if test="${pagination.currentPage == 1}">
                    <li class="page-item disabled">
                      <span class="page-link">이전</span>
                  	</li>
                  </c:if>
                  <c:if test="${pagination.currentPage != 1}">
                  	 <li class="page-item">
                      <a class="page-link" href="${contextPath}/market/show.do?marketNum=${market.marketId}&pg=${pagination.currentPage-1}">이전</a>
                  	</li>
                  </c:if>
                  <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" step="1" var="pg">
                  	<c:if test="${pg == pagination.currentPage}">
                  		<li class="page-item active">
							<span class="page-link">${pg}</span>
                  		</li>
                  	</c:if>
                  	<c:if test="${pg != pagination.currentPage}">
                  		<li class="page-item">
                  	 		<a class="page-link" href="${contextPath}/market/show.do?marketNum=${market.marketId}&pg=${pg}">${pg}</a>
                  		</li>
                  	</c:if>
                  </c:forEach>
                 	
                  <c:if test="${pagination.currentPage == pagination.pageCount}">
                    <li class="page-item disabled">
                      <span class="page-link">다음</span>
                  	</li>
                  </c:if>
                  <c:if test="${pagination.currentPage != pagination.pageCount}">
                  	 <li class="page-item">
                      <a class="page-link" href="${contextPath}/market/show.do?marketNum=${market.marketId}&pg=${pagination.currentPage+1}">다음</a>
                  	</li>
                  </c:if>
                </ul>
              </nav>
        </section>
        </c:if>
    </div>
</body>
</html>