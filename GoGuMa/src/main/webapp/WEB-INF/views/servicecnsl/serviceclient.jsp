<%@ page session="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
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

<%@ include file="../header.jsp" %>
<script>
  
   function openCnslPup(){
     
     if(`${memberDTO}`){
       //로그인 한 경우
       window.open("oneCnslPup", "popup01", "width=800, height=700");
     }else{
       location.href="${contextPath}/member/login.do";
     }
   }
   
   $(document).ready(function () {
     
   });
</script>
<main class="cmain customer" role="main" id="mainContents">
        <div class="container">
        	<!-- .side-menu-list -->
        	<div class="side-content">
                
                <h2 class="side-menu-title" onclick='javascript:location.href="${contextPath}/serviceclient/"' style="cursor:pointer;">고객센터</h2>
                <div class="side-menu-list">
                    <ul>
                        <li><a class="#" href="">자주 묻는 질문</a></li>
                        <li><a href="#" onclick="openCnslPup(); return false;">1:1 문의하기</a></li>
                        <li><a href="#" onclick="openCustBoardPup();" >내 상담내역 조회</a></li>
                        <li><a href="/p/ccb/noticeList.do">공지사항</a></li>
                        
                    </ul>
                </div>
                <!-- // .side-menu-list -->

                <!--side-info-->
                <!-- <div class="side-info">
                    <p class="banner"><strong>현대Hmall</strong><em>1600-0000</em><span>(유료)</span></p>
                    <p class="banner"><strong>모바일 현대Hmall</strong><em>1600-0009</em><span>(유료)</span></p>
                    <p class="txt"><span>평일 09:00~20:00<br>주말, 공휴일 휴무</span></p>
                </div> -->
                <!--//side-info-->
            </div>
             <!-- // .side-menu-list -->
             <div class="contents">
				<!--search : 자주 묻는 질문-->
                <div class="cus-wrap">
                    <h3>자주 묻는 질문</h3>
                    <div class="search-area">
                    	<form id="searchForm" action="" >
                        	<div class="inputbox">
								<label class="inplabel icon-find"><input type="text" name="ancmCntn" placeholder="질문을 검색해보세요" title="검색어 입력" value=""></label>
	                            <button type="button" class="btn btn-find searchBtn" onclick="searchCntn();"></button>
                        	</div>
                        </form>
                    </div>
                </div>
                <!--//search : 자주 묻는 질문-->
                <!--베스트 FAQ 10-->
                <div class="cus-wrap">
                    <div class="tit-wrap">
                        <h3>베스트 FAQ 5</h3>
                        <p><a class="#" href="">전체보기</a><i class="fas fa-angle-right"></i></p>
                    </div>
                   <div class="accordion accordion-flush" id="accordionFlushFAQ">
                   		<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading1">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse1" aria-expanded="false" aria-controls="flush-collapse1"><i class="fa-solid fa-q"></i><strong>주문 내용 변경, 취소, AS 등은 어떻게 하나요?</strong></button>
							</h3>
							<div id="flush-collapse1" class="accordion-collapse collapse" aria-labelledby="flush-heading1" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
								 <p>
								 	▷ 색상/사이즈 및 배송지 변경
									결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다.
									주문이 상품준비중 단계로 변경된 이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다.
									
									▷ 주문 취소
									마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다. 
									- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)
									- 현금, 상품권 주문 : 주문접수
									즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이 표시되므로, 직접 취소 하실 수 있습니다. 단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다. 
									
									▷ AS신청
									AS는 마이페이지에서 직접 신청이 불가합니다. 1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.
									
									주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.
								 </p>
												
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading2">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse2" aria-expanded="false" aria-controls="#flush-collapse2"><i class="fa-solid fa-q"></i><strong>취소/반품 완료 후 환불 언제 되나요?</strong></button>
							</h3>
							<div id="flush-collapse2" class="accordion-collapse collapse" aria-labelledby="flush-heading2" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
								 <p>
								 	▷ 색상/사이즈 및 배송지 변경
									결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다.
									주문이 상품준비중 단계로 변경된 이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다.
									
									▷ 주문 취소
									마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다. 
									- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)
									- 현금, 상품권 주문 : 주문접수
									즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이 표시되므로, 직접 취소 하실 수 있습니다. 단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다. 
									
									▷ AS신청
									AS는 마이페이지에서 직접 신청이 불가합니다. 1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.
									
									주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.
								 </p>
												
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading3">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse3" aria-expanded="false" aria-controls="#flush-collapse3"><i class="fa-solid fa-q"></i><strong>주문한 상품은 배송 내역은 어디서 확인하나요?</strong></button>
							</h3>
							<div id="flush-collapse3" class="accordion-collapse collapse" aria-labelledby="flush-heading3" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
								 <p>
								 	▷ 색상/사이즈 및 배송지 변경
									결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다.
									주문이 상품준비중 단계로 변경된 이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다.
									
									▷ 주문 취소
									마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다. 
									- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)
									- 현금, 상품권 주문 : 주문접수
									즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이 표시되므로, 직접 취소 하실 수 있습니다. 단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다. 
									
									▷ AS신청
									AS는 마이페이지에서 직접 신청이 불가합니다. 1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.
									
									주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.
								 </p>
												
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading4">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse4" aria-expanded="false" aria-controls="#flush-collapse4"><i class="fa-solid fa-q"></i><strong>주문한 상품은 배송 내역은 어디서 확인하나요?</strong></button>
							</h3>
							<div id="flush-collapse4" class="accordion-collapse collapse" aria-labelledby="flush-heading4" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
								 <p>
								 	▷ 색상/사이즈 및 배송지 변경
									결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다.
									주문이 상품준비중 단계로 변경된 이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다.
									
									▷ 주문 취소
									마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다. 
									- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)
									- 현금, 상품권 주문 : 주문접수
									즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이 표시되므로, 직접 취소 하실 수 있습니다. 단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다. 
									
									▷ AS신청
									AS는 마이페이지에서 직접 신청이 불가합니다. 1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.
									
									주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.
								 </p>
												
								</div>
							</div>
						</div>
						<div class="accordion-item">
							<h3 class="accordion-header order-products" id="flush-heading5">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse5" aria-expanded="false" aria-controls="#flush-collapse5"><i class="fa-solid fa-q"></i><strong>주문한 상품은 배송 내역은 어디서 확인하나요?</strong></button>
							</h3>
							<div id="flush-collapse5" class="accordion-collapse collapse" aria-labelledby="flush-heading5" data-bs-parent="#accordionFlushFAQ">
								<div class="accordion-body">
								 <p>
								 	▷ 색상/사이즈 및 배송지 변경
									결제완료 단계일때 마이페이지에서 직접 수정하실 수 있습니다.
									주문이 상품준비중 단계로 변경된 이후에는 1:1 고객상담을 통해 변경 신청 하실 수 있습니다.
									
									▷ 주문 취소
									마이페이지 주문상세 내역에서 즉시 취소가 가능한 단계는 아래와 같습니다. 
									- 신용카드 주문 : 결제완료, 상품준비중 (주문제작/설치 등 일부 상품 제외)
									- 현금, 상품권 주문 : 주문접수
									즉시 취소가 가능한 주문은 위 단계일때 [주문취소] 버튼이 표시되므로, 직접 취소 하실 수 있습니다. 단, 위에 해당되지 않는 단계로 넘어간 주문에 대해서는 1:1 고객상담을 통해 주문취소 신청하실 수 있습니다. 
									
									▷ AS신청
									AS는 마이페이지에서 직접 신청이 불가합니다. 1:1상담신청 혹은 현대홈쇼핑 고객센터(1600-0000)로 전화 주시어 AS 문의를 남겨 주신다면 안내 도와 드리겠습니다.
									
									주문 진행상태에 따라 신청 가능한 항목은 다음과 같습니다.
								 </p>
												
								</div>
							</div>
						</div>
                   </div>
                </div>
                <!--//베스트 FAQ 10--> 
                
                <!--1:1문의하기 / 공지사항-->
                <div class="cus-wrap noti">
                   
                    <!--공지사항-->
                    <div class="noti-wrap">
                        <div class="tit-wrap">
                            <h3>공지사항</h3>
                            <p><a href="/p/ccb/noticeList.do">전체보기</a><i class="fas fa-angle-right"></i></p>
                        </div>
                        <!--tblwrap tbl-list-->
                        <div class="tblwrap tbl-list">
                            <table>
                                <colgroup>
                                    <col style="width:400px">
                                    <col style="width:75px">
                                </colgroup>
                                <tbody>
                                
			                                    		<tr>
				                                        <td class="nowrap"><a href="/p/ccb/noticeView.do?ancmId=53744&page=1">현대홈쇼핑 멤버십 제도 개편 안내</a></td>
				                                        <td class="txt-center"><span class="date">2022.05.02</span></td>
				                                    	</tr>
				                                    	
			                                    		<tr>
				                                        <td class="nowrap"><a href="/p/ccb/noticeView.do?ancmId=53740&page=1">현대홈쇼핑 상시채용 안내</a></td>
				                                        <td class="txt-center"><span class="date">2022.04.15</span></td>
				                                    	</tr>
				                                    	
			                                    		<tr>
				                                        <td class="nowrap"><a href="/p/ccb/noticeView.do?ancmId=53722&page=1">개인정보처리방침 변경 안내(01/27)</a></td>
				                                        <td class="txt-center"><span class="date">2022.01.27</span></td>
				                                    	</tr>
				                                    	 
			                                    		<tr>
				                                        <td class="nowrap"><a href="/p/ccb/noticeView.do?ancmId=53597&page=1">현대홈쇼핑 금융소비자보호 내부통제기준 및 금융소비자보호기준</a></td>
				                                        <td class="txt-center"><span class="date">2021.09.24</span></td>
				                                    	</tr>
				                                    	
			                                    		<tr>
				                                        <td class="nowrap"><a href="/p/ccb/noticeView.do?ancmId=53596&page=1">현대홈쇼핑 보험대리점등록증</a></td>
				                                        <td class="txt-center"><span class="date">2021.09.24</span></td>
				                                    	</tr>
     
                                </tbody>
                            </table>
                        </div>
                        <!--//tblwrap tbl-list-->
                    </div>
                    <!--//공지사항-->
                     <!--1:1 문의하기-->
                    <div class="question-wrap">
                    	<div class="q-cont" onclick="">
	                        <strong>1:1 문의하기 </strong><i class="fas fa-angle-right"></i>
	                        <div id="cont-txt">쇼핑을 하다가 생긴 궁금증 언제든지 물어보세요.</div>
                        </div>
                    </div>
                    <!--//1:1 문의하기-->
                    <!-- 내 상담내역 조회-->
                    <div class="question-wrap">
                    	<div class="sel-cont" onclick="">
	                        <strong>내 상담내역 조회 </strong><i class="fas fa-angle-right"></i>
	                        <div id="cont-txt">문의사항에 대한 답변을 확인하실 수 있습니다.</div>
                        </div>
                    </div>
                    <!--//내 상담내역 조회-->
                </div>
                <!--//1:1문의하기 / 공지사항-->
            </div>
            <!-- // .contents -->
        </div>
        
        </div>
        <!-- //.container -->
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
