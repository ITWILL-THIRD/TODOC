<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원비번수정</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>

	function check_pwd(frm) {
		var pwd = frm.hosPw.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.pwdCheck.value="";
			return false;
		}
		return true;
	}

	function pwdUpdate_ok(frm) {
		alert("변경하시겠습니까?")
		frm.action="updateHoPwd.do";
		frm.submit();
	}
</script>
</head>
<body>
<h1>병원비밀번호 변경</h1>
<c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
<form action="updateHoPwd.do" method="post">
	<table class="tb">
		<tr>
		<td>현재 비밀번호</td>
		</tr>
		<tr>
			 <td><input class="text" type="password" name="currentPassword"></td>
		</tr>
		<tr>
		<td>변경할 비밀번호</td>
		</tr>
		<tr>
			<td><input class="text" type="password" name="hosPw" ></td>
		</tr>
		<tr>
		<td>비밀번호 확인</td>
		</tr>
		<tr>
			<td><input class="text" type="password" name="pwdCheck" onblur="check_pwd(this.form)"></td>
		</tr>
		<tr>
			<td><input type="hidden" name="hosIdx" value="${hoUser.hosIdx}"></td>
		</tr>
		<tr>
			<td>
			<input class="loginBtn" type="button" value="비밀번호 변경" onclick="pwdUpdate_ok(this.form)">
			</td>
		</tr>
	</table>
</form>
</body>
</html>