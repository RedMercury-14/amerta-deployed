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
		<script	src="${pageContext.request.contextPath}/resources/js/violationList.js"></script>
		
		<!-- 		Подключаем стили snackbar -->
		<link href="${pageContext.request.contextPath}/resources/css/snackbar.css" rel="stylesheet">
<title>Список текущих нарушений</title>
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
<h2 class="pb-2 border-bottom">Список текущих нарушений</h2>
<div id="snackbar"></div>
<div class="container">

<div class="form-group pull-right">
 <input type="text" class="searchKey form-control" placeholder="Введите запрос">
</div>
<span class="searchCount pull-right"></span>
<input type="hidden" id="targetUrl">
<a href="./addviolation" >Создать новый</a>
<table class="table table-bordered results">
 <thead>
 <tr>
 <th class="col-md-1 col-xs-1">Код нарушения</th>
 <th class="col-md-3 col-xs-3">Название</th>
 <th class="col-md-3 col-xs-3">Описание</th>
 <th class="col-md-3 col-xs-3">Сумма</th>
 <th class="col-md-3 col-xs-3" id="tmb">В общем доступе</th>
 </tr>
 <tr class="warning no-result">
 <td colspan="4"><i class="fa fa-warning"></i> Совпадения не найдены</td>
 </tr>
 </thead>
 <tbody>
 
				<c:forEach var="violation" items="${violations}">					 			
					<tr>
						<td id="idViolation">${violation.idViolation}</td>
						<td>${violation.name}</td>
						<td>${violation.description}</td>
						<td>${violation.value}</td>
						<td id="SwitchCheck">
							<div class="form-check form-switch ">
 								<input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" style="margin: auto;" value="${violation.sign}">
							</div>
						</td>
					</tr>        
			</c:forEach>
 </tbody>
</table>
</div><!-- ./container -->


</body>
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

 $('.searchCount').text('найдено ' + searchCount + ' совпадений');
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