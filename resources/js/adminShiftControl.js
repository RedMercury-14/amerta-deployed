window.onload = function() {
	//функция отслеживания и изминения смен
	var tr = document.querySelector('#table').querySelectorAll("tr");
	
	
	for (let i = 0; i < tr.length; i++) {
		var targetTR = tr[i];
		var tumbler = targetTR.querySelector('#tumbler');
		var idWS = targetTR.querySelector('#idWorkingShift');
		changeEditTumbler(idWS, tumbler);
	}
}
//управление тумблером
function changeEditTumbler(idWS, tumbler) {
	if (tumbler.value == "true") {
		tumbler.checked = true;
	}
	tumbler.addEventListener('change', (event) => {
		var xhr = new XMLHttpRequest()
		xhr.open(
			'GET',
			`../../api/admin/changeIsTrueSalary/${idWS.innerHTML}&${tumbler.value}`,
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
	})
}