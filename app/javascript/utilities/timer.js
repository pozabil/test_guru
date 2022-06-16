document.addEventListener('turbolinks:load', function() {
	let timerContainer = document.querySelector('.test-timer-container')
	if (timerContainer) {
		let timerValue = timerContainer.querySelector('.test-timer').dataset.testTimer
		if (timerValue > 0) { timer(timerContainer) }
	}
})

function timer(timerContainer) {
	let timeleftInMinutes = timerContainer.querySelector('.test-timer').dataset.testTimerLeft
	let timerZone = timerContainer.querySelector('.test-timer')
	timerContainerSwitcher(timerContainer)
	changeTimerColor(timeleftInMinutes, timerZone)
	startTimer(timeleftInMinutes, timerZone)
}

function timerContainerSwitcher(timerContainer) {
	timerContainer.classList.remove('d-none')
}

function startTimer(timeleftInMinutes, timerZone) {
	timerZone.textContent = timerText(timeleftInMinutes)
	let timerInterval = setInterval(() => { timeleftInMinutes = updateTimer(timeleftInMinutes, timerZone) }, 1000)
	setTimeout(() => {
		clearInterval(timerInterval)
		setCompleted(timerZone)
	}, timeleftInMinutes*60*1000)
}

function updateTimer(timeleftInMinutes, timerZone) {
	timeleftInMinutes -= 1/60
	changeTimerColor(timeleftInMinutes, timerZone)
	timerZone.textContent = timerText(timeleftInMinutes)
	return timeleftInMinutes
}

function changeTimerColor(timeleftInMinutes, timerZone) {
	if (timeleftInMinutes < 1/3 && timerZone.classList.contains('text-success')) {
		timerZone.classList.remove('text-success')
		timerZone.classList.add('text-danger')
	}
}

function timerText(timeleftInMinutes) {
	let minutes = Math.floor(timeleftInMinutes)
	let seconds = Math.trunc((timeleftInMinutes % 1)*60)
	return `${correctNumberText(minutes)}:${correctNumberText(seconds)}`
}

function correctNumberText(number) {
	if (number < 10) {
		number = `0${number}`
	}
	return number
}

function setCompleted(timerZone) {
	document.querySelector('[type=submit]').disabled = true
	window.location.reload()
}
