<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	session.invalidate();
	//30분 지나면 자동으로 로그아웃 된다 (30분 후에 세션삭제)
	//session.setMaxInactiveInterval(30*60); 
%>
<script type="text/javascript">
	alert("로그아웃되었습니다");
	location.href="loginForm.jsp";
</script>
</body>
</html>