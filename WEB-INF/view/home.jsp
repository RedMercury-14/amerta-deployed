<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 <title>Главная страница</title>

<!--     <link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/"> -->


    <!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/bootstrap/dist/js/bootstrap.min.js" rel="stylesheet">


    
  </head>
  <body class="text-center bg-light" style="padding-top: 200px">  
  <jsp:include page="header.jsp"/>
<h1>ГЛАВНАЯ СТРАНИЦА</h1>
<h2>вер. 0.9</h2>
    <a href="/amerta/home/main-report/test" style="display: none"> 
    Тестовая страница </a>
  </body>
</html>