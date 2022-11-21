<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="flea.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		
	<%
	int pNumber = 9;
	String modalID = "";
	String modalID2 = "";
	String sessionID = "cheolsu";
			
	
	for(int i=0; i<10; i++) {
		
		modalID = "modal_"+pNumber;
		modalID2 = "report_"+pNumber;
		
		ProductVO productVO = new ProductDAO().getProduct(pNumber);
		String pName = "����Ű ���� �����׷���"; //��ǰ��
		String id = "ö��"; //�Ǹ���

		ClosedBidVO closedBidVO = new ClosedBidDAO().getList(pNumber);
		String bidMaxId = closedBidVO.getBidMaxID(); //������
		int bidMaxPrice = closedBidVO.getBidMaxPrice(); //������
		int takeProfit = closedBidVO.getTakeProfit();

		BidDAO bidDAO = new BidDAO();
		UserDAO userDAO = new UserDAO();
		int countBid = bidDAO.countBid(pNumber); //���� ��
		%>
	<a data-bs-toggle="modal" data-bs-target="#<%=modalID%>" class="btn btn-dark">��������</a>
	<!-- Modal -->
	<div class="modal fade text-black" id="<%=modalID%>" tabindex="-1"
		aria-labelledby="closedInfoLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="closedInfoLabel">��Ÿ���</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h1 class="modal-title fs-5" id="exampleModalLabel"><%=pName%></h1><br>
					<%
						if (sessionID.equals(id)) { // �Ǹ����� ���
							if (countBid == 0) { // ������ ���ٸ�
					%>
							���� ��: <%=countBid%><br>
							������ �����ϴ� �Ф�
							<%
						} else {
					%>
							���� ��: <%=countBid%><br>
							������: <%=new UserDAO().getName(bidMaxId)%><br> 
							������: <%=bidMaxPrice%>��
							
							<%
						if (takeProfit == 0) { // �������� ���� �Ȱ���������
					%>
							<button type="button" class="btn btn-primary btn-sm" onclick="location.href='FinishBid_DB.jsp?pNumber=<%=pNumber%>';">
							�ޱ�</button>
							<%
								} else { // ����������
							%>
							<button type="button" class="btn btn-primary btn-sm" disabled>
							���ɿϷ�</button>
							<%
								}
									}
								} else if (bidDAO.bidCheck(sessionID, pNumber)) { // �������� ���
									if (sessionID.equals(closedBidVO.getBidMaxID())) { // �������� ���
							%>
							�����Ǿ����ϴ�. �����մϴ�!<br><br>
							
							���� ��: <%=countBid%><br>
							������: <%=new UserDAO().getName(bidMaxId)%><br> 
							������: <%=bidMaxPrice%>��<br><br>
							
							�� ����������: <%=bidDAO.bidMaxPrice(sessionID, pNumber)%>
							<%
								} else { 	// �������� ���
							%>
							������ �����߽��ϴ�...<br><br>
							
							���� ��: <%=countBid%><br>
							������: <%=new UserDAO().getName(bidMaxId)%><br> 
							������: <%=bidMaxPrice%>��<br><br>
							
							�� ����������: <%=bidDAO.bidMaxPrice(sessionID, pNumber)%>
							<%
								if (bidDAO.refCheck(sessionID, pNumber) == 0) { 	// ȯ�� �ȹ޾�����
							%>
							<button type="button" class="btn btn-primary btn-sm" onclick="location.href='FinishBid_DB.jsp?pNumber=<%=pNumber%>';">
							ȯ��</button>
							<%
								} else {	//�޾�����
							%>
							<button type="button" class="btn btn-primary btn-sm" disabled>
							ȯ�ҿϷ�</button>
							<%
								}
									}
							%>
							<br><br>
							������ظ� �Ծ�����..?  <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#<%=modalID2%>">�Ű��ϱ�</button>
							<%
								}
							%>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">�ݱ�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade text-black" id="<%=modalID2 %>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">�Ű��ϱ�</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form method="post" action="Report_DB.jsp?pNumber=<%=pNumber%>">
	          <div class="mb-3">
      						<h1 class="modal-title fs-5" id="exampleModalLabel"><%=pName%></h1><br>
            	<label for="message-text" class="col-form-label">����: </label>
		          <select name="category">
					<option value="��� �ǽ�">��� �ǽ�</option>
					<option value="���� �� ����">���� �� ����</option>					          
					<option value="��Ÿ">��Ÿ</option>					          
		          </select>
		          </div>
		          <div class="mb-3">
		            <textarea class="form-control" id="reason" name="reason" placeholder="�Ű����� �ۼ����ּ���."></textarea>
		          </div>
	      </div>
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-danger">�Ű�</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">���</button>
	        </form>					      
	      </div>
	    </div>
	  </div>
	</div>
		<%
	}
		%>
	
</body>
</html>