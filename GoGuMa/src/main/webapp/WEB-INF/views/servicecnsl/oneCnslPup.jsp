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

<script type="text/javascript"
	src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.js"></script>
	
<body id="popWin">   <!--20200826 수요일 추가 윈도우 팝업은 body에 popWin 아이디값 설정해주셔야 합니다. --> 
    <!--윈도우팝업(새창으로열기) 1:1 상담신청 :  PIA017 LNB 1:1상담신청 클릭 시 윈도우 팝업 // 20200825 script 요청드림-->  <!--pc 공통 스크립트 잡은 후 윈도우 팝업 변경 가능성 있음-->
    <!--popup-win : 윈도우 팝업일 경우 // width:649px , min-height:482px, height:575px (높이값은 popup-win 뒤의 클래스마다 변경) -->
    <div class="popup-win wd600 cus-consult"> <!--20200828 금요일 pc레이아웃 공통작업 wd600 클래스 추가-->
        <!--pop-wrap-->
        <div class="pop-wrap" tabindex="0">
            <!--pop-content-wrap-->
            <div class="pop-content-wrap">
                <strong class="pop-title">1:1 문의하기</strong>
                <!--pop-content-->
                <div class="pop-content">
                    <p class="desc">
                        문의하고자 하시는 내용을 작성해주세요. 빠른 답변 드리겠습니다.
                    </p>
                    <div class="content"> 
                        <div class="consult-wrap">
                            <!--상담유형선택-->
                            <div class="custom-selectbox" data-modules-selectbox="">
                                <select name="mCnslCsfCd" class="cu_select" id="mCnslCsfCd">
                                
									
									
									
	                                    <option value="">상담 분야 선택</option>
	                                    <option value="0405">취소신청</option>
	                                    <option value="0404">반품신청</option>
	                                    <option value="0501">배송/회수 문의</option>
	                                    <option value="0303">결제/환불 문의</option>
	                                    <option value="0402">교환신청</option>
	                                    <option value="0401">AS신청</option>
	                                    <option value="0712">시스템오류</option>
	                                    <option value="0701">서비스문의</option>
									
								
                             </select>
                            </div>
                            <!--//상담유형선택-->
                            <!--상담유형선택-->
                            <div class="custom-selectbox" data-modules-selectbox="" id="cnslCsfCd">
                                <select name="cnslCsfCd" class="cu_select" >
                                    <option>상담 사유 선택</option>
                                </select>
                            </div> 
                            <!--//상담유형선택-->
                            <!--product-wrap-->
                            <div class="product-wrap" id="cnslChoiceMsg">
                                <p>문의 분야를 선택해주세요.</p>
                            </div>
                            <!--//product-wrap-->
                            <!--product-wrap-->
                            <div class="product-wrap" id="cnslNoItemMsg" style="display:none;">
                                <p>최근 12개월 내 <em>취소신청</em> 가능한 주문/배송 내역이 없습니다.</p>
                            </div>
                            <!--//product-wrap-->
                        </div>
                        
                        <!--product-wrap-->
                        <div class="product-wrap delete" id="productChoiceMsg" style="display:none;">  <!--20200827 금요일 윈도우 팝업안에서 버튼 클릭 시 새창 윈도우로 뜸. (페이지고유 name값 추가)-->
                            <a href="#" onclick="openCnslAcptPup(); return false;">
                                <p><i class="icon"></i>상담할 상품을 선택해주세요.</p>
                            </a>
                        </div>
                        <!--//product-wrap-->
                            
                        <!--choice-item-->
                        <div id="choiceItemDiv">
                        </div>
                        <!--//choice-item -->
                        
                        <form id="cnslAcptPupForm">
	                        <input type="hidden" name="cnslCsfCd" value=""/>
	                        <input type="hidden" name="page" value=""/>
	                        <input type="hidden" name="mCnslCsfNm" value=""/>
                        </form>
                    </div>
                </div>
                <!--//pop-content-->
            </div>
            <!--//pop-content-wrap-->
        </div>
        <!--//pop-wrap-->
    </div>
    <!--popup-win-->
    <!--//윈도우팝업 1:1 상담신청-->
    <!--20201005 월요일 레이어팝업추가 : 개인정보수집및이용-->
    <div class="ui-modal" id="modalCollectPersonalInfo" tabindex="-1" role="dialog" aria-label="개인정보수집및이용">
        <div class="ui-modal-dialog collect-perInfo" role="document">
            <div class="content">
                <p class="ui-title">개인정보 수집 및 이용</p>
                <!-- //.content-head -->
                <div class="content-body">
                    <div class="tblwrap">
                        <table>
                            <caption>개인정보 수집 및 이용</caption>
                            <colgroup>
                                <col style="width:138px">
                                <col style="width:140px">
                                <col style="width:182px">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col" class="regular">목적</th>
                                    <th scope="col" class="regular">항목</th>
                                    <th scope="col">보유기간</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="txt-center">1:1상담</td>
                                    <td class="txt-center">휴대폰번호(SMS, 전화상담 선택 시), 이메일(이메일 선택 시)</td>
                                    <td class="txt-center bold">회원탈퇴 시 <br/> 또는 법정 의무 보유기간</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- //.content-body -->
                
                <button class="btn btn-close" data-dismiss="modal"><i class="icon xico"></i><span class="hiding">레이어 닫기</span></button>
            </div>
            <!-- //.content -->
        </div>
        <!-- //.ui-modal-dialog -->
    </div>
    <!--//20201005 월요일 레이어팝업추가 : 개인정보수집및이용-->
    <!--20201005 월요일 레이어팝업추가 : 개인정보수집및이용-환불-->
    <div class="ui-modal" id="modalCollectPersonalInfoRefund" tabindex="-1" role="dialog" aria-label="개인정보수집및이용">
        <div class="ui-modal-dialog collect-perInfo" role="document">
            <div class="content">
                <p class="ui-title">개인정보 수집 및 이용</p>
                <!-- //.content-head -->
                <div class="content-body">
                    <div class="tblwrap">
                        <table>
                            <caption>개인정보 수집 및 이용</caption>
                            <colgroup>
                                <col style="width:138px">
                                <col style="width:140px">
                                <col style="width:182px">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col" class="regular">목적</th>
                                    <th scope="col" class="regular">항목</th>
                                    <th scope="col">보유기간</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="txt-center">환불처리</td>
                                    <td class="txt-center">예금주명, 계좌정보</td>
                                    <td class="txt-center bold">회원탈퇴 시 <br/> 또는 법정 의무 보유기간</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- //.content-body -->
                
                <button class="btn btn-close" data-dismiss="modal"><i class="icon xico"></i><span class="hiding">레이어 닫기</span></button>
            </div>
            <!-- //.content -->
        </div>
    </div>
    <!--//20201005 월요일 레이어팝업추가 : 개인정보수집및이용-환불-->
	<div class="ui-modal alert" id="modalAddressAlert1" tabindex="-1" role="dialog" aria-label="택배사 방문 주소를 입력해 주세요.">
       <div class="ui-modal-dialog restockalarm" role="document">
           <div class="content">
               <span class="bgcircle ex-redmark-sm"><i class="icon ex-red-mark"></i></span>
               <p class="ctypo17 bold">택배사 방문 주소를 입력해 주세요.</p>
           </div>
           <div class="btngroup">
               <button class="btn btn-default" data-dismiss="modal"><span>확인</span></button>
               <!-- 데이터 전송 후 닫힘 $(element).modal().hide() -->
           </div>
           <button class="btn btn-close" data-dismiss="modal"><i class="icon xico"></i><span class="hiding">레이어 닫기</span></button>
       </div>
   </div>    
    
</body>