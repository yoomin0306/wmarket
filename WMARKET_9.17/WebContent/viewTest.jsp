<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더블유마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">
<style>
	img {
	  width: 1,020px;
	  height: 450px;
	  object-fit: contain;
	}
	h6.card-text {
		font-size: 1em;
	}
	p.card-text {
		font-size: 0.5em;
	}
	input.img_button {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 42px;
		height: 42px;
		cursor: pointer;
	}
	a { text-decoration: none; }
	@font-face {
	    font-family: 'IM_Hyemin-Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/IM_Hyemin-Bold.woff2') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* { font-family: "IM_Hyemin-Bold" }
	table {
		border: 1px solid #eeeeee;
		border-collapse: collapse;
	}
	th, td {
    border: 1px solid #eeeeee;
 	}
</style>
</head>
<body>
<header>
<div class="container">
<div class="row">
<div class="col-6"></div>
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
%>
<%
	// 로그인 안 했을 때 화면
	if(sessionID == null){
%>
	<div class="col-6" align="right" margin-top:10px;"><a href="Login_UI.jsp">로그인</a> &emsp; <a href="Join_UI.jsp">회원가입</a></div>
<%
	// 관리자 로그인
	} else if(sessionID.equals("admin")){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="manage.jsp">관리자페이지</a></div>
<%
	// 로그인 했을 때 화면
	}else {
%>
	<div class="col-6" align="right" margin-top:10px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="UserInfo_UI.jsp">내 정보</a> &emsp; <a href="MyPage.jsp">마이페이지</a> &emsp; <a href="Upload_UI.jsp">상품등록</a></div>
<%
	}
%>
</div>
</div>
</header>
<!-- nav -->
<nav class="navbar navbar-expand-lg sticky-top navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="Main.jsp">더블유마켓</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <form class="d-flex" action="Search.jsp" method="post">
        <input class="form-control me-2" type="text" name="_search" placeholder="상품명" aria-label="Search">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="검색">
      </form>
    </div>
  </div>
</nav>

<div style="margin-top:15px;"><hr></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous"></script>
<aside></aside>
<div>
<section>
	<div class="container" id="section">
		 <div class="row">
			<%
				// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
				String id = null;
				if(session.getAttribute("__ID") != null){
					id = (String)session.getAttribute("__ID");
				}
				
				// pNumber를 초기화 시키고
				// 'pNumber'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
				int pNumber = 1;
				if(request.getParameter("pNumber") != null){
					pNumber = Integer.parseInt(request.getParameter("pNumber"));
				}
				
				// 만약 넘어온 데이터가 없다면
				if(pNumber == 0){
					out.println("<script>");
					out.println("alert('유효하지 않은 글입니다')");
					out.println("location.href='Main.jsp'");
					out.println("</script");
				}
				
				// 유효한 글이라면 구체적인 정보를 'vo'라는 인스턴스에 담는다
				ProductVO vo = new ProductDAO().getProduct(pNumber);
				
				int minute = new ProductDAO().getDateDiff(vo.getDate_b());
				int hour = minute/60;
				int day = hour/24;
				int restHour = hour%24;
				int restMin = minute%60;
				String period = "";
				
				if (day < 1) {
					period = Integer.toString(restHour) + "시간 " + Integer.toString(restMin) + "분 ";
				}else {
					period = Integer.toString(day) + "일 " + Integer.toString(restHour) + "시간 ";
				}
			%>
			
			<!-- 게시판 글 보기 영역 -->
			<table class="tb" style=" border: 1px solid #dddddd">
					<tr>
						<td colspan="3" style="background-color: #eeeeee; font-size: 20px;'" align="center"><%= vo.getpName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td colspan="1" rowspan="10" style="width:50%;" align="center"><img src="img\<%=vo.getpNumber()%>_image.jpg"></td>
					</tr>
					<tr>
						<td colsapn="2" rowspan="1" >판매자: <%=vo.getId() %>님</td>
					</tr>
					<tr>
						<td colsapn="2" rowspan="1" >작성일자: 시분초</td>
					</tr>
					<tr>
						<td colsapn="2" rowspan="1" >경매마감: 시분초</td>
					</tr>
					<tr>
						<td colsapn="2" rowspan="7" style="height:50%;">상품정보: ~~</td>
					</tr>
					
				</tbody>
			</table>
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(id == null){
			%>
					<form action="Login_UI.jsp" method="post" align="center">
						<input type="text" name="bidPrice" placeholder="입찰가 입력" onclick="alert('로그인이 필요합니다.')">
						<input type="submit" value="입찰" onclick="alert('로그인이 필요합니다.'); location.href='Login_UI.jsp'">
					</form>
			<%
				} else if(id.equals(vo.getId()) || id.equals("admin")){
			%>		
					<center><a href="update.jsp?pNumber=<%= pNumber %>" class="btn">수정</a>
					<a href="deleteAction.jsp?pNumber=<%= pNumber %>" class="btn">삭제</a></center>
			<%
				} else {
			%>		
					<form action="Bid.jsp?pNumber=<%= pNumber %>" method="post" align="center">
						<input type="number" name="bidPrice" placeholder="입찰가 입력">
						<input type="submit" value="입찰">
					</form>
			<%
				}
			%>
			<%
				ProductDAO productDAO = new ProductDAO();
				int result = productDAO.getDateDiff(vo.getDate_b());

				if (result < 0) {
					out.println("<script>");
					out.println("alert('경매가 마감되었습니다.')");
					out.println("history.back");
					out.println("</script>");
				}
			%>
		</div>
	</div>
</section>
</div>
<aside>
</aside>
</body>
</html>