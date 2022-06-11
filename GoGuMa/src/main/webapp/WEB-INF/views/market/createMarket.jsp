<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://kit.fontawesome.com/a4f59ea730.js"
	crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html>
<head>
	<meta charset="UTF-8">
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
	    #submit-btn {
	        background-color: #6426DD;
	        color: white;
	    }
	    #upload-thumbnail{
	        width: 100px;
	        height: 100px;
	        cursor: pointer;
	    }
	   
	    #upload-banner  {
	        width: 300px;
	        height: 300px;
	        cursor: pointer;
	    }
	</style>
	
	<script>
	    $(document).ready(function () {
	    	
	    	var error = "${error}";
	    	if(error) {
	    		alert(error);
	    	}
	    	
	        $("#upload-thumbnail").click(function () {
	            $("#thumbnail").click();
	        });
	
	        $("#upload-banner").click(function () {
	            $("#banner").click();
	        });
	        $("#thumbnail").change(function () {
	            var img = $("#preview-thumbnail");
	            readfile(this, img);
	        });
	        $("#banner").change(function () {
	            var img = $("#preview-banner");
	            readfile(this,img);
	        });
	
	        $("button[name=categoryBtn]").click(function() {
	            var btn = $(this);
	            var value = btn.data("value");
	            console.log(value);
	            $("#categoryId").val(value);
	
	        
	            btn.parent("div").find("button").each(function(idx,elem) {
	               
	                if($(elem).hasClass("btn-success")) {
	                    $(elem).removeClass("btn-success");
	                    $(elem).addClass("btn-outline-primary");
	                } 
	            });
	            $(this).removeClass("btn-outline-primary");
	            $(this).addClass("btn-success");
	        })
	    })
	
	    function readfile(input, img) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	
	          
	            reader.onload = function (e) {
	                img.attr('src', e.target.result);
	            }
	
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	</script>
</head>


<body>
	<%@ include file="../market/marketHeader.jsp" %>
    <section class="container">
        <div class="w-50 m-auto" style="min-width: 970px;">
            <h1>나만의 마켓 만들기</h1>
            <p class="text-secondary">아래 정보를 기입해주세요.</p>

            <form id="MarketForm" method="post" action="${contextPath}/market/createMarket.do" enctype="multipart/form-data">
                <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                <input type="hidden" name="memberId" value="12" /> 
                <label for="marketName" class="form-label">
                    사용할 마켓 이름
                </label>
                <input id="marketName" name="marketName" type="text" class="form-control"
                    placeholder="멋진 마켓 이름을 지어주세요." required/>
                <label for="marketDetail" class="form-label mt-3">
                    마켓 설명
                </label>
                <input id="marketDetail" name="marketDetail" type="text" class="form-control"
                    placeholder="마켓에 대해 설명해주세요." required/>
                <label for="thumbnail" class="form-label mt-3">
                    마켓 썸네일
                </label>
                <input id=thumbnail name="thumbnail" type="file" class="form-control" accept=".jpg, .jpeg, .png"
                    style="position: absolute; left: -9999px;"  required>
                <div id="upload-thumbnail">
                    <img id="preview-thumbnail" class="w-100 h-100" src="${contextPath}/resources/img/gallery.png"/>
                </div>
                <label for="banner" class="form-label mt-3">
                    마켓 배너 이미지 <span class="text-secondary">(가로 1320px 이상으로 넣어주세요.)</span>
                </label>
                <input id="banner" name="banner" type="file" class="form-control" accept=".jpg, .jpeg, .png"
                    style="position: absolute; left: -9999px;"  required>
                <div id="upload-banner">
                    <img id="preview-banner" class="w-100 h-100" src="${contextPath}/resources/img/gallery.png"/>
                </div>

                <input id="categoryId" name="categoryId" type="hidden" class="form-control" required/>
                <div class="accordion mt-3" id="accordionCategories">
                    <div class="accordion-item">
                      <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            카테고리 목록
                        </button>
                      </h2>
                      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="d-flex justify-content-between flex-wrap">
                            	<c:forEach items="${categoryList}" var="category">
                            		<button type="button" name="categoryBtn" class="btn btn-outline-primary mt-2" data-value="${category.categoryID}">${category.categoryName}</button>
                            	</c:forEach>                                
                            </div>
                        </div>
                      </div>
                    </div>       
                  </div>

                <button id="submit-btn" type="submit" class="w-100 btn mt-3 btn-lg">마켓 만들기</button>
              
            </form>
        </div>
    </section>
   	<%@ include file="../market/marketFooter.jsp" %>
</body>
</html>