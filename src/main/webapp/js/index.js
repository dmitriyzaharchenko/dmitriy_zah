function closem(id) {
    $(id).modal('hide');
}

function register() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'main', true);
    xhr.send();

    xhr.onreadystatechange = function() {
        if (xhr.readyState != 4) return;
        if (xhr.status != 200) {
            alert(xhr.status + ': ' + xhr.statusText);
        } else {
            alert(xhr.responseText);
        }
    }

}