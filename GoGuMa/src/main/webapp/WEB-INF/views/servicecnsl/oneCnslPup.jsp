<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<link rel="stylesheet" href="${contextPath}/resources/css/oneCnslPup.css">

<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>

<script type="text/javascript">
  $(document).ready(function() {
    console.log("${memberDTO}");
  });
</script>

<body id="popWin">
	<div class="popup-win cus-consult">
		<!--pop-wrap-->
		<div class="pop-wrap">
			<!--pop-content-wrap-->
			<div class="pop-content-wrap">
				<strong class="pop-title">1:1 문의하기</strong>
				<!--pop-content-->
				<div class="pop-content">
					<p class="desc">문의하고자 하시는 내용을 작성해주세요. 빠른 답변 드리겠습니다.</p>
					<div>고객센터 > 내 상담내역 조회에서 확인하실 수 있습니다.</div>
					<form class="frm-cnslPup">
						<div class="content">
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 유형 선택</div>
								<div class="col-md-8" id="bname">
									<!--상담유형선택-->
									<select name="cnslSel" class="cu_select" id="cnslSel">
										<option value="">상담 분야 선택</option>
										<c:forEach var="i" items="${scDtoList }" begin="0" step="1" varStatus="status">
											<option value="">${i.categoryName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 상품 정보</div>
								<div class="col-md-8" id="bemail">
									<span><button>주문내역에서 찾기</button>
										<button>장바구니에서 찾기</button></span>
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">제목</div>
								<div class="col-md-8" id="baddress">
									<input type="text" placeholder="제목을 입력해주세요.">
								</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">문의 내용</div>
								<div class="col-md-8" id="bphone">내용</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">연락처</div>
								<div class="col-md-8" id="bphone">${memberDTO.phone}</div>
							</div>
							<div class="row pop-row">
								<div class="col-md-4 col-head">이메일</div>
								<div class="col-md-8" id="email">${memberDTO.email}</div>
							</div>
						</div>
					</form>
					<div class="btnGroup">
						<button>문의하기</button>
						<button>취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>