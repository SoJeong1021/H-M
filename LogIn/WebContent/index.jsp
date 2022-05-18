<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관 로그인 page</title>
<style>
.wrapper {
   border: 3px solid #FF6F61;
   border-radius : 40px;
   
   padding:50px;
   width: 50%;
   height: auto;
   margin: 0 auto;
}
a {color:#FFBF00; text-decoration: none;} 
a:hover {color: #FFBF00; text-decoration: underline;} 
</style>
</head>
<body style="background-color:#2a365c">

   <form method="post" action="doLogIn">
      <br /><h1 align="center" style="color:#FFBF00">듣는 미술관</h1><br />
      <br /> <br /> <br />
   <fieldset style="width:40%; height:auto; margin:0 auto; border-radius:30px">
      <legend align="center"><h1 style="color:#ffffff">Login</h1></legend>

      <table align="center" >

         <tr>
            <td style="color:#ffffff"> ID </td>
            <td><input type="text" title="아이디" tabindex='1' name="uid" /></td>
            <td rowspan='2'><input type="submit" tabindex='3'
               style='height: 50px' value="로그인" /></td>
         </tr>
         <tr>
            <td align="left" style="color:#ffffff">Password</td>
            <td><input type="password" tabindex='2' name="passwd" /></td>
         </tr>
         <tr>
            <td><h5>
                  <a href="findID.jsp">아이디 찾기 </a> &nbsp;
               </h5></td>
            <td><h5>
                  <a href="findPW.jsp">비밀번호 찾기</a>
               </h5></td>
            <td><h5>
                  <a href="Join.jsp">회원가입</a>
               </h5></td>
         </tr>
         
      </table>
         </fieldset>
   <br/> <br/>
   </form>
   </div>
</body>
</html>