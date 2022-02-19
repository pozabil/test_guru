document.addEventListener('turbolinks:load', function() {
	let control = document.querySelector('.autoloaded-image-path')
	if (control) { checkImageAutoload(control) }
})

function checkImageAutoload(control) {
	let autoloadedImageContainer = document.querySelector('.autoloaded-image-container')
	let autoloadedImage = autoloadedImageContainer.querySelector('.autoloaded-image')
	let oldImage = autoloadedImage.querySelector('img')

	oldImage.onerror = function () { this.src = '/errors/images/no-image-error.svg' }

	control.addEventListener('blur', function() { imageAutoload(control, autoloadedImage) })
}

function imageAutoload(imagePathInput, autoloadedImage) {
	let oldImage = autoloadedImage.querySelector('img')

	let updatedImagePath = imagePathInput.value.trim()
	let updatedImage = document.createElement('img')

	updatedImage.src = updatedImagePath
	updatedImage.width = "64"
	updatedImage.height = "64"
	autoloadedImage.replaceChild(updatedImage, oldImage)

	updatedImage.onerror = function () { this.src = '/errors/images/no-image-error.svg' }
}
