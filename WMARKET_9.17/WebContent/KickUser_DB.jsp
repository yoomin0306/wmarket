<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@page import="flea.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>더블유마켓</title>
</head>
<body>
<%
//메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if (session.getAttribute("__ID") != null) {
		sessionID = (String) session.getAttribute("__ID");
	}	
	
	// 관리자 ID가 맞는지 확인
	if(!sessionID.equals("admin")) {
		out.println("<script>");
		out.println("alert('권한이 없습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}

	
	// id를 초기화 시키고
	// 'id'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
	String id = "";
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	
	String reason = request.getParameter("reason");
	
	out.println(id);
	out.println(reason);
	
	KickedUserDAO kickedUserDAO = new KickedUserDAO();
	int result = kickedUserDAO.kickUser(id, reason);
	if(result == -1) {		//db오류
		out.println("<script>");
		out.println("alert('실패했습니다')");
		out.println("location.href='Manage.jsp'");
		out.println("</script>");
	}else {
		out.println("<script>");
		out.println("alert('성공했습니다.')");
		out.println("location.href='Manage.jsp'");
		out.println("</script>");
	}
%>
</body>
</html>