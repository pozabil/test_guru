document.addEventListener('turbolinks:load', function() {
	let container = document.querySelector('.rule-selector-container')
	if (container) {
		ruleConditionSwitcher(container)
		ruleConditionLevelChecker(container)
		let ruleSelector = container.querySelector('.rule-selector')
		if (ruleSelector) {
			ruleSelector.addEventListener('change', function() { ruleConditionSwitcher(container) })
		}
	}
})

function ruleConditionSwitcher(ruleContainer) {
	let ruleType = ruleContainer.querySelector('.rule-selector').value
	let ruleConditionCategory = ruleContainer.querySelector('.rule-condition-category-selector')
	let ruleConditionLevel = ruleContainer.querySelector('.rule-condition-level-field')

	if (ruleType == 'success_by_category') {
		if (ruleConditionCategory) {
			ruleConditionCategory.disabled = false
			ruleConditionCategory.classList.remove('d-none')
		}
		if (ruleConditionLevel) {
			ruleConditionLevel.disabled = true
			ruleConditionLevel.classList.add('d-none')
			ruleConditionLevel.value = '0'
		}
	} else if (ruleType == 'success_by_level') {
		if (ruleConditionCategory) {
			ruleConditionCategory.disabled = true
			ruleConditionCategory.classList.add('d-none')
			ruleConditionCategory.value = 'back-end'
		}
		if (ruleConditionLevel) {
			ruleConditionLevel.disabled = false
			ruleConditionLevel.classList.remove('d-none')
		}
	} else {
		if (ruleConditionCategory) {
			ruleConditionCategory.disabled = true
			ruleConditionCategory.classList.add('d-none')
			ruleConditionCategory.value = 'back-end'
		}
		if (ruleConditionLevel) {
			ruleConditionLevel.disabled = true
			ruleConditionLevel.classList.add('d-none')
			ruleConditionLevel.value = '0'
		}
	}
}

function ruleConditionLevelChecker(ruleContainer) {
	let ruleConditionLevel = ruleContainer.querySelector('.rule-condition-level-field')

	ruleConditionLevel.addEventListener('change', function() { naturalNumberCheck(ruleConditionLevel) })
}

function naturalNumberCheck(numberField){
	let digitRegex = /^\d+$/
	if (!digitRegex.test(numberField.value)) { numberField.value = 0}
}
