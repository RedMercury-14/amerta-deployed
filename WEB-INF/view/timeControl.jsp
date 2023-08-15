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
					<!-- 		Подключаем стили snackbar -->
					<link href="${pageContext.request.contextPath}/resources/css/snackbar.css" rel="stylesheet">
					<title>Учёт рабочего времени</title>
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
					.scroll-table-body {
    height: 300px;
    overflow-x: auto;
    margin-top: 0px;
    margin-bottom: 20px;
    border-bottom: 1px solid #eee;
}
.scroll-table table {
    width:100%;
    table-layout: fixed;
    border: none;
}
.scroll-table thead th {
    font-weight: bold;
    text-align: left;
    border: none;
    padding: 10px 15px;
    background: #d8d8d8;
    font-size: 14px;
    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
}
.scroll-table tbody td {
    text-align: left;
    border-left: 1px solid #ddd;
    border-right: 1px solid #ddd;
    padding: 10px 15px;
    font-size: 14px;
    vertical-align: top;
}
.scroll-table tbody tr:nth-child(even){
    background: #f3f3f3;
}
 
/* Стили для скролла */
::-webkit-scrollbar {
    width: 6px;
} 
::-webkit-scrollbar-track {
    box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
} 
::-webkit-scrollbar-thumb {
    box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
}
					
				</style>


				<body class="text-center bg-light">
				<input type="hidden" value="${thisUser.isEdit}" id="isEdit">
				
					<jsp:include page="header.jsp" />
					<br><br><br><br>
					<div id="snackbar"></div>
					<div class="container-fluid">
						<div class="form-group pull-right">
							<input type="text" class="searchKey form-control" placeholder="Кого ищите?">
						</div>
						<span class="searchCount pull-right"></span>
						<h2 id="nowMonth">${nowMonth}</h2> <input type="hidden" id="numMonth" value="${numMonth}"/>
						<div style="display: inline-block;"><button type="button" class="btn btn-success" id="backMonth"><-</button>
									<button type="button" class="btn btn-success" style="margin: 10px;"	id="8hour">Заполнить сегодняшние смены</button>
									<button type="button" class="btn btn-success" id="nextMonth">-></button></div>
						<br>
						<input id="daysOfMounth" value="${lengthOfMonth}" type="hidden">
						<div style="position: fixed; overflow: auto; height: 500pt;">
						<table class="table table-bordered border-dark table-responsive" >
							<thead>
								<tr>
									<th class="headerTd">Таб.Номер</th>
									<th class="col-xs-3">Имя / Фамилия</th>
									<th class="col-xs-3">Должность</th>
									<th class="col-xs-1">График</th>
									<th class="col-xs-1">Телефон</th>
									<th class="col-xs-1">Общие</th>
									<th class="col-xs-1">Часы</th>
									<th></th>
									<c:forEach var="date" items="${daysOfHead}">
										<th>${date}</th>
									</c:forEach>
								</tr>
								<tr class="warning no-result">
									<td colspan="4"><i class="fa fa-warning"></i> Совпадения не найдены</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${users}">
									<input type="hidden" value="${user.shiftPlan}" id="shiftPlan">
									
									 <!--      массив отреботанных дней         -->
									<tr id="${user.idUser}&day">
										<input type="hidden" value="${user.workingShift.timeStartDay}" id="timeStartDay">
										<input type="hidden" value="${user.workingShift.timeFinishDay}" id="timeFinishDay">										
										<input type="hidden" value="${user.workingDayHasTarget}" id="workingDays">
										<input type="hidden" value="${user.workingShift.trueSalary}" id="trueSalaryTr">
										
										<th rowspan="2">${user.idUser}</th>
										<th rowspan="2" id="fullName">${user.surname} ${user.name} </th>
										<td rowspan="2" class="overflow-auto">${user.position}</td>
										<td rowspan="2" id="workingShiftName" abbr="${user.workingShift.idWorkingShift}" >
											${user.workingShift.name} ${user.workingShift.numHoursAsMounth}
										</td>										
										<td rowspan="2">${user.telephone}</td>
										<td rowspan="2"> ${user.summHoursInMounth}</td>
										<th scope="row" id="summHours"></th>
										<td>дн</td>
										<c:forEach var="date" items="${daysOfHead}">
											<td id="${date}&day"></td>
										</c:forEach>
									</tr>
									<tr id="${user.idUser}&night" class="border-3 border-dark border-bottom">									
										<input type="hidden" value="${user.workingShift.timeStartNight}" id="timeStartNight">
										<input type="hidden" value="${user.workingShift.timeFinishNight}" id="timeFinishNight">
										<th style="display: none">2</th>
										<th style="display: none" id="fullName">${user.surname} ${user.name}</th>
										<td style="display: none">${user.position}</td>
										<td style="display: none">${user.workingShift.name}</td>
										<th scope="row" id="summHours"></th>
										<td>нч</td>
										<c:forEach var="date" items="${daysOfHead}">
											<td id="${date}&night"></td>
										</c:forEach>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
					</div><!-- ./container -->
					<!-- контекстное меню -->
					<ul class="right-click-menu text-white border-dark">
						<li id="l1">8ч</li>
						<li id="l2">11ч</li>
						<li id="l3">Больничный</li>
						<li id="l7">Отпуск</li>
						<li id="l4">Прогул</li>
						<li id="l5"><a id="myBtn2">Переработка</a></li>
						<li id="l6">Дополнительное работа</li>
						<li id="l8">Удалить метку</li>
					</ul>


					<!-- new modal window -->
					<!-- Модальное окно для переработки-->
					<div class="modal fade text-black" id="exampleModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Редактор переработки сотрудника <div id="targetTitleFullName" style="display: inline;"> </div>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Закрыть"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="row" id="rowTmpl">
											<div class="col-8 col-sm-6">
												<label class="col-form-label">Тип работы:</label>
												<select class="form-select" id="typeOfWork">
													<option></option>
													<c:forEach var="typeWork" items="${typeWorks}">
														<option value="${typeWork.idtypeOvertimeWork}">${typeWork.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Количество часов:</label>
												<select class="form-select" id="hoursOfOvertime">
													<option></option>
													<option value="01:00:00">1 час</option>
													<option value="02:00:00">2 часа</option>
													<option value="03:00:00">3 часа</option>
													<option value="04:00:00">4 часа</option>
													<option value="05:00:00">5 часов</option>
													<option value="06:00:00">6 часов</option>
													<option value="07:00:00">7 часов</option>
													<option value="08:00:00">8 часов</option>
													<option value="09:00:00">9 часов</option>
													<option value="10:00:00">10 часов</option>
													<option value="11:00:00">11 часов</option>
												</select>
											</div>
										</div>										
									<div id="workRows"></div> <!-- сюда вставляется темплейт -->
										<br>
										<button type="button" class="btn btn-outline-secondary" id="addTmpl">+</button>
										<div class="mb-3">
											<label for="message-text" class="col-form-label">Примечание:</label>
											<textarea class="form-control" id="message-text"></textarea>
										</div>
									</form>
								</div>
								<div class="modal-footer">
								<div id="errorMessage"></div>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Закрыть</button>
									<button type="button" class="btn btn-primary" id="saveOvertimeWorkingDay">Сохранить</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Модальное окно для отпусков-->
					<div class="modal fade text-black" id="holidayModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Редактор создания отуска<div id="targetTitleFullName" style="display: inline;"> </div>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Закрыть"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="row" id="rowTmpl">
											<div class="col-8 col-sm-6">
												<label class="col-form-label">Тип отпуска:</label>
												<select class="form-select" id="typeOfModal">
													<option value="holiday">Трудовой отпуск</option>
													<option value="!holiday">Отпуск за свой счёт</option>
													<option value="holiday-sociality">Социальный отпуск</option>
													<option value="holiday-children">Отпуск по уходу за ребенком</option>
												</select>
											</div>
											<div class="col-4 col-sm-3">
												<label class="col-form-label">Дата начала:</label>
												<input type="date" id="dateStart" class="form-control">
											</div>
											<div class="col-4 col-sm-3">
												<label class="col-form-label">Дата окончания:</label>
												<input type="date" id="dateEnd" class="form-control">
											</div>
										</div>	
										<div class="mb-3">
											<label for="message-text" class="col-form-label">Примечание:</label>
											<textarea class="form-control" id="message-text"></textarea>
										</div>
									</form>
								</div>
								<div class="modal-footer">
								<div id="errorMessage"></div>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Закрыть</button>
									<button type="button" class="btn btn-primary" id="saveHoliday">Сохранить</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Модальное окно для дополнительной работы-->
					<div class="modal fade text-black" id="extraModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Редактор доп.работы сотрудника <div id="targetTitleFullName" style="display: inline;"> </div>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Закрыть"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="row" id="rowTmpl">
											<div class="col-8 col-sm-6">
												<label class="col-form-label">Тип работы:</label>
												<select class="form-select" id="typeOfWorkExtra">
													<option></option>
													<c:forEach var="typeWork" items="${extraWorks}">
														<option value="${typeWork.idtypeOvertimeWork}">${typeWork.name}</option>
													</c:forEach>
												</select>
											</div>
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Количество часов:</label>
												<select class="form-select" id="hoursOfWorkExtra">
													<option></option>
													<option value="01:00:00">1 час</option>
													<option value="02:00:00">2 часа</option>
													<option value="03:00:00">3 часа</option>
													<option value="04:00:00">4 часа</option>
													<option value="05:00:00">5 часов</option>
													<option value="06:00:00">6 часов</option>
													<option value="07:00:00">7 часов</option>
													<option value="08:00:00">8 часов</option>
													<option value="09:00:00">9 часов</option>
													<option value="10:00:00">10 часов</option>
													<option value="11:00:00">11 часов</option>
												</select>
											</div>
										</div>										
									<div id="workRowsExtra"></div> <!-- сюда вставляется темплейт -->
										<br>
										<button type="button" class="btn btn-outline-secondary" id="addTmplExtra">+</button>
										<div class="mb-3">
											<label for="message-text" class="col-form-label">Примечание:</label>
											<textarea class="form-control" id="message-text-extra"></textarea>
										</div>
									</form>
								</div>
								<div class="modal-footer">
								<div id="errorMessageExtra"></div>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Закрыть</button>
									<button type="button" class="btn btn-primary" id="saveExtraWorkingDay">Сохранить</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Модальное окно для обозначения смены (левый клик)-->
					<div class="modal fade text-black" id="mainAddModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Редактор рабочей смены сотрудника <div id="targetTitleFullName" style="display: inline;"></div> <div id="targetTitleFullDate" style="display: inline;"> </div>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Закрыть"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="row">
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Начало работы:</label>
												<input type="time" class="form-control" id="timeStartCustomWorkingDay" >
											</div>
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Окончание работы:</label>
												<input type="time" class="form-control" id="timeFinishCustomWorkingDay" >
											</div>
										</div>
										<br>
										<div class="row">
												<div class="col-4 col-sm-12">
													<label class="col-form-label">Без обеда:</label>
													<input type="checkbox" class="" id="isLunch" >
												</div>
										</div>	
									</form>
								</div>
								<div class="modal-footer">
								<div id="errorMessage"></div>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Закрыть</button>
									<button type="button" class="btn btn-primary" id="saveCustomWorkingDay">Сохранить</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Модальное окно для просмотра и редактирования-->
					<div class="modal fade text-black" id="showModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">Просмотр рабочей смены сотрудника <div id="targetTitleFullName" style="display: inline;"></div> <div id="targetTitleFullDate" style="display: inline;"> </div>
									</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Закрыть"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="row">
											<div class="col-4 col-sm-12">
												<label class="col-form-label">Основная смена:</label>
											</div>
										</div>
										<div class="row">
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Начало работы:</label>
												<input type="time" class="form-control" id="wokrStartTime" >
											</div>
											<div class="col-4 col-sm-6">
												<label class="col-form-label">Окончание работы:</label>
												<input type="time" class="form-control" id="wokrEndTime">
											</div>
										</div>
										<br>
										<div class="row">
												<div class="col-4 col-sm-12">
													<label class="col-form-label">Без обеда:</label>
													<input type="checkbox" class="" id="showIsLunch" >
												</div>
										</div>
										<hr class="my-4">
										<div class="row">
											<div class="col-4 col-sm-12">
												<label class="col-form-label">Переработка:</label>
											</div>
										</div>	
										<div id="workRowsShow"></div> <!-- сюда вставляется темплейт -->
										<br>
										<button type="button" class="btn btn-outline-secondary" id="addTmplEdit" style="display: none">+</button>
										<button type="button" class="btn btn-outline-secondary" id="delTmplEdit" style="display: none">-</button>
									</form>
								</div>
								<div class="modal-footer">
								<div id="errorMessage"></div>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Закрыть</button>
									<button type="button" class="btn btn-primary" id="editCustomWorkingDay">Внести изменения</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- Модальное окно для ввода нормочасов за месяц для каждого вида работ  -->
					<div class="modal fade" id="rateMounthModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">Введите количество рабочих часов</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Закрыть"></button>
					      </div>
					      <div class="modal-body">
					        <form id="form">					          
					        </form>
					        <h5 class="modal-title text-danger" id="errorMessageRateMounthModal"></h5>
					      </div>
					      <div class="modal-footer">					      	
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
					        <button type="button" class="btn btn-primary" id="saveRateHours">Сохранить</button>
					      </div>
					    </div>
					  </div>
					</div>
										
					<!-- темплейт добавления строк доп работы в переработку--> 
					<template id="tmpl"> 
							<div class="col-8 col-sm-6">
								<label class="col-form-label">Тип работы:</label>
								<select class="form-select" id="typeOfWork">
									<option></option>
									<c:forEach var="typeWork" items="${typeWorks}">
													<option value="${typeWork.idtypeOvertimeWork}">${typeWork.name}</option>
									</c:forEach>

								</select>
							</div>
							<div class="col-4 col-sm-6">
								<label class="col-form-label">Количество часов:</label>
								<select class="form-select" id="hoursOfOvertime">
									<option></option>
									<option value="01:00:00">1 час</option>
									<option value="02:00:00">2 часа</option>
									<option value="03:00:00">3 часа</option>
									<option value="04:00:00">4 часа</option>
									<option value="05:00:00">5 часов</option>
									<option value="06:00:00">6 часов</option>
									<option value="07:00:00">7 часов</option>
									<option value="08:00:00">8 часов</option>
									<option value="09:00:00">9 часов</option>
									<option value="10:00:00">10 часов</option>
									<option value="11:00:00">11 часов</option>

								</select>
							</div>
					</template>
					
					<!-- темплейт добавления строк доп работы в доп работу --> 
					<template id="tmplExtra"> 
							<div class="col-8 col-sm-6">
								<label class="col-form-label">Тип работы:</label>
								<select class="form-select" id="typeOfWorkExtra">
									<option></option>
									<c:forEach var="typeWork" items="${extraWorks}">
													<option value="${typeWork.idtypeOvertimeWork}">${typeWork.name}</option>
									</c:forEach>

								</select>
							</div>
							<div class="col-4 col-sm-6">
								<label class="col-form-label">Количество часов:</label>
								<select class="form-select" id="hoursOfWorkExtra">
									<option></option>
									<option value="01:00:00">1 час</option>
									<option value="02:00:00">2 часа</option>
									<option value="03:00:00">3 часа</option>
									<option value="04:00:00">4 часа</option>
									<option value="05:00:00">5 часов</option>
									<option value="06:00:00">6 часов</option>
									<option value="07:00:00">7 часов</option>
									<option value="08:00:00">8 часов</option>
									<option value="09:00:00">9 часов</option>
									<option value="10:00:00">10 часов</option>
									<option value="11:00:00">11 часов</option>
								</select>
							</div>
					</template>
					
					<!-- темплейты дополнительных параметров для доп работы --> 
					<template id="tmplExtraParametersCount">
							<div class="col-8 col-sm-2">
								<label class="col-form-label">Количество строк:</label>
								<input type="number" min="0" class="form-control" id="inputCount" >
							</div>
					</template>
					<template id="tmplExtraParametersWeight">
							<div class="col-8 col-sm-2">
								<label class="col-form-label">Вес в килограммах:</label>
								<input type="number" min="0" class="form-control" id="inputWeight" >
							</div>
					</template>
					<template id="tmplExtraParametersStickers">
							<div class="col-8 col-sm-2">
								<label class="col-form-label">Количество стикеров:</label>
								<input type="number" min="0" class="form-control" id="inputStickers" >
							</div>
					</template>
					<template id="tmplExtraParametersPallets">
							<div class="col-8 col-sm-2">
								<label class="col-form-label">Количество паллет:</label>
								<input type="number" min="0" class="form-control" id="inputPallets" >
							</div>
					</template>
					
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
				<script src="${pageContext.request.contextPath}/resources/js/timeControl.js"></script>

				</html>