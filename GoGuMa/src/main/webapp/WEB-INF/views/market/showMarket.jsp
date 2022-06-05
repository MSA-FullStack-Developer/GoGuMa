<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/a4f59ea730.js"
	crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>마켓 - 고구마</title>

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

<!-- jquery -->
<script type="text/javascript"
	src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
<style>
	<%@ include file="/resources/css/bootstrap-custom.css"%>
</style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			var marketId = $("input[name=marketId]").val();
			
			$("#follow-btn").click(function() {
				var data = {
						marketId: marketId,
						_csrf: token
				};
				var btn = $(this);
				
				$.ajax({ 
					url : '${contextPath}/market/api/updateFollow.do',
					type : 'POST',
					data : data,
					beforeSend : function(xhr) {
			            xhr.setRequestHeader(header, token);
		            },
					success:function(result) {
						console.log(result);
						var message = result.message;
						
						if(message === 'follow') {
							btn.removeClass();
							btn.addClass("btn btn-secondary");
							btn.html("팔로우 중");
						} else {
							btn.removeClass();
							btn.addClass("btn btn-primary");
							btn.html("팔로우 하기");
						}
						
					},
					error: function(req, status, error) {
						if(req.status == 401) {
							alert("로그인 후 이용 할 수 있습니다.");
						}else {
							alert("데이터 전송 중 문제가 발생하였습니다.");
						}
					}
				});
			}) 
		}); 	
	
	</script>
	<div class="container pt-3 pb-3">
		<input name="marketId" type="hidden" value="${market.marketId}" />
        <section name="head-area" class="w-100 border border-secondary rounded">
            <div class="w-100"
                style="background-image: url(${contextPath}/image/${market.marketBanner}); background-repeat: no-repeat; background-size: cover; background-position: center center; height: 200px;">
            </div>
            <div class="row p-4">
                <div class="col-1">
                    <img class="w-100 border border-secondary rounded-circle" src="${contextPath}/image/${market.marketThumbnail}" />
                </div>
                <div class="col-9">
                    <h5>${market.marketName}</h5>
                    <p class="text-secondary">${market.marketDetail}</p>
                    <span class="badge bg-info text-dark">${market.category.categoryName}</span>
                </div>
                
                <div class="col d-flex justify-content-center align-items-center">
                	<c:if test="${not isAlreadyFollow}">
                		<button id="follow-btn" type="button" class="btn btn-primary">팔로우 하기</button>
                	</c:if>
                	<c:if test="${isAlreadyFollow}">
                		<button id="follow-btn" type="button" class="btn btn-secondary">팔로우 중</button>
                	</c:if>
                
                </div>
            </div>

        </section>

        <section name="content-area" class="w-100 mt-3">
            <div class="d-flex justify-content-between">
                <h2>${market.marketName}의 진열대</h2>
                <c:if test="${isMine}">
                	 <button type="button" class="btn btn-success">글 작성하기</button>
                </c:if>
               
            </div>
          
            <div class="d-flex flex-wrap">

                <div class="card border border-dark mt-2" style="width: 18rem;">
                    <a href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604"
                        class="text-decoration-none text-dark">
                        <img src="https://image.hmall.com/static/6/6/28/10/2010286604_0.jpg?RS=400x400&AR=0"
                            class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">조 말론 다크 앰버 진저 릴리 콜롱 인텐스 스프레이 (원래 박스 없음)100ml/3.4oz</p>

                        </div>
                    </a>
                    <div class="card-footer bg-dark">

                        <div id="carouselProducts" class="carousel slide" data-bs-touch="false"
                            data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <a class="text-decoration-none text-light" href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604">
                                        <div class="row d-flex align-items-center">
                                            <div name="prod-thumb" class="col">
                                                <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                            </div>
                                            <div name="prod-name" class="col-8">
                                                <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                                <p class="text-secondary text-truncate mb-0" style="font-size: 13px;">상품 이름 이름 이름상품 름상름상름상</p>
                                                <span  style="font-size: 10px;">31,000원</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">32,000원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">33,000원</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 데이터가 2개 이상일 경우 보여주기 -->
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div> <!--carouselProducts 끝-->

                    </div> <!-- card footer 끝-->
                </div> <!--card 영역 끝-->

                <div class="card border border-dark mt-2 ms-auto" style="width: 18rem;">
                    <a href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604"
                        class="text-decoration-none text-dark">
                        <img src="https://image.hmall.com/static/6/6/28/10/2010286604_0.jpg?RS=400x400&AR=0"
                            class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">조 말론 다크 앰버 진저 릴리 콜롱 인텐스 스프레이 (원래 박스 없음)100ml/3.4oz</p>

                        </div>
                    </a>
                    <div class="card-footer bg-dark">

                        <div id="carouselProducts" class="carousel slide" data-bs-touch="false"
                            data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <a class="text-decoration-none text-light" href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604">
                                        <div class="row d-flex align-items-center">
                                            <div name="prod-thumb" class="col">
                                                <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                            </div>
                                            <div name="prod-name" class="col-8">
                                                <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                                <span  style="font-size: 13px;">31,000원</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">32,000원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">33,000원</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 데이터가 2개 이상일 경우 보여주기 -->
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div> <!--carouselProducts 끝-->

                    </div> <!-- card footer 끝-->
                </div> <!--card 영역 끝-->

                <div class="card border border-dark mt-2 ms-auto" style="width: 18rem;">
                    <a href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604"
                        class="text-decoration-none text-dark">
                        <img src="https://image.hmall.com/static/6/6/28/10/2010286604_0.jpg?RS=400x400&AR=0"
                            class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">조 말론 다크 앰버 진저 릴리 콜롱 인텐스 스프레이 (원래 박스 없음)100ml/3.4oz</p>

                        </div>
                    </a>
                    <div class="card-footer bg-dark">

                        <div id="carouselProducts" class="carousel slide" data-bs-touch="false"
                            data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <a class="text-decoration-none text-light" href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604">
                                        <div class="row d-flex align-items-center">
                                            <div name="prod-thumb" class="col">
                                                <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                            </div>
                                            <div name="prod-name" class="col-8">
                                                <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                                <span  style="font-size: 13px;">31,000원</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">32,000원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">33,000원</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 데이터가 2개 이상일 경우 보여주기 -->
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div> <!--carouselProducts 끝-->

                    </div> <!-- card footer 끝-->
                </div> <!--card 영역 끝-->

                <div class="card border border-dark mt-2 ms-auto" style="width: 18rem;">
                    <a href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604"
                        class="text-decoration-none text-dark">
                        <img src="https://image.hmall.com/static/6/6/28/10/2010286604_0.jpg?RS=400x400&AR=0"
                            class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">조 말론 다크 앰버 진저 릴리 콜롱 인텐스 스프레이 (원래 박스 없음)100ml/3.4oz</p>

                        </div>
                    </a>
                    <div class="card-footer bg-dark">

                        <div id="carouselProducts" class="carousel slide" data-bs-touch="false"
                            data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <a class="text-decoration-none text-light" href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604">
                                        <div class="row d-flex align-items-center">
                                            <div name="prod-thumb" class="col">
                                                <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                            </div>
                                            <div name="prod-name" class="col-8">
                                                <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                                <span  style="font-size: 13px;">31,000원</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">32,000원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">33,000원</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 데이터가 2개 이상일 경우 보여주기 -->
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div> <!--carouselProducts 끝-->

                    </div> <!-- card footer 끝-->
                </div> <!--card 영역 끝-->

                <div class="card border border-dark mt-2" style="width: 18rem;">
                    <a href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604"
                        class="text-decoration-none text-dark">
                        <img src="https://image.hmall.com/static/6/6/28/10/2010286604_0.jpg?RS=400x400&AR=0"
                            class="card-img-top" alt="...">
                        <div class="card-body">
                            <p class="card-text">조 말론 다크 앰버 진저 릴리 콜롱 인텐스 스프레이 (원래 박스 없음)100ml/3.4oz</p>

                        </div>
                    </a>
                    <div class="card-footer bg-dark">

                        <div id="carouselProducts" class="carousel slide" data-bs-touch="false"
                            data-bs-interval="false">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <a class="text-decoration-none text-light" href="https://www.hmall.com/p/pda/itemPtc.do?sectId=2731163&slitmCd=2010286604">
                                        <div class="row d-flex align-items-center">
                                            <div name="prod-thumb" class="col">
                                                <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                            </div>
                                            <div name="prod-name" class="col-8">
                                                <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                                <span  style="font-size: 13px;">31,000원</span>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">32,000원</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <div class="row d-flex align-items-center">
                                        <div name="prod-thumb" class="col">
                                            <img class="w-100 rounded" src="./웰시코기.jpeg" />
                                        </div>
                                        <div name="prod-name" class="col-8">
                                            <p class="text-truncate mb-0">상품 이름 이름 이름상품 름상름상름상</p>
                                            <span class="text-secondary" style="font-size: 13px;">33,000원</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 데이터가 2개 이상일 경우 보여주기 -->
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselProducts"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div> <!--carouselProducts 끝-->

                    </div> <!-- card footer 끝-->
                </div> <!--card 영역 끝-->
            </div>
        </section>
        <section name="pagination-area" class="w-100 mt-3 d-flex justify-content-center">
            <nav>
                <ul class="pagination">
                  <li class="page-item disabled">
                    <span class="page-link">Previous</span>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item active" aria-current="page">
                    <span class="page-link">2</span>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                  </li>
                </ul>
              </nav>
        </section>
    </div>

</body>
</html>