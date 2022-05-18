<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="model.DBUtil"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.ArrayList"%>
<%--@ page import="com.oreilly.servlet.MultipartRequest,
               com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                   java.util.*"
                   --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>듣는 미술관</title>
</head>
<style>
.geul {
   text-align: right;
}

.write_img {
   position: absolute;
   left: 17%;
}

.write_music {
   position: absolute;
   left: 52%;
}
</style>
<script>
$.fn.setPreview = function(opt) {
   "use strict"
   var defaultOpt = {
      inputFile : $(this),
      img : null,
      w : 200,
      h : 200
   };
   $.extend(defaultOpt, opt);
      var previewImage = function() {
         if (!defaultOpt.inputFile || !defaultOpt.img)
            return;
         var inputFile = defaultOpt.inputFile.get(0);
         var img = defaultOpt.img.get(0);
         // FileReader
         if (window.FileReader) {
            // image 파일만
            if (!inputFile.files[0].type.match(/image\//))
               return;
            // preview
            try {
               var reader = new FileReader();
               reader.onload = function(e) {
                  img.src = e.target.result;
                  img.style.width = defaultOpt.w + 'px';
                  img.style.height = defaultOpt.h + 'px';
                  img.style.display = '';
               }
               reader.readAsDataURL(inputFile.files[0]);
            } catch (e) {
               // exception...
            }
            // img.filters (MSIE)
         } else if (img.filters) {
            inputFile.select();
            inputFile.blur();
            var imgSrc = document.selection.createRange().text;
            img.style.width = defaultOpt.w + 'px';
            img.style.height = defaultOpt.h + 'px';
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
                  + imgSrc + "\")";
            img.style.display = '';
            // no support
         } else {
            // Safari5, ...
         }
      };
   // onchange
   $(this).change(function() {
      previewImage();
   });
};
$(document).ready(function() {
   var opt = {
      img : $('#img_preview'),
      w : 200,
      h : 200
   };
   $('#input_file').setPreview(opt);
});
function search(keyword) {
   keyword.action = "search.jsp";
   keyword.method = "post";
   keyword.submit();
}
</script>
<body>
<form method="post" action="search" enctype="multipart/form-data">
      <a href="MainPage.html"><h1 align="center">듣는 미술관</h1></a>
      <div style="float: left">
         <div>
            <a
               onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'카테고리':'카테고리';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'"
               href="#";>카테고리</a>
            <div style="DISPLAY: none;">
               <div>
                  <ul>
                     <li class="menu"><a
                        onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'이미지':'이미지';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'"
                        href="#">이미지</a>
                        <div style="DISPLAY: none;">
                           <ul class="hide">
                              <a href="category_img1.jsp"><li>자연</li></a>
                              <a href="category_img2.jsp"><li>사물</li></a>
                              <a href="category_img3.jsp"><li>인물</li></a>
                           </ul>
                        </div></li>
                     <li class="menu"><a
                        onclick="this.innerHTML=(this.nextSibling.style.display=='none')?'사진':'사진';this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none'"
                        href="#">사진</a>
                        <div style="DISPLAY: none;">
                           <ul class="hide">
                              <a href="category_music1.jsp"><li>EDM</li></a>
                              <a href="category_music2.jsp"><li>클래식</li></a>
                              <a href="category_music3.jsp"><li>가요</li></a>
                           </ul>
                        </div></li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
      <div class="geul">
         <a href="#"><font size="2px">글 쓰기</font></a> <a href="#"><font
            size="2px">마이페이지</font> </a>
      </div>
      <div>
         <table class="write_img">
               <tr>
                  <td>
                     <select name="imgCate" size="1" onchange="selectMail()" class="select">
                        <option value="0">category</option>
                        <option value="natural">자연</option>
                        <option value="person">인물</option>
                        <option value="object">사물</option>
                     </select>
                  </td>
               </tr>
               <tr>
                  <td>
                     <label>이미지명</label>
                     <input type="text" name="imgg" size=40 />
                     <input type="button" value="검색" onclick="search(imgg)">
                  </td>
               </tr>
               <tr>
                  <td><label id="fileimg">첨부파일</label> <input type="file"
                     id="input_file" name="imgLoadDB" value="불러오기" /> <br /> <img
                     id="img_preview" style="display: none;" /></td>
               </tr>
               <tr>
               <tr>
                  <td><textarea name="imgDesc" cols=40 rows=10>시각장애인이 그림 대신 들을 설명입니다. 자세하게 묘사해 주세요.
            </textarea></td>
               </tr>
               <tr>
            </table>

         <table class="write_music">
               <tr>
                  <td>
                     <select name="songCate" size="1" onchange="selectMail()">
                        <option value="0">category</option>
                        <option value="classic">클래식</option>
                        <option value="edm">EDM</option>
                        <option value="unknown">unknown</option>
                     </select>
                  </td>
               </tr>
               <tr>
                  <td>
                     <label> 음악명 </label>
                     <input type="text" name="songg" size=40 /> 
                     <input type="button" value="검색" onclick="search(songg)">
                  </td>
               </tr>
               <tr>
                  <td><label id="filesong">첨부파일</label>
                  <input id="filesong" type="file" name="songLoadDB" value="불러오기"/>
                  <img id="img_preview" style="display: none;" /></td>
               </tr>
               <tr>
                  <td>
                     <textarea name="songDesc" cols=40 rows=10>청각장애인이 음악 대신 읽을 설명입니다. 자세하게 묘사해 주세요.
                         </textarea>
                      </td>
               </tr>
            </table>
      </div>
</form>
</body>
</html>