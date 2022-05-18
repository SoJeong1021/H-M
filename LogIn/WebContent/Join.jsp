<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ page import="java.util.*" %> 
 <% request.setCharacterEncoding("utf-8"); %> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
<style>
 a {color:#FFBF00; text-decoration: none;} 
  a:hover {color: #FFBF00; text-decoration: underline;} 

body{
background-color:#2a365c;
}
.submit{
position: absolute;
left:36.5%;

}
.box{
border-radius:"30px";
}
</style>
<script type="text/javascript">
function idcheck(){
	var id = document.getElementById("Joinid").value;
	if(id.length<1 || id == null){
		alert("아이디를 입력해 주세요.");
		return false;
	}
	var url = "idCheck.jsp?id="+id;
	window.open(url, "get", "height=180, width=300");	
}

function nickcheck(){
	var id = document.getElementById("Joinid").value;
	var nickname = document.getElementById("JoinNick").value;
	if(nickname.length<1 || nickname == null){
		alert("닉네임을 입력해 주세요.");
		return false;
	}
	
	var url = "nickcheck.jsp?nickname="+id+nickname;
	window.open(url, "get", "height=180, width=300");	
}
	

function check(){
var passwd = document.getElementById("Joinpasswd").value;
var checkpw = document.getElementById("Joinchpw").value;

	if(passwd == checkpw){
		alert("비밀번호가 일치합니다.");
	}
	else {
		alert("비밀번호가 일치하지 않습니다.");
	}
	
}

</script>
</head>
<body>
<a href="Join.jsp"><h1 align="center">듣는 미술관</h1></a>
<br/>
<br/>
<form name="form" action="DoJoin" method="POST">
<fieldset style="width:40%; height:300px; margin:0 auto; border-radius:30px">
<legend class="a"align="center"><h1 style="color:#ffffff">회원 가입</h1></legend>
<div class="box">
<table align="center" class="box">
  <tr>
       <td style="color:#ffffff"> Name:</td>
       <td style="color:#ffffff"><input type="text" tabindex='1' name="Joiname" /></td>
   </tr>
    <tr>
   <td style="color:#ffffff">  NickName:</td>
   <td><input type="text" tabindex='1' name="JoinNick" id="JoinNick" /></td>
    <td ><input type="button" onclick="nickcheck()" value="닉네임 중복 확인"/></td>
   </tr>
        <tr>
       <td style="color:#ffffff"> Id:</td>
       <td><input type="email" tabindex='1' name="Joinid" id="Joinid" /></td>
        <td ><input type="button" onclick="idcheck()" value="아이디 중복 확인"/></td>
   </tr>
   
   <tr>
   <td style="color:#ffffff">Passwd:</td>
   <td><input type="password" tabindex='1' name="Joinpasswd" id="Joinpasswd"/></td>   
   </tr>
    <tr>
       <td style="color:#ffffff"> Check pw:</td>
       <td><input type="password" tabindex='1' name="Joinchpw" id="Joinchpw"/></td>
       

   <td ><input type="button" onclick="return check()" value="비밀번호 확인"/></td>
   </tr>
   <tr>
       <td style="color:#ffffff"> Phone:</td>
       <td><input type="tel" tabindex='1' name="Jointel" /></td>
   </tr>
 
   <tr>
   <td style="color:#ffffff"> Gender:</td>
   <td style="color:#ffffff">여성<input type="radio" name="gender" value="female" checked />
  남성<input type="radio" name="gender" value="male" /></td>
   </tr>
   <tr>
   <td></td>
   <td></td>
   <td>
<input class="submit" type="submit"  onclick="location.href='index.html'" value="회원가입하기"/></td>
   </tr>
   </table>
   </div>
   <br/>

</fieldset>
</form>
	

</body>
</html>
<table>