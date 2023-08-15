<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
/*       body{ */
/*       cursor: */
/* 		url('data:image/x-icon;base64,AAACAAEAICAAAAAAAACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDuhoGA/8aBgP/GgYD/xoGA/8aBgP/GgYD/xoGA/8aBgP/GgYDugAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGAwYaBgPe6urq/+bm5v/i4uL/39/f/9vb2//Y2Nj/1dXV/9PT0/8aBgPhAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDYxoGA4fu7u7/6urq/+bm5v/i4uL/39/f/9vb2//Y2Nj/1dXV/xoGA94aBgMwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGAwYaBgPex8LC//Hx8f/u7u7/6urq/+bm5v/i4uL/39/f/9vb2//Y2Nj/GgYDhxoGA4cAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDYxoGA7T4+Pj/7u7u//Hx8f/u7u7/7u7u/+Li4v/i4uL/4uLi/9vb2/+wrKv/GgYD1QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGAwYaBgPezcnI//v7+//u7u7/7u7u/+7u7v/u7u7/4uLi/+Li4v/i4uL/39/f/9vb2/8aBgPeGgYDMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDYxoGA7T//////f39///////u7u7/7u7u/+7u7v/u7u7/4uLi/+Li4v/i4uL/39/f/xoGA4caBgOHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaBgPez8rK/v///////////////+7u7v/u7u7/7u7u/+7u7v/u7u7/4uLi/+bm5v/i4uL/tbGw/xoGA9UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDYxoGA7T/////z8rK/v//////////////////////////7u7u/+7u7v/u7u7/7u7u/+bm5v/i4uL/GgYD/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGAzYaBgO66Obl//////+Ge3r/////////////////////////////////7u7u/+7u7v/u7u7/6urq/+bm5v8aBgP/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYDuujm5f///////////xoGA////////////////////////f39//v7+//4+Pj/9fX1//Hx8f/u7u7/6urq/xoGA/8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaBgP/6Obl/+jm5f8aBgO6GgYD/////////////////////////////f39//v7+//4+Pj/GgYD//Hx8f/u7u7/GgYD/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGA7oaBgP/GgYDuhoGAzYaBgP///////////8aBgP///////////8aBgP//f39//v7+/8aBgP/9fX1/8O/v/8aBgO6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGA////////////xoGA////////////xoGA////////f39/xoGA//JxcT/GgYDuhoGAxoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYD/8/Kyv//////GgYD////////////GgYD///////Pysr/GgYD/xoGA7oaBgMaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaBgM2GgYDuhoGA/8aBgP///////////8aBgP/GgYD/xoGA7oaBgM2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGA////////////xoGA/8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYD////////////GgYD/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaBgP///////////8aBgP/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoGA////////////xoGA/8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGgYD////////////GgYD/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaBgM2GgYD/xoGA7oaBgM2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//////////////////////////////////////////////////////gB///4Af//+AH///AA///wAP//4AD//+AAf//AAH//wAB//4AAf/8AAH//AAB//xAAf//wAP//8AH///gH///+H////h////4f///+H////h////8///8='), */
/* 		auto; */
/*       } */
      	
    </style>
    
    

<title>Insert title here</title>
</head>
  <!-- Bootstrap core CSS -->
  <script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js"></script>  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" >
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.bundle.min.css" >
  
  <!-- daterangepicker  -->
  <script src="${pageContext.request.contextPath}/resources/daterangepicker/moment.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/daterangepicker/daterangepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/daterangepicker/daterangepicker.css" >
  
<%-- <link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet"> --%>
<%-- <link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.bundle.min.css" rel="stylesheet"> --%>
<%-- <link href="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js" rel="stylesheet"> --%>
<%-- <link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/navbar-top-fixed.css" rel="stylesheet"> --%>


<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script> -->
<body>
		<sec:authorize access="isAuthenticated()">  
        	<strong><sec:authentication property="principal.authorities" var="roles"/></strong>
    	</sec:authorize>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Доброном</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    		<c:choose>
			<c:when test="${roles == '[ROLE_ADMIN]'}">
			
				    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/hr">Отдел кадров</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/main-report">Управление отделом</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/admin">Администрация</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/security">Охрана</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Управленческий отчёт</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/gsus" tabindex="-1" aria-disabled="true">ГСУС</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/stock" tabindex="-1" aria-disabled="true">Управление складом</a>
        </li>
      </ul>
    </div>
			</c:when>	
			<c:when test="${roles == '[ROLE_HR]'}">
				    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/hr">Отдел кадров</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="/amerta/home/main-report">Управление отделом</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="/amerta/home/admin">Администрация</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Охрана</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Управленческий отчёт</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">ГСУС</a>
        </li>
      </ul>
    </div>
			</c:when>	
	<c:when test="${roles == '[ROLE_DEPARTMENT_HEAD]'}">
								    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="/amerta/home/hr">Отдел кадров</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/main-report">Управление отделом</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="/amerta/home/admin">Администрация</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Охрана</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Управленческий отчёт</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">ГСУС</a>
        </li>
      </ul>
    </div>
	</c:when>
	<c:when test="${roles == '[ROLE_SECURITY]'}">
	<div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/security" tabindex="-1" aria-disabled="true">Охрана</a>
        </li>
      </ul>
    </div>
	</c:when>
	<c:when test="${roles == '[ROLE_SECURITY_HEAD]'}">
	<div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/amerta/home/hr">Отдел кадров</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/security" tabindex="-1" aria-disabled="true">Охрана</a>
        </li>
      </ul>
    </div>
	</c:when>
	<c:when test="${roles == '[ROLE_GSUS]'}">
	<div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/gsus" tabindex="-1" aria-disabled="true">ГСУС</a>
        </li>
      </ul>
    </div>
	</c:when>
	
	<c:when test="${roles == '[ROLE_GSUS_HEAD]'}">
	<div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/amerta/home">Главная страница</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="/amerta/home/hr">Отдел кадров</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/main-report">Управление отделом</a>
        </li>
        <li class="nav-item">
          <a class="nav-link " href="/amerta/home/gsus" tabindex="-1" aria-disabled="true">ГСУС</a>
        </li>
      </ul>
    </div>
	</c:when>
		</c:choose>
    <div class="form-check form-switch" style="display: none">
  		<input class="form-check-input" type="checkbox" id="flexSwitchCheckDefaultHeader">
  		<label class="form-check-label text-white" for="flexSwitchCheckDefaultHeader">Dark</label>
	</div>

  </div>
</nav>
<script	src="${pageContext.request.contextPath}/resources/js/header.js"></script>
</body>
</html>