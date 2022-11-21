<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
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
      <form class="d-flex" action="Main.jsp" method="post">
        <input class="form-control me-2" type="search" name="_search" placeholder="상품명 또는 #판매자명" aria-label="Search">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="검색">
      </form>
    </div>
  </div>
</nav>

<div style="margin-top:15px;"><hr></div>

<!-- 탭 -->
<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding-left: 12%;">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#myProduct" type="button" role="tab" aria-controls="myProduct" aria-selected="true">내 상품</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#myBid" type="button" role="tab" aria-controls="myBid" aria-selected="false">내 입찰</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#myAccount" type="button" role="tab" aria-controls="myAccount" aria-selected="false">예치금</button>
  </li>
</ul>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous">
</script>
<aside></aside>
<section>

<%
ProductDAO productDAO = new ProductDAO();
BidDAO bidDAO = new BidDAO();
UserDAO userDAO = new UserDAO();

int pNumber = 0; //DB에서 가져올 정보 변수 선언
String id = "";
String pName = "";
String image = "";
String pExplain = "";
String pCondition = "";
String price = "";
String date_a = "";
String date_b = "";

String bidPrice = "";
String bidMaxPrice = "";

String modalID = "";
String modalID2 = "";
%>

<div class="tab-content" id="myTabContent">
	<!-- 첫번째 탭 -->
	<div class="container tab-pane fade show active" id="myProduct" role="tabpanel" aria-labelledby="myProduct-tab">
		 <div class="row">
<%	//마감안된 상품들
	ArrayList<ProductVO> list = productDAO.getList(sessionID);

	for(int i = 0; i < list.size(); i++){
		pNumber = list.get(i).getpNumber(); //상품번호
		id = list.get(i).getId(); //작성자id
		pName = list.get(i).getpName(); //상품명
		image = list.get(i).getImage();	//이미지 경로
		pExplain = list.get(i).getpExplain(); //상품설명
		pCondition = list.get(i).getpCondition(); //상품상태
		price= list.get(i).getPrice(); //가격
		date_a = list.get(i).getDate_a().substring(0, 11) + list.get(i).getDate_a().substring(11, 13) + "시"
				+ list.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
		date_b = list.get(i).getDate_b().substring(5, 7) + "-" + list.get(i).getDate_b().substring(8, 10) + "&nbsp; | &nbsp;" + list.get(i).getDate_b().substring(11, 13) + ":"
				+ list.get(i).getDate_b().substring(14, 16); //마감날짜
		
		bidMaxPrice = bidDAO.bidMaxPrice(list.get(i).getpNumber());
%>
		<div class="col-md-4">
			<div class="card" style="width: 18rem;">
				<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
				<div class="card-body">
                     	<h4 class="card-title"><%=pName %></h4>                
                    	<h6 class="card-text"> 판매자 : <%=userDAO.getName(id) %></h6><p>
                    	<h6 class="card-text"> 시작 가격 : <%=price %></h6>
                    	<h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6><p>
                    	<p class="card-text"> 경매 마감<br><%=date_b %></p>
					<a href="Detail.jsp?pNumber=<%=pNumber %>" class="btn btn-warning">상세정보</a>
				</div>
			</div>
		</div>
<%} %>

<% //마감된 상품들
	ArrayList<ProductVO> list2 = productDAO.getClosedList(sessionID);
	BidDAO bidDAO4 = new BidDAO();
	
	for(int i = 0; i < list2.size(); i++){
		
		pNumber = list2.get(i).getpNumber(); //상품번호
		id = list2.get(i).getId(); //작성자id
		pName = list2.get(i).getpName(); //상품명
		image = list2.get(i).getImage(); //이미지 경로
		pExplain = list2.get(i).getpExplain(); //상품설명
		pCondition = list2.get(i).getpCondition(); //상품상태
		price = list2.get(i).getPrice(); //가격
		date_a = list2.get(i).getDate_a().substring(0, 11) + list2.get(i).getDate_a().substring(11, 13) + "시"
				+ list2.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
		date_b = list2.get(i).getDate_b().substring(5, 7) + "-" + list2.get(i).getDate_b().substring(8, 10) + "&nbsp; | &nbsp;" + list2.get(i).getDate_b().substring(11, 13) + ":"
				+ list2.get(i).getDate_b().substring(14, 16); //마감날짜
				
		bidMaxPrice = bidDAO4.bidMaxPrice(list2.get(i).getpNumber());
				
		modalID = "modal_"+pNumber;
		
		ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
		String bidMaxId = closedBidVO.getBidMaxID(); //낙찰자
		int finPrice = closedBidVO.getBidMaxPrice(); //낙찰가
		int takeProfit = closedBidVO.getTakeProfit();

		int countBid = bidDAO.countBid(pNumber); //입찰 수
%>
		<div class="col-md-4">
			<div class="card text-white bg-secondary mb-3" style="width: 18rem;">
				<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
				<div class="card-body">
                   	<h4 class="card-title"><%=pName %></h4>                
                   	<h6 class="card-text"> 판매자 : <%=userDAO.getName(id) %></h6><p>
                   	<h6 class="card-text"> 시작 가격 : <%=price %></h6>
                   	<h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6><p>
                   	<p class="card-text"> 경매 마감<br><%=date_b %></p>
                 	<a data-bs-toggle="modal" data-bs-target="#<%=modalID%>" class="btn btn-dark">마감정보</a>
					<!-- Modal -->
					<div class="modal fade text-black" id="<%=modalID%>" tabindex="-1"
						aria-labelledby="closedInfoLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="closedInfoLabel">경매마감</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<h1 class="modal-title fs-5" id="exampleModalLabel"><%=pName%></h1><br>
									<%
										if (sessionID.equals(id)) { // 판매자인 경우
											if (countBid == 0) { // 입찰이 없다면
									%>
											입찰 수: <%=countBid%><br>
											입찰이 없습니다 ㅠㅠ
											<%
										} else {
									%>
											입찰 수: <%=countBid%><br>
											낙찰자: <%=userDAO.getName(bidMaxId)%><br> 
											낙찰가: <%=finPrice%>원
											
											<%
										if (takeProfit == 0) { // 낙찰가를 아직 안가져갔으면
									%>
											<button type="button" class="btn btn-primary btn-sm" onclick="location.href='FinishBid_DB.jsp?pNumber=<%=pNumber%>';">
											받기</button>
											<%
												} else { // 가져갔으면
											%>
											<button type="button" class="btn btn-primary btn-sm" disabled>
											수령완료</button>
											<%
												} } }
											%>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
<%} %>


		</div>
	</div>
	
	<!-- 두번째 탭 -->	
  	<div class="container tab-pane fade" id="myBid" role="tabpanel" aria-labelledby="myBid-tab">
		 <div class="row">
<% //유효한 상품들
	ArrayList<ProductVO> list3 = productDAO.getBidList(sessionID); //리스트 생성

	for(int i = 0; i < list3.size(); i++){
		
		pNumber = list3.get(i).getpNumber(); //상품번호
		id = list3.get(i).getId(); //작성자id
		pName = list3.get(i).getpName(); //상품명
		image = list3.get(i).getImage();;
		pExplain = list3.get(i).getpExplain(); //상품설명
		pCondition = list3.get(i).getpCondition(); //상품상태
		price = list3.get(i).getPrice(); //가격
		
		bidPrice = list3.get(i).getBidPrice(); //가격
		
		date_a = list3.get(i).getDate_a(); //게시날짜
		date_b = list3.get(i).getDate_b().substring(5, 7) + "-" + list3.get(i).getDate_b().substring(8, 10) + "&nbsp; | &nbsp;" + list3.get(i).getDate_b().substring(11, 13) + ":"
				+ list3.get(i).getDate_b().substring(14, 16); //마감날짜
		
		bidMaxPrice = bidDAO.bidMaxPrice(list3.get(i).getpNumber());
		 
%>
		<div class="col-md-4">
			<div class="card" style="width: 18rem;">
				<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
				<div class="card-body">
                     	<h4 class="card-title"><%=pName %></h4>                
                    	<h6 class="card-text"> 판매자 : <%=new UserDAO().getName(id) %></h6><p>
                    	<h6 class="card-text"> 시작 가격 : <%=price %></h6>
                    	<h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6>
                    	<h6 class="card-text"> 내 입찰가 : <%=bidPrice %></h6><p>
                    	<p class="card-text"> 경매 마감<br><%=date_b %></p>
						<a href="Detail.jsp?pNumber=<%=pNumber %>" class="btn btn-warning">상세정보</a>
				</div>
			</div>
		</div>
<%} %>

<% //마감된 상품들
	ArrayList<ProductVO> list4 = productDAO.getClosedBidList(sessionID); //리스트 생성

	for(int i = 0; i < list4.size(); i++){
		
		pNumber = list4.get(i).getpNumber(); //상품번호
		id = list4.get(i).getId(); //작성자id
		pName = list4.get(i).getpName(); //상품명
		image = list4.get(i).getImage(); //이미지 경로
		pExplain = list4.get(i).getpExplain(); //상품설명
		pCondition = list4.get(i).getpCondition(); //상품상태
		price = list4.get(i).getPrice(); //가격
		bidPrice = list4.get(i).getBidPrice(); //가격
		date_a = list4.get(i).getDate_a(); //게시날짜
		date_b = list4.get(i).getDate_b().substring(5, 7) + "-" + list4.get(i).getDate_b().substring(8, 10) + "&nbsp; | &nbsp;" + list4.get(i).getDate_b().substring(11, 13) + ":"
				+ list4.get(i).getDate_b().substring(14, 16); //마감날짜
		
		bidMaxPrice = bidDAO.bidMaxPrice(list4.get(i).getpNumber());
		
		modalID = "modal_"+pNumber;
		modalID2 = "report_"+pNumber;
		
		ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
		String bidMaxId = closedBidVO.getBidMaxID(); //낙찰자
		int finPrice = closedBidVO.getBidMaxPrice(); //낙찰가
		int takeProfit = closedBidVO.getTakeProfit();

		int countBid = bidDAO.countBid(pNumber); //입찰 수
%>
		<div class="col-md-4">
			<div class="card text-white bg-secondary mb-3" style="width: 18rem;">
				<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
				<div class="card-body">
                    <h4 class="card-title"><%=pName %></h4>                
                    <h6 class="card-text"> 판매자 : <%=new UserDAO().getName(id) %></h6><p>
                    <h6 class="card-text"> 시작 가격 : <%=price %></h6>
                    <h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6>
                    <h6 class="card-text"> 내 입찰가 : <%=bidPrice %></h6><p>
                    <p class="card-text"> 경매 마감<br><%=date_b %></p>
                    <a data-bs-toggle="modal" data-bs-target="#<%=modalID%>" class="btn btn-dark">마감정보</a>
					<!-- Modal -->
					<div class="modal fade text-black" id="<%=modalID%>" tabindex="-1"
						aria-labelledby="closedInfoLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="closedInfoLabel">경매마감</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<h1 class="modal-title fs-5" id="exampleModalLabel"><%=pName%></h1><br>
											<%
											if (bidDAO.bidCheck(sessionID, pNumber)) { // 입찰자인 경우
												if (sessionID.equals(closedBidVO.getBidMaxID())) { // 낙찰자인 경우
											%>
											낙찰되었습니다. 축하합니다!<br><br>
											
											입찰 수: <%=countBid%><br>
											낙찰자: <%=userDAO.getName(bidMaxId)%><br> 
											낙찰가: <%=finPrice%>원<br><br>
											
											내 최종입찰가: <%=bidDAO.bidMaxPrice(sessionID, pNumber)%>
											<%
												} else { 	// 패찰자인 경우
											%>
											낙찰에 실패했습니다...<br><br>
											
											입찰 수: <%=countBid%><br>
											낙찰자: <%=userDAO.getName(bidMaxId)%><br> 
											낙찰가: <%=finPrice%>원<br><br>
											
											내 최종입찰가: <%=bidDAO.bidMaxPrice(sessionID, pNumber)%>
											<%
												if (bidDAO.refCheck(sessionID, pNumber) == 0) { 	// 환불 안받았으면
											%>
											<button type="button" class="btn btn-primary btn-sm" onclick="location.href='FinishBid_DB.jsp?pNumber=<%=pNumber%>';">
											환불</button>
											<%
												} else {	//받았으면
											%>
											<button type="button" class="btn btn-primary btn-sm" disabled>
											환불완료</button>
											<%
												}
													}
											%>
											<br><br>
											사기피해를 입었나요..?  <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#<%=modalID2%>">신고하기</button>
											<%
												}
											%>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- Modal -->
					<div class="modal fade text-black" id="<%=modalID2 %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="exampleModalLabel">신고하기</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					        <form method="post" action="Report_DB.jsp?pNumber=<%=pNumber%>">
					          <div class="mb-3">
				      						<h1 class="modal-title fs-5" id="exampleModalLabel"><%=pName%></h1><br>
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
				</div>
			</div>
		</div>
<%} %>

		</div>
  	</div>
  	<!-- 세번째 탭 -->
  	<div class="container tab-pane fade" id="myAccount" role="tabpanel" aria-labelledby="myAccount-tab">

  	<%
  	String account = userDAO.account(sessionID);
  	
  	DecimalFormat df = new DecimalFormat("###,###");
  	account = df.format(Long.parseLong(account));
  	%>
  	
  	<form action="Account_DB.jsp" method="post" align="center" style="font-size: 1.5em;">
	  	<br> 내 보유 예치금: <%=account %> 원<br><br>
	  	<input type="number" name="money" min="0"> 원 <br><br>
	  	<input type="submit" name="inOut" value="입금">
	  	<input type="submit" name="inOut" value="출금">
  	</form>
  	</div>
</div>



</section>

<aside></aside>
</body>
</html>