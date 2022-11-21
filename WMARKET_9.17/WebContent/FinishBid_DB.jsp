<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="flea.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>더블유마켓</title>
</head>
<body>
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if (session.getAttribute("__ID") != null) {
		sessionID = (String) session.getAttribute("__ID");
	}	
	
	// pNumber를 초기화 시키고
	// 'pNumber'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
	int pNumber = 0;
	if (request.getParameter("pNumber") != null) {
		pNumber = Integer.parseInt(request.getParameter("pNumber"));
	}

	// 만약 넘어온 데이터가 없다면
	if (pNumber == 0) {
		out.println("<script>");
		out.println("alert('에러')");
		out.println("location.href='Main.jsp'");
		out.println("</script");
	}
	
	ProductVO productVO = new ProductDAO().getProduct(pNumber);
	ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
	BidDAO bidDAO = new BidDAO();
	
	int bidMaxPrice = closedBidVO.getBidMaxPrice();
	// 정보 확인	
	if (sessionID.equals(productVO.getId())) {	// if(세션id == 상품id) -> 판매자인 경우
		if (closedBidVO.getTakeProfit() == 0) {		// if(낙찰가 수령여부 == 0)
			String account = new UserDAO().account(productVO.getId());	
			long account_long = Long.parseLong(account);
			
			account_long += bidMaxPrice;	// 계좌 += 낙찰가
			account = Long.toString(account_long);
			
			int result1 = new ClosedBidDAO().takeProfit(pNumber);
			int result2 = new UserDAO().inOut(productVO.getId(), account);
			
			if(result1 == -1 || result2 == -1) {	// db오류
				out.println("<script>");
				out.println("alert('입금 실패')");
				out.println("history.back()");
				out.println("</script");
			} else {
				out.println("<script>");
				out.println("alert('입금 성공')");
				out.println("location.href='MyPage.jsp'");
				out.println("</script>");
			}
			
		} else {
			out.println("<script>");
			out.println("alert('이미 낙찰가를 수령하였습니다.')");
			out.println("history.back()");
			out.println("</script");
		}
	} else if (sessionID.equals(closedBidVO.getBidMaxID())) {	//if(세션id == 낙찰자) -> 낙찰자인 경우
		out.println("<script>");
		out.println("alert('낙찰가는 환불 되지 않습니다.')");
		out.println("history.back()");
		out.println("</script");
	} else if (bidDAO.bidCheck(sessionID, pNumber)) {	// if(세션id == 입찰자id) -> 입찰자인 경우
		if (bidDAO.refCheck(sessionID, pNumber) == 0) {		// if(환불 여부 == 0)
			String account = new UserDAO().account(sessionID);
			long account_long = Long.parseLong(account);
			int bidPrice = Integer.parseInt(bidDAO.bidMaxPrice(sessionID, pNumber));	// 입찰가
			
			account_long += bidPrice;	// 계좌 += 입찰가
			account = Long.toString(account_long);
			
			int result1 = bidDAO.refund(sessionID, pNumber);
			int result2 = new UserDAO().inOut(sessionID, account);
			
			if(result1 == -1 || result2 == -1) {	// db오류
				out.println("<script>");
				out.println("alert('입금 실패')");
				out.println("history.back()");
				out.println("</script");
			} else {
				out.println("<script>");
				out.println("alert('입금 성공')");
				out.println("location.href='MyPage.jsp'");
				out.println("</script>");
			}
			
		} else { 
			out.println("<script>");
			out.println("alert('이미 환불되었습니다.')");
			out.println("history.back()");
			out.println("</script");
		} 
		
	} else {
		out.println("<script>");
		out.println("alert('권한이 없습니다.')");
		out.println("history.back()");
		out.println("</script");
	}
%>
</body>
</html>