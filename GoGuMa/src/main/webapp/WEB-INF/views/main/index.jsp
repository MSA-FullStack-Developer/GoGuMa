<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://kit.fontawesome.com/a4f59ea730.js" crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고구마 - 고객과 구성하는 마켓</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

   	<!-- jquery -->
	<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    
    <style>
    	<%@ include file="/resources/css/bootstrap-custom.css" %>
    </style>
</head>

<body>
    <style>
        #banner-section {
            background-color: #3831C9;
            transition: background-color 0.3s ease-in-out 0s;
			margin-top: 38px;
        }

        #md-category .list-group-item:hover {
            background-color: #FF493C;
            cursor: pointer;
        }

        #md-category .list-group-item:hover span {
            color: white;
        }

        #md-category .active {
            background-color: #6426DD !important;

        }

        #md-category .active span {
            color: white !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            var bannerSectionBgColors = ['#3831C9', '#C0E3FE', '#FFF8E7'];

            $(".list-group-item ").click(function () {
                $(this).parent().find('li').removeClass('active');
                $(this).addClass('active');
                var categoryId = $(this).parent("ul").find("li.active").children("input[type=hidden]").val();
                console.log(categoryId);
                getProductList(categoryId);
            });

            $("#banner-slide").on('slide.bs.carousel', function (event) {
                var bannderSection = $("#banner-section");

                var nextactiveslide = event.to;

                bannderSection.css('background-color', bannerSectionBgColors[nextactiveslide]);
            })
            
            var categoryId = $("#categoryGroup").find("li.active").children("input[type=hidden]").val();
            console.log(categoryId);
            getProductList(categoryId);
        });
        
        function addComma(number) {
        	var regexp = /\B(?=(\d{3})+(?!\d))/g;                
        	return number.toString().replace(regexp, ',');
        }
        
        function getProductList(categoryId) {
        	$.ajax({
        		url: "${contextPath}/api/v1/product?categoryId="+categoryId,
        		
        		dataType: "json",
        		success: function(data) {
        			console.log(data);
        			var items = $("#list-products");
        			items.empty();
        			data.forEach(elem => {
        				
        				var item = "<div class='card mt-3' style='width: 18rem;'>";
        				item += "<a href= '${contextPath}/category/1/" + elem.categoryID + "/detail/" + elem.productID + "'" + " class='text-decoration-none text-dark'>";
        				item += "<img src='" + elem.prodimgurl + "' class='card-img-top'" + "alt='" + elem.productName + "' style='height: 286px;'> </a>";
        				item += "<div class='card-body border-top border-light d-flex flex-column justify-content-between'>";
        				item += "<p class='card-text'>" + elem.productName + "</p>";
        				item += "<p><strong>"  + addComma(elem.productPrice) + "</strong>원</p></div> </div>";
        				items.append(item);
        			});
        			
        		},
        		error: function(xhr, status, error) {
        			alert("서버에 예상치 못한 오류 발생.");
        		}
        	});
        }
    </script>
    
	<%@ include file="../header.jsp" %>
	
    <div class="w-100" style="min-width: 1400px;">
        <section id="banner-section" class="continer-fluid">
            <div class="m-auto" style="width: 1240px;">
                <div id="banner-slide" class="carousel slide carousel-fade" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                        	<a href="${contextPath}/event/event1.do">
                            <img src="${contextPath}/resources/img/web_banner_001.png"
                                class="d-block w-80" alt="이벤트1 배너" />
                                </a>
                        </div>

                        <div class="carousel-item">
                            <img src="https://cdn.011st.com/11dims/resize/1240x400/quality/99/11src/http://cdn.011st.com/ds/2022/03/28/1415/fd3b6818fadc5c97cc941af5c357bd08.png"
                                class="d-block w-100" alt="이벤트2 배너">
                        </div>
                        <div class="carousel-item">
                            <img src="https://cdn.011st.com/11dims/resize/1240x400/quality/99/11src/http://cdn.011st.com/ds/2022/02/10/1415/d50c627745af74a5684f083ce6076e4c.jpg"
                                class="d-block w-100" alt="이벤트3 배너">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#banner-slide"" data-bs-slide="
                        prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">이전</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#banner-slide"" data-bs-slide="
                        next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">다음</span>
                    </button>
                </div>
            </div>
        </section>

        <section id="main-section" class="container-xxl pt-5 pb-5">

            <!-- MD 추천 카테고리 리스트 화면 -->
            <div id="md-category">
                <h3>MD 추천</h3>
                <ul id="categoryGroup" class="list-group list-group-horizontal">
                	<c:forEach var="category" items="${categoryList}" varStatus="status">
                		<c:if test="${status.first}">
                			<li class="list-group-item flex-fill d-flex justify-content-center align-items-center active">
                				<input type="hidden" value="${category.categoryID}"/>
                        		<span>${category.categoryName}</span>
                    		</li>
                		</c:if>
                		<c:if test="${not status.first}">
                			<li class="list-group-item flex-fill d-flex justify-content-center align-items-center">
                				<input type="hidden" value="${category.categoryID}"/>
                        		<span>${category.categoryName}</span>
                    		</li>
                    	</c:if>
                		
                	</c:forEach>
                </ul>
            </div> <!-- MD 추천 카테고리 리스트 화면 끝 -->

            <!-- 상품 리스트 화면 -->
            <div class="w-100 mt-4">
                <div id="list-products" class="d-flex justify-content-between align-content-between flex-wrap">
                	<div class="card mt-3" aria-hidden="true" style="width: 18rem;">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
                   
                    <div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body mt-3">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
					<div class="card mt-3" aria-hidden="true">
						<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
	  						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
	 						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
						</svg>
					  	<div class="card-body">
					  		<div class="h5 card-title placeholder-glow">
					  			<span class="placeholder col-8"></span>
					  		</div>
						    <p class="card-text placeholder-glow">
						      <span class="placeholder col-6"></span>
						    </p>
				  		</div>
				
					</div>
                </div>
            </div> <!-- 상품 리스트 화면 끝  -->
        </section>
    </div> <!-- 메인 화면 wrapper 끝-->
    
    <%@ include file="../footer.jsp" %>
</body>

</html>