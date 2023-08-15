<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
			<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="UTF-8">
					<meta name="${_csrf.parameterName}" content="${_csrf.token}"/>
					<meta name="viewport" content="width=device-width, initial-scale=1">
					<!-- Bootstrap core CSS -->
					<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/jquery.min.js"
						type="text/javascript"></script>
					<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css"
						rel="stylesheet">
					<script type="text/javascript"
						src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js"></script>
					<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/features.css"
						rel="stylesheet">


					<script src="${pageContext.request.contextPath}/resources/fc/dist/index.global.min.js"></script>
					<!-- 		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.1/index.global.min.js'></script> -->
					
					<script src="${pageContext.request.contextPath}/resources/js/timeControlView.js"></script>
					<title>Отчёт по заработной плате</title>
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

					.right-click-menu {
						margin: 0;
						padding: 0;
						position: fixed;
						list-style: none;
						background: #000000cc;
						border: 2px solid #ffffff00;
						border-color: white;
						border-radius: 2px;
						display: none;
					}

					.right-click-menu.active {
						display: block;
					}

					.right-click-menu li {
						width: 100%;
						padding: 10px;
						box-sizing: border-box;
						border: 1px solid #ffffff00;
						border-color: white;
						cursor: pointer;
						font-size: 15px;
					}

					.right-click-menu li:hover {
						background: #ffffff73;
					}
					.none{
						display: none;
					}
					.non-shift{
					    background: repeating-linear-gradient(45deg, gray, gray 15px, green 0, green 30px);
					}
				</style>


				<body class="text-center bg-light">
				<input type="hidden" value="${thisUser.isEdit}" id="isEdit">
				
					<jsp:include page="header.jsp" />
					<br><br><br><br>
					<div class="container-fluid">

						<div class="form-group pull-right">
							<input type="text" class="searchKey form-control" placeholder="Кого ищите?">
						</div>
						<span class="searchCount pull-right"></span>
						<div>
							<h2 id="nowMonth" style="display: inline-block;">${nowMonth}</h2> <h2 id="nowYear" style="display: inline-block;">${nowYear}</h2> 
						</div>
						<input type="hidden" id="fullDate" value="${fullDate}"/>
						<input type="hidden" id="numMonth" value="${numMonth}"/>
						<div style="display: inline-block;"><button type="button" class="btn btn-success" id="backMonth"><-</button>
									<button type="button" class="btn btn-success" style="margin: 10px;"	id="8hour">Заполнить сегодняшние смены</button>
									<button type="button" class="btn btn-success" id="nextMonth">-></button></div>
						<br>
						<input id="daysOfMounth" value="${lengthOfMonth}" type="hidden">
						<table class="table table-bordered border-dark results" id="mainTable">
							<thead>
								<tr>
									<th class="col-md-1 col-xs-1">Таб.Номер</th>
									<th class="col-md-3 col-xs-3">Имя / Фамилия</th>
									<th class="col-md-1 col-xs-1">Должность</th>
									<th class="col-md-1 col-xs-1">Подразделение</th>
									<th class="col-md-1 col-xs-1">З/П на руки</th>
									<th class="col-md-1 col-xs-1">Расчётные.часы</th>
									<th class="col-md-1 col-xs-1">Факт.часы</th>
									<th class="col-md-6 col-xs-6">Отчёт</th>
									<th class="col-md-2 col-xs-2">Управление</th>
								</tr>
								<tr class="warning no-result">
									<td colspan="7"><i class="fa fa-warning"></i> Совпадения не найдены</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${users}">									
									 <!--      массив отреботанных дней         -->
									<tr id="${user.idUser}&">
										<td id="id">${user.idUser}</td>
										<th id="fullName">${user.fullName}</th>
										<td class="overflow-auto">${user.position}</td>										
										<td class="overflow-auto">ПОДРАЗДЕЛЕНИЕ</td>										
										<td class="overflow-auto" id="finalSalary"></td>										
										<td class="overflow-auto">расч.часы</td>										
										<td class="overflow-auto" id="factHours"></td>										
										<td class="overflow-auto" id="bodyText"></td>
										<td class="overflow-auto"><input type="button" value="Рассчитать" id="calc">
											<div class="spinner-border" role="status" style="display: none" id="spinner">
												  <span class="visually-hidden">Загрузка...</span>
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
					$(document).ready(function () {

						$(".searchKey").keyup(function () {
							var searchTerm = $(".searchKey").val().replace(/["']/g, "");
							var arr = searchTerm.split(/(AND|OR)/);
							var exprs = createExpr(arr);
							var searchSplit = searchTerm.replace(/AND/g, "'):containsiAND('").replace(/OR/g, "'):containsiOR('");

							$.extend($.expr[':'], {
								'containsiAND': function (element, i, match, array) {
									return (element.textContent || element.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
								}
							});

							$('.results tbody tr').attr('visible', 'false');
							for (var expr in exprs) {
								$(".results tbody tr" + exprs[expr]).each(function (e) {
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
				<script src="${pageContext.request.contextPath}/resources/js/salaryControl.js"></script>

				</html>