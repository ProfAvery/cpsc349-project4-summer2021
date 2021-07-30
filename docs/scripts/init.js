const searchForm = document.querySelector('#search')
const keyword = document.querySelector('#keyword')

const resultDiv = document.querySelector('#results')
const result = document.querySelector('#result-value')

function search (term = '') {
  const query = encodeURIComponent(`%%${term}%%`)
  fetch(`http://localhost:5000/posts/?text=${query}`)
    .then(response => response.json())
    .then(data => {
      if (!term) {
        resultDiv.hidden = true
      } else {
        resultDiv.hidden = false
        result.textContent = JSON.stringify(data.resources, null, 2)
      }
    })
}

searchForm.addEventListener('submit', (event) => {
  event.preventDefault()
})

keyword.addEventListener('input', (event) => {
  search(keyword.value)
})
