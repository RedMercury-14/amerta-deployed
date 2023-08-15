//регаем модалку для ввода часов в месяц
let rateMounthModal = new bootstrap.Modal(document.querySelector('#rateMounthModal'));
var rateMounthModalDomElements = rateMounthModal._dialog;
var token = $("meta[name='_csrf']").attr("content");
var mounth = document.querySelector('#numMonth').value;
var isShowRateMod = false;

window.onload = function() {

	//регистрируем чекбоксы
	var checkboxes = document.querySelectorAll('#checkDefault');
	//регистрируем модальное окно переработок и доп работы
	let modal2 = new bootstrap.Modal(document.querySelector('#exampleModal'));
	var modalObject2 = document.querySelector('#exampleModal');

	let modalExtra = new bootstrap.Modal(document.querySelector('#extraModal'));
	let modalHoliday = new bootstrap.Modal(document.querySelector('#holidayModal'));
	var modalHolidayDOMObject = document.querySelector('#holidayModal');
	var modalObjectExtra = document.querySelector('#extraModal');

	//опредиляем добавляемые темплеты для переработки
	modalObject2.querySelector('#addTmpl').addEventListener('click', function() {
		let form = modalObject2.querySelector('#workRows');
		let elem = document.createElement('div');
		elem.classList.add('row');
		elem.id = "rowTmpl";
		elem.append(tmpl.content.cloneNode(true));
		form.append(elem);
	})
	// END опредиляем добавляемые темплеты для переработки

	//опредиляем добавляемые темплеты для доп работы
	modalObjectExtra.querySelector('#addTmplExtra').addEventListener('click', function() {
		let form = modalObjectExtra.querySelector('#workRowsExtra');
		let elem = document.createElement('div');
		elem.classList.add('row');
		elem.id = "rowTmpl";
		elem.append(tmplExtra.content.cloneNode(true));
		elem.querySelector('#typeOfWorkExtra').addEventListener("change", (el) => showTemplForExtraWorkParameters(el, modalObjectExtra));
		form.append(elem);
	})
	// END опредиляем добавляемые темплеты для доп работы

	// вешаем листнер на перебор доп работ (самый первый)
	var typeOfWorkOtrionsFirst = document.querySelector('#typeOfWorkExtra');
	typeOfWorkOtrionsFirst.addEventListener("change", (el) => showTemplForExtraWorkParameters(el, modalObjectExtra));

	//добавляем кнопки перехода на другие месяцы
	document.querySelector('#backMonth').addEventListener('click', () => {
		var number = document.querySelector('#numMonth').value - 1;
		window.location.href = `../../home/main-report/time?month=${number}`;
	});

	//регистрируем кнопки добавления и удаления переработок во время редактирования
	document.querySelector('#addTmplEdit').addEventListener('click', () => {
		plusRow();
	});

	document.querySelector('#delTmplEdit').addEventListener('click', () => {
		minusRow();

	});

	document.querySelector('#nextMonth').addEventListener('click', () => {
		var number = parseInt(document.querySelector('#numMonth').value) + 1;
		window.location.href = `../../home/main-report/time?month=${number}`;
	});

	//вешаем листнер на кнопку сохранения переработки
	document.querySelector('#saveOvertimeWorkingDay').addEventListener('click', (event) => {
		var flag = false;
		var errorMessage = modalObject2.querySelector('#errorMessage');
		var rowsHasOvertime = document.querySelector('#exampleModal').querySelectorAll('#rowTmpl');
		var typeOfWork = document.querySelectorAll('#typeOfWork');
		var hoursOfOvertime = document.querySelectorAll('#hoursOfOvertime');
		var message = document.querySelector('#message-text').value;
		typeOfWork.forEach(el => {
			if (el.value == "") {
				flag = true;
			}
		});
		hoursOfOvertime.forEach(el => {
			if (el.value == "") {
				flag = true;
			}
		})
		if (flag) {
			errorMessage.innerHTML = "Не заполнены все обязательные поля";
		} else {
			saveOwertimeWorkingDay(rowsHasOvertime, message, event);
			modal2.hide();
		}
	})
	
	//вешаем листнер на кнопку сохранения отпуска
	document.querySelector('#saveHoliday').addEventListener('click', (event) => {
		var flag = false;
		var errorMessage = modalHolidayDOMObject.querySelector('#errorMessage');
		var typeOfHoliday = document.querySelector('#holidayModal').querySelector('#typeOfModal');
		var dateStart = modalHolidayDOMObject.querySelector('#dateStart');
		var dateEnd = modalHolidayDOMObject.querySelector('#dateEnd');
		var message = modalHolidayDOMObject.querySelector('#message-text').value;
		if(dateStart.value == "" || dateEnd.value == ""){
			flag = true;
		}
		
		if (flag) {
			errorMessage.innerHTML = "Не заполнены все обязательные поля";
		} else {
			saveHolodayWorkingDay(typeOfHoliday.value, dateStart.value, dateEnd.value, message, event);
			modalHoliday.hide();
		}
	})

	//вешаем листнер на кнопку сохранения дополн. работы
	document.querySelector('#saveExtraWorkingDay').addEventListener('click', (event) => {
		var flag = false;
		var errorMessageExtra = modalObjectExtra.querySelector('#errorMessageExtra');
		var rowsHasExtraWork = document.querySelector('#extraModal').querySelectorAll('.row');
		var typeOfWork = document.querySelectorAll('#typeOfWorkExtra');
		var hoursOfOvertime = document.querySelectorAll('#hoursOfOvertimeExtra');
		var message = document.querySelector('#message-text-extra').value;
		typeOfWork.forEach(el => {
			if (el.value == "") {
				flag = true;
			}
		});
		hoursOfOvertime.forEach(el => {
			if (el.value == "") {
				flag = true;
			}
		})
		if (flag) {
			errorMessageExtra.innerHTML = "Не заполнены все обязательные поля";
		} else {
			saveExtraWorkingDay(rowsHasExtraWork, message, event); // тут сохранение EXTRA
			modalExtra.hide();
		}
	});

	//регистрируем кастомное модальное окно
	let mainModal = new bootstrap.Modal(document.querySelector('#mainAddModal'));
	var mainModalObject = mainModal._dialog;
	document.querySelector('#saveCustomWorkingDay').addEventListener('click', () => {
		var errorMessage = mainModalObject.querySelector('#errorMessage');
		var timeStart = document.querySelector('#timeStartCustomWorkingDay').value;
		var timeFinish = document.querySelector('#timeFinishCustomWorkingDay').value;
		var isLunch = document.querySelector('#isLunch');
		if (timeStart == "" || timeFinish == "") {
			errorMessage.innerHTML = "Не заполнены все обязательные поля";
		} else {
			mainModal.hide();
			saveCustomWorkingDay(timeStart, timeFinish, isLunch.checked, !tdClasslist.contains("bg-secondary"));
			console.log(!tdClasslist.contains("bg-secondary"))
		}
	})

	//регистрируем модальное окно для просмотра и редактирования
	let showModal = new bootstrap.Modal(document.querySelector('#showModal'));
	var showModalObject = showModal._dialog;
	document.querySelector('#editCustomWorkingDay').addEventListener('click', (event) => {
		var flag = false;
		var errorMessage = showModalObject.querySelector('#errorMessage');
		var body = document.querySelector('#showModal').querySelector('.modal-body');
		if (td.classList.contains("bg-warning") || td.classList.contains("border-warning")) {
			var thisModal = document.querySelector('#showModal').querySelector('#workRowsShow');
			var rowsHasOvertimeEdit = thisModal.querySelectorAll('.row');
			var typeOfWork = thisModal.querySelectorAll('#typeOfWork');
			var hoursOfOvertime = thisModal.querySelectorAll('#hoursOfOvertime');
			var message = document.querySelector('#message-text').value;
			typeOfWork.forEach(el => {
				if (el.value == "") {
					flag = true;
				}
			});
			hoursOfOvertime.forEach(el => {
				if (el.value == "") {
					flag = true;
				}
			})
			if (flag) {
				errorMessage.innerHTML = "Не заполнены все обязательные поля";
			} else {
				saveOwertimeWorkingDay(rowsHasOvertimeEdit, message, event);
				modal2.hide();
			}


		} else {
			saveEditWorkingDay(body);
		}
	});

	//управление подцветкой смен
	var tr = document.querySelector("tbody").querySelectorAll("tr"); // получение всех несущих инфу строк
	var dateNow = new Date().getDate();

	var daysOfMounth = document.querySelector("#daysOfMounth").value;
	if (dateNow.toString.length == 1) {
		dateNow = "0" + dateNow;
	}
	var shiftPlanList = document.querySelectorAll('#shiftPlan');
	for (let i = 0; i < shiftPlanList.length; i++) {
		var shiftPlan = shiftPlanList[i].value.replace(/^.|.$/g, "");
		var shiftPlanArray = shiftPlan.split(","); // массив с обозначением дней

		for (let j = 0; j < shiftPlanArray.length; j++) {

			var element = shiftPlanArray[j].trim();


			if (element == "д") {
				var trTarget = trTarget = tr[i * 2];
				//				var numberID = new Date().getDate() + j; //отображает смену только после сегодняшнего дня
				var numberID = j + 1;
				var id;
				if (numberID < 10) {
					id = "0" + numberID + "&day";
				} else {
					id = numberID + "&day";
				}
				var tds = trTarget.querySelectorAll("td");
				tds.forEach(elementTD => {
					if (elementTD.id == id) {
						elementTD.classList.add("bg-secondary");
						//class="border border-primary"
					}
				});
			}
			if (element == "н") {
				var trTarget = trTarget = tr[i * 2 + 1];
				//				var numberID = new Date().getDate() + j; //отображает смену только после сегодняшнего дня
				var numberID = j + 1;
				var id;
				if (numberID < 10) {
					id = "0" + numberID + "&night";
				} else {
					id = numberID + "&night";
				}
				var tds = trTarget.querySelectorAll("td");
				tds.forEach(elementTD => {
					if (elementTD.id == id) {
						elementTD.classList.add("bg-secondary");
					}
				});
			}
		}
	}
	//подсветка сегодняшнего дня
	for (let i = 0; i < tr.length; i++) {
		var tds = tr[i].querySelectorAll("td");
		var number = new Date().getDate()
		var idD;
		if (number < 10) {
			idD = "0" + number + "&day";
		} else {
			idD = number + "&day";
		}
		var idN;
		if (number < 10) {
			idN = "0" + number + "&night";
		} else {
			idN = number + "&night";
		}
		tds.forEach(elementTD => {
			if (elementTD.id == idD || elementTD.id == idN) {
				//elementTD.classList.add("myBG");	
				elementTD.classList.add("border-end");
				elementTD.classList.add("border-start");
				elementTD.classList.add("border-3");
				elementTD.classList.add("border-primary");
			}
		});
		//выставление всех данных через запрос на REST контроллер
		var workingDays = tr[i].querySelector("#workingDays");
		var id = tr[i].id.split('&')[0].trim();
		if (i % 2 == 0) {
			getRequestHasWprkingDay(id, document.querySelector('#numMonth').value);
		}

	}

	//окончание управление подцветкой смен
	//глобальные переменные
	var td; //td выбранная ячейка
	var tdClasslist; // classlist выбранного td
	var targetTD; // отдаёт id ячейки
	var targetTR; // отдаёт id строки
	var idUser; // id пользователя
	var numDay; // выбранный день
	var typeOfDay; // день или ночь
	var idWorkingDay; //отдаёт id рабочего дня, если он есть
	var targetEVENT;
	var targetFullName; // отдаёт полное имя выбраной строки
	var numMonth = document.querySelector('#numMonth').value; // отдаёт номер месяца
	contextMenu();


	var flagForContext;
	function contextMenu() {
		(function() {
			var routeItem = document.querySelector("tbody").querySelectorAll("tr");
			for (let i = 0; i < routeItem.length; i++) {
				var routeItemI = routeItem[i];
				contextMenuListner(routeItemI);
				showOfferByCarrier(routeItemI);
				leftClickLisnter(routeItemI);
				if (routeItemI.querySelector('#trueSalaryTr') != null && routeItemI.querySelector('#trueSalaryTr').value == 'false') {
					routeItemI.querySelector('#workingShiftName').classList.add('text-danger')
					routeItemI.querySelector('#workingShiftName').title = 'Указанная заработная плата не подтверждена администратором'
				}
			}
			function showOfferByCarrier(routeItemI) {
				if (routeItemI.querySelector('#showOfferByCArrier') != null) {
					routeItemI.querySelector('#showOfferByCArrier').addEventListener('click', () => {
						localStorage.setItem('lastClickRoute', routeItemI.querySelector('#idRoute').innerHTML);
					})
				}

			}
			let mouseX;
			let mouseY;
			const menu = document.querySelector(".right-click-menu");
			function contextMenuListner(el) {
				el.addEventListener("contextmenu", event => {
					if (event.target.classList.contains("bg-secondary")) {
						flagForContext = true;
					} else {
						flagForContext = false;
					}
					var routeItem = document.querySelectorAll('tr');
					for (let i = 1; i < routeItem.length; i++) {
						var routeItemI = routeItem[i];
					}
					event.preventDefault();
					menu.classList.add("active");
					mouseX = event.clientX || event.touches[0].clientX;
					mouseY = event.clientY || event.touches[0].clientY;
					let menuHeight = menu.getBoundingClientRect().height;
					let menuWidth = menu.getBoundingClientRect().width;
					let width = window.innerWidth;
					let height = window.innerHeight;
					//ближний правый угол
					if (width - mouseX <= 300) {
						menu.style.left = width - menuWidth + "px";
						menu.style.top = mouseY + "px";
						//правый низ
						if (height - mouseY <= 300) {
							menu.style.top = mouseY - menuHeight + "px";
						}
					}
					// левая сторона
					else {
						menu.style.left = mouseX + "px";
						menu.style.top = mouseY + "px";
						//левый низ
						if (height - mouseY <= 300) {
							menu.style.top = mouseY - menuHeight + "px";
						}
					}
					targetTR = el.id;
					idUser = targetTR.split('&')[0].trim();
					targetFullName = el.querySelector('#fullName').innerHTML.trim();
					targetTD = event.target.id;
					td = event.target;
					tdClasslist = td.classList;
					numDay = targetTD.split('&')[0].trim();
					typeOfDay = targetTD.split('&')[1].trim();
					targetEVENT = event;
					if (event.target.abbr == "") {
						idWorkingDay = null;
					} else {
						idWorkingDay = event.target.abbr;
					}
					if (targetTD == "" || targetTD == null) {
						menu.classList.remove("active");
					}
				}, false);
			}
			document.addEventListener("click", event => {
				if (event.button !== 2) {
					menu.classList.remove("active");
				}
				var routeItem = document.querySelectorAll('tr');
				for (let i = 1; i < routeItem.length; i++) {
					var routeItemI = routeItem[i];
				}

			}, false);

			menu.addEventListener("click", event => {
				event.stopPropagation();
			}, false);

			document.addEventListener("scroll", event => {
				if (event.button !== 2) {
					menu.classList.remove("active");
				}
			}, false);

			menu.addEventListener("scroll", event => {
				event.stopPropagation();
			}, false);


			document.querySelector("#l1").addEventListener("click", event => {
				if (idWorkingDay == null ) { //&& flagForContext
					if (typeOfDay == "day") {
						saveCustomWorkingDay('08:30:00', '18:30:00', false, !tdClasslist.contains("bg-secondary"));
					} else {
						saveCustomWorkingDay('20:30:00', '09:30:00', false, !tdClasslist.contains("bg-secondary"));
					}
				}
				menu.classList.remove("active");
			}, false);
			document.querySelector("#l2").addEventListener("click", () => {
				if (idWorkingDay == null ) { //&& flagForContext
					if (typeOfDay == "day") {
						saveCustomWorkingDay('08:30:00', '21:30:00', false, !tdClasslist.contains("bg-secondary"));
					} else {
						saveCustomWorkingDay('20:30:00', '09:30:00', false, !tdClasslist.contains("bg-secondary"));
					}

				}
				menu.classList.remove("active");
			}, false);
			document.querySelector("#l3").addEventListener("click", () => {
				//				targetEVENT.target.classList.add("bg-info");
				targetEVENT.target.innerHTML = "&#10015";
				targetEVENT.target.classList.remove("bg-secondary");
				saveIllWorkingDay('09:00:00', '18:00:00', false);
				menu.classList.remove("active");
			}, false);
			document.querySelector("#l4").addEventListener("click", () => {
				//				targetEVENT.target.classList.add("bg-danger");
				targetEVENT.target.innerHTML = "&#128405"; // fuck
				targetEVENT.target.classList.remove("bg-secondary");
				menu.classList.remove("active");
				// hooky
				saveHookyWorkingDay('09:00:00', '18:00:00', false);

			}, false);
			document.querySelector("#l5").addEventListener("click", () => {
				if (modalObject2.querySelector('#workRows').querySelectorAll('.row').length > 0) {
					modalObject2.querySelector('#workRows').querySelectorAll('.row').forEach(function(element) {
						element.remove();
					});
				}
				if (td.classList.contains("bg-warning") || td.classList.contains("border-warning")) {
					editOwertimeModalWindow(); // запускаем окно просмотра и редактирования
				} else {
					modal2.show();
					modalObject2.querySelector('#targetTitleFullName').innerHTML = targetFullName;
				} modalObject2.querySelector('#targetTitleFullName').innerHTML = targetFullName;

			}, false);
			document.querySelector("#l6").addEventListener("click", () => {//ТУТ EXTRA
				if (modalObjectExtra.querySelector('#workRowsExtra').querySelectorAll('.row').length > 0) {
					modalObjectExtra.querySelector('#workRowsExtra').querySelectorAll('.row').forEach(function(element) {
						element.remove();
					});
				}
				if (td.classList.contains("bg-info") || td.classList.contains("border-info")) {
					//editOwertimeModalWindow(); // запускаем окно просмотра и редактирования
				} else {
					modalExtra.show();
					modalObjectExtra.querySelector('#targetTitleFullName').innerHTML = targetFullName;
				} modalObjectExtra.querySelector('#targetTitleFullName').innerHTML = targetFullName;
			}, false);
			document.querySelector("#l7").addEventListener("click", () => {
				modalHoliday.show();
//				targetEVENT.target.innerHTML = "O";
//				targetEVENT.target.classList.remove("bg-secondary");
//				saveHolidayWorkingDay('09:00:00', '18:00:00', false, true);
//				menu.classList.remove("active");
			}, false);
			document.querySelector("#l8").addEventListener("click", () => {
				//				targetEVENT.target.classList.add("bg-info");
				deleteWorkingDay();
				menu.classList.remove("active");
			}, false);
		})();



		//листнер левого нажатия
		function leftClickLisnter(el) {
			el.addEventListener('click', event => {
				td = event.target;
				tdClasslist = td.classList;
				targetTR = el.id;
				idUser = targetTR.split('&')[0].trim();
				targetFullName = el.querySelector('#fullName').innerHTML.trim();
				targetTD = event.target.id;
				targetEVENT = event;

				if (event.target.abbr == "") {
					idWorkingDay = null;
				} else {
					idWorkingDay = event.target.abbr;
				}
				numDay = targetTD.split('&')[0].trim();
				typeOfDay = targetTD.split('&')[1].trim();
				if (targetTD.split('&')[1] == "day" || targetTD.split('&')[1] == "night" || targetTD.split('&')[1] == "day" || targetTD.split('&')[1] == "night") {
					if (event.target.classList.contains("bg-secondary") || event.target.classList.contains("bg-success") || event.target.classList.contains("bg-warning")) {
						console.log(td + ' -- td');
						console.log(tdClasslist + ' -- tdClasslist');						
						console.log(targetTR + ' -- targetTR');
						console.log(targetFullName + ' -- targetFullName');
						console.log(targetTD + ' -- targetTD');
						console.log(numMonth + ' -- numMonth');
						console.log(idUser + ' -- idUser');
						console.log(numDay + ' -- numDay');
						console.log(typeOfDay + ' -- typeOfDay');
						console.log(idWorkingDay + ' -- idWorkingDay');
						console.log(event.target.abbr);
						if (event.target.abbr != "") {
							showModalWindow(); // запускаем окно просмотра и редактирования
						} else {
							mainAddModal(); // запускаем окно
						}
					}
				}

			})
		}
	}
	// массовая простановка времени на сегодняшний день
	addCollToday(tr);
	function addCollToday(tr) {
		document.getElementById("8hour").addEventListener("click", () => {
			iteratorHasColl(tr);
			console.log('click')
		}, false);

	}

	function iteratorHasColl(tr) {
		for (let i = 0; i < tr.length; i++) {
			var tds = tr[i].querySelectorAll("td");
			var timeStartDay = tr[i].querySelector("#timeStartDay");
			var timeFinishDay = tr[i].querySelector("#timeFinishDay");
			var timeStartNight = tr[i].querySelector("#timeStartNight");
			var timeFinishNight = tr[i].querySelector("#timeFinishNight");
			var number = new Date().getDate()
			var idD;
			if (number < 10) {
				idD = "0" + number + "&day";
			} else {
				idD = number + "&day";
			}
			var idN;
			if (number < 10) {
				idN = "0" + number + "&night";
			} else {
				idN = number + "&night";
			}
			//проход по TD дневным			
			tds.forEach(elementTD => {
				if (timeStartDay != null || timeFinishDay != null) {
					let getDate = (string) => new Date(0, 0, 0, string.split(':')[0], string.split(':')[1]); //получение даты из строки (подставляются часы и минуты
					let different = (getDate(timeFinishDay.value) - getDate(timeStartDay.value));
					let hours = Math.floor((different % 86400000) / 3600000);
					if (Number(hours) < 0) {
						hours = Number(hours) * -1;
					}
					if (elementTD.id == idD && elementTD.classList.contains("bg-secondary")) {
						elementTD.innerHTML = hours - 1;
						elementTD.classList.add("bg-success");
						if (elementTD.abbr == "") {
							idUser = tr[i].id.split('&')[0];
							numDay = elementTD.id.split('&')[0];
							typeOfDay = tr[i].id.split('&')[1];
							saveAllWorkingDay(timeStartDay.value, timeFinishDay.value, false);
							elementTD.abbr = `Основаня смена:\nНачало работы: ${timeStartDay.value};\nОкончание работы: ${timeFinishDay.value}`;
						}
					}
				}

			});
			//проход по TD ночным
			tds.forEach(elementTD => {
				if (timeStartNight != null || timeFinishNight != null) {
					let getDate = (string) => new Date(0, 0, 0, string.split(':')[0], string.split(':')[1]); //получение даты из строки (подставляются часы и минуты
					let different = (getDate(timeFinishNight.value) - getDate(timeStartNight.value));
					let hours = Math.floor((different % 86400000) / 3600000);
					if (Number(hours) < 0) {
						hours = Number(hours) * -1;
					}
					if (elementTD.id == idN && elementTD.classList.contains("bg-secondary")) {
						if (hours == "8") {
							elementTD.innerHTML = "11";
						} else {
							elementTD.innerHTML = hours - 1;
						}
						elementTD.classList.add("bg-success");
						if (elementTD.abbr == "") {
							idUser = tr[i].id.split('&')[0];
							numDay = elementTD.id.split('&')[0];
							typeOfDay = tr[i].id.split('&')[1];
							saveAllWorkingDay(timeStartNight.value, timeFinishNight.value, false);
							elementTD.abbr = `Основаня смена:\nНачало работы: ${timeStartNight.value};\nОкончание работы: ${timeFinishNight.value}`;

						}
					}
				}

			});
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------	
	//модальное окно для рабочей смены сотрудника ЗАПУСК
	function mainAddModal() {
		mainModal.show();
		mainModalObject.querySelector('#targetTitleFullName').innerHTML = targetFullName;
		var str = " за " + targetTD.split('&')[0];
		mainModalObject.querySelector('#targetTitleFullDate').innerHTML = str;
	}
	//-------------------------------------------------------------------------------------------------------------------------------------	
	//модальное окно для ПРОСМОТРА и РЕДАКТИРОВАНИЯ РАБОЧЕЙ СМЕНЫ сотрудника ЗАПУСК
	function showModalWindow() {
		showModal.show();
		var wokrStartTime = document.querySelector('#wokrStartTime');
		var wokrEndTime = document.querySelector('#wokrEndTime');
		var showIsLunch = document.querySelector('#showIsLunch');
		var workRowsShow = document.querySelector('#workRowsShow');
		showModalObject.querySelector('#targetTitleFullName').innerHTML = targetFullName;
		var str = " за " + targetTD.split('&')[0];
		mainModalObject.querySelector('#targetTitleFullDate').innerHTML = str;
		var isEdit = document.querySelector('#isEdit').value;
		if (isEdit == "true") {
			showElementsForEdit();
		}
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/getWorkingDayById/${idWorkingDay}`,
			true
		)
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ со стрингом рабочего дня, преобразуем в объект
				wokrStartTime.value = obj.timeOfStart
				wokrStartTime.disabled = true
				wokrEndTime.value = obj.timeOfFinish;
				wokrEndTime.disabled = true;
				showIsLunch.disabled = true;

				showIsLunch.checked = obj.lunch;
				if (obj.overtimeWork == null) {
					workRowsShow.innerHTML = "Нет данных"
				} else {
					workRowsShow.innerHTML = ""
					for (let i = 0; i < obj.overtimeWork.overtimeWorkTimes.length; i++) {
						let elem = document.createElement('div');
						elem.classList.add('row');
						elem.append(tmpl.content.cloneNode(true));
						elem.querySelector('#typeOfWork').value = obj.overtimeWork.overtimeWorkTimes[i].typeOvertimeWork.idtypeOvertimeWork;
						elem.querySelector('#typeOfWork').disabled = true;
						elem.querySelector('#hoursOfOvertime').value = obj.overtimeWork.overtimeWorkTimes[i].time;
						elem.querySelector('#hoursOfOvertime').disabled = true;
						workRowsShow.append(elem);
					}

				}
			} else {
				console.log('err', xhr.responseText)
			}
		}

	}
	//-------------------------------------------------------------------------------------------------------------------------------------	
	//модальное окно для РЕДАКТИРОВАНИЯ ПЕРЕРАБОТКИ сотрудника ЗАПУСК (правый клик-переработка)
	function editOwertimeModalWindow() {
		showModal.show();
		var thisModal = document.querySelector('#showModal');
		var body = thisModal.querySelector('.modal-body');
		var rows = body.querySelectorAll('.row');

		var workRowsShow = document.querySelector('#workRowsShow');
		showModalObject.querySelector('#targetTitleFullName').innerHTML = targetFullName;
		var str = " за " + targetTD.split('&')[0];
		mainModalObject.querySelector('#targetTitleFullDate').innerHTML = str;
		var isEdit = document.querySelector('#isEdit').value;
		if (isEdit == "true") {
			showElementsForEditOwertime();
		}
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/getWorkingDayById/${idWorkingDay}`,
			true
		)
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ со стрингом рабочего дня, преобразуем в объект
				wokrStartTime.value = obj.timeOfStart
				wokrStartTime.disabled = true
				wokrEndTime.value = obj.timeOfFinish;
				wokrEndTime.disabled = true;
				showIsLunch.disabled = true;

				showIsLunch.checked = obj.lunch;
				if (obj.overtimeWork == null) {
					workRowsShow.innerHTML = "Нет данных"
				} else {
					workRowsShow.innerHTML = ""
					for (let i = 0; i < obj.overtimeWork.overtimeWorkTimes.length; i++) {
						let elem = document.createElement('div');
						elem.classList.add('row');
						elem.append(tmpl.content.cloneNode(true));
						elem.querySelector('#typeOfWork').value = obj.overtimeWork.overtimeWorkTimes[i].typeOvertimeWork.idtypeOvertimeWork;
						elem.querySelector('#typeOfWork').disabled = true;
						elem.querySelector('#hoursOfOvertime').value = obj.overtimeWork.overtimeWorkTimes[i].time;
						elem.querySelector('#hoursOfOvertime').disabled = true;
						workRowsShow.append(elem);
					}

				}
			} else {
				console.log('err', xhr.responseText)
			}
		}

	}

	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция отправки сохранения для рабочей смены сотрудника (единичная)
	function saveCustomWorkingDay(firstDate, secondDate, isLunch, isYouShift) {
		//опредиляем колличество отработанных часов
		let getDate = (string) => new Date(0, 0, 0, string.split(':')[0], string.split(':')[1]); //получение даты из строки (подставляются часы и минуты
		let different = (getDate(secondDate) - getDate(firstDate));
		let hours = Math.floor((different % 86400000) / 3600000);
		let minutes = Math.round(((different % 86400000) % 3600000) / 60000);
		let result = hours + ':' + minutes;
		if (Number(hours) < 0) {
			hours = Number(hours) * -1;
		}
		
		if(tdClasslist.contains("bg-secondary")){
			targetEVENT.target.classList.add("bg-success");
		}else{
//			targetEVENT.target.style.backgroundColor = "#ef25e39e";
			targetEVENT.target.classList.add("non-shift");
			
		}		
		targetEVENT.target.innerHTML = parseInt(hours) - 1;

		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/addCustomWorkingDay/${idUser}&${numDay}&${numMonth}&${typeOfDay}&${firstDate}&${secondDate}&${isLunch}&${isYouShift}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ с id рабочего дня
				targetEVENT.target.abbr = obj.id; // записываем в ячейку
				targetEVENT.target.title = `Основаня смена:\nНачало работы: ${firstDate};\nОкончание работы: ${secondDate}`
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}
	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция отправки сохранения больничных
	function saveIllWorkingDay(firstDate, secondDate, isLunch) {
		//опредиляем колличество отработанных часов
		targetEVENT.target.innerHTML = "&#10015";


		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/setIllWorkingDay/${idUser}&${numDay}&${numMonth}&${typeOfDay}&${firstDate}&${secondDate}&${isLunch}&${idWorkingDay}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ с id рабочего дня
				targetEVENT.target.abbr = obj.id; // записываем в ячейку
				targetEVENT.target.title = `Отсутствует по болезни`
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция отправки сохранения прогулов
	function saveHookyWorkingDay(firstDate, secondDate, isLunch) {
		//опредиляем колличество отработанных часов
		targetEVENT.target.innerHTML = "&#128405";

		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/setHookyWorkingDay/${idUser}&${numDay}&${numMonth}&${typeOfDay}&${firstDate}&${secondDate}&${isLunch}&${idWorkingDay}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ с id рабочего дня
				targetEVENT.target.abbr = obj.id; // записываем в ячейку
				targetEVENT.target.title = `Прогул`
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}
	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция удаления метки
		function deleteWorkingDay() {
			if(idWorkingDay == null){
				return
			}
		//опредиляем колличество отработанных часов	
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/deleteWorkingDay/${idWorkingDay}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ с id рабочего дня
				if(obj.status == 103){
					showSnackbar(obj.message);
				}else if(obj.status == 200){
					targetEVENT.target.abbr = ""; // удаляем id из ячейку
					targetEVENT.target.innerHTML = null;
					targetEVENT.target.title = `Удалено`
					var classMass = targetEVENT.target.classList.value.split(" ");
					var classTarget = classMass[classMass.length-1];					
					targetEVENT.target.classList.remove(classTarget)
					showSnackbar(obj.message);
				}
//				
//				if(isTrueHoliday){
//					targetEVENT.target.innerHTML = "О";
//					targetEVENT.target.title = `Отпуск`
//				}else{
//					targetEVENT.target.innerHTML = "С/С";
//					targetEVENT.target.title = `Отпуск за свой счёт`
//				}
				
				
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}
	
	
	//функция отправки сохранения для переработки сотрудника (единичная)
	function saveOwertimeWorkingDay(rowsHasOvertime, message, event) {
		let requestJSON = new Array();
		var oldTitle = targetEVENT.target.title;

		if (message == "") {
			message = null;
		}
		if (targetEVENT.target.innerHTML == "") {
			var hoursTotal = 0;
			var modules = document.querySelectorAll("#hoursOfOvertime");
			modules.forEach(el => {
				hoursTotal = hoursTotal + parseInt(el.value.split(':')[0]);
			});
			targetEVENT.target.classList.add("bg-warning");
			targetEVENT.target.classList.add("text-black");
			targetEVENT.target.innerHTML = hoursTotal;
		} else {
			var firstTime = targetEVENT.target.innerHTML;
			var hoursTotal = parseInt(firstTime);
			var modules = document.querySelectorAll("#hoursOfOvertime");
			modules.forEach(el => {
				hoursTotal = hoursTotal + parseInt(el.value.split(':')[0]);
			});
			targetEVENT.target.classList.add("bg-success");
			targetEVENT.target.classList.add("border");
			targetEVENT.target.classList.add("border-warning");
			targetEVENT.target.classList.add("border-3");
			targetEVENT.target.innerHTML = hoursTotal;
		}
		var elementTitle = '\nПереработки: \n';
		for (let i = 0; i < rowsHasOvertime.length; i++) {
			var el = rowsHasOvertime[i];
			var typeOfWork = el.querySelector('#typeOfWork');
			var hoursOfOvertime = el.querySelector('#hoursOfOvertime');
			elementTitle = elementTitle + `${typeOfWork.selectedOptions[0].innerHTML} в количестве ${hoursOfOvertime.value} часов\n`

			let request = {
				time: hoursOfOvertime.value,
				idtypeOvertimeWork: typeOfWork.value,
				idWorkingDay: idWorkingDay,
				message: message,
				idUser: idUser,
				targetDay: numDay,
				targetMonth: numMonth,
				typeOfDay: typeOfDay,
			};
			targetEVENT.target.title = oldTitle + elementTitle;
			requestJSON[i] = request;
		}
		//отправляем editOvertimeWorkingDay
		var url
		if (event.target.id == "editCustomWorkingDay") {
			url = "../../api/departmentHead/editOvertimeWorkingDay"
		} else {
			url = "../../api/departmentHead/addOvertimeWorkingDay";
		}
		$.ajax({
			type: "POST",
			url: url,
			headers: { "X-CSRF-TOKEN": token },
			data: JSON.stringify(requestJSON),
			contentType: 'application/json',
			dataType: 'json',
			success: function(html) {
				//						console.log(html.message);
			},
			error: function(err) { }
		})
	}
	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция отправки сохранения для доп работы
	function saveExtraWorkingDay(rowsHasOvertime, message, event) {
		let requestJSON = new Array();
		//		var oldTitle = targetEVENT.target.title;

		if (message == "") {
			message = null;
		}
		//		if (targetEVENT.target.innerHTML == "") {
		//			var hoursTotal = 0;
		//			var modules = document.querySelectorAll("#hoursOfOvertime");
		//			modules.forEach(el => {
		//				hoursTotal = hoursTotal + parseInt(el.value.split(':')[0]);
		//			});
		//			targetEVENT.target.classList.add("bg-warning");
		//			targetEVENT.target.classList.add("text-black");
		//			targetEVENT.target.innerHTML = hoursTotal;
		//		} else {
		//			var firstTime = targetEVENT.target.innerHTML;
		//			var hoursTotal = parseInt(firstTime);
		//			var modules = document.querySelectorAll("#hoursOfOvertime");
		//			modules.forEach(el => {
		//				hoursTotal = hoursTotal + parseInt(el.value.split(':')[0]);
		//			});
		//			targetEVENT.target.classList.add("bg-success");
		//			targetEVENT.target.classList.add("border");
		//			targetEVENT.target.classList.add("border-warning");
		//			targetEVENT.target.classList.add("border-3");
		//			targetEVENT.target.innerHTML = hoursTotal;
		//		}
		//		var elementTitle = '\nПереработки: \n';
		for (let i = 0; i < rowsHasOvertime.length - 1; i = i + 2) {
			var el = rowsHasOvertime[i];
			var typeOfWork = el.querySelector('#typeOfWorkExtra');
			var hoursOfOvertime = el.querySelector('#hoursOfWorkExtra');
			var paramInputs = rowsHasOvertime[i + 1].querySelectorAll('input');
			var count = null;
			var weight = null;
			var stickers = null;
			var pallets = null;

			paramInputs.forEach(input => {
				switch (input.id) {
					case 'inputCount':
						count = input.value;
						break;
					case 'inputWeight':
						weight = input.value;
						break;
					case 'inputStickers':
						stickers = input.value;
						break;
					case 'inputPallets':
						pallets = input.value;
						break;
				}
			});
			//			elementTitle = elementTitle + `${typeOfWork.selectedOptions[0].innerHTML} в количестве ${hoursOfOvertime.value} часов\n`

			let request = {
				time: hoursOfOvertime.value,
				idtypeExtraWork: typeOfWork.value,
				idWorkingDay: idWorkingDay,
				message: message,
				idUser: idUser,
				targetDay: numDay,
				targetMonth: numMonth,
				typeOfDay: typeOfDay,
				count: count,
				weight: weight,
				stickers: stickers,
				pallets: pallets,
			};
			console.log(request);
			//			targetEVENT.target.title = oldTitle + elementTitle;
			requestJSON.push(request);
		}
		//отправляем addExtraWork
		var url
		url = "../../api/departmentHead/addExtraWork"

		$.ajax({
			type: "POST",
			url: url,
			headers: { "X-CSRF-TOKEN": token },
			data: JSON.stringify(requestJSON),
			contentType: 'application/json',
			dataType: 'json',
			success: function(html) {
				//						console.log(html.message);
			},
			error: function(err) { }
		})
	}

	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция сохраненияы редактирования
	function saveEditWorkingDay(body) {
		var inputs = body.querySelectorAll('input');
		let request = {
			wokrStartTime: inputs[0].value,
			wokrEndTime: inputs[1].value,
			isLunch: body.querySelector('#showIsLunch').checked,
			idWorkingDay: idWorkingDay,
			idUser: idUser,
			targetDay: numDay,
			targetMonth: numMonth,
			typeOfDay: typeOfDay,
		};
		//		console.log(request)
		$.ajax({
			type: "POST",
			url: "../../api/departmentHead/editWorkingDay",
			headers: { "X-CSRF-TOKEN": token },
			data: JSON.stringify(request),
			contentType: 'application/json',
			dataType: 'json',
			success: function(html) {
				//						console.log(html.message);
			},
			error: function(err) { }
		})
		showModal.hide();
	}
	//-------------------------------------------------------------------------------------------------------------------------------------
	//функция отправки сохранения для отпуска сотрудника
	function saveHolodayWorkingDay(typeOfHoliday, dayStart, dayEnd, message, event) {
		let requestJSON = new Array();
		var oldTitle = targetEVENT.target.title;

		if (message == "") {
			message = null;
		}
		
		//отправляем на сервер
		let request = {
				message: message,
				idUser: idUser,
				dayStart: dayStart,
				dayEnd: dayEnd,
				status: typeOfHoliday,
			};
			
		console.log(request);
		var url = "../../api/departmentHead/addHolidayDay";
		$.ajax({
			type: "POST",
			url: url,
			headers: { "X-CSRF-TOKEN": token },
			data: JSON.stringify(request),
			contentType: 'application/json',
			dataType: 'json',
			success: function(html) {
				console.log(html.message);
			},
			error: function(err) { }
		})
	}

	//-------------------------------------------------------------------------------------------------------------------------------------	
	//функция отправки сохранения для рабочей смены сотрудника (масоовая)
	function saveAllWorkingDay(firstDate, secondDate, isLunch) {
		//опредиляем колличество отработанных часов
		let getDate = (string) => new Date(0, 0, 0, string.split(':')[0], string.split(':')[1]); //получение даты из строки (подставляются часы и минуты
		let different = (getDate(secondDate) - getDate(firstDate));
		let hours = Math.floor((different % 86400000) / 3600000);
		let minutes = Math.round(((different % 86400000) % 3600000) / 60000);
		let result = hours + ':' + minutes;
		if (Number(hours) < 0) {
			hours = Number(hours) * -1;
		}


		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/departmentHead/addCustomWorkingDay/${idUser}&${numDay}&${numMonth}&${typeOfDay}&${firstDate}&${secondDate}&${isLunch}&false`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText); // получаем обратно ответ с id рабочего дня
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}

	checkRateMounth();

	//метод запроса объектов workingDay для отображения
	setTimeout(() => {
		var trArray = document.querySelectorAll('tr');
		trArray.forEach(tr => {
			var summHoursHasTr = 0;
			var tdArray = tr.querySelectorAll('td');
			tdArray.forEach(td => {
				if (td.classList.contains('bg-success') || td.classList.contains('bg-warning')) {
					summHoursHasTr = summHoursHasTr + parseInt(td.innerHTML);
				}
			})
			try {
				tr.querySelector('#summHours').innerHTML = summHoursHasTr;
			} catch (e) {

			}

		})
	}, 500);
}//конец блока WINDOWS!
//-------------------------------------------------------------------------------------------------------------------------------------	


//-------------------------------------------------------------------------------------------------------------------------------------	
//метод запроса объектов workingDay для отображения
function getRequestHasWprkingDay(id, numMonth) {
	var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../api/departmentHead/getWorkingDays/${id}&${numMonth}`,
		true
	)
	xhr1.send()
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState != 4) {
			return
		}

		if (xhr1.status === 200) {
			var obj = JSON.parse(xhr1.responseText);
			obj.forEach(element => {
				viewDays(element);
			})
			//			console.log(obj);
		} else {
			console.log('err', xhr1.responseText)
		}
	}
}
//-------------------------------------------------------------------------------------------------------------------------------------	
//метод отображения объектов в таблице VIEW
function viewDays(element) {
	var idThisUser = element.userTarget.idUser;
	var typeOfDay = element.typeOfDay;
	var day = element.dateOfFinallyDay[2];
	var firstTime = element.timeOfStart;
	var secondTime = element.timeOfFinish;
	var idWorkingDay = element.idWorkingDay;
	var isLunch = element.lunch;
	var status = element.status;
	let hours;

	//всё что касается переработок

	if (element.overtimeWork != null) {
		//		console.log(element);
		var summHoursOfOvertime = element.overtimeWork.summHoursOfOvertime;
	}


	if (firstTime != null || secondTime != null) {
		let getDate = (string) => new Date(0, 0, 0, string.split(':')[0], string.split(':')[1], string.split(':')[2]); //получение даты из строки (подставляются часы и минуты
		let different = (getDate(secondTime) - getDate(firstTime));
		hours = Math.floor((different % 86400000) / 3600000);
		if (parseInt(hours) < 0) {
			hours = hours * -1;
		}
	} else {
		hours = "";
	}

	if (parseInt(day) < 10) {
		day = '0' + day;
	}
	let targetRow = document.getElementById(`${idThisUser}&${typeOfDay}`).getElementsByTagName('td');
	for (let i = 0; i < targetRow.length; i++) {
		if (targetRow[i].id == `${day}&${typeOfDay}`) {
			if (element.overtimeWork != null && hours == "") {
				targetRow[i].classList.add("bg-warning");
			} else if (status == 'ill') {
				targetRow[i].classList.remove("bg-secondary");
				targetRow[i].innerHTML = "&#10015";
				targetRow[i].style.color = "red";
			} else if (status == 'hooky') {
				targetRow[i].classList.remove("bg-secondary");
				targetRow[i].innerHTML = "&#128405";
				//				targetRow[i].style.color = "red";
			}else if(status == 'holiday' || status == 'holiday-sociality' || status == 'holiday-children'){
				targetRow[i].classList.remove("bg-secondary");
				targetRow[i].classList.add("bg-info");
				targetRow[i].innerHTML = "O";
			}else if(status == '!holiday'){
				targetRow[i].classList.remove("bg-secondary");
				targetRow[i].classList.add("bg-warning");
				targetRow[i].innerHTML = "A";
			} else if (element.overtimeWork != null && hours != "") {
				targetRow[i].classList.add("bg-success");
				targetRow[i].classList.add("border");
				targetRow[i].classList.add("border-warning");
				targetRow[i].classList.add("border-3");

			} else if(!targetRow[i].classList.contains("bg-secondary")){
				targetRow[i].classList.add("non-shift");
			} else {
				targetRow[i].classList.add("bg-success");
			}

			if (status == null) {
				if (isLunch && hours != "" && element.overtimeWork == null) {
					//тут с обедом и без переработки
					targetRow[i].innerHTML = parseInt(hours);
					targetRow[i].title = `Основаня смена:\nНачало работы: ${firstTime};\nОкончание работы: ${secondTime}`
				} else if (!isLunch && hours != "" && element.overtimeWork == null) {
					//тут типо без обеда и без переработки
					targetRow[i].innerHTML = parseInt(hours) - 1;
					targetRow[i].title = `Основаня смена:\nНачало работы: ${firstTime};\nОкончание работы: ${secondTime}`
				} else if (hours != "" && element.overtimeWork != null) {
					//тут обычная смена с переработкой
					var title;
					if (isLunch) {
						targetRow[i].innerHTML = parseInt(hours) + parseInt(summHoursOfOvertime);
					} else {
						targetRow[i].innerHTML = parseInt(hours) - 1 + parseInt(summHoursOfOvertime);
					}
					title = `Основаня смена:\nНачало работы: ${firstTime};\nОкончание работы: ${secondTime}\nПереработки: \n`
					element.overtimeWork.overtimeWorkTimes.forEach(time => {
						title = title + `${time.typeOvertimeWork.name} в количестве ${time.time} часов\n`
					})
					targetRow[i].title = title;

				} else {
					//тут чисто переработка
					targetRow[i].classList.add("text-black");
					targetRow[i].innerHTML = summHoursOfOvertime;
					var title = 'Переработки: \n';
					element.overtimeWork.overtimeWorkTimes.forEach(time => {
						title = title + `${time.typeOvertimeWork.name} в количестве ${time.time} часов\n`
					})
					targetRow[i].title = title;
				}
			}
			targetRow[i].abbr = idWorkingDay;

			break;
		}
	}
}

//костыль для открытия всех окон росто день
function showElementsForEdit() {
	setTimeout(() => {
		var thisModal = document.querySelector('#showModal');
		var body = thisModal.querySelector('.modal-body');
		body.querySelectorAll('input[type = time]').forEach(el => {
			el.disabled = false;
		})
		//		body.querySelectorAll('select').forEach(el => {
		//			el.disabled = false;
		//		})
		body.querySelector('#showIsLunch').disabled = false
		body.querySelector('#addTmplEdit').style.display = "none"
		body.querySelector('#delTmplEdit').style.display = "none"
	}, 500);

}
//костыль для открытия всех окон переработка
function showElementsForEditOwertime() {
	setTimeout(() => {
		var thisModal = document.querySelector('#showModal');
		var body = thisModal.querySelector('.modal-body');
		body.querySelectorAll('select').forEach(el => {
			el.disabled = false;
		})
		body.querySelector('#addTmplEdit').style.display = ""
		body.querySelector('#delTmplEdit').style.display = ""
		body.querySelector('#showIsLunch').disabled = false
	}, 500);

}
//убираем строку переработки в редакторе
function minusRow() {
	var thisModal = document.querySelector('#showModal');
	var body = thisModal.querySelector('.modal-body');
	var parent = body.querySelector('#workRowsShow');
	var rows = parent.querySelectorAll('.row');
	parent.removeChild(rows[rows.length - 1]);
}
//добавляем строки переработки
function plusRow() {
	var thisModal = document.querySelector('#showModal');
	var body = thisModal.querySelector('.modal-body');
	var parent = body.querySelector('#workRowsShow');
	let elem = document.createElement('div');
	elem.classList.add('row');
	elem.id = "rowTmpl";
	elem.append(tmpl.content.cloneNode(true));
	parent.append(elem);
}

//проверяем зполнено ли нормочасы за месяц для каждой смены

function checkRateMounth() {
	var mounth = document.querySelector('#numMonth').value;
	var elementSetId = new Set();
	var elementSetName = new Set();
	var requestArray = document.querySelectorAll('#workingShiftName');

	requestArray.forEach(el => {
		elementSetId.add(el.abbr);
		elementSetName.add(el.innerHTML);
	});
	Array.from(elementSetId).forEach(function(el, i, arr) {
		requestRateMounth(mounth, i, elementSetId, elementSetName);
	})
	//	for (let i = 0; i < elementSetId.size; i++) {
	//		requestRateMounth(mounth, i, elementSetId, elementSetName);
	//	}

	setTimeout(function() {
		//		console.log(isShowRateMod)
		if (isShowRateMod) {
			rateMounthModal.show();
			var bottunSaveHourse = rateMounthModalDomElements.querySelector('#saveRateHours')
			bottunSaveHourse.addEventListener('mousedown', function() {
				sendHourseJSON();
			});
		}
	}, 500)

}

//запрос для проверки введённых нормо-часов за месяц 
function requestRateMounth(mounth, i, elementSetId, elementSetName) {

	const idArr = Array.from(elementSetId);
	const nameArr = Array.from(elementSetName);
	var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../api/departmentHead/isEmptyRateMounth/${mounth}&${nameArr[i]}&${idArr[i]}`,
		true
	)
	xhr1.send()
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState != 4) {
			return
		}

		if (xhr1.status === 200) {
			var obj = JSON.parse(xhr1.responseText);
			if (obj.message == 'false') {
				isShowRateMod = true;
				var form = rateMounthModalDomElements.querySelector('#form');
				var divMD = document.createElement('div');
				divMD.classList.add('mb-3');
				var lable = document.createElement('label');
				lable.classList.add('col-form-label');
				lable.innerHTML = `Введите количество часов в месяце для смены: ${obj.nameShift}`;
				var input = document.createElement('input');
				input.type = "number";
				input.classList.add('form-control');
				input.required = true;
				input.min = 0;
				input.id = obj.idShift;
				input.placeholder = obj.nameShift;
				divMD.append(lable);
				divMD.append(input);
				divMD.append(document.createElement('br'));
				form.append(divMD);
			}
		} else {
			console.log('err', xhr1.responseText)
		}

	}
}

//отправка нормочасов на текущий месяц на сервер
function sendHourseJSON() {
	var inputArr = rateMounthModalDomElements.querySelectorAll('input');
	var requestJSON = new Array();

	for (let i = 0; i < inputArr.length; i++) {
		let input = inputArr[i];
		if (input.value < 0) {
			document.querySelector('#errorMessageRateMounthModal').innerHTML = "Значение не может быть отрицательным!";
			requestJSON = null;
			break;
		} else {
			let request = {
				idWorkingShift: input.id,
				workingShiftName: input.placeholder,
				hours: input.value,
				numMounth: mounth,
			};
			requestJSON[i] = request;
		}

	}
	if (requestJSON != null) {
		$.ajax({
			type: "POST",
			url: "../../api/departmentHead/addRateMounth",
			headers: { "X-CSRF-TOKEN": token },
			data: JSON.stringify(requestJSON),
			contentType: 'application/json',
			dataType: 'json',
			success: function(html) {
				//			console.log(html.message);
				rateMounthModal.hide();
			},
			error: function(err) { }
		})
	}

}
//функция отображения темплейтов с параметрами
function showTemplForExtraWorkParameters(el, modalObjectExtra) {
	var id = el.target.value;
	let form = modalObjectExtra.querySelector('#workRowsExtra');

	var thisRowElements = document.querySelector('#extraModal').querySelector("#workRowsExtra").querySelectorAll('.row');
	if (thisRowElements[thisRowElements.length - 1] != undefined && thisRowElements[thisRowElements.length - 1].id != 'rowTmpl') {
		console.log(thisRowElements[thisRowElements.length - 1]);
		thisRowElements[thisRowElements.length - 1].remove();
	}

	let elem = document.createElement('div');
	var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../api/departmentHead/getTypeOvertimeWorkById/${id}`,
		true
	)
	xhr1.send()
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState != 4) {
			return
		}

		if (xhr1.status === 200) {
			var obj = JSON.parse(xhr1.responseText);
			if (obj.count) {
				elem.classList.add('row');
				elem.id = "rowTmplExtra";
				elem.append(tmplExtraParametersCount.content.cloneNode(true));
				form.append(elem);
			}
			if (obj.weight) {
				elem.classList.add('row');
				elem.id = "rowTmplExtra";
				elem.append(tmplExtraParametersWeight.content.cloneNode(true));
				form.append(elem);
			}
			if (obj.stickers) {
				elem.classList.add('row');
				elem.id = "rowTmplExtra";
				elem.append(tmplExtraParametersStickers.content.cloneNode(true));
				form.append(elem);
			}
			if (obj.pallets) {
				elem.classList.add('row');
				elem.id = "rowTmplExtra";
				elem.append(tmplExtraParametersPallets.content.cloneNode(true));
				form.append(elem);
			}

		} else {
			console.log('err', xhr1.responseText)
		}

	}
}
//---------------------------------------------------------------------------------------------
//снекбар или всплывающее сообщение
var lastTimeout;
function showSnackbar(message) {
	var snackbar = document.querySelector('#snackbar');
	if (snackbar == null) {
		console.warn("Element not found", "Не найден элемент с идентификатором snackbar");
		
	} else {
		if (snackbar.classList.contains("show")) {
			clearTimeout(lastTimeout);
			snackbar.className = snackbar.className.replace("show", "");
		}
		snackbar.innerHTML = message;
		snackbar.classList.add("show");
		lastTimeout = setTimeout(function() { snackbar.className = snackbar.className.replace("show", ""); }, 3000);
	}

}
