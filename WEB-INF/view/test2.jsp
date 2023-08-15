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
		
		
		<script	src="${pageContext.request.contextPath}/resources/fc/dist/index.global.min.js"></script>
<!-- 		<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.1/index.global.min.js'></script> -->
		<script	src="${pageContext.request.contextPath}/resources/js/test2.js"></script>
<title>Учёт рабочего времени</title>
</head>
<style>

  body {
    margin-top: 40px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }

  #external-events {
    position: fixed;
    left: 20px;
    top: 80px;
    width: 150px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #141111;
    text-align: left;
  }

  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }

  #external-events .fc-event {
    margin: 3px 0;
    cursor: move;
  }

  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }

  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }

  #calendar-wrap {
    margin-left: 200px; 
  }

	#calendar1,
	#calendar2,
	#calendar3,#calendar4,#calendar5,
  #calendar6 {
    display: inline-block;;
    width: 500px;
    margin: 0 20px 20px 0;
  }

</style>


<body class="text-center text-white bg-dark">
<jsp:include page="header.jsp"/>
<br><br><br><br>
 <div id='wrap'>
<div id='external-events'>

      <h4>Заказы</h4>
      <div id='external-events-list'>
        <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>Добрый путь (пиво)</div>
        </div>
        <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>Савушкин продукт (молочка)</div>
        </div>
        <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>Аливария (пиво)</div>
        </div>
        <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>Скидельский завод (сахар)</div>
        </div>
        <div class='fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>Борисовский КХП (мука)</div>
        </div>
      </div>

      <p style="display: none">
        <input type='checkbox' id='drop-remove' />
        <label for='drop-remove'>remove after drop</label>
      </p>
 </div>
    
 </div>

<div class="container" >
<h1>Рампа 1</h1>
	<div id='calendar1' class="text-white"> </div>
	<h3 style="display: inline-block;">Текущая загруженность: 20%</h3>
</div>
<div class="container" >
<h1>Рампа 2</h1>
	<div id='calendar2' class="text-white"></div>
	<h3 style="display: inline-block;">Текущая загруженность: 70%</h3>
</div>
<div class="container" >
<h1>Рампа 3</h1>
	<div id='calendar3' class="text-white"></div>
	<h3 style="display: inline-block;">Текущая загруженность: 77%</h3>
</div>
<div class="container" >
<h1>Рампа 4</h1>
	<div id='calendar4' class="text-white"></div>
	<h3 style="display: inline-block;">Текущая загруженность: 100%</h3>
</div>
<div class="container" >
<h1>Рампа 5</h1>
	<div id='calendar5' class="text-white"></div>
	<h3 style="display: inline-block;">Текущая загруженность: 63%</h3>
</div>
<div class="container" >
<h1>Рампа 6</h1>
	<div id='calendar6' class="text-white"></div>
	<h3 style="display: inline-block;">Текущая загруженность: 80%</h3>
</div>
</body>

</html>