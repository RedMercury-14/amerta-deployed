<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
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
<title>График сменности</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<br><br><br><br>
<div class="container">
<div align="left"><a href="/amerta/home/main-report/shift/addshift"> Создать смену </a></div>
	<table  class="table table-bordered border-3">
			<thead class="text-center">
				<tr>
					<th>ID</th>
					<th>Название смены</th>
					<th>Паттерн</th>
					<th>Дата начала паттерна</th>
					<th>Место работы</th>
					<th>Указанный оклад</th>
					<th>Расчёт по окладу</th>
					<th>Мотивация</th>
					<th>Зеркальный</th>
					<th></th>
				</tr>
			</thead>	
			<tbody>				
				<c:forEach var="shift" items="${shift}">					 			
					<tr>
						<td>${shift.idWorkingShift}<input type="hidden" value="${shift.trueSalary}" id="isSalary"></td>
						<td>${shift.name}</td>
						<td>${shift.pattern}</td>
						<td>${shift.simpleDateOfStart}</td>	
						<td>${shift.placeOfWork}</td>	
						<td id="salary">${shift.salary}</td>
						<td>${shift.hourlyСalculation}</td>
						<td>${shift.motivation}</td>
						<td>${shift.mirror}</td>	
						<td><a href="shift/editshift?id=${shift.idWorkingShift}">Редактировать</a> | <a onclick="if (!(confirm('Вы действительно хотите удалить смену?'))) return false" href="shift/deleteshift?id=${shift.idWorkingShift}">Удалить</a></td>				
					</tr>        
			</c:forEach>
			</tbody>		
			</table>
			<script type="text/javascript">
				//подсвечиваем неактивную цену
				document.querySelector('tbody').querySelectorAll('tr').forEach(el=>{
					if(el.querySelector('#isSalary').value == 'false'){
						el.querySelector('#salary').classList.add('text-danger')
					}
				});
			</script>
</div>

</body>
</html>