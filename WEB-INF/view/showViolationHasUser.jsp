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
		<script	src="${pageContext.request.contextPath}/resources/js/showViolationHasUser.js"></script>
<title>Просмотр нарушений</title>
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
<h2 class="pb-2 border-bottom">Просмотр нарушений</h2>
<div class="container">

<div class="form-group">
<select id="departmentsDiv" class="form-select w-25" required style="display: inline;"> 
             	<option></option>
              	<c:forEach var="departmentI" items="${departments}" >              		
              		<option value="${departmentI.idDepartment}">${departmentI.name}</option>
              	</c:forEach>
              </select>
 <input type="text" class="form-control w-25" list="usersData" placeholder="Введите ФИО или табельный номер" style="display: inline;" disabled="true" id="worker">
     период <input type="text" class="form-control w-25" style="display: inline;" id="dates" disabled="true">
 		<datalist id="usersData"></datalist>
</div>
<span class="searchCount pull-right"></span>
<div id="message"></div>
<table class="table table-bordered results" style="display: none" id="table">
	 <thead>
		 <tr>
			 <th class="col-md-1 col-xs-1">Дата нарушения</th>
			 <th class="col-md-1 col-xs-1">ФИО</th>
			 <th class="col-md-1 col-xs-1">Номер нарушения</th>
			 <th class="col-md-3 col-xs-3">Наиминование</th>
			 <th class="col-md-3 col-xs-3">Описание</th>
			 <th class="col-md-2 col-xs-2">Зафиксировал нарушение</th>
			 <th class="col-md-3 col-xs-3">Статус</th>
		 </tr>
	 <tr class="warning no-result" id="messageTr">
	 	<td colspan="4"><i class="fa fa-warning"></i> Совпадения не найдены</td>
	 </tr>
	 </thead>
	 <tbody id="tbody">
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