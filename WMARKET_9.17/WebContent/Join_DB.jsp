<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<style> /* 스타일 */
body { text-align : center; margin:auto; }
hr { width : 500px; }
</style>

</head>
<body>

<jsp:useBean class="flea.UserDAO" id="user"></jsp:useBean>
<%
 	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
	String pw2 = request.getParameter("_pw2");
	String name = request.getParameter("_name");
	String address = request.getParameter("_address");
	String phone = request.getParameter("_phone");
	//String sessionId = (String)session.getAttribute("__ID");
	
	if(id == "" || pw == "" || pw2 == "" || name == "" || address == "" || phone == "") {
		out.println("<script>");
		out.println("alert('입력되지 않은 항목이 있습니다.')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		if(pw.equals(pw2)) {
			user.insert(id, pw, name, address, phone); //클래스를 따로 둬서 UI와 데이터접근을 분리함
			
			session.setAttribute("__ID", id);
			//out.println("<script>alert(\"가입이 완료되었습니다.\")</script>");
			//out.println("<script>window.location.href='Main.jsp'</script>");
			
			out.println("<script>");
			out.println("alert('가입이 완료되었습니다.')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
				
		} else {
			//out.println("<script>alert(\"비밀번호가 일치하지 않습니다.\")</script>");
			//out.println("<script>window.location.href='Join_UI.jsp'</script>");
			
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
	}

%>

</body>
</html>