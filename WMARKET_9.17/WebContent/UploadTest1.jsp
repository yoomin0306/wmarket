<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>상품 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">

<style> 
	a { text-decoration: none; }
	input.img_button {
		vertical-align: middle;
		background-color: white;
		border: none;
		width: 42px;
		height: 42px;
		cursor: pointer; }

	@font-face {
	    font-family: 'IM_Hyemin-Bold';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2106@1.1/IM_Hyemin-Bold.woff2') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	* { font-family: "IM_Hyemin-Bold" }

	form img {
      height: 5rem;
    }
</style>
</head>
<header>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String sessionID = null;
		if(session.getAttribute("__ID") != null){
			sessionID = (String)session.getAttribute("__ID");
		}
	%>	
	<%
		// 로그인 안 했을 때 화면
		if(sessionID == null){
	%>
		<div align="right" style="padding-right: 20%; padding-top:5px;"><a href="Login_UI.jsp">로그인</a> &emsp; <a href="Join_UI.jsp">회원가입</a></div>				
	<%
		// 로그인이 했을 때 화면
		}else {
	%>
		<div align="right" style="padding-right: 20%; padding-top:5px;"><a href="Logout.jsp">로그아웃</a> &emsp; <a href="UserInfo_UI.jsp">내 정보</a> &emsp; <a href="MyPage.jsp">내 상점</a></div>
	<%
		}
	%>
</header>

<!-- nav -->
<nav class="navbar navbar-expand-lg sticky-top navbar-light bg-light">
  <div class="container">
    <a class="navbar-brand" href="Main.jsp" style="padding-left: 20%;">더블유마켓</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="상품명" aria-label="Search">
        <input class="img_button bg-light" type="image" src="img/search.png" alt="검색">
      </form>
    </div>
  </div>
</nav>


<div style="margin-top:15px;"><hr></div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
crossorigin="anonymous"></script>

<section>
	<!-- 상품 등록 영역 시작 -->
<form method="post" action="Upload_DB.jsp" enctype="multipart/form-data" >
	<table class="tb" align="center" style="border: 100px; solid: #dddddd;">
		<thead>
			<tr>
				<td colspan="2" style="background-color: #eeeeee; text-align: center; font-size: 20px;">내 상품 등록</td>
			</tr>
		</thead>
		<tbody>
			<tr><td><br></td></tr>
			<tr>
				<td>상품명 &emsp; <input type="text" placeholder="상품의 제목을 입력하세요." name="pName" maxlength="40" style="width:700px; height:30px; font-size:15px;"></td>
			</tr>
			<tr><td><br><br></td></tr>
			<tr>
				<td>상품 이미지  &nbsp; <input type="file" name="image" id="file" accept="image/*" required="true" style="font-size:15px;" multiple>
				<p>
				    <div class="preview">
				    </div>
				    <div id='repImg'></div>
				</td>
			</tr>
			<tr><td><br><br></td></tr>
			<tr>
				<td>설명<p></td>
			</tr>
			<tr>
				<td><textarea placeholder="상품을 소개해주세요.
ex) 구입 날짜, 사용감, 하자 유무 등 " name="pExplain" maxlength="2048" rows="20" cols="103" style="resize: none; font-size:15px;"></textarea></td>
			</tr>
			<tr><td><br><br></td></tr>
			<tr>
				<td>상태 &emsp; <input type="radio" name="pCondition" value="old" checked> 중고상품 <input type="radio" name="pCondition" value="new"> 새상품</td>
			</tr>
			<tr><td><br><br></td></tr>
			<tr>
				<td>시작 가격 &emsp; <input type="number" placeholder="숫자만 입력해주세요." name="price" style="font-size:15px"> 원</td>
			</tr>
			<tr><td><br><br></td></tr>
			<tr>
				<td>
				경매 마감 &emsp; <input type="number" id='date_b_num' min="1" max="30" name="date_b_num" style="font-size:15px"> 
				<select name="date_b_unit">
					<option value="second">초 후</option>
					<option value="day" selected>일 후</option>
				</select>
				</td>
			</tr>
			<tr><td><br><br></td></tr>	
		</tbody>
	</table>
	<!-- 업로드 버튼 생성 -->
	<center><input type="submit" value="등록하기" style="font-size:15px";></center>
</form>
	<!-- 상품 등록 영역 끝 -->
</section>
<footer></footer>

  <script>
    const input = document.querySelector('#file');
    const preview = document.querySelector('.preview');

    input.addEventListener('change', updateImageDisplay);

    function updateImageDisplay() {
      while(preview.firstChild) {
        preview.removeChild(preview.firstChild);
      }

      const curFiles = input.files;
      if(curFiles.length === 0) {
        const para = document.createElement('p');
        para.textContent = 'No files currently selected for upload';
        preview.appendChild(para);
      } if(curFiles.length > 5) {
    	alert("사진은 5개까지 업로드 가능합니다.");
      } else {
    	
        for(const file of curFiles) {
          
          const radio = document.createElement('div');
          radio.className = "form-check form-check-inline";
          preview.appendChild(radio);
        	
          const radioItem = document.createElement('input');
          radioItem.className = "form-check-input";
          radioItem.type = "radio";
          radioItem.name = "repImg";
          radioItem.value = file.name;
          radioItem.addEventListener("click", click);
          
          radio.appendChild(radioItem);
        
          const image = document.createElement('img');
          image.src = URL.createObjectURL(file);
          
          radio.appendChild(image);
        }
        function click() {
       	  document.getElementById('repImg').innerText = "대표사진: " + this.value;
        }
      }
    }
    

  </script>
</body>
</html>