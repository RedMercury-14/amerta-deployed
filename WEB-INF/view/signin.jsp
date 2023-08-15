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
 <title>Вход в систему</title>

<!--     <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/"> -->


    <!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js" rel="stylesheet">


    
  </head>
  <body class="text-center text-white bg-dark" style="padding-top: 200px">  
    
<main class="form-signin">
<c:url value="/home/signinpost" var="loginVar" />
  <form:form action="${loginVar}" modelAttribute="user" method="POST">
    <h1 class="h3 mb-3 fw-normal">Вход в систему</h1>

    <div class="form-floating">
      <input type="text" class="form-control" id="floatingInput" placeholder="name@dobronom.by" name="login">
      <label for="floatingInput" class="text-dark">Логин</label>
    </div>
    <div class="form-floating">
      <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password">
      <label for="floatingPassword" class="text-dark">Пароль</label>
    </div>

<br><br>
    <button class="w-100 btn btn-lg btn-primary" type="submit">Войти</button>
  </form:form>
</main>

  <footer class="my-5 pt-5 text-muted text-center text-small">
    <p class="mb-1">&copy; 2022–2023 Dobronom</p>
    <ul class="list-inline">
<!--       <li class="list-inline-item"><a href="#">Privacy</a></li> -->
<!--       <li class="list-inline-item"><a href="#">Terms</a></li> -->
      <li class="list-inline-item"><a href="mailto:GrushevskiyD@dobronom.by">Поддержка</a></li>
    </ul>
  </footer>
    
  </body>
</html>