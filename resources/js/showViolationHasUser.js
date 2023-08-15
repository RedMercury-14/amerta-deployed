/**
 * https://www.daterangepicker.com/
 */
let dateStart = null;
let dateFinish = null;
let finalUserId = null;
window.onload = function() {
	$('input[id="dates"]').daterangepicker({
		"locale": {
			"format": "DD.MM.YYYY",
			"separator": " - ",
			"applyLabel": "Принять",
			"cancelLabel": "Отмена",
			"fromLabel": "From",
			"toLabel": "To",
			"customRangeLabel": "Custom",
			"weekLabel": "W",
			"daysOfWeek": [
				"Вс",
				"Пн",
				"Вт",
				"Ср",
				"Чт",
				"Пт",
				"Сб"
			],
			"monthNames": [
				"Январь",
				"Февраль",
				"Март",
				"Апрель",
				"Май",
				"Июнь",
				"Июль",
				"Август",
				"Сентябрь",
				"Октябрь",
				"Ноябрь",
				"Декабрь"
			],
			"firstDay": 1
		},
	}, function(start, end, label) {
		dateStart = start.format('YYYY-MM-DD');
		dateFinish = end.format('YYYY-MM-DD');
		getViolationsHasUserFrobDB()
	});
	var usersHasDepartment;
	var workerDataList = document.querySelector('#usersData');
	document.querySelector('#departmentsDiv').addEventListener('change', (el) => {
		document.querySelector("#worker").value = null;
		var requestText = el.target.value;
		if (requestText != "") {
			var xhr = new XMLHttpRequest();
			xhr.open(
				'GET',
				`../../api/main/getWorkersHasDepartment/${requestText}`,
				true
			)
			xhr.send()
			xhr.onreadystatechange = function() {
				if (xhr.readyState != 4) {
					return
				}

				if (xhr.status === 200) {
					var obj = JSON.parse(xhr.responseText);
					usersHasDepartment = obj;
					var options = workerDataList.querySelectorAll("option");
					for (let i = 0; i < options.length; i++) {
						options[i].remove();
					}
					obj.forEach(el => {
						var option = document.createElement("option");
						option.value = el.idUser
						option.label = el.surname + " " + el.name + " " + el.patronymic
						workerDataList.append(option);
					})
					if (obj != 0) {
						document.querySelector('input[id = worker]').disabled = false;
					} else {
						document.querySelector('input[id = worker]').value = null;
						document.querySelector('input[id = worker]').disabled = true;
						document.querySelector('#violation').value = null;
						document.querySelector('#violation').disabled = true;
					}
				} else {
					console.log('err', xhr.responseText)
				}
			}
		}		
	})
	document.querySelector('#worker').addEventListener('change', (el) => {
			if (el.target.value != "") {
				document.querySelector('#dates').disabled = false;
				finalUserId = el.target.value;
				getViolationsHasUserFrobDB()
			}
		})
}

function getViolationsHasUserFrobDB() {
	var table = document.querySelector('#table');
	var tbody = table.querySelector('#tbody');
	var trs = tbody.querySelectorAll('tr');
	trs.forEach(el=>{
		el.remove();
	})
	if (finalUserId != null && dateStart != null && dateFinish != null) {
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/security/getViolationHasUsersList/${finalUserId}&${dateStart}&${dateFinish}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200 && xhr.responseText != '') {
				document.querySelector('#message').innerHTML = null;
				var obj = JSON.parse(xhr.responseText);
				console.log(obj);
				table.style.display = "";
				
				obj.forEach(el => {
					var tr = document.createElement('tr')
					tr.id = el.idViolationHasUser;
					var td0 = document.createElement('td')
					td0.innerHTML = el.dateCreateStr;
					var td00 = document.createElement('td');
					td00.innerHTML = el.userHasTarget.name + ' ' + el.userHasTarget.surname
					var td1 = document.createElement('td')
					td1.innerHTML = el.idViolationHasUser;
					var td2 = document.createElement('td')
					td2.innerHTML = el.violationHasUser.name;
					var td3 = document.createElement('td')
					td3.innerHTML = el.comment;
					var td4 = document.createElement('td')
					td4.innerHTML = el.userHasShow.fullName;
					var td5 = document.createElement('td')
					if(el.proofHTML == false && el.proofComment == null){
						td5.innerHTML = 'На рассмотрении руководителем';
					}else if(el.proofHTML == false && el.proofComment != null){
						td5.innerHTML = 'Предупреждение';
					}else if(el.proofHTML == true){
						td5.innerHTML = 'К удержанию ' + el.violationHasUser.value + " BYN";
					}
					
					tr.append(td0);
					tr.append(td00);
					tr.append(td1);
					tr.append(td2);
					tr.append(td3);
					tr.append(td4);
					tr.append(td5);
					tbody.append(tr);
				})
			} else {
				table.style.display = 'none';
				document.querySelector('#message').innerHTML = "Нарушений не найдено.";
				console.log('err', xhr.responseText) // обработка прихода null
			}
		}
	}
}
