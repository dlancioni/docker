
function callapi(page, form, div) {

    const data = new URLSearchParams();
    for (const pair of new FormData(form)) {
        data.append(pair[0], pair[1]);
    }

    fetch(page, {method:'post', body:data})
    .then(response => {
        return response.json()
    })
    .then(data => {
        document.getElementById(div).innerHTML = "-> " + data.name;
    });
}