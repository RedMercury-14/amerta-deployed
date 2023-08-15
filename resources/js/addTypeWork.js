var ch1 = document.querySelector('#ch1');
var inputCh1 = document.querySelector('#rate');
var ch2 = document.querySelector('#ch2');
var inputCh2 = document.querySelector('#coefficient');
//опредиляем элементы доп работы
var count = document.querySelector('#count');
var costCount = document.querySelector('#costCount');
var weight = document.querySelector('#weight');
var costWeight = document.querySelector('#costWeight');
var stickers = document.querySelector('#stickers');
var costSticker = document.querySelector('#costSticker');
var pallets = document.querySelector('#pallets');
var costPallet = document.querySelector('#costPallet');

ch1.addEventListener('change', (el)=>{
	if(el.target.checked){
		inputCh1.disabled = false;
		ch2.checked = false;
		inputCh2.disabled = true;
		inputCh2.value = null;
	}else{
		inputCh1.disabled = true;
		inputCh1.value = null;
	}
});

ch2.addEventListener('change', (el)=>{
	if(el.target.checked){
		inputCh2.disabled = false;
		ch1.checked = false;
		inputCh1.disabled = true;
		inputCh1.value = null;
	}else{
		inputCh2.disabled = true;
		inputCh2.value = null;
	}
});

count.addEventListener('change', (el)=>{
	if(el.target.checked){
		costCount.disabled = false;
	}else{
		costCount.disabled = true;
	}
});

weight.addEventListener('change', (el)=>{
	if(el.target.checked){
		costWeight.disabled = false;
	}else{
		costWeight.disabled = true;
	}
});

stickers.addEventListener('change', (el)=>{
	if(el.target.checked){
		costSticker.disabled = false;
	}else{
		costSticker.disabled = true;
	}
});

pallets.addEventListener('change', (el)=>{
	if(el.target.checked){
		costPallet.disabled = false;
	}else{
		costPallet.disabled = true;
	}
});