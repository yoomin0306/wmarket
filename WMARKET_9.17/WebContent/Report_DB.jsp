<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@page import="flea.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����������</title>
</head>
<body>
<%
//���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
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
	
	String category = request.getParameter("category");
	String reason = request.getParameter("reason");
	
	out.println(category);
	out.println(reason);
	
	ReportDAO reportDAO = new ReportDAO();
	int result = reportDAO.report(pNumber, sessionID, category, reason);
	if(result == -1) {		//db����
		out.println("<script>");
		out.println("alert('�����߽��ϴ�')");
		out.println("history.back()");
		out.println("</script>");
	}else {
		out.println("<script>");
		out.println("alert('�����߽��ϴ�.')");
		out.println("history.back()");
		out.println("</script>");
	}
	
%>
</body>
</html>