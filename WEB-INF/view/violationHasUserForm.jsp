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
<title>Создание нарушения</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<div class="container">
  <main>
    <div class="py-5 text-center">
    <br><br>
      <h2>Создание нарушения</h2>
      <span class="text-primary">${message}</span>
    </div>
    
	<c:url value="/home/post/save-new-violation" var="loginVar"/>
	
  	<form:form action="${loginVar}" modelAttribute="violationHasUser" method="POST" class="needs-validation">
  	      
      <div class="col-md-12 col-lg-12">
        <h4 class="mb-3">Ввод данных</h4>
        <div>
    		<a href="mailto:GrushevskiyD@dobronom.by?subject=Управленческий табель - Создание нарушения">Сообщить о ошибке</a>
    	</div>
          <div class="row g-3">
          
          <div class="col-6">
              <label for="dateOfBorn" class="form-label">Дата совершения нарушения</label>
              <input type="date" class="form-control" name="dateViolation" placeholder="" required>
              <div class="invalid-feedback">
               Введите дату.
              </div>
        </div>
        
       <div class="col-6">
              <label for="department" class="form-label">Кто выявил нарушение</label>
              <input type="text" list="sec" class="form-control" required  id="userHasShow" autocomplete="off">
              <input type="hidden" list="sec" name="userHasShowModel" id="userHasShowInServer">
              <datalist id="sec">  
              	<c:forEach items="${users}" var="security">
              		<option value="${security.idUser}" label="${security.fullName}" >
              		</option>
              	</c:forEach>            
              </datalist>
       </div>
          
       <div class="col-6">
              <label for="department" class="form-label">Таб. номер сотрудника</label>
              <input class="form-control" type="text" list="workers" id="worker" name="userTargetModel" required autocomplete="off">
              <datalist id="workers">  
              	<c:forEach items="${users}" var="user">
              		<option value="${user.idUser}" label="${user.fullName}" >
              		</option>
              	</c:forEach>            
              </datalist>
       </div>
       
        <div class="col-6">
              <label for="department" class="form-label">ФИО сотрудника</label>
              <input type="text" id="departmentsDiv" class="form-control" name="departmentModel" disabled="true">
              <div class="invalid-feedback"> <!-- d-block -->
                Некорректно введен отдел. Выберите отдел из выпадающего списка
              </div>
       </div>
            
            
        	<div class="col-6">
              <label for="department" class="form-label">Код нарушения</label>
              
              <input type="text" list="violationsData" class="form-control" disabled="true" required  id="violation" autocomplete="off">
              <input type="hidden" list="violationsData" name="violationModel" id="violationIsServer">
              <datalist id="violationsData">
	              <c:forEach var="violation" items="${violations}">              	
	                <option value="${violation.idViolation}" label="${violation.name}">${violation.name}</option>
	              </c:forEach>
              </datalist>
       		</div>
       		
       		<c:choose>
       			<c:when test="${department == 'SECURITY'}">
       				<div class="col-6">
		              <label for="department" class="form-label">Бой (если имеется)</label>
		              <input type="number" min="0" class="form-control" name="breakage" >
		      		</div>
       			</c:when>
       		</c:choose>
		      
       		
       		<div class="col-12">
              <label for="department" class="form-label">Описание нарушения</label>
              <textarea style="width: 100%;" name="comment"></textarea>           
       		</div>
       </div>         

          <hr class="my-4">

          <button class="w-100 btn btn-primary btn-lg" type="submit">Создать</button>
      </div>
    </form:form>
  </main>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/violationHasUserForm.js"></script>
</body>
</html>