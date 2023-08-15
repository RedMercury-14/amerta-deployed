var table = document.querySelector('tbody');
table.querySelectorAll('tr').forEach(el => {
	var tr = el;
	el.querySelector('#change').addEventListener("mousedown", () => {
		changeSend(tr);
	});
	el.querySelectorAll('td').forEach(td => {
		if (td.id == "led") {
			if (td.abbr == "true") {
				td.style.color = "green";
			} else {
				td.style.color = "red";
			}

		}
	})
})

function changeSend(tr) {
	var id = tr.querySelector('#id').value;
	tr.querySelectorAll('td').forEach(td => {
		if (td.id == "led") {			
			if(td.style.color == "green"){
				td.style.color = "red"
			}else{
				td.style.color = "green"
			}			
		}
	});	
	var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../../api/departmentHead/changeViolationStatus/${id}`,
		true
	)
	xhr1.send()
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState != 4) {
			return
		}

		if (xhr1.status === 200) {
			var obj = JSON.parse(xhr1.responseText);
			//сюда поставить снекбар

		} else {
			console.log('err', xhr1.responseText)
		}

	}
}