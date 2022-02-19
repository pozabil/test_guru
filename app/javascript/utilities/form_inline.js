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
	let resourceId = this.dataset.resourceId
	formInlineHandler(resourceId)
}

function formInlineHandler(resourceId) {
	let link = document.querySelector(`.form-inline-link[data-resource-id="${resourceId}"]`)
	let resourceTitle = document.querySelector(`.resource-title[data-resource-id="${resourceId}"]`)
	let formInline = document.querySelector(`.form-inline[data-resource-id="${resourceId}"]`)

	if (formInline.classList.contains('d-none')) {
		formInline.classList.remove('d-none')
		resourceTitle.classList.add('d-none')
		link.textContent = link.dataset.cancelText
	} else {
		formInline.classList.add('d-none')
		resourceTitle.classList.remove('d-none')
		link.textContent = link.dataset.editText
	}
}
