var usersHasDepartment;
var workerDataList = document.querySelector('#workers');

//метод для заполнения списка сотрудников. Временно убрнал, т.к. не логично
//document.querySelector('#departmentsDiv').addEventListener('change', (el) => {
//	document.querySelector('#violation').value = null;
//	var requestText = el.target.value;
//	if (requestText != "") {
//		var xhr = new XMLHttpRequest();
//		xhr.open(
//			'GET',
//			`../../api/main/getWorkersHasDepartment/${requestText}`,
//			true
//		)
//		xhr.send()
//		xhr.onreadystatechange = function() {
//			if (xhr.readyState != 4) {
//				return
//			}
//
//			if (xhr.status === 200) {
//				var obj = JSON.parse(xhr.responseText);
//				usersHasDepartment = obj;
//				var options = workerDataList.querySelectorAll("option");
//					for (let i = 0; i < options.length; i++) {
//						options[i].remove();
//					}
//				obj.forEach(el => {
//					var option = document.createElement("option");
//					option.value = el.idUser
//					option.label = el.surname + " " + el.name + " " + el.patronymic
//					workerDataList.append(option);
//				})
//				if(obj != 0){
//					document.querySelector('input[id = worker]').disabled = false;
//				}else{
//					document.querySelector('input[id = worker]').value = null;
//					document.querySelector('input[id = worker]').disabled = true;
//					document.querySelector('#violation').value = null;
//					document.querySelector('#violation').disabled = true;
//				}
//			} else {
//				console.log('err', xhr.responseText)
//			}
//		}
//	}
//	document.querySelector('#worker').addEventListener('change', (el)=>{
//		if(el.target.value != ""){
//			document.querySelector('#violation').disabled = false;
//		}
//	})
//})

document.querySelector('#worker').addEventListener('change', (el) => {
	if (el.target.value != "") {
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/main/getUserById/${el.target.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {
				var obj = JSON.parse(xhr.responseText);
				document.querySelector('#departmentsDiv').value = obj.fullName;
			} else {
				console.log('err', xhr.responseText)
			}
		}

		document.querySelector('#violation').disabled = false;
	}
})

//костыль для подставления в input имени, вместо номера (отдельной input отправляем на сервак)
document.querySelector('#violation').addEventListener("change" , (el) =>{
	if (el.target.value != "") {		
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/main/getTypeViolationById/${el.target.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {				
				var obj = JSON.parse(xhr.responseText);	
				document.querySelector('#violationIsServer').value = el.target.value;			
				document.querySelector('#violation').value = obj.name;
				
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}
})

//костыль для подставления в input имени, вместо номера (отдельной input отправляем на сервак)
document.querySelector('#userHasShow').addEventListener("change" , (el) =>{
	if (el.target.value != "") {		
		var xhr = new XMLHttpRequest();
		xhr.open(
			'GET',
			`../../api/main/getUserById/${el.target.value}`,
			true
		)
		xhr.send()
		xhr.onreadystatechange = function() {
			if (xhr.readyState != 4) {
				return
			}

			if (xhr.status === 200) {				
				var obj = JSON.parse(xhr.responseText);	
				document.querySelector('#userHasShowInServer').value = el.target.value;			
				document.querySelector('#userHasShow').value = obj.fullName;
				
			} else {
				console.log('err', xhr.responseText)
			}
		}
	}
})


