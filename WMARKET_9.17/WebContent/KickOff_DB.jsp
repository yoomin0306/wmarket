<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="flea.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������������</title>
</head>
<body>
<%
	// ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
	
	// ������ ID�� �´��� Ȯ��
	if(!sessionID.equals("admin")) {
		out.println("<script>");
		out.println("alert('������ �����ϴ�.')");
		out.println("history.back()");
		out.println("</script>");
	}
	
	// id�� �ʱ�ȭ ��Ű��
	// 'id'��� �����Ͱ� �Ѿ�� ���� �����Ѵٸ� ĳ������ �Ͽ� ������ ��´�
	String id = "";
	if (request.getParameter("id") != null) {
		id = request.getParameter("id");
	}
	
	KickedUserDAO kickedUserDAO = new KickedUserDAO();
	int result = kickedUserDAO.kickOff(id);
	if(result == -1) {		//db����
		out.println("<script>");
		out.println("alert('�����߽��ϴ�')");
		out.println("location.href='Manage.jsp'");
		out.println("</script>");
	}else {
		out.println("<script>");
		out.println("alert('�����߽��ϴ�.')");
		out.println("location.href='Manage.jsp'");
		out.println("</script>");
	}
%>
</body>
</html>