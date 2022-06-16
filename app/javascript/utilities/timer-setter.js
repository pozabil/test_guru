document.addEventListener('turbolinks:load', function() {
	if (document.querySelector('.timer-setter-container')) {
		let timerCheckbox = document.getElementById('test_timer_checkbox')
		let timerField = document.getElementById('test_timer')
		let submitButton = document.getElementById('submit_button')

		timerCheckboxAutoSetter(timerCheckbox, timerField)
		timerSetter(timerCheckbox, timerField)
		if (timerCheckbox) {
			timerCheckbox.addEventListener('change', function() { timerSetter(timerCheckbox, timerField) })
		}
		if (submitButton) {
			submitButton.addEventListener('click', function() { submitTimer(timerCheckbox, timerField) })
		}
	}
})

function timerCheckboxAutoSetter(timerCheckbox, timerField) {
	if (parseInt(timerField.value, 10) > 0) {
		timerCheckbox.checked = true
	}
}

function timerSetter(timerCheckbox, timerField) {
	let minutesText = document.getElementById('test_minutes_text')

	if (timerCheckbox.checked) {
		timerField.classList.remove('d-none')
		minutesText.classList.remove('d-none')
	} else {
		timerField.classList.add('d-none')
		minutesText.classList.add('d-none')
	}
}

function submitTimer(timerCheckbox, timerField) {
	if (timerCheckbox.checked == false) {
		timerField.value = '0'
	}
}
