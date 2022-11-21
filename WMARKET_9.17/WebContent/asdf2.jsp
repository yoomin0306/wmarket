<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
<%
String path = "D:\\WebSoft\\Workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WMARKET_9.17\\img\\testImage";
int maxSize = 5*1024*1024;
String encType = "utf-8";

MultipartRequest multi = new MultipartRequest(request, path, maxSize, encType, new DefaultFileRenamePolicy());
String fileName = multi.getFilesystemName("image");

String hidden = multi.getParameter("hidden");
out.println(hidden);

String[] order = hidden.split("/");

File folder = new File(path);
File[] files = folder.listFiles();

int i = 1;
for(String s: order) {
	int o = Integer.parseInt(s);
	System.out.println(o);
	File newFile = new File(path+"\\"+i+"_"+files[o].getName());
	files[o].renameTo(newFile);
	i++;
}

%>
</body>
</html>