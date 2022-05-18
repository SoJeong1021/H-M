<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action = "addImg" method = "post" enctype = "multipart/form-data">
<select name="imgCate" size="1" onchange = "selectMail()">
  <option value="0">category</option>  
  <option value="classic"> 자연 </option> 
  <option value="edm"> 인물 </option> 
  <option value="unknown"> 사물 </option> 
</select> <br/>
<label> IMGNAME </label>
<input type="text" name="imgName" size = 40/> <br/>
<label id = "filesong">FILE</label>
<input id = "filesong" type="file" name = "imgLoadDB" value = "불러오기"/>  <br/>
<textarea name = "songDesc" cols = 40 rows = 10> placeholder="Write songDesc"</textarea><br/>
<textarea name = "imgDesc" cols = 40 rows = 10> placeholder="Write imgDesc"</textarea><br/>
<input type = "submit" />
</form>
</body>
</html>