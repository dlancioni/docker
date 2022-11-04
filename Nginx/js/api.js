function ler(div) {

    fetch('https://api.github.com/repos/javascript-tutorial/en.javascript.info/commits', {
        headers: {
            //Authentication: 'secret'
        }
    })
    .then(response => response.json())
    .then(commits => document.getElementById(div).innerHTML = commits[0].author.login)
}

function addComponent(page, div) {
    fetch('./' + page)
    .then(response => {
      return response.text()
    })
    .then(data => {
      document.getElementById(div).innerHTML = data;
    });
}