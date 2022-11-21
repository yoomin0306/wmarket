<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean class="flea.UserDAO" id="user"></jsp:useBean>
<%
	String sessionId = (String)session.getAttribute("__ID");

	String id = sessionId;
	String pw = request.getParameter("_pw");
	String pw2 = request.getParameter("_pw2");
	String name = request.getParameter("_name");
	String address = request.getParameter("_address");
	String phone = request.getParameter("_phone");
	
	if(pw.equals(pw2)) {
		user.update(id, pw, name, address, phone);
		//out.println("<script>alert(\"수정이 완료되었습니다.\")</script>");
		//out.println("<script>window.location.href='UserInfo_UI.jsp'</script>");
		
		out.println("<script>");
		out.println("alert('수정이 완료되었습니다.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		//out.println("<script>alert(\"비밀번호가 일치하지 않습니다.\")</script>");
		//out.println("<script>window.location.href='UserInfo_UI.jsp'</script>");
		
		out.println("<script>");
		out.println("alert('비밀번호가 일치하지 않습니다.')");
		out.println("history.back()");
		out.println("</script>");
	}

%>
</body>
</html>