
window.onload = function() {
	//функция отслеживания и изминения смен
	var trList = document.querySelector("tbody").querySelectorAll("tr");
	var roleList = document.querySelectorAll("#roleChoice");
	var idUserList = document.querySelectorAll("#idUser");
	var password = document.querySelectorAll('#password');
	var fullNameList = document.querySelectorAll('#fullName');
	var tumblers = document.querySelectorAll('#flexSwitchCheckDefault');
	for (let i = 0; i < trList.length; i++) {		
		var trI = trList[i];
		var role = roleList[i];
		var idUser = trI.querySelector("#idUser");
		var idUserValue = idUser.innerHTML;
		var passwordI = password[i];
		var fullName = fullNameList[i].innerHTML;
		var tumbler = tumblers[i];		
		changeListner(role, idUser, passwordI);
		changeEditTumbler(tumbler);
		changePasswordListner(passwordI, fullName, idUser);
	}
}
//функция отслеживания и изминения ролей
function changeListner(role, idUser, passwordI) {
	role.addEventListener('change', (event) => {		
		if (passwordI.value != "") {
			var xhr = new XMLHttpRequest()
			xhr.open(
				'GET',
				`../../api/admin/changeRole/${idUser.innerHTML}&${event.target.value}&${passwordI.value}`,
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
		} else {
			alert("Не введен пароль, по которому пользователь будет входить в систему!")
		}

	});
}
function changePasswordListner(passwordI, fullName, idUser) {
	passwordI.addEventListener('change', (event) => {
		let isConfrom = confirm(`Сохранить новый пароль для ${fullName}`);
		if (isConfrom) {
			var xhr = new XMLHttpRequest()
			xhr.open(
				'GET',
				`../../api/admin/changePassword/${idUser.innerHTML}&${event.target.value}`,
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
		}
	})
}
//управление тумблером
function changeEditTumbler(tumbler) {
	var idUser = tumbler.parentElement.parentElement.parentElement.querySelector('#idUser');
	if (tumbler.value == "true") {
		tumbler.checked = true;
	}
	tumbler.addEventListener('change', (event) => {
		console.log(tumbler);
		var xhr = new XMLHttpRequest()
		xhr.open(
			'GET',
			`../../api/admin/changeIsEdit/${idUser.innerHTML}&${tumbler.value}`,
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
