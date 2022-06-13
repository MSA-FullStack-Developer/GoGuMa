<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고구마 - 고객과 구성하는 마켓</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>

    <!-- bootstrap icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $("li").click(function(){
                
                var productId = $(this).data("productId");
                var imgSrc = $(this).find("img").attr("src");
                var productName = $(this).find("p[name=productName]").text();
                var optionName = $(this).find("p[name=optionName]").text();
                console.log(productId + " " + imgSrc + " " + productName);

              
                var elem = "";
                elem += "<li class='list-group-item list-group-item-action'>";
                elem += "<input name='productId' type='hidden' value='" + productId + "' />";
                elem += "<div class='row'>";
                elem += "<div class='col-2'>";
                elem += "<img src='" + imgSrc + "' class='w-100'/> </div>";
                elem += "<div class='col'>";
                elem += "<p>" + productName + "</p>";
                elem += "<p class='text-secondary' style='font-size: 13px;'>" + optionName + "</p> </div>";
                elem += "<div class='col-1 d-flex align-items-center'> <button type='button' name='delete-btn' class='btn btn-danger'> <svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash' viewBox='0 0 16 16'><path d='M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z'/><path fill-rule='evenodd' d='M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z'/>/svg> </button> </div>"
                elem += "</div> </li>"
                
                $("#selectedProducts",opener.document).prepend(elem);

                self.close();
                      
            }) 
        });
    </script>
</head>

<body>
    <section class="container pt-3 pb-3">
        <h1>상품 찾기</h1>
        <form action="${contextPath}/market/article/searchProudct.do" method="get">
        	<div class="input-group mb-3">
	            <input name="keyword" type="text" class="form-control" placeholder="찾을려는 상품을 검색하세요." aria-label="찾을려는 상품을 검색하세요."
	                aria-describedby="button-addon2" value="${keyword}">
	            <button type="submit" id="search-btn" class="btn btn-outline-secondary" type="button" id="button-addon2">
	                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
	                    viewBox="0 0 16 16">
	                    <path
	                        d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
	                </svg>
	            </button>
         	</div>
         </form>
        <div class="w-100 border border-secondary">
        	<c:if test="${products eq null}">
	        	<div name="no-data" class="h-25 d-flex flex-column justify-content-center align-items-center">
	                <div>
	                    <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor"
	                        class="bi bi-exclamation-circle" viewBox="0 0 16 16" style="margin-top: 20px;">
	                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
	                        <path
	                            d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z" />
	                    </svg>
	                </div>
	                <p class="fs-3">조회된 상품이 없습니다.</p>
	            </div> 
        	</c:if>
            <c:if test="${products ne null}">
	            <div name="result-data" class="p-3">
	                <h3>조회 결과</h3>
	                <ul class="list-group">
	                	<c:forEach items="${products}" var="product" >
		                	<li class="list-group-item list-group-item-action" data-product-id="${product.productId}">
		                        <div class="row">
		                            <div class="col-2" style="height: 10px; margin-top: 4px;">
		                                <img src="${product.prodImgUrl}" style="width: 70px; height: 70px;"/>
		                            </div>
		                            <div class="col" style="margin-top: 11px; margin-left: 5px;">
		                                <p name="productName" style="margin-top: 0; margin-bottom: 0;">${product.productName}</p>
		                                <p name="optionName" class="text-secondary" style="font-size: 13px;">${product.optionName}</p>
		                            </div>
		                        </div>
		                    </li>
	                	</c:forEach>
	                </ul>
	            </div>
            </c:if>
        </div>
    </section>
</body>
</html>