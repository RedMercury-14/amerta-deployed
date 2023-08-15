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
<title>Картотека</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<br><br><br><br>
      <h2>Картотека</h2><br>
      <c:url value="/home/hr/user-list" var="url"/>
  		<form action="${url}", method="get">
    <div class="container-fluid form-floating mb-3">
    
  		<input type="text" class="form-control bg-dark text-white" id="search" placeholder="s" name="search">
  		
  		<label for="search" class="text-white">Поиск</label>
  		
	</div>
	</form>
	<h1>${response}</h1>
	<main>
  <div class="accordion container-fluid" id="accordionExample">
  <c:forEach var="user" items="${users}">
  		<div class="accordion-item bg-dark text-white">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        ${user.surname} ${user.name}
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
      <div class="accordion-body">
            <div class="py-5 text-center">
      <h2>Карточка работника</h2>
    </div>
  	
    <div class="row g-5 container-fluid">
      <div class="col-md-5 col-lg-4 order-md-last">
        
         <div class="col-sm-12">
              <label for="idUser" class="form-label">Табельный номер</label>
              <h1>${user.idUser}</h1>
       </div>
       
       <div class="col-sm-12">
              <label for="position" class="form-label">Должность</label>
              <h1>${user.position}</h1>
       </div>
       
       <div class="col-sm-12">
              <label for="department" class="form-label">Отдел</label>
              <h1>${user.department}</h1>
       </div>
       
        <div class="col-sm-12">
              <label for="dateOfEmployment" class="form-label">Дата начала трудовой деятельности</label>
              <h1>${user.dateOfEmployment}</h1>
            </div>
       
       
      </div>
      <div class="col-md-7 col-lg-8">
          <div class="row g-3">
          
           <div class="col-12">
              <label for="surname" class="form-label">Фамилия</label>
              <h2>${user.surname}</h2>
            </div>
            
            
            <div class="col-sm-6">
              <label for="name" class="form-label">Имя</label>
              <h2>${user.name}</h2>
            </div>

            <div class="col-sm-6">
              <label for="patronymic" class="form-label">Отчество</label>
              <h2>${user.patronymic}</h2>
            </div>
            
            <div class="col-md-3">
              <label for="dateOfBorn" class="form-label">Дата рождения</label>
              <h2>${user.dateOfBorn}</h2>
            </div>
            
            <div class="col-md-3">
              <label for="plaseOfBorn" class="form-label">Место рождения</label>
              <h2>${user.plaseOfBorn}</h2>
            </div>
            
            <div class="col-md-3">
              <label for="sex" class="form-label">Пол</label>
              <h2>${user.sex}</h2>
            </div>
                        
            <div class="col-md-3">
              <label for="education" class="form-label">Образование</label>
                  <h2>${user.education}</h2>
            </div>            
            <hr class="my-4">
			<div class="col-sm-6">
              <label for="diplomaSpecialty" class="form-label">Специальность по диплому</label>
              	<h2>${user.diplomaSpecialty}</h2>
            </div>

            <div class="col-sm-6">
              <label for="diplomaQualification" class="form-label">Квалификация</label>
              <h2>${user.diplomaQualification}</h2>
            </div>




            <div class="col-12">
              <label for="email" class="form-label">Email <span class="text-muted">(служебный)</span></label>
              <h2>${user.email}</h2>
            </div>

            <div class="col-12">
              <label for="homeAddress" class="form-label">Адрес регистрации</label>
              <h2>${user.homeAddress}</h2>
            </div>

            <div class="col-md-6">
              <label for="telephone" class="form-label">Телефон</label>
              <h2>${user.telephone}</h2>
            </div>

            <div class="col-md-3">
              <label for="maritalStatus" class="form-label">Семейное положение</label>
              <h2>${user.maritalStatus}</h2>
            </div>
             <div class="col-md-3">
              <label for="children" class="form-label">Дети</label>
              <h2>${user.children}</h2>
            </div>

          </div>         

          <hr class="my-4">
      </div>
    </div>
      </div>
    </div>
  </div>
  </c:forEach>
  
</div>
 </main>
</body>
</html>