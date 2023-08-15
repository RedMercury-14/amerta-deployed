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
<title>Редактирование работника</title>
</head>
<body class="text-center bg-light">
<jsp:include page="header.jsp"/>
<div class="container">
  <main>
    <div class="py-5 text-center">
    <br><br>
      <h2>Редактор работника</h2>
      <span class="text-primary">${message}</span>
    </div>
	<c:url value="/home/main-report/workers/save-new-user" var="loginVar"/>
  	<form:form action="${loginVar}" modelAttribute="user" method="POST" class="needs-validation">
    <div class="row g-5">
      <div class="col-md-5 col-lg-4 order-md-last">
        <h4 class="d-flex justify-content-between align-items-center mb-3">
          <span class="text-primary">Профессиональная информация</span>
        </h4>
        
         <div class="col-sm-12">
              <label for="idUser" class="form-label">Табельный номер</label>
              <input type="text" class="form-control" name="idUser" placeholder="" value="${user.idUser}" required>
              <div class="invalid-feedback">
                Введите должность.
              </div>
       </div>
       
       <div class="col-sm-12">
              <label for="position" class="form-label">Должность</label>
              <input type="text" class="form-control" name="position" placeholder="" value="${user.position}" required>
              <div class="invalid-feedback">
                Введите должность.
              </div>
       </div>
       
       <div class="col-sm-12">
              <label for="department" class="form-label">Отдел</label>
              <input type="text" list="dep" class="form-control" name="departmentId" value="${user.department.idDepartment}">
              <datalist id="dep">
              <c:forEach var="department" items="${departments}">
              	<option value="${department.idDepartment}" label="${department.name}"></option>
              </c:forEach>              
              </datalist> 
       </div>
       
       <div class="col-sm-12">
              <label for="department" class="form-label">Логин в WMS (если имеется)</label>
              <input type="text" class="form-control" name="wmsLogin" value="${user.wmsLogin}">
       </div>
       
       <div class="col-sm-12">
              <label for="department" class="form-label">Id в WMS (если имеется)</label>
              <input type="number" class="form-control" name="wmsId" value="${user.wmsId}"> 
       </div>
       
        <div class="col-sm-12">
              <label for="dateOfEmployment" class="form-label">Дата начала трудовой деятельности</label>
              <input type="date" class="form-control" name="dateOfEmployment" placeholder="" value="${user.dateOfEmployment}" required>
              <div class="invalid-feedback">
               Введите дату.
              </div>
            </div>
       
       
      </div>
      
      <div class="col-md-7 col-lg-8">
        <h4 class="mb-3">Основная информация</h4>
          <div class="row g-3">
          
           <div class="col-12">
              <label for="surname" class="form-label">Фамилия</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" name="surname" required value="${user.surname}">
              <div class="invalid-feedback">
                  Введите фамилию.
                </div>
              </div>
            </div>
            
            
            <div class="col-sm-6">
              <label for="name" class="form-label">Имя</label>
              <input type="text" class="form-control" name="name" placeholder="" value="${user.name}" required>
              <div class="invalid-feedback">
                Введите имя.
              </div>
            </div>

            <div class="col-sm-6">
              <label for="patronymic" class="form-label">Отчество</label>
              <input type="text" class="form-control" name="patronymic" placeholder="" value="${user.patronymic}" required>
              <div class="invalid-feedback">
                Введите отчество.
              </div>
            </div>
            
            <div class="col-md-3">
              <label for="dateOfBorn" class="form-label">Дата рождения</label>
              <input type="date" class="form-control" name="dateOfBorn" placeholder="" required value="${user.dateOfBorn}">
              <div class="invalid-feedback">
               Введите дату рождения.
              </div>
            </div>
            
            <div class="col-md-3">
              <label for="plaseOfBorn" class="form-label">Место рождения</label>
              <input type="text" class="form-control" name="plaseOfBorn" placeholder="Минск, РБ"  value="${user.plaseOfBorn}">
              <div class="invalid-feedback">
                Введите дату место рождения.
              </div>
            </div>
            
            <div class="col-md-3">
              <label for="sex" class="form-label">Пол</label>
              <select class="form-select" name="sex" required >
                <option>${user.sex}</option>
                <option>Мужчина</option>
                <option>Женщина</option>
              </select>              
              <div class="invalid-feedback">
                Выберите пол.
              </div>
            </div>
                        
            <div class="col-md-3">
              <label for="education" class="form-label">Образование</label>
              <select class="form-select" name="education">
                <option>${user.education}</option>
                <option>Высшее</option>
                <option>Незаконченное высшее</option>
                <option>Средне специальное</option>
                <option>Базовое</option>
              </select>              
              <div class="invalid-feedback">
                Выберите образование.
              </div>
            </div>            
            <hr class="my-4">
			<div class="col-sm-6">
              <label for="diplomaSpecialty" class="form-label">Специальность по диплому</label>
              <input type="text" class="form-control" name="diplomaSpecialty" placeholder="Инженер" value="${user.diplomaSpecialty}">
              <div class="invalid-feedback">
                Введите специальность.
              </div>
            </div>

            <div class="col-sm-6">
              <label for="diplomaQualification" class="form-label">Квалификация</label>
              <input type="text" class="form-control" name="diplomaQualification" placeholder="Водитель погрузчика 3 разряда" value="${user.diplomaQualification}" >
              <div class="invalid-feedback">
                Введите квалификацию.
              </div>
            </div>

            <div class="col-12">
              <label for="email" class="form-label">Email <span class="text-muted">(служебный)</span></label>
              <input type="email" class="form-control" name="email" placeholder="name@dobronom.by" value="${user.email}">
              <div class="invalid-feedback">
                Please enter a valid email address.
              </div>
            </div>

            <div class="col-12">
              <label for="homeAddress" class="form-label">Адрес регистрации</label>
              <input type="text" class="form-control" name="homeAddress" placeholder=""  value="${user.homeAddress}">
              <div class="invalid-feedback">
                Введите адрес регистрации.
              </div>
            </div>

            <div class="col-md-6">
              <label for="telephone" class="form-label">Телефон</label>
              <input type="text" class="form-control" name="telephone" placeholder="+375295986325"  value="${user.telephone}">
              <div class="invalid-feedback">
                Введите номер телефона.
              </div>
            </div>

            <div class="col-md-3">
              <label for="maritalStatus" class="form-label">Семейное положение</label>
              <select class="form-select" name="maritalStatus" >
                <option>${user.maritalStatus}</option>
                <option>Не женат/Не замужем</option>
                <option>Женат/Замужем</option>
              </select>
              <div class="invalid-feedback">
                Введите семейное положение.
              </div>
            </div>
             <div class="col-md-3">
              <label for="children" class="form-label">Дети</label>
              <select class="form-select" name="children">
                <option>Нет</option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
                <option>6</option>
                <option>7</option>
                <option>8</option>
                <option>9</option>
                <option>10</option>
              </select>
              <div class="invalid-feedback">
                Please provide a valid state.
              </div>
            </div>

          </div>         

          <hr class="my-4">

          <button class="w-100 btn btn-primary btn-lg" type="submit">Сохранить</button>
      </div>
    </div>
    </form:form>
  </main>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/form-validation.js"></script>
</body>
</html>