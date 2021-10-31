document.addEventListener('turbolinks:load', function() {
	let control = document.querySelector('.account_settings_form')
	if (control) { passwordComparison() }
})

function passwordComparison() {
	let password = document.getElementById('user_password')
	let passwordConfirmation = document.getElementById('user_password_confirmation')

	password.addEventListener('input', function() { fieldCompare(password, passwordConfirmation) })
	passwordConfirmation.addEventListener('input', function() { fieldCompare(password, passwordConfirmation) })
}

function fieldCompare(field1, fieldConfirmation) {
	if (!fieldConfirmation.value) {
		fieldConfirmation.classList.remove('border-danger', 'border-success', 'border-2')
	} else if (field1.value == fieldConfirmation.value) {
		fieldConfirmation.classList.remove('border-danger')
		fieldConfirmation.classList.add('border-success', 'border-2')
	} else {
		fieldConfirmation.classList.add('border-danger', 'border-2')
		fieldConfirmation.classList.remove('border-success')
	}
}
