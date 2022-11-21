<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flea Market</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Nanum+Gothic&display=swap" rel="stylesheet">

<style> /* 스타일 */
	* {font-family: 'Gamja Flower', cursive;
font-family: 'Nanum Gothic', sans-serif;}
	body { margin: auto; }
	hr { width: 500px; }
	table { width: 200px;
			border-color: #999999;
			border-top: 1px solid #999999;
			border-bottom: 1px solid #999999;
			border-collapse: collapse; } /* 테두리 사이 간격 없앰 */
	th, td {/* border-bottom: 1px solid #999999;
			border-top: 1px solid #999999; */
			border-collapse: collapse;
			 padding: 5px;
			 /* height: 25px; */}
	input.img_button {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 42px;
		height: 42px;
		cursor: pointer; }
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
<h1><center><a href=Main.jsp>더블유마켓</a></center></h1>

<form action="Login_DB.jsp" method="post" align="center">
<table align="center">
	<tr>
		<td><label for="exampleInputEmail1"><img src="img/id.png" width="30" height="30" alt="ID"></label></td>
		<td><input type="text" name="_id" placeholder="아이디"></td>
	</tr>
	<tr>
		<td><label for="exampleInputPassword1"><img src="img/login_pw.png" width="25" height="25" alt="ID"></label></td>
		<td><input type="password" name="_pw" placeholder="비밀번호"></td>
	</tr>
</table> <p>
<center><input class="img_button" type="image" src="img/arrow.png" alt="로그인"></center> <p>

</form>

  <%
    String clientId = "sFBNNQyafG5a_1_8KOXh";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/fleaMarket/Main.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
 
  <div align="center"><a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a></div>
<p><center>회원이 아니신가요? <input type="button" value="회원가입" onclick="location.href='Join_UI.jsp'"></center> </P>
</body>
</html>
<!--  border="1" bordercolor="grey"  -->