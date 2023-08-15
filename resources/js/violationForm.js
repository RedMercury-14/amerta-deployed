document.querySelector('input[name=idViolation]').addEventListener('change', el => {
	var requestText = el.target.value;
	//d-block
	var xhr = new XMLHttpRequest();
	xhr.open(
		'GET',
		`../../api/security/proofIdViolation/${requestText}`,
		true
	)
	xhr.send()
	xhr.onreadystatechange = function() {
		if (xhr.readyState != 4) {
			return
		}

		if (xhr.status === 200) {
//			var obj = JSON.parse(xhr.responseText);
			if(xhr.responseText == "true"){
				document.querySelector('#idViolationError').classList.add("d-block");
			}else{
				document.querySelector('#idViolationError').classList.remove("d-block");
			}
		} else {
			console.log('err', xhr.responseText)
		}
	}
})