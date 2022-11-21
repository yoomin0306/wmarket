<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>

<form method="post" action="asdf2.jsp" enctype="multipart/form-data" onsubmit="return formSubmit()">
<input type="hidden" name="hidden" id="hidden">
<input type="text" name="text" id="text"><p>
<div class="column">
<img src="img\image_1\11111.png" style="width:10rem" name="1">
<img src="img\image_3\22222.png" style="width:10rem" name="2">
<img src="img\image_3\33333.png" style="width:10rem" name="3">
</div>
<input type="submit">
</form>

<script>
	function formSubmit() {
		document.querySelector('#hidden').value = "";
		var text = document.querySelector('#text').value;
		if(text == ""){
			alert("값을 입력하세요.");
			return true;
		} else {
			const imgs = document.querySelectorAll('img');
			for(const img of imgs) {
				document.querySelector('#hidden').value += img.name;
			}
			alert("업로드 성공")
	        return false;
		}
    }
	
	const columns = document.querySelectorAll(".column");
	columns.forEach((column) => {
	  new Sortable(column, {
	    animation: 150,
	    ghostClass: "blue-background-class"
	  });
	});
</script>
</body>
</html>