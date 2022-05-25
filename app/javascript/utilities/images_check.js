document.addEventListener('turbolinks:load', function() {
	if (document.querySelector('.checked-image-container')) { checkImages() }
})

function checkImages() {
	let checkedImageContainers = document.querySelectorAll('.checked-image-container')
	if (checkedImageContainers.length) {
		for (var i = 0; i < checkedImageContainers.length; i++) {
			checkedImage = checkedImageContainers[i].querySelector('img')
			checkedImage.onerror = function () { this.src = '/errors/images/no-image-error.svg' }
		}
	}
}
