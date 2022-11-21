<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style> /* 스타일 */
	body { margin: auto; }
	hr { width: 500px; }
	table { width: 200px;
			border-color: #999999;
			border-top: 1px solid #999999;
			border-bottom: 1px solid #999999;
			border-collapse: collapse; } /* 테두리 사이 간격 없앰 */
	th, td { /* border-bottom: 1px solid #999999;
			 border-top: 1px solid #999999; */
			 border-collapse: collapse;
			 padding: 5px;
			 /* height: 25px; */}
	a { text-decoration: none; }
	input.img_button {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 42px;
		height: 42px;
		cursor: pointer; }

	@font-face {
	    font-family: 'IM_Hyemin-Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/IM_Hyemin-Bold.woff2') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* { font-family: "IM_Hyemin-Bold" }
	
</style>

</head>
<body>
<h1><center><a href="Main.jsp">Flea Market</a></center></h1>

<% String sessionId = (String)session.getAttribute("__ID"); %>

<form action="UserInfo_DB.jsp" method="post">
<table align="center">
	<tr>
		<td><label><img src="img/id.png" width="30" height="30" alt="ID"></label></td>
		<td><% out.println(sessionId);%>님</td>
	</tr>
	<tr>
		<td><label><img src="img/join_pw.png" width="30" height="30" alt="PW"></label></td>
		<td><input type="password" name="_pw" placeholder="비밀번호"></td>
	</tr>
	<tr>
		<td><label><img src="img/join_pw2.png" width="30" height="30" alt="PW2"></label></td>
		<td><input type="password" name="_pw2" placeholder="비밀번호 확인"></td>
	</tr>
	<tr>
		<td><label><img src="img/join_name.png" width="30" height="30" alt="NAME"></label></td>
		<td><input type="text" name="_name" placeholder="이름"></td>
	</tr>
	<tr>
		<td><label><img src="img/join_address.png" width="30" height="30" alt="ADDRESS"></label></td>
		<td><input type="text" name="_address" placeholder="주소"></td>
	</tr>
	<tr>
		<td><label><img src="img/join_phone.png" width="30" height="30" alt="PHONE"></label></td>
		<td><input type="text" name="_phone" placeholder="휴대전화"></td>
	</tr>	
</table> <p>
<center><input type="button" value="메인으로" onclick="location.href='Main.jsp'"> <input type="submit" value="정보수정"></center>
</form>



</body>
</html>