<%@page import="ch10.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDao md = MemberDao.getInstance();
	int result = md.delete(id);
	if(result > 0) {
		session.invalidate(); //탈퇴하려면 invalidate()해줘야한다
%>		
<script type="text/javascript">
	alert("탈퇴성공");
	location.href="loginForm.jsp";
</script>
<%	}
	else {	%>
<script type="text/javascript">
	alert("탈퇴실패");
	history.go(-1);
</script>		
<%	}	%>
</body>
</html>