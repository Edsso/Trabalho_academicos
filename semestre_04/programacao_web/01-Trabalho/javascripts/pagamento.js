document.getElementById('pagamentoForm').addEventListener('submit', function(e){
    e.preventDefault();
    
    window.location.href="revisao.html";
    
    var nome = document.getElementById('nome').value.trim();
    var cartaoNumero = document.getElementById('cartaoNumero').Value.trim();
    var dataExpirada = document.getElementById('dataExpirada').value.trim();
    var cvv = document.getElementById('cvv').value.trim();

    if(!/^\d{12,19}$/.test(cartaoNumero)){
        alert("Por favor, insira um número de cartão válido.");
        return;
    }

    var dataAtual = new Date();
    var anoAtual = dataAtual.getFullYear() % 100;
    var mesAtual = dataAtual.getMonth() + 1;
    var [mesExpirado, anoExpirado] = dataExpirada.split("/");
    mesExpirado = parseInt(mesExpirado, 10);
    anoExpirado = parseInt(anoExpirado, 10);

    if(
        !/^\d{2}\/\d{2}$/.test(dataExpirada) ||
        mesExpirado < 1 || mesExpirado > 12 || anoExpirado < anoAtual ||
        (anoExpirado === anoAtual && mesExpirado < mesAtual)
    ){
        alert("Por favor, insira uma data de validade válida no formato MM/YY.")
        return;
    }

    if(!/^\d{3,4}$/.test(cvv)){
        alert("Por favor, insira um CVV válido.");
        return;
    }

    alert("Pagamento confirmado!");

    sessionStorage.setItem("nome", JSON.stringify(nome));
    sessionStorage.setItem("cartaoNumero", JSON.stringify(cartaoNumero));
    sessionStorage.setItem("dataValidade", JSON.stringify(dataExpirada));
    sessionStorage.setItem("cvv", JSON.stringify(cvv));
});