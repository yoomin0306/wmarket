<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String path = "D:\\WebSoft\\Workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WMARKET_9.17\\img\\testImage"; //���� ���
String encType = "utf-8";
int maxSize = 5*1024*1024; //�̹��� �ִ� �뷮 5mb

MultipartRequest multi = null;
multi = new MultipartRequest(request, path, maxSize, encType, new DefaultFileRenamePolicy());

%>


</body>
</html>