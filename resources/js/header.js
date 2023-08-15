/**
 * 
 */
//window.onload = function() {
//	var ground = localStorage.getItem('ground');
//	var tumbler = document.querySelector('#flexSwitchCheckDefault');
//	if (ground = ! null && ground == "true") {
//		tumbler.checked = true;
//	} else {
//		tumbler.checked = false;
//	}
//
//	tumbler.addEventListener('change', (el)=>{
//		localStorage.setItem("ground", el.target.checked);
//	})
//}

var ground = localStorage.getItem('ground');
var tumbler = document.querySelector('#flexSwitchCheckDefaultHeader');
if (ground = ! null && ground == "true") {
	tumbler.checked = true;
} else {
	tumbler.checked = false;
}

tumbler.addEventListener('change', (el) => {
	localStorage.setItem("ground", el.target.checked);
})
