<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
	String bidPrice_St = request.getParameter("bidPrice");
	int bidPrice = Integer.parseInt(bidPrice_St);
	out.println(bidPrice);
	
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
	
	int pNumber = 0;
	pNumber = Integer.parseInt(request.getParameter("pNumber"));
	
	ProductVO vo = new ProductDAO().getProduct(pNumber);
	
	int price;
	price = Integer.parseInt(vo.getPrice());
	out.println(price);
	
	int curPrice;
	curPrice = Integer.parseInt(new BidDAO().bidMaxPrice(pNumber));
	
	int minPrice = curPrice + 1000;
	out.println(minPrice);
	
	if (bidPrice < minPrice) {	//최소입찰가 미만인 경우
		out.println("<script>");
		out.println("alert('최소입찰가를 충족해주세요.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		String account = userDAO.account(sessionID);
		int account_int = Integer.parseInt(account);
		
		if (account_int < bidPrice) {	//잔액이 부족할 경우
			out.println("<script>");
			out.println("alert('예치금 잔액이 부족합니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
		BidDAO bidDAO = new BidDAO();
		
		String pastBid = bidDAO.bidMaxPrice(sessionID, pNumber);	//이전 입찰금액 (혹시 몰라서 최댓값으로 가져옴)
		if(pastBid != null) {	//입찰가가 있으면
			int pastBid_int = Integer.parseInt(pastBid);	//형변환
			account_int += pastBid_int;		//예치금 += 이전 입찰가
			account = Integer.toString(account_int);	//형변환
			
			int result = bidDAO.delBid(sessionID, pNumber);	//이전의 입찰 기록을 삭제
			
			if(result == -1) {	//이전 입찰기록이 있는데 삭제가 안됨 == db오류
				out.println("<script>");
				out.println("alert('데이터베이스 오류')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		}
		
		
		int result1 = bidDAO.bid(sessionID, pNumber, bidPrice_St);	//입찰
		//db오류
		if(result1 == -1) {
			out.println("<script>");
			out.println("alert('입찰에 실패했습니다')");
			out.println("history.back()");
			out.println("</script>");
			} else {
				account_int -= bidPrice;
				account = Integer.toString(account_int);
				
				int result2 = userDAO.inOut(sessionID, account);
				//db오류
				if(result2 == -1) {
					out.println("<script>");
					out.println("alert('입찰에 실패했습니다')");
					out.println("history.back()");
					out.println("</script>");
				} else {
					out.println("<script>");
					out.println("alert('입찰 성공')");
					out.println("location.href='Main.jsp'");
					out.println("</script>");
				}
				
				out.println("<script>");
				out.println("alert('입찰 성공')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			
		}
		
	}
	
%>
</body>
</html>