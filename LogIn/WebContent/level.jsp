<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1" />

<title>레벨 안내 페이지</title>
</head>
<body>
<div align="center">
<h2>  <%= session.getAttribute("nickname") %> 님의 현재 레벨입니다.
<img src="2.png" width="40px" height="40px"> </h2>
<table>
   <tr> 
      <td> <img src="level1.png" width="50px" height="50px"> </td>
      <td> 가입 시 </td>
      <td> <img src="level2.png" width="50px" height="50px"> </td>
      <td> 게시물 수  10 댓글 수 20 이상</td> 
   </tr>
      <tr> 
      <td> <img src="level3.png" width="50px" height="50px"> </td>
      <td> 게시물 수 20 댓글 수 50 이상 </td>
      <td> <img src="level4.png" width="50px" height="50px"> </td>
      <td> 게시물 수 30 댓글 수 100 이상</td> 
   </tr>
   <tr>
      <td> <img src="5.jpg" width="50px" height="50px"> </td>
      <td> 이 달의 베스트 누적 3회</td> 
   </tr>
</table>
</div>
</body>
</html>