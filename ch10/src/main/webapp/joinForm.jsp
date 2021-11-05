<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
<!-- jquery사용할 때 이렇게 해줘야함 -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	function chk() {
		if(!frm.id.value) {
			alert("아이디를 입력하고 체크하세오");
			frm.id.focus();
			return false;
		}
		// jquery를 사용한 ajax
		//$ : jquery를 쓰겠다
		//속성 id에 입력한 값을 가지고 confirm.jsp를 실행해라 
		//실행한 그 결과를 받아서 data에 저장하고 
		//그 data를 id가 err인 곳에 html형식으로 넣어라 
		$.post('confirm.jsp', 'id='+frm.id.value, function(data) {
			$('#err').html(data);
		});
	}
	function chk2() {
		if(frm.password.value != frm.password2.value) {
			alert("암호와 암호확인이 다릅니다");
			frm.password2.focus();
			frm.password2.value="";
			return false;
		}
	}
</script>
</head>
<body>
<form action="join.jsp" method="post" name="frm" onsubmit="return chk2()">
<table><caption>회원가입</caption>
	<tr><th>아이디</th><td><input type="text" name="id" required="required" autofocus="autofocus">
		<input type="button" value="중복체크" onclick="chk()">
		<div id="err"></div> <!-- 에러발생했을 때 적용 --></td></tr>
	<tr><th>암호</th><td><input type="password" name="password" required="required"></td></tr>
	<tr><th>암호</th><td><input type="password" name="password" required="required"></td></tr>
	<tr><th>이름</th><td><input type="text" name="name" required="required"></td></tr>
	<tr><th>주소</th><td><input type="text" name="address" required="required"></td></tr>
	<tr><th>전화번호</th><td><input type="tel" name="tel" required="required" 
		pattern="010-\d{3,4}-\d{4}" placeholder="010-1111-1111" title="전화형식은 010-(3,4)-4"></td></tr>
	<tr><th colspan="2"><input type="submit" value="확인"></th></tr>
</table>
</form>
<button onclick="location.href='loginForm.jsp'">로그인</button>
</body>
</html>