<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="flea.ProductVO"%>
<%@page import="flea.ProductDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����������</title>
</head>
<body>
<%
	// ���� ���� ���¸� üũ�Ѵ�
	String sessionID = null;
	if (session.getAttribute("__ID") != null) {
		sessionID = (String) session.getAttribute("__ID");
	}
	// �α����� �� ����� ���� �� �� �ֵ��� �ڵ带 �����Ѵ�
	if (sessionID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�α����� �ϼ���')");
		script.println("location.href='Login_UI.jsp'");
		script.println("</script>");
	}

	int pNumber = 0;
	if (request.getParameter("pNumber") != null) {
		pNumber = Integer.parseInt(request.getParameter("pNumber"));
	}
	if (pNumber == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('��ȿ���� ���� ���Դϴ�')");
		script.println("location.href='Main.jsp'");
		script.println("</script>");
	}
	//�ش� 'pNumber'�� ���� �Խñ��� ������ ���� ������ ���Ͽ� �ۼ��� ������ �´��� üũ�Ѵ�
	ProductVO productVO = new ProductDAO().getProduct(pNumber);
	if (!sessionID.equals(productVO.getId()) && !sessionID.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('������ �����ϴ�')");
		script.println("location.href='Main.jsp'");
		script.println("</script>");
	} else {
		// �� ���� ������ �����Ѵ�
		ProductDAO productDAO = new ProductDAO();
		int result = productDAO.delProduct(pNumber);
		int result2 = productDAO.delBid(pNumber);
		// �����ͺ��̽� ������ ���
		if (result == -1 || result2 == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ǰ ���� ����')");
			script.println("history.back()");
			script.println("</script>");
			// �� ������ ���������� ����Ǹ� �˸�â�� ���� �Խ��� �������� �̵��Ѵ�
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ǰ ���� ����')");
			script.println("location.href='Main.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>