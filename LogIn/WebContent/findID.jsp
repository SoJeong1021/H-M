<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
<style>
a {color:#FFBF00; text-decoration: none;} 
a:hover {color: #FFBF00; text-decoration: underline;} 

</style>
</head>
<body style="background-color:#2a365c; color:#ffffff">
<br /><h1 align="center" style="color:#FFBF00">듣는 미술관</h1><br />
	<br />
	<br />
	<form action="findID.do" method="post">
	<fieldset style="width:30%; height:auto; margin:0 auto; padding:40px; border-radius:30px">
	<legend align="center"><h1 style="color:#ffffff">ID 찾기</h1></legend>
	<table align="center">

		<tr>
			<td style="color:#ffffff">이름 :</td>
			<td><input type="text" tabindex='1' name="uname" /></td>
			<td rowspan='2'><input type="submit" tabindex='3'
				style='height: 50px' value="확인" /></td>
		</tr>
		<tr>
			<td style="color:#ffffff">핸드폰  :</td>
			<td><input type="text" tabindex='2' name="phone" /></td>
		</tr>

	</table>
	</fieldset>
</form> 

</body>
</html>