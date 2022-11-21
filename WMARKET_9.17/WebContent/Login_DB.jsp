<%@page import="javafx.scene.control.Alert"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*, flea.*"%>
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
    String id = request.getParameter("_id");
    String pw = request.getParameter("_pw");
    
    
    boolean login = user.login(id, pw);
    
    KickedUserDAO kickedUserDAO = new KickedUserDAO();
    boolean kickedUser = kickedUserDAO.findID(id);
    String reason = kickedUserDAO.getReason(id);
    
    if (id != null && pw != null) {
    	if (login && !kickedUser) {
    		session.setAttribute("__ID", id);
            response.sendRedirect("Main.jsp");
    	} else if (!login) {
    		out.println("<script>");
			out.println("alert('아이디 또는 비밀번호가 일치하지 않습니다.')");
			out.println("history.back()");
			out.println("</script>");
    	} else if (kickedUser) {
    		out.println("<script>");
			out.println("alert('이용정지된 아이디입니다. \\n\\n사유: "+reason+"')");
			out.println("history.back()");
			out.println("</script>");
    	}
    } 
	

%>

</body>
</html>