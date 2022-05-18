<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action = "addSong" method = "post" enctype = "multipart/form-data">
<select name="songCate" size="1" onchange = "selectMail()">
  <option value="0">category</option>  
  <option value="pop"> 가요 </option> 
  <option value="edm"> EDM </option> 
  <option value="unknown"> unknown</option> 
</select> <br/>
<label> SONGNAME  </label>
<input type="text" name="songName" size = 40/> <br/>
<label id = "filesong">FILE</label>
<input id = "filesong" type="file" name = "songLoadDB" value = "불러오기"/>  <br/>
<textarea name = "songDesc" cols = 40 rows = 10  placeholder="Write songDesc"></textarea><br/>
<textarea name = "imgDesc" cols = 40 rows = 10  placeholder="Write imgDesc"></textarea><br/>
<input type = "submit" />
</form>
</body>
</html>