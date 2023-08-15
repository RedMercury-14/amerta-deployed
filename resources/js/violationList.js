var url = window.location.href;

window.onload = function() {
	if (url.split('amerta/')[1] == "home/security/violationList" || url.split('amerta/')[1] == "home/gsus/violationList") {
		document.querySelector('#tmb').style.display = "none";
		document.querySelectorAll('#SwitchCheck').forEach(el => {
			el.style.display = "none";
		})
	}

	var trList = document.querySelectorAll('tr');
	for (let i = 2; i < trList.length; i++) {
		var switchCheck = trList[i];
		var tumbler = switchCheck.querySelector('#flexSwitchCheckDefault');
		var idViolation = switchCheck.querySelector('#idViolation');
		if (tumbler.value == "true") {
			tumbler.checked = true;
		}
		changeTublerEvent(tumbler, idViolation)
	}
}

function changeTublerEvent(tumbler, idViolation) {
	tumbler.addEventListener('change', (event) => {
		var xhr = new XMLHttpRequest()
		xhr.open(
			'GET',
			`../../api/admin/changeIsSignViolation/${idViolation.innerHTML}&${tumbler.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {

				var obj = JSON.parse(xhr.responseText);
				if (obj.status == "200") {
					tumbler.value = obj.value;
					//					console.log('obj', obj)
					showSnackbar(obj.message);
				}
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
