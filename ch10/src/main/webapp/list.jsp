<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
</head>
<body>
<%
	MemberDao md = MemberDao.getInstance();
	List<Member> list = md.list();
	pageContext.setAttribute("list", list);
%>
<table><caption>회원목록</caption>
	<tr><th>아이디</th><th>이름</th><th>주소</th><th>전화</th><th>가입일</th><th>삭제</th></tr>
<c:if test="${empty list }">
	<tr><th colspan="6">데이터가 없습니다</th></tr>
</c:if>
<c:if test="${not empty list }">
	<c:forEach var="member" items="${list }">
		<tr><td>${member.id }</td><td>${member.name }</td><td>${member.address }</td>
			<td>${member.tel }</td><td>${member.reg_date }</td><td>${member.del }</td></tr>
	</c:forEach>
</c:if>
</table>
<button onclick="location.href='main.jsp'">메인</button>
</body>
</html>