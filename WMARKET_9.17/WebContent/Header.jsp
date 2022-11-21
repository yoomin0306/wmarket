<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더블유마켓</title>

<!-- 부트스트랩 다운로드 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous"></script>

</head>

<body>
	
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
	
	String search = request.getParameter("_search");	//검색어
	if (search == null) {
		search = "";
	}
%>
<div class="bg-light" style="padding-right: 12rem;">
<%
	// 로그인 안 했을 때 화면
	if(sessionID == null){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Login_UI.jsp">로그인</a> &emsp; <a href="Join_UI.jsp">회원가입</a></div>
<%
	// 관리자 로그인
	} else if(sessionID.equals("admin")){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="Manage.jsp">관리자페이지</a></div>
<%
	// 로그인 했을 때 화면
	}else {
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="UserInfo_UI.jsp"><%=new UserDAO().getName(sessionID) %>님</a> &emsp; <a href="MyPage.jsp?tab=acc">예치금: <%=new UserDAO().account(sessionID) %>원</a> &emsp; <a href="Logout.jsp">로그아웃</a></div>
<%
	}
%>
</div>

<!-- nav -->
<nav class="navbar navbar-expand-lg sticky-top navbar-light bg-light" id="navBar">
  <div class="container">
    <a class="navbar-brand" href="Main.jsp">더블유마켓</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <form class="d-flex me-auto" action="Main.jsp" method="post">
        <input class="form-control me-2" type="text" name="_search" placeholder="상품명 또는 #판매자명" aria-label="Search" value="<%=search %>">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="검색">
      </form>
      
      <%
      // 로그인 X
      if(sessionID == null) {
    	  %>
          <ul class="navbar-nav me-5">
          <li class="nav-item">
            <a class="nav-link active me-3" onclick="alert('로그인이 필요합니다.');" href="Login_UI.jsp">상품 등록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active me-3" onclick="alert('로그인이 필요합니다.');" href="Login_UI.jsp">내 상점</a>
          </li>
          </ul>
          <%
      // 로그인 O
      } else {
    	  %>
	      <ul class="navbar-nav me-5">
	      <li class="nav-item">
	        <a class="nav-link active me-3" href="Upload_UI.jsp">상품 등록</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link active me-3" href="MyPage.jsp">내 상점</a>
	      </li>
	      </ul>
    	  <%
      }
      %>
    </div>
  </div>
</nav>
<div style="margin-top:15px;"></div>
</body>
</html>