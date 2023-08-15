console.log(localStorage.getItem("title"))


document.addEventListener('DOMContentLoaded', function() {


	var containerEl = document.getElementById('external-events-list');

	new FullCalendar.Draggable(containerEl, {
		itemSelector: '.fc-event',
		eventData: function(eventEl) {
			return {
				title: eventEl.innerText.trim(),
				start: '2023-01-12T08:00:00+03:00',
				end: '2023-01-12T19:00:00+03:00',
				allDay: 'false'
			}
		}
	});

	var calendarEl = document.getElementById('calendar1');
	var calendarE2 = document.getElementById('calendar2');
	var calendarE3 = document.getElementById('calendar3');
	var calendarE4 = document.getElementById('calendar4');
	var calendarE5 = document.getElementById('calendar5');
	var calendarE6 = document.getElementById('calendar6');
	var initialLocaleCode = 'ru';

	var calendar1 = new FullCalendar.Calendar(calendarEl, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'

		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar1.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
			}
			calendar1.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar1.render();


	var calendar2 = new FullCalendar.Calendar(calendarE2, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'
		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar2.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
				console.log(title)
				console.log(arg.startStr)
				console.log(arg.endStr)
				console.log(arg.allDay)
				console.log(arg)
				localStorage.setItem("title", title)
				localStorage.setItem("start", arg.startStr)
				localStorage.setItem("end", arg.endStr)
				localStorage.setItem("allDay", arg.allDay)
			}
			calendar2.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar2.render();

	var calendar3 = new FullCalendar.Calendar(calendarE3, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'
		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar3.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
				console.log(title)
				console.log(arg.startStr)
				console.log(arg.endStr)
				console.log(arg.allDay)
				console.log(arg)
				localStorage.setItem("title", title)
				localStorage.setItem("start", arg.startStr)
				localStorage.setItem("end", arg.endStr)
				localStorage.setItem("allDay", arg.allDay)
			}
			calendar3.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar3.render();


	var calendar4 = new FullCalendar.Calendar(calendarE4, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'
		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar3.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
				console.log(title)
				console.log(arg.startStr)
				console.log(arg.endStr)
				console.log(arg.allDay)
				console.log(arg)
				localStorage.setItem("title", title)
				localStorage.setItem("start", arg.startStr)
				localStorage.setItem("end", arg.endStr)
				localStorage.setItem("allDay", arg.allDay)
			}
			calendar4.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar4.render();


	var calendar5 = new FullCalendar.Calendar(calendarE5, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'
		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar3.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
				console.log(title)
				console.log(arg.startStr)
				console.log(arg.endStr)
				console.log(arg.allDay)
				console.log(arg)
				localStorage.setItem("title", title)
				localStorage.setItem("start", arg.startStr)
				localStorage.setItem("end", arg.endStr)
				localStorage.setItem("allDay", arg.allDay)
			}
			calendar5.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar5.render();




	var calendar6 = new FullCalendar.Calendar(calendarE6, {
		locale: initialLocaleCode,
		headerToolbar: {
			right: 'timeGridWeek,timeGridDay'
		},
		initialView: 'timeGridDay',
		firstDay: '1',
		buttonIcons: false,
		editable: true,
		initialDate: '2023-01-12',
		navLinks: true, // can click day/week names to navigate views
		selectable: true,
		dayMaxEvents: true,
		selectMirror: true,
		select: function(arg) {
			var title = prompt('Введите имя сотрудника:');
			if (title) {
				calendar3.addEvent({
					title: title,
					start: arg.start,
					end: arg.end,
					allDay: arg.allDay
				})
				console.log(title)
				console.log(arg.startStr)
				console.log(arg.endStr)
				console.log(arg.allDay)
				console.log(arg)
				localStorage.setItem("title", title)
				localStorage.setItem("start", arg.startStr)
				localStorage.setItem("end", arg.endStr)
				localStorage.setItem("allDay", arg.allDay)
			}
			calendar6.unselect()
		},
		eventClick: function(arg) {
			if (confirm('Уверены что хотите удалить евент?')) {
				arg.event.remove()
			}
		},
		editable: true,
		dayMaxEvents: true, // allow "more" link when too many events

		events: [
			{
				title: localStorage.getItem("title"),
				start: localStorage.getItem("start"),
				end: localStorage.getItem("end"),
			},
			{
				title: 'Ганна (мясо)',
				start: '2023-01-12T10:30:00',
				end: '2023-01-12T12:30:00'
			},
			{
				title: 'Тара',
				start: '2023-01-12T13:00:00'
			},
			{
				title: 'Ганна (яица)',
				start: '2023-01-12T14:30:00',
				end: '2023-01-12T15:00:00'
			}
		]
	});
	calendar6.render();
});

