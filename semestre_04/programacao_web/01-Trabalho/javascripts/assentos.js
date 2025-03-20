let filmeSelecionado = JSON.parse(sessionStorage.getItem('filmeSelecionado'));

if(filmeSelecionado){
    let filmeNome = document.getElementById('filme-nome');
    let filmeImagem = document.getElementById('filme-img');
    let filmeHorario = document.getElementById('filme-horario');
    let filmeTempo = document.getElementById('filme-tempo');
    let filmeSalas = document.getElementById('filme-salas');

    filmeImagem.src = filmeSelecionado.img;
    filmeNome.textContent = filmeSelecionado.titulo;
    filmeHorario.textContent = filmeSelecionado.horario;
    filmeTempo.textContent = filmeSelecionado.tempo;
    filmeSalas.textContent = filmeSelecionado.salas;
}

function selecionarAssento(assento, ID_Assento){
    if(assento.classList.contains('disponivel')){
        if(assento.classList.contains('selecionado')){
            assento.classList.remove('selecionado');
            assento.style.backgroundColor = '';
            sessionStorage.removeItem(ID_Assento);
        }else{
            assento.classList.add('selecionado');
            assento.style.backgroundColor = 'orange';
            sessionStorage.setItem(ID_Assento, 'selecionado');
        }
        atualizarDetalhes();
    }else{
        console.log('Este assento não está disponível.');
    }
}

function atualizarDetalhes(){
    let assentoSelecionado = [];
    for(let i = 0; i < sessionStorage.length; i++){
        let key = sessionStorage.key(i);
        if(sessionStorage.getItem(key) === 'selecionado'){
            assentoSelecionado.push(key);
        }
    }
    let precoTotal = assentoSelecionado.length*25;

    sessionStorage.setItem('ValorIngresso', precoTotal);

    if(precoTotal === 0){
        document.getElementsByClassName('preco')[0].innerHTML = '';
    }else
    document.getElementsByClassName('preco')[0].innerHTML = 'Total: R$' + precoTotal + ',00';
}

function confirmarSelecionado(){
    let assentoSelec = [];
    for (let i = 0; i < sessionStorage.length; i++){
        let key = sessionStorage.key(i);
        if(sessionStorage.getItem(key) === 'selecionado'){
            assentoSelec.push(key);
        }
        sessionStorage.setItem('assentoSelec', JSON.stringify(assentoSelec));
        window.location.href="aperitivos.html";
    }
}