<%@page import="ch10.*"%>
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
	String id = request.getParameter("id");
	MemberDao md = MemberDao.getInstance(); //싱글톤 사용할 수 있게 생성자 만들기
	int result = md.confirm(id); //id가 있는지 확인
	if(result > 0) out.println("이미 사용중인 ID입니다");
	else out.println("사용 가능한 ID입니다");
%>
</body>
</html>