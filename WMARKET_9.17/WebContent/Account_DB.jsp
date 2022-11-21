<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
%>

<% 
	String money = request.getParameter("money");
	String inOut = request.getParameter("inOut");
	
	UserDAO userDAO = new UserDAO();
  	String account = userDAO.account(sessionID);
  	
  	long money_long = Long.parseLong(money);
  	long account_long = Long.parseLong(account);
	
	if (inOut.equals("입금")) {
		account_long += money_long;
		account = Long.toString(account_long);
		int result = userDAO.inOut(sessionID, account);
		//db오류
		if(result == -1) {
			out.println("<script>");
			out.println("alert('입금에 실패했습니다')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('입금 성공')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
		}
		
	} else if (inOut.equals("출금")) {
		account_long -= money_long;
		account = Long.toString(account_long);
		int result = userDAO.inOut(sessionID, account);
		//db오류
		if(result == -1) {
			out.println("<script>");
			out.println("alert('출금에 실패했습니다')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('출금 성공')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
		}
		
	} else {
		out.println("<script>");
		out.println("alert('에러가 발생했습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
%>
</body>
</html>