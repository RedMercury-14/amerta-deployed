let tuchList = document.querySelector('tbody').querySelectorAll('tr');
let rateMounthModal = new bootstrap.Modal(document.querySelector('#rateMounthModal'));
tuchList.forEach(el=>{	
	var id = el.querySelector('#id').value;
	var tr = el;
	var flipBox = el.querySelector('.flip-box-front');
	var buttons = el.querySelector('#buttons');
	var tuch = el.querySelector('#tuch')
		tuch.addEventListener('click', (el)=>{			
			rateMounthModal.show();
			modalProcess(id);
		})
		
		el.querySelector('#yes').addEventListener("mousedown", ()=>{
			tr.classList.add('bg-success');		
			tr.querySelector('a').style.color = "black";
			buttons.style.display = 'none';
			send(id, true);
		})
		el.querySelector('#no').addEventListener("mousedown", ()=>{
			tr.classList.add('bg-danger');	
			tr.querySelector('a').style.color = "black";
			buttons.style.display = 'none';
			send(id, false);
		})
		
})


function modalProcess(id){
		var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../api/departmentHead/getViolationById/${id}`,
		true
	)
	xhr1.send()
	xhr1.onreadystatechange = function() {
		if (xhr1.readyState != 4) {
			return
		}

		if (xhr1.status === 200) {
			var obj = JSON.parse(xhr1.responseText);
			console.log(obj[0]);
			document.querySelector('#dateViolation').innerHTML = new Date(obj[0].dateViolation).toLocaleDateString();
			document.querySelector('#dateCreate').innerHTML = new Date(obj[0].dateCreate).toLocaleDateString();
			document.querySelector('#violationName').innerHTML = obj[0].violationHasUser.name;
			document.querySelector('#fio').innerHTML = obj[0].userHasCreate.surname +" "+obj[0].userHasCreate.name + " " + obj[0].userHasCreate.patronymic;
			document.querySelector('#comment').innerHTML = obj[0].comment;
		} else {
			console.log('err', xhr1.responseText)
		}

	}
}

function send(id, status){
		var xhr1 = new XMLHttpRequest()
	xhr1.open(
		'GET',
		`../../api/departmentHead/saveViolationStatus/${id}&${status}`,
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