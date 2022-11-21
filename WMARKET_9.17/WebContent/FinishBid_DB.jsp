<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="flea.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����������</title>
</head>
<body>
<%
	// ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
	String sessionID = null;
	if (session.getAttribute("__ID") != null) {
		sessionID = (String) session.getAttribute("__ID");
	}	
	
	// pNumber�� �ʱ�ȭ ��Ű��
	// 'pNumber'��� �����Ͱ� �Ѿ�� ���� �����Ѵٸ� ĳ������ �Ͽ� ������ ��´�
	int pNumber = 0;
	if (request.getParameter("pNumber") != null) {
		pNumber = Integer.parseInt(request.getParameter("pNumber"));
	}

	// ���� �Ѿ�� �����Ͱ� ���ٸ�
	if (pNumber == 0) {
		out.println("<script>");
		out.println("alert('����')");
		out.println("location.href='Main.jsp'");
		out.println("</script");
	}
	
	ProductVO productVO = new ProductDAO().getProduct(pNumber);
	ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
	BidDAO bidDAO = new BidDAO();
	
	int bidMaxPrice = closedBidVO.getBidMaxPrice();
	// ���� Ȯ��	
	if (sessionID.equals(productVO.getId())) {	// if(����id == ��ǰid) -> �Ǹ����� ���
		if (closedBidVO.getTakeProfit() == 0) {		// if(������ ���ɿ��� == 0)
			String account = new UserDAO().account(productVO.getId());	
			long account_long = Long.parseLong(account);
			
			account_long += bidMaxPrice;	// ���� += ������
			account = Long.toString(account_long);
			
			int result1 = new ClosedBidDAO().takeProfit(pNumber);
			int result2 = new UserDAO().inOut(productVO.getId(), account);
			
			if(result1 == -1 || result2 == -1) {	// db����
				out.println("<script>");
				out.println("alert('�Ա� ����')");
				out.println("history.back()");
				out.println("</script");
			} else {
				out.println("<script>");
				out.println("alert('�Ա� ����')");
				out.println("location.href='MyPage.jsp'");
				out.println("</script>");
			}
			
		} else {
			out.println("<script>");
			out.println("alert('�̹� �������� �����Ͽ����ϴ�.')");
			out.println("history.back()");
			out.println("</script");
		}
	} else if (sessionID.equals(closedBidVO.getBidMaxID())) {	//if(����id == ������) -> �������� ���
		out.println("<script>");
		out.println("alert('�������� ȯ�� ���� �ʽ��ϴ�.')");
		out.println("history.back()");
		out.println("</script");
	} else if (bidDAO.bidCheck(sessionID, pNumber)) {	// if(����id == ������id) -> �������� ���
		if (bidDAO.refCheck(sessionID, pNumber) == 0) {		// if(ȯ�� ���� == 0)
			String account = new UserDAO().account(sessionID);
			long account_long = Long.parseLong(account);
			int bidPrice = Integer.parseInt(bidDAO.bidMaxPrice(sessionID, pNumber));	// ������
			
			account_long += bidPrice;	// ���� += ������
			account = Long.toString(account_long);
			
			int result1 = bidDAO.refund(sessionID, pNumber);
			int result2 = new UserDAO().inOut(sessionID, account);
			
			if(result1 == -1 || result2 == -1) {	// db����
				out.println("<script>");
				out.println("alert('�Ա� ����')");
				out.println("history.back()");
				out.println("</script");
			} else {
				out.println("<script>");
				out.println("alert('�Ա� ����')");
				out.println("location.href='MyPage.jsp'");
				out.println("</script>");
			}
			
		} else { 
			out.println("<script>");
			out.println("alert('�̹� ȯ�ҵǾ����ϴ�.')");
			out.println("history.back()");
			out.println("</script");
		} 
		
	} else {
		out.println("<script>");
		out.println("alert('������ �����ϴ�.')");
		out.println("history.back()");
		out.println("</script");
	}
%>
</body>
</html>