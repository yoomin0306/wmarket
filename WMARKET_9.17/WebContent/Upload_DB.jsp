<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="flea.ProductVO"%>
<%@page import="flea.ProductDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="vo" class="flea.ProductVO" scope="page" />
<jsp:useBean id="dao" class="flea.ProductDAO" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 업로드</title>
</head>
<body>
<%
	String path = "D:\\WebSoft\\Workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WMARKET_9.17\\img\\image_"+dao.getNext(); //폴더 경로
	File folder = new File(path);
	
	String encType = "utf-8";
	int maxSize = 5*1024*1024; //이미지 최대 용량 5mb
	
	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (folder.exists()) {	// 디렉토리가 존재할 경우 삭제
		File[] folder_list = folder.listFiles();	// 파일리스트 얻어오기
		for (int j = 0; j < folder_list.length; j++) {
			System.out.println(folder_list.length);
			folder_list[j].delete(); //파일 삭제 
		}
		folder_list = folder.listFiles();
		if(folder_list.length == 0 && folder.isDirectory()){ 
			folder.delete(); //대상폴더 삭제
		    folder.mkdir(); //폴더 생성합니다.
		    System.out.println("폴더 생성: "+folder.getAbsolutePath());
		}
				
	} else {
		    folder.mkdir(); //폴더 생성합니다.
		    System.out.println("폴더 생성: "+folder.getAbsolutePath());
			}        
	
	MultipartRequest multi = null;
	
	//파일 업로드
	multi = new MultipartRequest(request, path, maxSize, encType, new DefaultFileRenamePolicy());
	
	String hidden = multi.getParameter("hidden");

	String[] order = hidden.split("/");

	File[] files = folder.listFiles();

	int i = 1;
	for(String s: order) {
		int o = Integer.parseInt(s);
		System.out.println(o);
		File newFile = new File(path+"\\"+i+"_"+files[o].getName());
		files[o].renameTo(newFile);
		i++;
	}

	
	String pName = multi.getParameter("pName");
	
	String pExplain = multi.getParameter("pExplain");
	String pCondition = multi.getParameter("pCondition");
	String price = multi.getParameter("price");
	String date_b = multi.getParameter("date_b_num") + " " + multi.getParameter("date_b_unit");
	
	
	vo.setpName(pName);
	
	vo.setImage(folder.getAbsolutePath());
	
	vo.setpExplain(pExplain);
	vo.setpCondition(pCondition);
	vo.setPrice(price);
	vo.setDate_b(date_b);
	
	
	// 현재 세션 상태를 체크한다
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
	// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
	if(sessionID == null){
		out.println("<script>");
		out.println("alert('로그인을 하세요')");
		out.println("location.href='Login_UI.jsp'");
		out.println("</script>");
	}else {
		// 입력이 안 된 부분이 있는지 체크한다
		if(vo.getpName() == null || vo.getpExplain() == null || vo.getImage() == null  || vo.getpCondition() == null || vo.getPrice() == null || vo.getDate_b() == null){
			out.println("<script>");
			out.println("alert('입력이 안 된 사항이 있습니다')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			// 정상적으로 입력이 되었다면 업로드 로직을 수행한다
			ProductDAO productDAO = new ProductDAO();
			int result = productDAO.upload(sessionID, vo.getpName(), vo.getImage(), vo.getpExplain(), vo.getpCondition(), vo.getPrice(), vo.getDate_b());
			// 데이터베이스 오류인 경우
			if(result == -1){
				out.println("<script>");
				out.println("alert('업로드에 실패했습니다')");
				out.println("history.back()");
				out.println("</script>");
			// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
			}else {
				out.println("<script>");
				out.println("alert('업로드 성공')");
				out.println("location.href='Main.jsp'");
				out.println("</script>");
			}
		}
	}
%>
</body>
</html>