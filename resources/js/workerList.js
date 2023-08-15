
window.onload = function() {
	//функция отслеживания и изминения смен
	var shiftList = document.querySelectorAll("#shiftSelect");
	var idUserList = document.querySelectorAll("#idUser");
	var tumblerList = document.querySelectorAll('#deal');
	for (let i = 0; i < shiftList.length; i++) {
		var shiftI = shiftList[i];
		var idUser = idUserList[i];
		var tumbler = tumblerList[i];
		changeListner(shiftI, idUser);
		changeEditTumbler(idUser, tumbler)
	}
}
//функция отслеживания и изминения смен
function changeListner(shiftI, idUser) {
	shiftI.addEventListener('change', (event) => {
		var xhr = new XMLHttpRequest()
		xhr.open(
			'GET',
			`../../api/departmentHead/changeShift/${idUser.innerHTML}&${event.target.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				console.log('result', xhr)
				var obj = JSON.parse(xhr.responseText);
			} else {
				console.log('err', xhr.responseText)
			}
		}
	});
}

//управление тумблером
function changeEditTumbler(idUser, tumbler) {
	if (tumbler.value == "true") {
		tumbler.checked = true;
	}
	tumbler.addEventListener('change', (event) => {
		var xhr = new XMLHttpRequest()
		xhr.open(
			'GET',
			`../../api/departmentHead/changeIsDeal/${idUser.innerHTML}&${tumbler.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				console.log('result', xhr)
				var obj = JSON.parse(xhr.responseText);
				showSnackbar(obj.message)
			} else {
				console.log('err', xhr.responseText)
			}
		}
	})
}

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
