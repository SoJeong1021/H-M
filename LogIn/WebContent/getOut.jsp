<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<body style="background-color:#2a365c; color:#ffffff; align:center">
	<br /><h1 align="center" style="color:#FFBF00">듣는 미술관</h1><br />
<form action="dropPeople.jsp" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?')">

	<fieldset style="width:30%; height:auto; margin:0 auto; padding:40px; border-radius:30px">
		<legend align="center"><h1 style="color:#ffffff">비밀번호를 입력해주세요.</h1></legend>
<br/>
<div align="center">
pw : <input type="password" name="pw"> &nbsp;
<input type="submit" value="탈퇴하기">
<input type="reset" value="취소" onclick="history.back()">
</div>
</form>
</body>
</html>