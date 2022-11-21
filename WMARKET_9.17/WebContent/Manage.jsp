<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="flea.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������������</title>
<style>
	img {
	  width: 340px;
	  height: 150px;
	  object-fit: contain;
	}
	h6.card-text {
		font-size: 1em;
	}
	p.card-text {
		font-size: 0.5em;
	}
	input.img_button {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 42px;
		height: 42px;
		cursor: pointer;
	}
	a { text-decoration: none; }
	@font-face {
	    font-family: 'IM_Hyemin-Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/IM_Hyemin-Bold.woff2') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* { font-family: "IM_Hyemin-Bold" }
	img.img_button_view {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 50px;
		height: 42px;
		cursor: pointer;
	}
	
</style>

</head>
<body>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
		crossorigin="anonymous">
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
<header>
<div class="container">
<div class="row">
<div class="col-6"></div>
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
	
	String search = request.getParameter("_search");	//�˻���
	if (search == null) {
		search = "";
	}
%>
<%
	// �α��� �� ���� �� ȭ��
	if(sessionID == null){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Login_UI.jsp">�α���</a> &emsp; <a href="Join_UI.jsp">ȸ������</a></div>
<%
	// ������ �α���
	} else if(sessionID.equals("admin")){
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><a href="Logout.jsp">�α׾ƿ�</a> &emsp; <a href="Manage.jsp">������������</a></div>
<%
	// �α��� ���� �� ȭ��
	}else {
%>
	<div align="right" style="padding-right: 10%; padding-top:5px;"><%=new UserDAO().getName(sessionID) %>�� &emsp; ��ġ��: <%=new UserDAO().account(sessionID) %>�� &emsp; <a href="Logout.jsp">�α׾ƿ�</a> &emsp; <a href="UserInfo_UI.jsp">�� ����</a> &emsp; <a href="MyPage.jsp">�� ����</a> &emsp; <a href="Upload_UI.jsp">��ǰ ���</a></div>
<%
	}
%>
</div>
</div>
</header>
<!-- nav -->
<nav class="navbar navbar-expand-lg sticky-top navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="Main.jsp">����������</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <form class="d-flex" action="Main.jsp" method="post">
        <input class="form-control me-2" type="text" name="_search" placeholder="��ǰ�� �Ǵ� #�Ǹ��ڸ�" aria-label="Search" value="<%=search %>">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="�˻�">
      </form>
    </div>
  </div>
</nav>
<hr>

<!-- �� -->
<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding-left: 12%;">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#user" type="button" role="tab" aria-controls="user" aria-selected="true">����� ��ȸ</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#product" type="button" role="tab" aria-controls="product" aria-selected="false">��ǰ ��ȸ</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#report" type="button" role="tab" aria-controls="report" aria-selected="false">���� �Ű�</button>
  </li>
</ul>


<div class="tab-content" id="myTabContent">

<!-- ù��° �� -->
<div class="container tab-pane fade show active" id="user" role="tabpanel" aria-labelledby="user-tab">
<div class="row">
<%
String id = "";
String name = "";
String address = "";
String phone = "";
String account = "";

UserDAO userDAO = new UserDAO();
KickedUserDAO kickedUserDAO = new KickedUserDAO();
ArrayList<UserVO> userList = userDAO.getUserList();

%>
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:15rem">���̵�</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">�г���</li>
  <li class="list-group-item list-group-item-secondary" style="width:28rem">�ּ�</li>
  <li class="list-group-item list-group-item-secondary" style="width:12rem">��ȭ��ȣ</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">��ġ��</li>
  <li class="list-group-item list-group-item-secondary" style="width:5rem">����</li>
</ul>
<%
for(int i = 0; i < userList.size(); i++) {
	id = userList.get(i).getId();	//���̵�
	name = userList.get(i).getName(); 	//�г���
	address = userList.get(i).getAddress(); 	//�ּ�
	phone = userList.get(i).getPhone();		//��ȭ��ȣ
	account = userList.get(i).getAccount();	//��ġ��
	
	int random = (int)(Math.random()*1000);
	String modalID = "kickModal_"+id+random;
	
	if (!id.equals("admin")) {
	%>
	<ul class="list-group list-group-horizontal">
	  <li class="list-group-item" style="width:15rem"><%=id %></li>
	  <li class="list-group-item" style="width:10rem"><%=name %></li>
	  <li class="list-group-item" style="width:28rem"><%=address %></li>
	  <li class="list-group-item" style="width:12rem"><%=phone %></li>
	  <li class="list-group-item" style="width:10rem"><%=account %>��</li>
	  <%
	  if (kickedUserDAO.findID(id) == true) {
		  %>
		  <button type="button" class="btn btn-danger" onclick="location.href='KickOff_DB.jsp?id=<%=id%>'">��������</button>
		  <%
	  } else {
		  %>
		  <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#<%=modalID%>">�̿�����</button>
		  <%
	  }
	  %>
	</ul>	
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">��������</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="KickUser_DB.jsp?id=<%=id%>">
	          <div class="mb-3">
	            <label for="message-text" class="col-form-label"><%=name %>�Կ���</label>
	            <textarea class="form-control" id="message-text" name="reason" placeholder="ex) ���"></textarea>
	          </div>
		     </div>
		     <div class="modal-footer">
		       <button type="submit" class="btn btn-danger">����</button>
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">���</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<%
} }
%>
</div>
</div>

<!-- �ι�° �� -->	
<div class="container tab-pane fade" id="product" role="tabpanel" aria-labelledby="product-tab">
<div class="row">

���� ���� ���
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:7rem">��ǰ��ȣ</li>
  <li class="list-group-item list-group-item-secondary" style="width:18rem">��ǰ��</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">�Ǹ��� ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">���� ����</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">���� ���� (����)</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">��� ����</li>
  <li class="list-group-item list-group-item-secondary" style="width:5rem">��ȸ</li>
</ul>

<%
	int pNumber = 0; //DB���� ������ ���� ���� ����
	String pName = "";
	String id2 = "";
	String price = "";
	
	String bidMaxPrice = "";
	int countBid = 0;
	String bidId = "";
	String bidPrice = "";
	
	String date_a = "";
	String date_b = "";
	
	ProductDAO productDAO = new ProductDAO();
	ArrayList<ProductVO> productList = productDAO.getList();
	BidDAO bidDAO = new BidDAO();
	
	for(int i = 0; i < productList.size(); i++) {

		pNumber = productList.get(i).getpNumber(); //��ǰ��ȣ
		pName = productList.get(i).getpName(); //��ǰ��
		id2 = productList.get(i).getId(); //�ۼ���id
		price= productList.get(i).getPrice(); //����
		
		bidMaxPrice = bidDAO.bidMaxPrice(productList.get(i).getpNumber());
		countBid = bidDAO.countBid(pNumber);
		
		date_a = productList.get(i).getDate_a().substring(0, 11) + productList.get(i).getDate_a().substring(11, 13) + "��"
				+ productList.get(i).getDate_a().substring(14, 16) + "��"; //�Խó�¥
		date_b = productList.get(i).getDate_b(); //������¥
		
		int random = (int)(Math.random()*1000);
		String modalID = "bidModal_"+pNumber+random;
		%>
		<ul class="list-group list-group-horizontal">
		  <li class="list-group-item" style="width:7rem"><%=pNumber %></li>
		  <li class="list-group-item" style="width:18rem"><%=pName %></li>
		  <li class="list-group-item" style="width:15rem"><%=id2 %></li>
		  <li class="list-group-item" style="width:10rem"><%=price %>��</li>
		  <button class="list-group-item list-group-item-action" style="width:10rem" data-bs-toggle="modal" data-bs-target="#<%=modalID%>"><%=bidMaxPrice %>�� <span class="badge bg-primary rounded-pill"><%=countBid %></span></button>
		  <li class="list-group-item" style="width:15rem"><%=date_b.substring(0, 16) %></li>
		<button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber %>')">������</button>
		</ul>
		
		<!-- Modal -->
		<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">���� ��ȸ</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      �� <%=countBid %>�� <br><br>
		    	 <ul class="list-group list-group-horizontal">
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">������ ID</li>
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">������</li>
				 </ul>
				  <%
				  ArrayList<BidVO> bidList = bidDAO.getList(pNumber);
				  
				  for (int i2 = 0; i2 < bidList.size(); i2++) {
					  bidId = bidList.get(i2).getId();
					  bidPrice = bidList.get(i2).getBidPrice();
					  
					  %>
					  	<ul class="list-group list-group-horizontal">
							<li class="list-group-item" style="width:12rem"><%=bidId %></li>
					  		<li class="list-group-item" style="width:12rem"><%=bidPrice %></li>
				  		</ul>
					  <%
				  }
				  %>
			     </div>
			     <div class="modal-footer">
			       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">�ݱ�</button>
		      </div>
		    </div>
		  </div>
		</div>
			
		<%} %>
<br>
������ ���
<ul class="list-group list-group-horizontal">
  <li class="list-group-item list-group-item-secondary" style="width:7rem">��ǰ��ȣ</li>
  <li class="list-group-item list-group-item-secondary" style="width:18rem">��ǰ��</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">�Ǹ��� ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">���� ����</li>
  <li class="list-group-item list-group-item-secondary" style="width:10rem">���� ���� (����)</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">��� ����</li>
    <li class="list-group-item list-group-item-secondary" style="width:5rem">��ȸ</li>
</ul>

<%
	int pNumber3 = 0; //DB���� ������ ���� ���� ����
	String pName3 = "";
	String id3 = "";
	String price3 = "";
	
	String bidMaxPrice3 = "";
	int countBid3 = 0;
	String bidId3 = "";
	String bidPrice3 = "";
	
	
	String date_a3 = "";
	String date_b3 = "";
	
	ProductDAO productDAO3 = new ProductDAO();
	ArrayList<ProductVO> productList3 = productDAO3.getFinishedList();
	BidDAO bidDAO3 = new BidDAO();
	
	for(int i = 0; i < productList3.size(); i++) {

		pNumber3 = productList3.get(i).getpNumber(); //��ǰ��ȣ
		pName3 = productList3.get(i).getpName(); //��ǰ��
		id3 = productList3.get(i).getId(); //�ۼ���id
		price3 = productList3.get(i).getPrice(); //����
		
		bidMaxPrice3 = bidDAO3.bidMaxPrice(productList3.get(i).getpNumber());
		countBid3 = bidDAO3.countBid(pNumber3);
		
		date_a3 = productList3.get(i).getDate_a().substring(0, 11) + productList3.get(i).getDate_a().substring(11, 13) + "��"
				+ productList3.get(i).getDate_a().substring(14, 16) + "��"; //�Խó�¥
		date_b3 = productList3.get(i).getDate_b(); //������¥
		
		int random = (int)(Math.random()*1000);
		String modalID = "bidModal_"+pNumber3+random;
		%>
		<ul class="list-group list-group-horizontal">
		  <li class="list-group-item" style="width:7rem"><%=pNumber3 %></li>
		  <li class="list-group-item" style="width:18rem"><%=pName3 %></li>
		  <li class="list-group-item" style="width:15rem"><%=id3 %></li>
		  <li class="list-group-item" style="width:10rem"><%=price3 %>��</li>
		  <button class="list-group-item list-group-item-action" style="width:10rem" data-bs-toggle="modal" data-bs-target="#<%=modalID%>"><%=bidMaxPrice3 %>�� <span class="badge bg-primary rounded-pill"><%=countBid3 %></span></button>
		  <li class="list-group-item" style="width:15rem"><%=date_b3.substring(0, 16) %></li>
		  <button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber3 %>')">������</button>
		</ul>
		
		<!-- Modal -->
		<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">���� ��ȸ</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      �� <%=countBid3 %>�� <br><br>
		    	 <ul class="list-group list-group-horizontal">
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">������ ID</li>
				  <li class="list-group-item list-group-item-secondary" style="width:12rem">������</li>
				 </ul>
				 <%
				 ArrayList<BidVO> bidList3 = bidDAO3.getList(pNumber3);
				 
				 for (int i2 = 0; i2 < bidList3.size(); i2++) {
					  bidId3 = bidList3.get(i2).getId();
					  bidPrice3 = bidList3.get(i2).getBidPrice();					 
					  
					  %>
					  	<ul class="list-group list-group-horizontal">
							<li class="list-group-item" style="width:12rem"><%=bidId3 %></li>
					  		<li class="list-group-item" style="width:12rem"><%=bidPrice3 %></li>
				  		</ul>
					  <%
				 }
				 %>
							 
				 		      
			     </div>
			     <div class="modal-footer">
			       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">�ݱ�</button>
		      </div>
		    </div>
		  </div>
		</div>
		<%} %>
</div>
</div>

<!-- ����° �� -->	
<div class="container tab-pane fade" id="report" role="tabpanel" aria-labelledby="report-tab">
<div class="row">

<ul class="list-group list-group-horizontal" style="padding-left: 12%;">
  <li class="list-group-item list-group-item-secondary" style="width:15rem">��ǰ��ȣ</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">�Ǹ��� ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">�Ű��� ID</li>
  <li class="list-group-item list-group-item-secondary" style="width:15rem">�Ű�����</li>
</ul>

<%
int pNumber2 = 0;
String reportedID = "";
String reporterID = "";
String category = "";
String reason = "";

String reportedName = "";

ReportDAO reportDAO = new ReportDAO();
ArrayList<ReportVO> reportList = reportDAO.getReportList();

for (int i = 0; i < reportList.size(); i++) {
	pNumber2 = reportList.get(i).getpNumber();
	reportedID = new ProductDAO().getProduct(pNumber2).getId();
	reporterID = reportList.get(i).getReporter();
	category = reportList.get(i).getCategory();
	reason = reportList.get(i).getReason();
	
	reportedName = new UserDAO().getName(reportedID);
	
	int random = (int)(Math.random()*1000);
	String modalID = "reportModal_"+pNumber+random;
	String modalID2 = "kickModal_"+pNumber+random;
	%>
	<ul class="list-group list-group-horizontal" style="padding-left: 12%;">
	  <li class="list-group-item list-group-item-action" style="width:15rem"><%=pNumber2 %></li>
	  <li class="list-group-item" style="width:15rem"><%=reportedID %></li>
	  <li class="list-group-item" style="width:15rem"><%=reporterID %></li>
	  <li class="list-group-item" style="width:15rem"><%=category %></li>
	  
		<div class="btn-group" role="group" aria-label="Basic example">
			<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#<%=modalID%>">����</button>
			<button type="button" class="btn btn-dark">����</button>
		</div>
	</ul>
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">�Ű����</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      <%=reason %>
		     </div>
		     <div class="modal-footer">
		       <button type="button" class="btn btn-warning" onclick="window.open('Detail.jsp?pNumber=<%=pNumber2 %>')">��ǰ����</button>
		       <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#<%=modalID2%>">�Ǹ��� �̿�����</button>
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">���</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="<%=modalID2%>" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel2">��������</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="KickUser_DB.jsp?id=<%=reportedID%>">
	          <div class="mb-3">
	            <label for="message-text" class="col-form-label"><%=reportedName %>�Կ���</label>
	            <textarea class="form-control" id="message-text" name="reason" placeholder="ex) ���"><%=category %>: <%=reason %></textarea>
	          </div>
		     </div>
		     <div class="modal-footer">
		       <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">���</button>
		       <button type="submit" class="btn btn-danger">����</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<%
}
%>
</div>
</div>
</div>
	

</body>
</html>