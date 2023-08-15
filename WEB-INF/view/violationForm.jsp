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
<title>Создание модели нарушения</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<div class="container">
  <main>
    <div class="py-5 text-center">
    <br><br>
      <h2>Создание модели нарушения</h2>
      <span class="text-primary">${message}</span>
    </div>
<%-- 	<c:url value="/home/post/save-new-violation-model" var="loginVar"/> --%>
	<c:url value="./save-new-violation-model" var="loginVar"/>
	
  	<form:form action="${loginVar}" modelAttribute="violation" method="POST" class="needs-validation">
  	      
      <div class="col-md-12 col-lg-12">
        <h4 class="mb-3">Созданное нарушение не появится в общем списке до подтверждения руководством</h4>
          <div class="row g-3">
          
          <div class="col-6">
              <label for="dateOfBorn" class="form-label">Номер нарушения (должен быть уникальным)</label>
              <input type="text" class="form-control" name="idViolation" placeholder="" required>
              <div class="invalid-feedback" id="idViolationError">
               Номер нарушения не уникален
              </div>
        </div>
          
          <div class="col-6">
              <label for="department" class="form-label">Название нарушения</label>
             <input type="text" class="form-control" name="name" placeholder="" required>
         </div>
          
          <div class="col-6">
              <label for="department" class="form-label">Описание нарушения</label>
               <textarea style="width: 100%;" name="description" required></textarea>
      	 </div>
      	 
      	  <div class="col-6">
              <label for="department" class="form-label">Сумма нарушения</label>
               <input type="number" min="0" class="form-control" name="value" placeholder="BYN" required>
      	 </div>
            

       </div>         

          <hr class="my-4">

          <button class="w-100 btn btn-primary btn-lg" type="submit">Создать</button>
      </div>
    </form:form>
  </main>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/violationForm.js"></script>
</body>
</html>