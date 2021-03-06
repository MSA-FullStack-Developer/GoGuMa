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

    <!-- include summernote css/js -->
    <link href="${contextPath}/resources/summernote/summernote-lite.css" rel="stylesheet">
    <script src="${contextPath}/resources/summernote/summernote-lite.js"></script>
    <script src="${contextPath}/resources/summernote/summernote-ko-KR.js"></script>
</head>
<style>
    #submit-btn {
        background-color: #6426DD;
        color: white;
    }

    #upload-thumbnail {
        width: 150px;
        height: 150px;
        cursor: pointer;
    }
</style>

<script>
    $(document).ready(function() {

        $("#add-product-btn").click(function() {

            var width = 540;
            var height = 600; 

            var left = (document.body.offsetWidth / 2) - (width / 2);
            var tops = (document.body.offsetHeight / 2) - (height / 2);

            left += window.screenLeft;

            var option = "";
            option += "width=" + width;
            option += ", height=" + height;
            option += ", left=" + left;
            option += ", top=" + top;
            window.open('${contextPath}/market/article/searchProudct.do', 'popup', option);

        });
        
        $("#selectedProducts").on("click", "button[name=delete-btn]",function(e) {
            var li = $(this).parents("li")[0];
            li.remove();
        });
        
        $("#submit-btn").click(function(e) {
        	e.preventDefault();
        	
        	var productIdCount = $("input[name=productId]").length;
        	
        	var title = $("#articleTitle").val();
        	var thumbnail = $("#thumbnail").val();
        	
        	
			if(productIdCount == 0) {
				alert("상품을 추가해주세요.");
			}else if(!title) {
				alert("제목을 입력해주세요.");
			}else if(!thumbnail) {
				alert("썸네일을 입력해주세요.");
			} else if($("#summernote").summernote('isEmpty')) {
				alert("본문 내용을 입력해주세요.");
			} else {
				$("#articleForm").submit();
			}
			
        });
    })

    $(document).ready(function () {
        $('#summernote').summernote({
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['picture']],
            ],
            height: 500,                 // 에디터 높이
            minHeight: null,             // 최소 높이
            maxHeight: null,             // 최대 높이
            focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",					// 한글 설정
            callbacks: {	//여기 부분이 이미지를 첨부하는 부분
                 onImageUpload: function (files) {
                     uploadSummernoteImageFile(files[0], this);
                 }
            }
        });

        $(".note-group-image-url").remove();    //이미지 추가할 때 Image URL 등록 input 삭제 

    });

    $(document).ready(function () {
        $("#upload-thumbnail").click(function () {
            $("#thumbnail").click();
        });


        $("#thumbnail").change(function () {
            var img = $("#preview-thumbnail");
            readfile(this, img);
        });
    });

    function readfile(input, img) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();


            reader.onload = function (e) {
                img.attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		data.append("${_csrf.parameterName}", "${_csrf.token}");
		$.ajax({
			data : data,
			type : "POST",
			url : "${contextPath}/market/api/uploadArticleImage.do",
			contentType : false,
			processData : false,
			success : function(data) {
				console.log(data);
				
				var imageURL = data.imagePath;
				//var img = $("<img>").attr({src: imageURL, width: '100%'});
				$(editor).summernote('insertImage', imageURL);
				//$(editor).summernote('insertNode', img[0]);
			},
			error: function() {
				alert("이미지 업로드에 실패하였습니다.");
			}
		});
	}
</script>

<body>
	<%@ include file="../market/marketHeader.jsp" %>
    <section class="container">
        <div class="w-50 m-auto" style="min-width: 970px;">
            <h1>게시글 만들기</h1>
            <p class="text-secondary">아래 정보를 기입해주세요.</p>

            <form id="articleForm" action="${contextPath}/market/article/createArticle.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="marketId" value="${marketId}"/>
                <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
                <label for="articleTitle" class="form-label">
                    게시글 제목
                </label>
                <input id="articleTitle" name="articleTitle" type="text" class="form-control"
                    placeholder="게시글의 제목을 지어주세요." required />
                <label for="thumbnail" class="form-label mt-3">
                    썸네일
                </label>
                <input id="thumbnail" name="thumbnail" type="file" class="form-control" accept=".jpg, .jpeg, .png"
                    style="position: absolute; left: -9999px;" required>
                <div id="upload-thumbnail">
                    <img id="preview-thumbnail" class="w-100 h-100" src="${contextPath}/resources/img/gallery.png" style="object-fit: cover;"/>
                </div>

                <div class="accordion mb-3 mt-3" id="accordionSelectedProducts">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                선택한 상품 목록
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
                            data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <ul id="selectedProducts" class="list-group">
                                    <li id="add-product-btn" class="list-group-item d-flex justify-content-center align-items-center" style="cursor: pointer;">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
                                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                                            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                          </svg>
                                          <span class="ms-1">상품 추가하기</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
              
                <textarea  id="summernote"  name="articleContent" class="mt-4"></textarea>
                <button id="submit-btn" type="submit" class="w-100 btn mt-3 btn-lg">게시글 생성하기</button>

            </form>
        </div>
    </section>
   	<%@ include file="../market/marketFooter.jsp" %>
</body>
</html>