<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- 직원 추가 디자인화면 (아마추어 페이지) --%>
	<form action="addSawon_pro.jsp" method="get">
		<div align="center">
			<h1>직원 추가</h1>
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="s_id" /></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="s_name" /></td>
				</tr>
				<tr>
					<th>패스워드</th>
					<td><input type="text" name="s_pw" /></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="text" name="s_age" /></td>
				</tr>
				<tr>
					<th>근무지</th>
					<td>
						<select name="s_addr">
							<option value="서울">서울</option>
							<option value="경기">경기</option>
							<option value="인천">인천</option>
							<option value="수원">수원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내선번호</th>
					<td><input type="text" name="s_extension"/></td>
				</tr>
				<tr>
					<th>부서명</th>
					<td>
						<select name="s_dept">
							<option value="영업">영업</option>
							<option value="기술">기술</option>
							<option value="기획">기획</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="직원 추가"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="직원 추가 취소"/>
					</td>
				</tr>
				
			</table>
		</div>
	</form>
</body>
</html>