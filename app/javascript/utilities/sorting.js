document.addEventListener('turbolinks:load', function() {
	let control = document.querySelector('.sort-by-title')
	if (control) { control.addEventListener('click', sortRowsByTitle) }
})

function sortRowsByTitle() {
	let table = document.querySelector('table')
	let tbody = table.querySelector('tbody')
	let rows = tbody.querySelectorAll('tr')
	let sortedRows =[]

	for (let i = 1; i < rows.length; i++) {
		sortedRows.push(rows[i])
	}

	let sortAscIcon = this.querySelector('.octicon-sort-asc')
	let sortDescIcon = this.querySelector('.octicon-sort-desc')

	sortedRows.sort(compareRowsAsc)
	if (sortAscIcon.classList.contains('d-none')) {
		sortedRows.sort(compareRowsAsc)
		sortAscIcon.classList.remove('d-none')
		sortDescIcon.classList.add('d-none')
	} else {
		sortedRows.sort(compareRowsDesc)
		sortAscIcon.classList.add('d-none')
		sortDescIcon.classList.remove('d-none')
	}

	let sortedTbody = document.createElement('tbody')
	sortedTbody.appendChild(rows[0])

	for (let i = 0; i < sortedRows.length; i++) {
		sortedTbody.appendChild(sortedRows[i])
	}

	table.replaceChild(sortedTbody, tbody)
}

function compareRowsAsc(row1, row2) {
	let title1 = row1.querySelector('.td-sort').textContent
	let title2 = row2.querySelector('.td-sort').textContent

	if (title1 < title2) { return -1 }
	if (title1 > title2) { return 1 }
	return 0
}

function compareRowsDesc(row1, row2) {
	let title1 = row1.querySelector('.td-sort').textContent
	let title2 = row2.querySelector('.td-sort').textContent

	if (title1 < title2) { return 1 }
	if (title1 > title2) { return -1 }
	return 0
}
