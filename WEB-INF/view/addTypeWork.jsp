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
    <br><br>
      <h2>Редактор типов работы</h2>
      <span class="text-primary">${message}</span>
    </div>
	<c:url value="/home/main-report/typeWorks/save" var="loginVar"/>
  	<form:form action="${loginVar}" modelAttribute="typeOvertimeWork" method="POST" class="needs-validation">
    <div class="row g-5">           
      <div class="col-md-7 col-lg-12">
          <div class="row g-4">   
          
          <div class="col-sm-12" >
              <label class="form-label">Тип работы</label><br>
             <div class="form-check-inline">
			  <input class="form-check-input" type="radio" name="extraWork" id="flexRadioDefault1" checked value="false">
			  <label class="form-check-label" for="flexRadioDefault1">
			    Переработка
			  </label>
			</div>
			<div class="form-check-inline">
			  <input class="form-check-input" type="radio" name="extraWork" id="flexRadioDefault2" value="true">
			  <label class="form-check-label" for="flexRadioDefault2">
			    Дополнительная работа
			  </label>
			</div>
            </div>
                   
            <div class="col-sm-6">
              <label for="name" class="form-label">Название</label>
              <input type="text" class="form-control" name="name" placeholder="" value="${typeOvertimeWork.name}" required>
            </div>           
            

            <div class="col-sm-6">
              <label for="patronymic" class="form-label">Номер работы</label>
              <input type="text" class="form-control" name="idtypeOvertimeWork" placeholder="" value="${typeOvertimeWork.idtypeOvertimeWork}" required>
            </div>
            
            <div class="col-sm-6" >
              <label for="name" class="form-label">  <input type="checkbox" class="form-check-input" id="ch1"> Часовая ставка</label>
              <input type="number" min="0" class="form-control" step="any" name="rate" placeholder="" value="${typeOvertimeWork.rate}"  disabled="true" id="rate">
            </div>

            <div class="col-sm-6"  >
              <label for="patronymic" class="form-label"> <input type="checkbox" class="form-check-input" id="ch2"> Коэффициент</label>
              <input type="number" min="0" class="form-control" step="any" name="coefficient"  value="${typeOvertimeWork.coefficient}" disabled="true" id="coefficient">
            </div>
          </div> 
         </div>   
          <hr class="my-3">
          <h3>Дополнительные параметры</h3>
         <div class="col-md-7 col-lg-12">
          <div class="row g-4">                        
            <div class="col-sm-6" >
              <label for="name" class="form-label">  <input type="checkbox" class="form-check-input" id="count" name="count" value="true"> Строки </label>
              <input type="number" min="0" class="form-control" step="any" name="costCount" placeholder="Оплата за строку в рублях" value="${typeOvertimeWork.costCount}"  disabled="true" id="costCount">
            </div>

            <div class="col-sm-6"  >
              <label for="patronymic" class="form-label"> <input type="checkbox" class="form-check-input" id="weight" name="weight" value="true"> Вес (кг)</label>
              <input type="number" min="0" class="form-control" step="any" name="costWeight"  value="${typeOvertimeWork.costWeight}" disabled="true" id="costWeight" placeholder="Оплата за 1 кг в рублях">
            </div>
            
            <div class="col-sm-6" >
              <label for="name" class="form-label">  <input type="checkbox" class="form-check-input" id="stickers" name="stickers" value="true"> Количество стикеров</label>
              <input type="number" min="0" class="form-control" step="any" name="costSticker" placeholder="Оплата за стикер в рублях" value="${typeOvertimeWork.costSticker}"  disabled="true" id="costSticker">
            </div>

            <div class="col-sm-6"  >
              <label for="patronymic" class="form-label"> <input type="checkbox" class="form-check-input" id="pallets" name="pallets" value="true"> Количество паллет</label>
              <input type="number" min="0" class="form-control" step="any" name="costPallet"  value="${typeOvertimeWork.costPallet}" disabled="true" id="costPallet" placeholder="Оплата за паллету в рублях">
            </div>
          </div> 
         </div>
          

          <button class="w-100 btn btn-primary btn-lg" type="submit">Сохранить</button>
      </div>
    </form:form>
  </main>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addTypeWork.js"></script>
</body>
</html>