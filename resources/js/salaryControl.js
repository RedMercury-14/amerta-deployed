window.onload = () => {
	let mountNow = document.querySelector('#numMonth');
	let yearNow = document.querySelector('#nowYear');
	let fullDate = document.querySelector('#fullDate');
	let table = document.querySelector('#mainTable');
	let tableBody = table.querySelector('tbody');
	
	var dateForRequest = fullDate.value.substring(0, fullDate.value.length-2)+'01';
	
	listnerButtonBack();
	listnerButtonNext();
	
//	getReportFromServerAndWriteAtTable(1, dateForRequest, dateForRequest);
	tableBody.querySelectorAll('tr').forEach((tr)=>{
		var massTd = tr.querySelectorAll('td');
		var id = massTd[0].innerHTML;
		var reportBodyTd = massTd[6];
		var buttonCalc = massTd[7];
		var targetTr = tr;
		calculate(id, dateForRequest, dateForRequest, reportBodyTd, buttonCalc, tr)
		getReportFromServerAndWriteAtTable(id, dateForRequest, dateForRequest, reportBodyTd, targetTr);
	})
}


//====================================МЕТОДЫ==================================

//вешаем листнер на кнопку расчёт и отправляем на сервер для расчёта для каждого по отдельности
function calculate(idUser, dateStart, dateFinish, bodyTd, buttonTd, tr){
	
	buttonTd.querySelector('input').addEventListener('mousedown', ()=>{
		buttonTd.querySelector('#spinner').style.display = null; // при нажатии запускает спинер загрузки
		buttonTd.querySelector('#calc').style.display = "none"; //и прячет кнопку
			var xhr = new XMLHttpRequest();
	xhr.open(
		'GET',
		`../../api/departmentHead/gerSalaryReportByUser/${idUser}&${dateStart}&${dateFinish}`,
		true
	)
	xhr.send();	
	xhr.onreadystatechange = function() {
		var response;
		if (xhr.readyState != 4) {
			return
		}		
		if (xhr.status === 200) {		
			if (xhr.responseText.length == 0) {
				response = null;
			} else {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ со стрингом рабочего дня, преобразуем в объект
				response = obj;				
				buttonTd.querySelector('#spinner').style.display = "none"; // когда приходит ответ, прячем спинер 
				buttonTd.querySelector('#calc').style.display = null; //и показываем кнопку
			}
		} else {
			console.log('err', xhr.responseText)
		}
		if(response != null){
			var massTd = tr.querySelectorAll('td');
			viewSingleTD(massTd, response);
		}else{
			bodyTd.innerHTML = "ERROR - ответ не пришел!"
		}
	}
	})
}
//метод ответа на сообщение от сервера, для единичного расчёта
function viewSingleTD(massTd, obj){
	if(parseInt(obj.status) < 6){
		massTd[3].innerHTML = obj.salaryFinal + " BYN";
		massTd[5].innerHTML = obj.hoursOfFact;
		massTd[6].innerHTML = obj.body;
	}else{
		massTd[3].innerHTML = "Ошибка";
		massTd[5].innerHTML = "Ошибка";
		massTd[6].innerHTML = obj.comment;
	}
}

//спрашиваем у сервера, есть ли готовые отчёты и заполняем таблицу
function getReportFromServerAndWriteAtTable(idUser, dateStart, dateFinish, td, tr) {
	var xhr = new XMLHttpRequest();
	xhr.open(
		'GET',
		`../../api/departmentHead/getOneSalaryReport/${idUser}&${dateStart}&${dateFinish}`,
		true
	)
	xhr.send();	
	xhr.onreadystatechange = function() {
		var response;
		if (xhr.readyState != 4) {
			return
		}		
		if (xhr.status === 200) {		
			if (xhr.responseText.length == 0) {
				response = null;
			} else {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ со стрингом рабочего дня, преобразуем в объект
				response = obj;
			}
		} else {
			console.log('err', xhr.responseText)
		}
		if(response != null){
			var massTd = tr.querySelectorAll('td');
			viewSingleTD(massTd, response)
		}else{
			td.innerHTML = "Расчёт не произведен"
		}
	}	
}

function listnerButtonBack(){//добавляем кнопки перехода на другие месяцы	
	document.querySelector('#backMonth').addEventListener('click', () => {
		var number = document.querySelector('#numMonth').value - 1;
		window.location.href = `../../home/main-report/salaryControl?month=${number}`;
	});
}
function listnerButtonNext(){//добавляем кнопки перехода на другие месяцы
	document.querySelector('#nextMonth').addEventListener('click', () => {
		var number = parseInt(document.querySelector('#numMonth').value) + 1;
		window.location.href = `../../home/main-report/salaryControl?month=${number}`;
	});
}