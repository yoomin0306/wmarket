<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="flea.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		
	<%
	int pNumber = 9;
	String modalID = "";
	String modalID2 = "";
	String sessionID = "cheolsu";
			
	
	for(int i=0; i<10; i++) {
		
		modalID = "modal_"+pNumber;
		modalID2 = "report_"+pNumber;
		
		ProductVO productVO = new ProductDAO().getProduct(pNumber);
		String pName = "나이키 조던 울프그레이"; //상품명
		String id = "철수"; //판매자

		ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
		String bidMaxId = closedBidVO.getBidMaxID(); //낙찰자
		int bidMaxPrice = closedBidVO.getBidMaxPrice(); //낙찰가
		int takeProfit = closedBidVO.getTakeProfit();

		BidDAO bidDAO = new BidDAO();
		UserDAO userDAO = new UserDAO();
		int countBid = bidDAO.countBid(pNumber); //입찰 수
		%>
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
							낙찰자: <%=new UserDAO().getName(bidMaxId)%><br> 
							낙찰가: <%=bidMaxPrice%>원
							
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
								}
									}
								} else if (bidDAO.bidCheck(sessionID, pNumber)) { // 입찰자인 경우
									if (sessionID.equals(closedBidVO.getBidMaxID())) { // 낙찰자인 경우
							%>
							낙찰되었습니다. 축하합니다!<br><br>
							
							입찰 수: <%=countBid%><br>
							낙찰자: <%=new UserDAO().getName(bidMaxId)%><br> 
							낙찰가: <%=bidMaxPrice%>원<br><br>
							
							내 최종입찰가: <%=bidDAO.bidMaxPrice(sessionID, pNumber)%>
							<%
								} else { 	// 패찰자인 경우
							%>
							낙찰에 실패했습니다...<br><br>
							
							입찰 수: <%=countBid%><br>
							낙찰자: <%=new UserDAO().getName(bidMaxId)%><br> 
							낙찰가: <%=bidMaxPrice%>원<br><br>
							
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
		<%
	}
		%>
	
</body>
</html>