<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*"%>
<%@ include file="sessionChk.jsp" %><!-- 로그인 안하는 사람이 수정하는 것을 막는다 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
<script type="text/javascript">
	function chk(){
		if(frm.password.value != frm.password2.value) {
			alert("암호와 암호확인이 다릅니다");
			frm.password2.focus();
			frm.password2.value=""
			return false;
		}
	}
</script>
</head>
<body>
<%
	//수정은 현재정보를 보여주고 수정해야한다		
	MemberDao md = MemberDao.getInstance();
	Member member = md.select(id);
	pageContext.setAttribute("member", member);
%>
<form action="update.jsp" name="frm" method="post" onsubmit="return chk()">
	<input type="hidden" name="id" value="${member.id }">
<table><caption>회원정보 수정</caption>
	<tr><th>아이디</th><td>${member.id }</td></tr>
	<tr><th>암호</th><td><input type="password" name="password" required="required" autofocus="autofocus"></td></tr>
	<tr><th>암호확인</th><td><input type="password" name="password2" required="required"></td></tr>
	<tr><th>이름</th><td><input type="text" name="name" required="required"></td></tr>
	<tr><th>주소</th><td><input type="text" name="adress" required="required"></td></tr>
	<tr><th>전화번호</th><td><input type="tel" name="tel" required="required"></td></tr>
	<tr><th>가입일</th><td>${member.reg_date }</td></tr>
	<tr><th colspan="2"><input type="submit" value="확인"></th></tr>
</table>
</form>
</body>
</html>