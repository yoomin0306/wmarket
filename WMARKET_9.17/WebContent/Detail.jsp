<%@page import="java.io.File"%>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous"></script>
<script>
const countDownTimer = function (id, date) {
	var _vDate = new Date(date); // 전달 받은 일자
	var _second = 1000;
	var _minute = _second * 60;
	var _hour = _minute * 60;
	var _day = _hour * 24;
	var timer;

	function showRemaining() {
		var now = new Date();
		var distDt = _vDate - now;

		if (distDt < 0) {
			clearInterval(timer);
			document.getElementById(id).textContent = '경매마감!!';
			return;
		}

		var days = Math.floor(distDt / _day);
		var hours = Math.floor((distDt % _day) / _hour);
		var minutes = Math.floor((distDt % _hour) / _minute);
		var seconds = Math.floor((distDt % _minute) / _second);

		//document.getElementById(id).textContent = date.toLocaleString() + "까지 : ";
		
		if (hours < 1) {
			document.getElementById(id).textContent = minutes + '분 ';
			document.getElementById(id).textContent += seconds + '초 남음';
		} else if (days < 1) {
			document.getElementById(id).textContent = hours + '시간 ';
			document.getElementById(id).textContent += minutes + '분 남음';
		} else {
			document.getElementById(id).textContent = days + '일 ';
			document.getElementById(id).textContent += hours + '시간 남음';
		}
	}
	timer = setInterval(showRemaining, 1000);
}

</script>
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
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Login_UI.jsp">로그인</a> &emsp; <a href="Join_UI.jsp">회원가입</a></div>
<%
	// 관리자 로그인
	} else if(sessionID.equals("admin")){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="manage.jsp">관리자페이지</a></div>
<%
	// 로그인 했을 때 화면
	}else {
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><%=new UserDAO().getName(sessionID) %>님 &emsp; 예치금: <%=new UserDAO().account(sessionID) %>원 &emsp; <a href="Logout.jsp">로그아웃</a> &emsp; <a href="UserInfo_UI.jsp">내 정보</a> &emsp; <a href="MyPage.jsp">내 상점</a> &emsp; <a href="Upload_UI.jsp">상품 등록</a></div>
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
				int pNumber = 0;
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
				
				// 유효한 글이라면 구체적인 정보를 'productVO'라는 인스턴스에 담는다
				ProductDAO productDAO = new ProductDAO();
				ProductVO productVO = productDAO.getProduct(pNumber);
				
				String periodID = "period"+pNumber;
				
				String path = productVO.getImage(); //이미지 경로
				File dir = new File(path);

				String image = "img\\image_" + pNumber + "\\" + dir.list()[0];
				
			%>
			<script>
			var date_b = "<%=productVO.getDate_b()%>";
			var id = "<%=periodID%>";
			countDownTimer(id, date_b);
			</script>
			<!-- 게시판 글 보기 영역 -->
			<table class="tb" style=" border: 1px solid #dddddd">
				<thead>
					<tr>
						<td colspan="2" style="background-color: #eeeeee; text-align: center; font-size: 20px;"><%= productVO.getpName().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="2" style="width: 20%;">판매자</td>
						<td rowspan="2" colspan="2"><%= new UserDAO().getName(productVO.getId()) %> 님</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td rowspan="2">작성일자</td>
						<td rowspan="2" colspan="2"><%= productVO.getDate_a().substring(0, 11) + productVO.getDate_a().substring(11, 13) + "시"
								+ productVO.getDate_a().substring(14, 16) + "분" %></td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td rowspan="2">경매마감</td>
						<td rowspan="2" colspan="2"><%= productVO.getDate_b().substring(0, 11) + productVO.getDate_b().substring(11, 13) + "시"
								+ productVO.getDate_b().substring(14, 16) + "분" %> &emsp; <span style="color:blue;" id="<%=periodID%>"></span></td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td rowspan="2">상품정보</td>
						<td rowspan="2" colspan="2" style="text-align: left;"><%= productVO.getpExplain().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td>이미지</td>
						<td>
						<div id="carouselExampleControls" class="carousel carousel-dark slide" data-bs-ride="carousel" data-bs-interval="false">
						  <div class="carousel-indicators">
						    <button type="button" data-bs-target="#carouselExampleControls" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						    <%
						    String[] filenames = dir.list();
						    for (int i = 1; i < filenames.length; i++) {
						    %>
						    <button type="button" data-bs-target="#carouselExampleControls" data-bs-slide-to="<%=i %>" aria-label="Slide <%=i%>"></button>
						    <%
						    }
						    %>
						  </div>
						  <div class="carousel-inner">
						    <div class="carousel-item active">
						      <img src="<%=image %>" class="d-block w-100" alt="...">
						    </div>
						    <%
						    for (int i = 1; i < filenames.length; i++) {
						    	image = "img\\image_" + pNumber + "\\" + filenames[i];
						    	%>
							    <div class="carousel-item">
							      <img src="<%=image%>" class="d-block w-100" alt="...">
							    </div>
								<%
							    }
							    %>
						  </div>
						  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Previous</span>
						  </button>
						  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Next</span>
						  </button>
						</div>
						</td>
					</tr>
					<tr><td colspan="2"><br></td></tr>
				</tbody>
			</table>
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				int result = productDAO.getDateDiff(productVO.getDate_b());
	
				if (result < 0) {	// 마감된 경매라면
			%>
				<center class="btn" style="font-size: 1.5rem;">마감된 경매입니다.</center>
			<%
				} else if(id == null){
			%>
					<form action="Login_UI.jsp" method="post" align="center">
						<input type="text" name="bidPrice" placeholder="입찰가 입력" onclick="alert('로그인이 필요합니다.')">
						<input type="submit" value="입찰" onclick="alert('로그인이 필요합니다.'); location.href='Login_UI.jsp'">
					</form>
			<%
				} else if(id.equals(productVO.getId()) || id.equals("admin")){
			%>		
					<center><a href="Delete_DB.jsp?pNumber=<%= pNumber %>" class="btn" style="font-size: 1.5rem;">상품 삭제</a></center>
			<%
				} else {
			%>		
					<a data-bs-toggle="modal" data-bs-target="#exampleModal">신고하기</a>
					<form action="Bid.jsp?pNumber=<%= pNumber %>" method="post" align="center">
						<input type="number" name="bidPrice" placeholder="입찰가 입력">
						<input type="submit" value="입찰">
					</form>
					
					<!-- Modal -->
					<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">신고하기</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <form method="post" action="Report_DB.jsp?pNumber=<%=productVO.getpNumber()%>">
					          <div class="mb-3">
          						<h1 class="modal-title fs-5" id="exampleModalLabel"><%=productVO.getpName()%></h1><br>
				            	<label for="message-text" class="col-form-label">사유: </label>
						          <select name="category">
									<option value="사기 의심">사기 의심</option>
									<option value="광고 및 도배">광고 및 도배</option>					          
									<option value="기타">기타</option>					          
						          </select>
						          </div>
						          <div class="mb-3">
						            <textarea class="form-control" id="reason" name="reason" placeholder="신고내용을 작성해주세요."></textarea>
						          </div>
					      </div>
					      <div class="modal-footer">
					        <button type="submit" class="btn btn-danger">신고</button>
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					        </form>					      
					      </div>
					    </div>
					  </div>
					</div>
			<%
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