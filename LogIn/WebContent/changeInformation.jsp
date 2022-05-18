<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
String pw = (String) session.getAttribute("passwd");
String name = (String) session.getAttribute("phone_number");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1" />
<title>내 정보 수정</title>
</head>
<script type="text/javascript">
function nickcheck(){
   var nickname = document.getElementById("nickname").value;
   if(nickname.length<1 || nickname == null){
      alert("닉네임을 입력해 주세요.");
      return false;
   }
   
   var url = "nickcheck.jsp?nickname="+nickname;
   window.open(url, "get", "height=180, width=300");   
}
</script>
<style>
.align {
   position: absolute;
   text-align: center;
   margin: 0 auto auto 38%;
}
.border {
   border: 5px ridge #1234f2;
   padding: 20px;
}

</style>
<body>
<h1 align="center">듣는 미술관</h1> 
   <br>
  <form method = post action="change.jsp">
<div align="center">
   <h1> 내 정보 수정 </h1>
   <table>
      <tr> 
         <td> 닉네임  </td>
         <td> <input type="text" name="nickname" id="nickname" value="<%= session.getAttribute("nickname") %>"/> </td>
         <td><input type="button" onclick="nickcheck();" value="닉네임 중복 확인" class=""/></td>
      </tr>
      <tr> 
         <td> ID </td>
         <td> <input type="text" name="uid" value="<%= session.getAttribute("id") %>" disabled/> </td>
      </tr>
      <tr> 
         <td> 이름 </td>
         <td> <input type="text" name="uname" value="<%= session.getAttribute("name") %>" /> </td>
      </tr>
      <tr> 
         <td> Password </td>
         <td> <input type="password" name="passwd" value="<%= session.getAttribute("passwd") %>" /> </td>
      </tr>
      <tr> 
         <td> 전화번호 </td>
         <td> <input type="tel" name="phone" value="<%= session.getAttribute("phone") %>"/>  </td>
      </tr>
      <tr><td></td></tr>
      <tr><td></td></tr>
      <tr>
         <td>  </td>
        
         <td><input type="submit" value="수정"/>
             <input type="button" value="취소" > </td>
      </tr>
    </table>   
</div>
</form>
</body>
</html>