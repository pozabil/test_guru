document.addEventListener('turbolinks:load', function() {
	if (document.querySelector('.form-inline')) {
		let errors = document.querySelector('.resource-errors')
		if (errors) { formInlineHandler(errors.dataset.resourceId) }

		let controls = document.querySelectorAll('.form-inline-link')
		if (controls.length) {
			for (var i = 0; i < controls.length; i++) {
				controls[i].addEventListener('click', formInlineLinkHandler)
			}
		}
	}
})

function formInlineLinkHandler(event) {
	event.preventDefault()
	let testId = this.dataset.testId
	formInlineHandler(testId)
}

function formInlineHandler(testId) {
	let link = document.querySelector(`.form-inline-link[data-test-id="${testId}"]`)
	let testTitle = document.querySelector(`.test-title[data-test-id="${testId}"]`)
	let formInline = document.querySelector(`.form-inline[data-test-id="${testId}"]`)

	if (formInline.classList.contains('d-none')) {
		formInline.classList.remove('d-none')
		testTitle.classList.add('d-none')
		link.textContent = link.dataset.cancelText
	} else {
		formInline.classList.add('d-none')
		testTitle.classList.remove('d-none')
		link.textContent = link.dataset.editText
	}
}
