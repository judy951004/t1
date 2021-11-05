<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="sessionChk.jsp" %> <!-- 공통적인 것들은 따로 파일을 만들어서 뺴는 게 좋다  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
<script type="text/javascript">
	function del() {
		var chk = confirm("정말 탈퇴하시겠습니까?");
		if(chk) location.href="delete.jsp";
		else alert("탈퇴가 취소되었습니다");
	}
	function chk() {
		var id = "<%=id %>"; /* 자바 스크립트에서 자바변수를 받을 때는 따옴표처리 해야한다 */
		if(id != 'master') {
			alert("목록을 볼 권한이 없습니다");
			return;
		}
		else location.href="list.jsp";
	}
</script>
</head>
<body>
<!-- 모두 세션체크 해야하는 것들을 모아둠(로그인해야만 다룰수 있는 것들) -->
<table><caption>회원관리</caption>
	<tr><th><button onclick="location.href='updateForm.jsp'">회원정보 수정</button></th></tr>
	<tr><th><button onclick="chk()">회원목록</button></th></tr>
	<tr><th><button onclick="del()">회원탈퇴</button></th></tr>
	<tr><th><button onclick="location.href='logout.jsp'">로그아웃</button></th></tr>
</table>
</body>
</html>