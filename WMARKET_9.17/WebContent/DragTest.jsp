<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
.container {
display: flex;
gap: 1rem;
}
.column {
flex-basis: 5%;
background: #ddd;
padding: 5px;
border-radius: 10px;
}
.column h1 {
text-align: center;
font-size: 22px;
}
.list-group-item {
background: #fff;
margin: 1rem;
padding: 1rem;
border-radius: 5px;
cursor: pointer;
}
img {
width: 5rem;
}
</style>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js" integrity="sha512-zYXldzJsDrNKV+odAwFYiDXV2Cy37cwizT+NkuiPGsa9X1dOz04eHvUWVuxaJ299GvcJT31ug2zO4itXBjFx4w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<div class="container">
   <div class="column">
      <div class="list-group-item" draggable="true"><img src="img\image_1\11111.png"></div>
   </div>
   <div class="column">
      <div class="list-group-item" draggable="true"><img src="img\image_1\22222.png"></div>
   </div>
   <div class="column">
      <div class="list-group-item" draggable="true"><img src="img\image_1\33333.png"></div>
   </div>
</div>
<script>
const columns = document.querySelectorAll(".list-group-item");
columns.forEach((column) => {
  column.addEventListener("mouseup", mouseup);
  new Sortable(column, {
	group: 'shared',
    animation: 150
  });
});

const container = document.getElementByClassName(".container");
container.addEventListener("mouseup", mouseup);

function mouseup() {
  alert('asdf');
  documet.getElementByTagNameDiv('img').name = "asdf";
}

</script>
</body>
</html>