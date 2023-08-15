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
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/form-validation.css" rel="stylesheet">
<title>Редактор смен</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<div class="container">
  <main>
    <div class="py-5 text-center">
    <br><br><br>
      <h2>Редактор смен</h2>
      <span class="text-danger">${message}</span>
    </div>
	<c:url value="/home/main-report/shift/save" var="loginVar"/>
  	<form:form action="${loginVar}" modelAttribute="workingShift" method="POST" class="needs-validation">
    <div class="row g-5">           
      <div class="col-md-7 col-lg-12">
          <div class="row g-3">
          <input type="hidden" name="idWorkingShift" value="${workingShift.idWorkingShift}">
           <div class="col-12">
              <label for="surname" class="form-label">Паттерн</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" name="pattern" required value="${workingShift.pattern}">
              </div>
            </div>
            
            <div class="col-4">
              <label class="form-label">Оклад на руки</label>
              <div class="input-group has-validation">
                <input type="number" class="form-control" name="salary" min="377" placeholder="BYN" required value="${workingShift.salary}"> 
              </div>
            </div>
            <div class="col-6">
              <label class="form-label">Место работы</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" name="placeOfWork"  required value="${workingShift.placeOfWork}">
              </div>
            </div>
            <div class="col-sm-2">
              <label for="patronymic" class="form-label">Мотивация</label>
             	 <div class="form-check" style="padding-left: 7.5em">
  					<form:checkbox path="motivation" value="${workingShift.motivation}" class="form-check-input"/>
            <script type="text/javascript">            
              var checkbox = document.querySelector("#motivation");
              if (checkbox.value == "true") {
                checkbox.checked = 1;
              }
            </script>
				</div>
            </div>
            
            <div class="col-sm-6">
              <label for="name" class="form-label">Название</label>
              <input type="text" class="form-control" name="name" placeholder="" value="${workingShift.name}" required>
            </div>

            <div class="col-sm-2">
              <label for="patronymic" class="form-label">Дата начала смены</label>
              <input type="date" class="form-control" name="dateOfStart" placeholder="" value="${workingShift.dateOfStart}" required>
            </div>
            
            <div class="col-sm-2">
              <label for="patronymic" class="form-label">Зеркально</label>
             	 <div class="form-check" style="padding-left: 7.5em">
  					<form:checkbox path="mirror" value="${workingShift.mirror}" class="form-check-input"/>
            <script type="text/javascript">            
              var checkbox = document.querySelector("#checkbox");
              if (checkbox.value == "true") {
                checkbox.checked = 1;
              }
            </script>
				</div>
            </div>
            
            <div class="col-sm-2" style="display: none">
              <label for="patronymic" class="form-label">Расчёт по окладу</label>
             	 <div class="form-check" style="padding-left: 7.5em">
  					<form:checkbox path="hourlyСalculation" value="${workingShift.hourlyСalculation}" class="form-check-input"/>
            <script type="text/javascript">            
              var checkbox = document.querySelector("#checkbox");
              if (checkbox.value == "true") {
                checkbox.checked = 1;
              }
            </script>
				</div>
            </div>
            
            <div class="col-sm-3">
              <label for="patronymic" class="form-label">Время начала работы (Дневной)</label>
              <input type="time" class="form-control" name="timeStartDay" placeholder="" value="${workingShift.timeStartDay}">
            </div>
            
            <div class="col-sm-3">
              <label for="patronymic" class="form-label">Время окончания работы (Дневной)</label>
              <input type="time" class="form-control" name="timeFinishDay" placeholder="" value="${workingShift.timeFinishDay}">
            </div>
            
            <div class="col-sm-3">
              <label for="patronymic" class="form-label">Время начала работы (Ночной)</label>
              <input type="time" class="form-control" name="timeStartNight" placeholder="" value="${workingShift.timeStartNight}">
            </div>
            
            <div class="col-sm-3">
              <label for="patronymic" class="form-label">Время окончания работы (Ночной)</label>
              <input type="time" class="form-control" name="timeFinishNight" placeholder="" value="${workingShift.timeFinishNight}">
            </div>
            
          </div>         

          <hr class="my-4">

          <button class="w-100 btn btn-primary btn-lg" type="submit">Сохранить</button>
          <hr class="my-4">
          <h4><p>Паттерн формеруется из колличества рабочих смен и типа смены: д-дневная, н-ночная, в-выходной. Разделяются смены тире(-).</p></h4>
          <h4><p>Пример пятидневной рабочей недели: 5д-2в</p></h4>          
          <h4><p>При отметке "Зеркально" паттерн будет меняться при сл. итерации: 5д-2в, 5в-2д и т.д.</p></h4>
      </div>
    </div>
    </form:form>
  </main>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js"></script>
</body>
</html>