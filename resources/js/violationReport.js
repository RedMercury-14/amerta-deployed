 
/**
 * https://www.daterangepicker.com/
 */
let dateStart = null;
let dateFinish = null;
window.onload = function() {
        $('input[id="dates"]').daterangepicker({
        "locale": {
            "format": "DD.MM.YYYY",
            "separator": " - ",
            "applyLabel": "Показать",
            "cancelLabel": "Отмена",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": [
                "Вс",
                "Пн",
                "Вт",
                "Ср",
                "Чт",
                "Пт",
                "Сб"
            ],
            "monthNames": [
                "Январь",
                "Февраль",
                "Март",
                "Апрель",
                "Май",
                "Июнь",
                "Июль",
                "Август",
                "Сентябрь",
                "Октябрь",
                "Ноябрь",
                "Декабрь"
            ],
            "firstDay": 1
        },
    }, function(start, end, label) {
        dateStart = start.format('YYYY-MM-DD');
        dateFinish = end.format('YYYY-MM-DD');
        getViolationsFromDB()
    });
}
 
function getViolationsFromDB() {
    var table = document.querySelector('#table');
    var tbody = table.querySelector('#tbody');
    var trs = tbody.querySelectorAll('tr');
    trs.forEach(el=>{
        el.remove();
    })
    if (dateStart != null && dateFinish != null) {
        var xhr = new XMLHttpRequest();
        xhr.open(
            'GET',
            `../../api/security/getViolationHasUsersList/0&${dateStart}&${dateFinish}`,
            true
        )
        xhr.send()
        xhr.onreadystatechange = function() {
            if (xhr.readyState != 4) {
                return
            }
 
            if (xhr.status === 200 && xhr.responseText != '') {
                document.querySelector('#message').innerHTML = null;
                var obj = JSON.parse(xhr.responseText);
                table.style.display = "";
                
                obj.forEach(el => {
                    var tr = document.createElement('tr')
                    tr.id = el.idViolationHasUser;
                    var td0 = document.createElement('td')
                    td0.innerHTML = el.dateViolationStr;
                    var td1 = document.createElement('td');
                    td1.innerHTML = el.dateCreateStr;
                    var td2 = document.createElement('td')
                    td2.innerHTML = el.userHasTarget.fullName;
                    var td3 = document.createElement('td')//подразделение
                    td3.innerHTML = el.userHasTarget.department.name;
                    var td4 = document.createElement('td')
                    td4.innerHTML = el.userHasTarget.department.head;
                    var td5 = document.createElement('td')
                    if(el.violationHasUser.value == null){
//                        td5.innerHTML = el.violationHasUser.name  +' (Сумма боя : ' + el.breakage + ' BYN)';//классификация and Размер депремирования предусмотренный Регламентом
                        td5.innerHTML = `${el.violationHasUser.name} <p>(Сумма боя : ${el.breakage} BYN)</p>`;//классификация and Размер депремирования предусмотренный Регламентом
                    }else{
                        td5.innerHTML = el.violationHasUser.name + ' ('+el.violationHasUser.value+' BYN)'; //классификация and Размер депремирования предусмотренный Регламентом
                    }
                    var td6 = document.createElement('td')
                    td6.innerHTML = el.comment; //Суть нарушения
                    var td7 = document.createElement('td')
                    td7.innerHTML = el.userHasShow.fullName; //ФИО охранника, выявившего нарушение
                    var td8 = document.createElement('td')
                    td8.innerHTML = el.userHasCreate.fullName; //Внёс нарушение в программу
                    var td9 = document.createElement('td')
                    if(el.proofHTML == false && el.proofComment == null){
                        td9.innerHTML = 'На рассмотрении руководителем';
                    }else if(el.proofHTML == false && el.proofComment != null){
                        td9.innerHTML = 'Предупреждение';
                    }else if(el.proofHTML == true){
                        td9.innerHTML = 'К удержанию ' + el.violationHasUser.value + " BYN";
                    }
                    var td10 = document.createElement('td')
                    var text = el.proofComment
                    if(text == null){
                        td10.innerHTML = 'На рассмотрении руководителем'; //Последний изменивший решения
                    }else if(text != null && text.split("&").length == 1){
                        td10.innerHTML = 'Изминений не проводилось'; //Последний изменивший решения
                    }else if(text != null && text.split("&").length > 1){
                        var mass = text.split("&");
                        td10.innerHTML = mass[mass.length-1]; //Последний изменивший решения
                    }
                    
                    
                    
                    tr.append(td0);
                    tr.append(td1);
                    tr.append(td2);
                    tr.append(td3);
                    tr.append(td4);
                    tr.append(td5);
                    tr.append(td6);
                    tr.append(td7);
                    tr.append(td8);
                    tr.append(td9);
                    tr.append(td10);
                    tbody.append(tr);
                })
            } else {
                table.style.display = 'none';
                document.querySelector('#message').innerHTML = "Нарушений не найдено.";
                console.log('err', xhr.responseText) // обработка прихода null
            }
        }
    }
}
 
