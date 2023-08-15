<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap core CSS -->
		<script	src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/jquery.min.js"	type="text/javascript"></script>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js"></script>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/features.css" rel="stylesheet">
		
		
		<script	src="${pageContext.request.contextPath}/resources/fc/dist/index.global.min.js"></script>
<!-- 		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.1/index.global.min.js'></script> -->
		
				<!-- 		Подключаем стили flip box -->
		<link href="${pageContext.request.contextPath}/resources/css/flipbox.css" rel="stylesheet">
<title>Нарушение сотрудников</title>
</head>
<style>
.results tr[visible='false'],
.no-result {
 display: none;
}
.results tr[visible='true'] {
 display: table-row;
}
.searchCount {
 padding: 8px;
 color: #ccc;
}

</style>

<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<br><br><br><br>
<h2 class="pb-2 border-bottom">Неподтвержденные нарушение сотрудников</h2>
<div class="container">

<div class="form-group pull-right">
 <input type="text" class="searchKey form-control" placeholder="Кого ищите?">
</div>
<h4><a href ="./violationControl/archive">Архив</a></h4>
<span class="searchCount pull-right"></span>
<table class="table table-bordered results">
 <thead>
 <tr>
 <th class="col-md-1 col-xs-1">Табельный номер</th>
 <th class="col-md-3 col-xs-3">ФИО</th>
 <th class="col-md-3 col-xs-3">Должность</th>
 <th class="col-md-1 col-xs-1">Дата нарушения</th>
 <th class="col-md-3 col-xs-3">Нарушение</th>
 <th class="col-md-5 col-xs-5"></th>
 </tr>
 <tr class="warning no-result">-
 <td colspan="4"><i class="fa fa-warning"></i> Совпадения не найдены</td>
 </tr>
 </thead>
 <tbody>
 
 <c:forEach var="violation" items="${violations}">
 <tr> 
 <th id="idUser">${violation.userHasTarget.idUser}</th>
 <td> <a href="#" id="tuch">${violation.userHasTarget.surname} ${violation.userHasTarget.name}</a>  <input type="hidden" value="${violation.idViolationHasUser}" id="id"></td>
 <td>${violation.userHasTarget.position}</td>
 <td>${violation.dateViolationStr}</td>
 <td>${violation.violationHasUser.name}</td> 
 <td>
 	<div id="buttons" >
	   	<button type="button" class="btn btn-success" id="yes">Подтвердить</button>
		<button type="button" class="btn btn-danger" id="no">Отменить</button>
	</div>
 </td>
 </tr>
 </c:forEach>
 </tbody>
</table>
</div><!-- ./container -->
	<!-- модалка -->
		<div class="modal fade modal-xl" id="rateMounthModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title">Описание</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
							      </div>
							      <div class="modal-body">
							        <h3>Дата совершения нарушения:</h3> <div id="dateViolation" class="border-bottom"></div>
							        <h3>Дата создания нарушения:</h3> <div id="dateCreate" class="border-bottom"></div>
							        <h3>Нарушение:</h3> <div id="violationName" class="border-bottom"></div>
							        <h3>Зафиксировал нарушение:</h3> <div id="fio" class="border-bottom"></div>
							        <h3>Описание нарушения:</h3><div id="comment"></div>
							      </div>
							      <div class="modal-footer">					      	
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
							      </div>
							    </div>
							  </div>
		</div>


</body>

<script	src="${pageContext.request.contextPath}/resources/js/violationControlHead.js"></script>
<script>
function createExpr(arr) {
 var index = 0;
 var expr = [":containsiAND('" + arr[0] + "')"];
 for (var i = 1; i < arr.length; i++) {
 if (arr[i] === 'AND') {
 expr[index] += ":containsiAND('" + arr[i + 1] + "')";
 i++;
 } else if (arr[i] === 'OR') {
 index++;
 expr[index] = ":containsiOR('" + arr[i + 1] + "')";
 i++;
 }
 }
 return expr;
}
$(document).ready(function() {

 $(".searchKey").keyup(function() {
 var searchTerm = $(".searchKey").val().replace(/["']/g, "");
 var arr = searchTerm.split(/(AND|OR)/);
 var exprs = createExpr(arr);
 var searchSplit = searchTerm.replace(/AND/g, "'):containsiAND('").replace(/OR/g, "'):containsiOR('");

 $.extend($.expr[':'], {
 'containsiAND': function(element, i, match, array) {
 return (element.textContent || element.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
 }
 });

 $('.results tbody tr').attr('visible', 'false');
 for (var expr in exprs) {
 $(".results tbody tr" + exprs[expr]).each(function(e) {
 $(this).attr('visible', 'true');
 });
 }

 var searchCount = $('.results tbody tr[visible="true"]').length;

 $('.searchCount').text('найдено ' + searchCount + ' человек');
 if (searchCount == '0') {
 $('.no-result').show();
 } else {
 $('.no-result').hide();
 }
 if ($('.searchKey').val().length == 0) {
 $('.searchCount').hide();
 } else {
 $('.searchCount').show();
 }
 });
});
</script>


</html>