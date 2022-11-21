<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="flea.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자페이지</title>
<style>
	img {
	  width: 340px;
	  height: 150px;
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
	img.img_button_view {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 50px;
		height: 42px;
		cursor: pointer;
	}
	
</style>

</head>
<body>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
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
	
	// 관리자 ID가 맞는지 확인
	if(!sessionID.equals("admin")) {
		out.println("<script>");
		out.println("alert('권한이 없습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
	
	String search = request.getParameter("_search");	//검색어
	if (search == null) {
		search = "";
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
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="Manage.jsp">관리자페이지</a></div>
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
      <form class="d-flex" action="Main.jsp" method="post">
        <input class="form-control me-2" type="text" name="_search" placeholder="상품명 또는 #판매자명" aria-label="Search" value="<%=search %>">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="검색">
      </form>
    </div>
  </div>
</nav>
<hr>

<!-- 탭 -->
<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding-left: 12%;">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#user" type="button" role="tab" aria-controls="user" aria-selected="true">사용자 조회</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#product" type="button" role="tab" aria-controls="product" aria-selected="false">상품 조회</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#report" type="button" role="tab" aria-controls="report" aria-selected="false">받은 신고</button>
  </li>
</ul>


<div class="tab-content" id="myTabContent">

<!-- 첫번째 탭 -->
<div class="container tab-pane fade show active" id="user" role="tabpanel" aria-labelledby="user-tab">
<div class="row">
<%
String id = "";
String name = "";
String address = "";
String phone = "";
String account = "";

UserDAO userDAO = new UserDAO();
KickedUserDAO kickedUserDAO = new KickedUserDAO();
ArrayList<UserVO> userList = userDAO.getUserList();

%>
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:15rem">아이디</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">닉네임</li>
  <li class="list-group-item list-group-item-secondary" style="width:28rem">주소</li>
  <li class="list-group-item list-group-item-secondary" style="width:12rem">전화번호</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">예치금</li>
  <li class="list-group-item list-group-item-secondary" style="width:5rem">정지</li>
</ul>
<%
for(int i = 0; i < userList.size(); i++) {
	id = userList.get(i).getId();	//아이디
	name = userList.get(i).getName(); 	//닉네임
	address = userList.get(i).getAddress(); 	//주소
	phone = userList.get(i).getPhone();		//전화번호
	account = userList.get(i).getAccount();	//예치금
	
	int random = (int)(Math.random()*1000);
	String modalID = "kickModal_"+id+random;
	
	if (!id.equals("admin")) {
	%>
	<ul class="list-group list-group-horizontal">
	  <li class="list-group-item" style="width:15rem"><%=id %></li>
	  <li class="list-group-item" style="width:10rem"><%=name %></li>
	  <li class="list-group-item" style="width:28rem"><%=address %></li>
	  <li class="list-group-item" style="width:12rem"><%=phone %></li>
	  <li class="list-group-item" style="width:10rem"><%=account %>원</li>
	  <%
	  if (kickedUserDAO.findID(id) == true) {
		  %>
		  <button type="button" class="btn btn-danger" onclick="location.href='KickOff_DB.jsp?id=<%=id%>'">정지해제</button>
		  <%
	  } else {
		  %>
		  <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#<%=modalID%>">이용정지</button>
		  <%
	  }
	  %>
	</ul>	
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">정지사유</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="KickUser_DB.jsp?id=<%=id%>">
	          <div class="mb-3">
	            <label for="message-text" class="col-form-label"><%=name %>님에게</label>
	            <textarea class="form-control" id="message-text" name="reason" placeholder="ex) 사기"></textarea>
	          </div>
		     </div>
		     <div class="modal-footer">
		       <button type="submit" class="btn btn-danger">정지</button>
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<%
} }
%>
</div>
</div>

<!-- 두번째 탭 -->	
<div class="container tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
<div class="row">

진행 중인 경매
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:7rem">상품번호</li>
  <li class="list-group-item list-group-item-secondary" style="width:18rem">상품명</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">판매자 ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">시작 가격</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">현재 가격 (입찰)</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">경매 마감</li>
  <li class="list-group-item list-group-item-secondary" style="width:5rem">조회</li>
</ul>

<%
	int pNumber = 0; //DB에서 가져올 정보 변수 선언
	String pName = "";
	String id2 = "";
	String price = "";
	
	String bidMaxPrice = "";
	int countBid = 0;
	String bidId = "";
	String bidPrice = "";
	
	String date_a = "";
	String date_b = "";
	
	ProductDAO productDAO = new ProductDAO();
	ArrayList<ProductVO> productList = productDAO.getList();
	BidDAO bidDAO = new BidDAO();
	
	for(int i = 0; i < productList.size(); i++) {

		pNumber = productList.get(i).getpNumber(); //상품번호
		pName = productList.get(i).getpName(); //상품명
		id2 = productList.get(i).getId(); //작성자id
		price= productList.get(i).getPrice(); //가격
		
		bidMaxPrice = bidDAO.bidMaxPrice(productList.get(i).getpNumber());
		countBid = bidDAO.countBid(pNumber);
		
		date_a = productList.get(i).getDate_a().substring(0, 11) + productList.get(i).getDate_a().substring(11, 13) + "시"
				+ productList.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
		date_b = productList.get(i).getDate_b(); //마감날짜
		
		int random = (int)(Math.random()*1000);
		String modalID = "bidModal_"+pNumber+random;
		%>
		<ul class="list-group list-group-horizontal">
		  <li class="list-group-item" style="width:7rem"><%=pNumber %></li>
		  <li class="list-group-item" style="width:18rem"><%=pName %></li>
		  <li class="list-group-item" style="width:15rem"><%=id2 %></li>
		  <li class="list-group-item" style="width:10rem"><%=price %>원</li>
		  <button class="list-group-item list-group-item-action" style="width:10rem" data-bs-toggle="modal" data-bs-target="#<%=modalID%>"><%=bidMaxPrice %>원 <span class="badge bg-primary rounded-pill"><%=countBid %></span></button>
		  <li class="list-group-item" style="width:15rem"><%=date_b.substring(0, 16) %></li>
		<button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber %>')">상세정보</button>
		</ul>
		
		<!-- Modal -->
		<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">입찰 조회</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      총 <%=countBid %>건 <br><br>
		    	 <ul class="list-group list-group-horizontal">
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">입찰자 ID</li>
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">입찰가</li>
				 </ul>
				  <%
				  ArrayList<BidVO> bidList = bidDAO.getList(pNumber);
				  
				  for (int i2 = 0; i2 < bidList.size(); i2++) {
					  bidId = bidList.get(i2).getId();
					  bidPrice = bidList.get(i2).getBidPrice();
					  
					  %>
					  	<ul class="list-group list-group-horizontal">
							<li class="list-group-item" style="width:12rem"><%=bidId %></li>
					  		<li class="list-group-item" style="width:12rem"><%=bidPrice %></li>
				  		</ul>
					  <%
				  }
				  %>
			     </div>
			     <div class="modal-footer">
			       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
			
		<%} %>
<br>
마감된 경매
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:7rem">상품번호</li>
  <li class="list-group-item list-group-item-secondary" style="width:18rem">상품명</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">판매자 ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">시작 가격</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">현재 가격 (입찰)</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">경매 마감</li>
    <li class="list-group-item list-group-item-secondary" style="width:5rem">조회</li>
</ul>

<%
	int pNumber3 = 0; //DB에서 가져올 정보 변수 선언
	String pName3 = "";
	String id3 = "";
	String price3 = "";
	
	String bidMaxPrice3 = "";
	int countBid3 = 0;
	String bidId3 = "";
	String bidPrice3 = "";
	
	
	String date_a3 = "";
	String date_b3 = "";
	
	ProductDAO productDAO3 = new ProductDAO();
	ArrayList<ProductVO> productList3 = productDAO3.getFinishedList();
	BidDAO bidDAO3 = new BidDAO();
	
	for(int i = 0; i < productList3.size(); i++) {

		pNumber3 = productList3.get(i).getpNumber(); //상품번호
		pName3 = productList3.get(i).getpName(); //상품명
		id3 = productList3.get(i).getId(); //작성자id
		price3 = productList3.get(i).getPrice(); //가격
		
		bidMaxPrice3 = bidDAO3.bidMaxPrice(productList3.get(i).getpNumber());
		countBid3 = bidDAO3.countBid(pNumber3);
		
		date_a3 = productList3.get(i).getDate_a().substring(0, 11) + productList3.get(i).getDate_a().substring(11, 13) + "시"
				+ productList3.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
		date_b3 = productList3.get(i).getDate_b(); //마감날짜
		
		int random = (int)(Math.random()*1000);
		String modalID = "bidModal_"+pNumber3+random;
		%>
		<ul class="list-group list-group-horizontal">
		  <li class="list-group-item" style="width:7rem"><%=pNumber3 %></li>
		  <li class="list-group-item" style="width:18rem"><%=pName3 %></li>
		  <li class="list-group-item" style="width:15rem"><%=id3 %></li>
		  <li class="list-group-item" style="width:10rem"><%=price3 %>원</li>
		  <button class="list-group-item list-group-item-action" style="width:10rem" data-bs-toggle="modal" data-bs-target="#<%=modalID%>"><%=bidMaxPrice3 %>원 <span class="badge bg-primary rounded-pill"><%=countBid3 %></span></button>
		  <li class="list-group-item" style="width:15rem"><%=date_b3.substring(0, 16) %></li>
		  <button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber3 %>')">상세정보</button>
		</ul>
		
		<!-- Modal -->
		<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">입찰 조회</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      총 <%=countBid3 %>건 <br><br>
		    	 <ul class="list-group list-group-horizontal">
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">입찰자 ID</li>
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">입찰가</li>
				 </ul>
				 <%
				 ArrayList<BidVO> bidList3 = bidDAO3.getList(pNumber3);
				 
				 for (int i2 = 0; i2 < bidList3.size(); i2++) {
					  bidId3 = bidList3.get(i2).getId();
					  bidPrice3 = bidList3.get(i2).getBidPrice();					 
					  
					  %>
					  	<ul class="list-group list-group-horizontal">
							<li class="list-group-item" style="width:12rem"><%=bidId3 %></li>
					  		<li class="list-group-item" style="width:12rem"><%=bidPrice3 %></li>
				  		</ul>
					  <%
				 }
				 %>
							 
				 		      
			     </div>
			     <div class="modal-footer">
			       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<%} %>
</div>
</div>

<!-- 세번째 탭 -->	
<div class="container tab-pane fade" id="report" role="tabpanel" aria-labelledby="report-tab">
<div class="row">

<ul class="list-group list-group-horizontal" style="padding-left: 12%;">
  <li class="list-group-item list-group-item-secondary" style="width:15rem">상품번호</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">판매자 ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">신고자 ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">신고유형</li>
</ul>

<%
int pNumber2 = 0;
String reportedID = "";
String reporterID = "";
String category = "";
String reason = "";

String reportedName = "";

ReportDAO reportDAO = new ReportDAO();
ArrayList<ReportVO> reportList = reportDAO.getReportList();

for (int i = 0; i < reportList.size(); i++) {
	pNumber2 = reportList.get(i).getpNumber();
	reportedID = new ProductDAO().getProduct(pNumber2).getId();
	reporterID = reportList.get(i).getReporter();
	category = reportList.get(i).getCategory();
	reason = reportList.get(i).getReason();
	
	reportedName = new UserDAO().getName(reportedID);
	
	int random = (int)(Math.random()*1000);
	String modalID = "reportModal_"+pNumber+random;
	String modalID2 = "kickModal_"+pNumber+random;
	%>
	<ul class="list-group list-group-horizontal" style="padding-left: 12%;">
	  <li class="list-group-item list-group-item-action" style="width:15rem"><%=pNumber2 %></li>
	  <li class="list-group-item" style="width:15rem"><%=reportedID %></li>
	  <li class="list-group-item" style="width:15rem"><%=reporterID %></li>
	  <li class="list-group-item" style="width:15rem"><%=category %></li>
	  
		<div class="btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#<%=modalID%>">보기</button>
			<button type="button" class="btn btn-dark">삭제</button>
		</div>
	</ul>
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">신고사유</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      <%=reason %>
		     </div>
		     <div class="modal-footer">
		       <button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber2 %>')">상품보기</button>
		       <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#<%=modalID2%>">판매자 이용정지</button>
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID2%>" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel2">정지사유</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="KickUser_DB.jsp?id=<%=reportedID%>">
	          <div class="mb-3">
	            <label for="message-text" class="col-form-label"><%=reportedName %>님에게</label>
	            <textarea class="form-control" id="message-text" name="reason" placeholder="ex) 사기"><%=category %>: <%=reason %></textarea>
	          </div>
		     </div>
		     <div class="modal-footer">
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		       <button type="submit" class="btn btn-danger">정지</button>
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
</div>
	

</body>
</html>