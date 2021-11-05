<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = (String)session.getAttribute("id");
	if(id == null || id.equals("")) {
		response.sendRedirect("loginForm.jsp");
		return; // 더 이상 다른 프로그램을 실행시키지 마라, 여기서 끝내라
	}
%>
