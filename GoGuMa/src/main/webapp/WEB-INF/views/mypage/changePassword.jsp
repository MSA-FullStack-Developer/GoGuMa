<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
	<title>고구마 - 고객과 구성하는 마켓</title>
    <!-- bootstrap icon -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<!-- bootstrap css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <style>
        a {
            text-decoration: none;
        }
        a:link {
            color: black;
        }
        a:visited {
            color: black;
        }
        table {
            table-layout: fixed;
        }
        table tbody tr {
            line-height: 3rem;
            table-layout: fixed;
            word-break: keep-all;
        }
        input {
        	margin: 10px 0px 10px 0px;
        }
        .custom-tooltip {
        	--bs-tooltip-bg: var(--bs-secondary);
        }
    </style>
</head>
<body>
	<%@ include file="../header.jsp" %>
	<div class="container mt-5" style="min-width: 1200px">
		<div class="row">
			<%@ include file="mypageMenu.jsp" %>
            <div class="col">
                <%@ include file="quickMenu.jsp" %>
                <div>
                    <h5><b>비밀번호변경</b></h5>
                </div>
                <div>
                    <h5>기존 비밀번호 입력</h5>
                </div>
                <table class="table">
                    <tbody class="table-group-divider">
                        <tr>
                            <th class="col-2 table-active" style="text-align: center;">기존 비밀번호</th>
                            <td><input type="password" class="form-control form-control-sm ms-2" id="curPassword" maxlength="16" style="width:200px; height:25px"/></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <h5>새 비밀번호 입력</h5>
                </div>
                <table class="table">
                    <tbody class="table-group-divider">
                        <tr>
                            <th class="col-2 table-active" style="text-align: center;">새 비밀번호</th>
                            <td><input type="password" class="form-control form-control-sm ms-2" id="newPassword" maxlength="16" style="width:200px; height:25px"/></td>
                        </tr>
                        <tr>
                            <th class="col-2 table-active" style="text-align: center;">새 비밀번호 확인</th>
                            <td><input type="password" class="form-control form-control-sm ms-2" id="newConfirm" maxlength="16" style="width:200px; height:25px"/></td>
                        </tr>
                    </tbody>
                </table>
                <div align="center">
                    <button type="button" class="btn btn-dark" onclick="changePassword()">변경</button>
                    <button type="button" class="btn btn-secondary">취소</button>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
<script type="text/javascript">
	function changePassword() {
		if($("#newPassword").val() != $("#newConfirm").val()) alert('새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.');
		else {
			let token = $("meta[name='_csrf']").attr("content");
		    let header = $("meta[name='_csrf_header']").attr("content");
			$.ajax({
				url : "${contextPath}/mypage/changePassword",
				type : "POST",
				data : {
					curPassword : $("#curPassword").val(),
					newPassword : $("#newPassword").val()
				},
				beforeSend : function(xhr) {
		            xhr.setRequestHeader(header, token);
		        },
		        success:function(result) {
		        	if(result==1) window.location.href = "${contextPath}/mypage";
		        	else if(result==2) alert('비밀번호가 일치하지 않습니다.');
		        	else alert("서버에 오류가 발생했습니다.");
		        },
				error:function(xhr, status, error) {
					var errorResponse = JSON.parse(xhr.responseText);
					var errorCode = errorResponse.code;
					var message = errorResponse.message;
					alert(message);
				}
			});
		}
	}
</script>
</html>