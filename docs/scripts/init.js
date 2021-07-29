const searchForm = document.querySelector('#search')
const keyword = document.querySelector('#keyword')
const results = document.querySelector('#results')
const resultValue = document.querySelector('#result-value')

function search (term = '') {
  const query = encodeURIComponent(`%%${term}%%`)
  fetch(`http://localhost:5000/posts/?text=${query}`)
    .then(response => response.json())
    .then(data => {
      resultValue.textContent = JSON.stringify(data.resources, null, 2)
      results.hidden = false
    })
}

window.addEventListener('load', (event) => {
  search()
})

searchForm.addEventListener('submit', (event) => {
  search(keyword.value)
  event.preventDefault()
})
