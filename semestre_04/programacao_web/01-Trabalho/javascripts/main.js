let popup = document.getElementById("popup-tela");
let span = document.getElementsByClassName("fechar")[0];
let filmeSelecionado = null;

function mostrarDetalhesFilme(titulo, img, sinopse, horario, tempo, salas){
    filmeSelecionado = {titulo, img, sinopse, horario, tempo, salas};

    document.getElementById("titulo-filme").innerHTML = titulo;
    document.getElementById("sinop").innerHTML = sinopse;
    document.getElementById("horario").innerHTML = horario;
    document.getElementById("salas").innerHTML = salas;
    popup.classList.add("mostrar-popup");
}

span.onclick = function(){
    popup.classList.remove("mostrar-popup");
}

window.onclick = function(event){
    if(event.target == popup){
        popup.classList.remove("mostrar-popup");;
    }
}

document.getElementById("confirmar-btn").onclick = function(){
    if(filmeSelecionado){
        sessionStorage.setItem("filmeSelecionado", JSON.stringify(filmeSelecionado));
    }
    window.location.href="assentos.html";
}