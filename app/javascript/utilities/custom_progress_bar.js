document.addEventListener('turbolinks:load', function() {
	let progressBar = document.querySelector('.custom-progress-bar')
	if (progressBar) { fillProgressBar(progressBar) }
})

function fillProgressBar(progressBar) {
	let bar = document.createElement('b')
	let currentQuestionNumber = progressBar.dataset.currentQuestionNumber
	let totalQuestionNumbers = progressBar.dataset.totalQuestionNumbers
	let progress = ((currentQuestionNumber/totalQuestionNumbers)*100).toFixed()

	bar.textContent = `${currentQuestionNumber}/${totalQuestionNumbers}`
	bar.style.display = 'inline-block'
	bar.style.width = '100%'
	bar.style.textAlign = 'center'
	bar.style.background = `linear-gradient(to right, rgba(13, 110, 253, 0.666) ${progress}%, #ffffff ${progress}%)`

	progressBar.appendChild(bar)
}
