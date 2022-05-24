<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" pageEncoding="UTF-8" %>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<script type="text/javascript" src="${contextPath}/webjars/jquery/3.6.0/dist/jquery.min.js"></script>
 <script>
	 var IMP = window.IMP; // 생략 가능
	 IMP.init("imp"); // 예: imp00000000
    function requestPay() {
      // IMP.request_pay(param, callback) 결제창 호출
      IMP.request_pay({ // param
          pg: "html5_inicis",
          pay_method: "card",
          merchant_uid: "ORD20180131-0000011",
          name: "노르웨이 회전 의자",
          amount: 64900,
          buyer_email: "gildong@gmail.com",
          buyer_name: "홍길동",
          buyer_tel: "010-4242-4242",
          buyer_addr: "서울특별시 강남구 신사동",
          buyer_postcode: "01181"
      }, function (rsp) { // callback
    	  console.log(rsp)
          if (rsp.success) {
        	  var msg = "결제가 완료됐습니다"
          } else {
        	  var msg = "결제에 실패했습니다."
          }
      alert(msg)
      });
    }
  </script>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

 <button onclick="requestPay()">결제하기</button>
<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
