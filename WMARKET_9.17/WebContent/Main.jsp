<!-- 메인화면 -->

<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="flea.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더블유마켓</title>
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
	#navBar {
		position: sticky;
	}
</style>
</head>

<!-- 부트스트랩 다운로드 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous"></script>


<body>
<script>
<!-- date까지 남은 시간을 id에 실시간으로 출력하는 함수 -->
const countDownTimer = function (id, date) {
	var _vDate = new Date(date); // 전달 받은 일자
	var _second = 1000;
	var _minute = _second * 60;
	var _hour = _minute * 60;
	var _day = _hour * 24;
	var timer;

	function showRemaining() {
		var now = new Date();	// 현재시간
		var distDt = _vDate - now;

		if (distDt < 0) {	// 남은 시간이 0보다 작은 경우
			clearInterval(timer);
			document.getElementById(id).textContent = '경매마감!!';
			return;
		}

		var days = Math.floor(distDt / _day);
		var hours = Math.floor((distDt % _day) / _hour);
		var minutes = Math.floor((distDt % _hour) / _minute);
		var seconds = Math.floor((distDt % _minute) / _second);

		//document.getElementById(id).textContent = date.toLocaleString() + "까지 : ";
		
		if (days < 1 && hours < 1) {	// 일과 시간이 1보다 작은 경우 >> n분 n초 출력
			document.getElementById(id).textContent = minutes + '분 ';
			document.getElementById(id).textContent += seconds + '초 남음';
		} else if (days < 1) {		// 일이 1보다 작은 경우 >> n시간 n분 출력
			document.getElementById(id).textContent = hours + '시간 ';
			document.getElementById(id).textContent += minutes + '분 남음';
		} else {		// 모두 1 이상인 경우 >> n일 n시간 출력
			document.getElementById(id).textContent = days + '일 ';
			document.getElementById(id).textContent += hours + '시간 남음';
		}
		
	}

	timer = setInterval(showRemaining, 1000);	// 함수를 1초마다 실행
}

</script>
	
<header>
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String sessionID = null;
	if(session.getAttribute("__ID") != null){
		sessionID = (String)session.getAttribute("__ID");
	}
	
	String search = request.getParameter("_search");	//검색어
	if (search == null) {
		search = "";
	}
%>
</header>

<jsp:include page="Header.jsp"/>


<aside></aside>
<div>
<section>
	<div class="container" id="section">
		 <div class="row">
<%
	int pNumber = 0; //DB에서 가져올 정보 변수 선언
	String id = "";
	String pName = "";
	String path = "";
	String image = "";
	String pExplain = "";
	String pCondition = "";
	String price = "";
	String date_a = "";
	String date_b = "";
	String bidMaxPrice = "";
	String name = "";
	
	//판매자 이름으로 검색했을 때
	if(search.replace(" ", "").startsWith("#")) {
		
		name = search.substring(1);
		
		ProductDAO productDAO2 = new ProductDAO();
		ArrayList<ProductVO> list2 = productDAO2.getList(new UserDAO().getIdByName(name));
		BidDAO bidDAO2 = new BidDAO();
		
		for(int i = 0; i < list2.size(); i++){

			pNumber = list2.get(i).getpNumber(); //상품번호
			id = list2.get(i).getId(); //작성자id
			pName = list2.get(i).getpName(); //상품명
			
			path = list2.get(i).getImage(); //이미지 경로
			File dir = new File(path);

			String filename = dir.list()[0];
			image = "img\\image_" + pNumber + "\\" + filename;
			
			pExplain = list2.get(i).getpExplain(); //상품설명
			pCondition = list2.get(i).getpCondition(); //상품상태
			price= list2.get(i).getPrice(); //가격
			date_a = list2.get(i).getDate_a().substring(0, 11) + list2.get(i).getDate_a().substring(11, 13) + "시"
					+ list2.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
			date_b = list2.get(i).getDate_b(); //마감날짜
			
			String period = productDAO2.getPeriod(date_b);

			String periodID = "period2_"+i;
			
			bidMaxPrice = bidDAO2.bidMaxPrice(list2.get(i).getpNumber());
%>
			<div class="col-md-4">
				<div class="card text-dark bg-light mb-3" style="width: 18rem;">
					<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
					<div class="card-body">
                     	<h4 class="card-title"><%=pName %></h4>                
                    	<h6 class="card-text"> 판매자 : <%=new UserDAO().getName(id) %></h6><p>
                    	<h6 class="card-text"> 시작 가격 : <%=price %></h6> 
                    	<h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6><br><p>
						<a href="Detail.jsp?pNumber=<%=pNumber %>" class="btn" style="font-size: 0.4em;"">
						<img class="img_button_view bg-light" src="img/view.png" alt="상세정보"><br>구매 하기</a>
                    	<h7 style="padding-left: 3em;"class="card-text" id="<%=period%>"><%=period %></h7><p>
					</div>
				</div>
			</div>
			<script>
			var date_b = "<%=date_b%>";
			var id = "<%=periodID%>";
			countDownTimer(id, date_b); // 2019년 4월 1일까지
			</script>
<%		
	} } else {
	ProductDAO productDAO = new ProductDAO();
	ArrayList<ProductVO> list = productDAO.getList();
	BidDAO bidDAO = new BidDAO();
	
	for(int i = 0; i < list.size(); i++){

		pNumber = list.get(i).getpNumber(); //상품번호
		id = list.get(i).getId(); //작성자id
		pName = list.get(i).getpName(); //상품명
		
		path = list.get(i).getImage(); //이미지 경로
		File dir = new File(path);
		
		String filename = dir.list()[0];
		image = "img\\image_" + pNumber + "\\" + filename;
		
		pExplain = list.get(i).getpExplain(); //상품설명
		pCondition = list.get(i).getpCondition(); //상품상태
		price= list.get(i).getPrice(); //가격
		date_a = list.get(i).getDate_a().substring(0, 11) + list.get(i).getDate_a().substring(11, 13) + "시"
				+ list.get(i).getDate_a().substring(14, 16) + "분"; //게시날짜
		date_b = list.get(i).getDate_b(); //마감날짜

		String period = productDAO.getPeriod(date_b);
		
		String periodID = "period_"+i;
		
		bidMaxPrice = bidDAO.bidMaxPrice(list.get(i).getpNumber());
		//matches
		if(pName.replace(" ", "").contains(search.replace(" ", ""))) { 
		//for문안에서 

%>
		<div class="col-md-4">
			<div class="card text-dark bg-light mb-3" style="width: 18rem;">
				<img src="<%=image %>" class="card-img-top" alt="..." style="border-bottom: 1px solid #eee; ">
				<div class="card-body">
                     	<h4 class="card-title"><%=pName %></h4>                
                    	<h6 class="card-text"> 판매자 : <%=new UserDAO().getName(id) %></h6><p>
                    	<h6 class="card-text"> 시작 가격 : <%=price %></h6> 
                    	<h6 class="card-text"> 현재 가격 : <%=bidMaxPrice %></h6><br><p>
						<a href="Detail.jsp?pNumber=<%=pNumber %>" class="btn" style="font-size: 0.4em;"">
						<img class="img_button_view bg-light" src="img/view.png" alt="상세정보"><br>구매 하기</a>
                    	<h7 style="padding-left: 3em;"class="card-text" id="<%=periodID%>"><%=period %></h7><p>
				</div>
			</div>
		</div>
		
		<script>
		var date_b = "<%=date_b%>";
		var id = "<%=periodID%>";
		countDownTimer(id, date_b); // 2019년 4월 1일까지
		</script>
	<%} } }%>
	
	
		</div>
	</div>
</section>
</div>
<aside></aside>
</body>
</html>