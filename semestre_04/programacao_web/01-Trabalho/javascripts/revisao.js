let filmeSelecionado = JSON.parse(sessionStorage.getItem("filmeSelecionado"));
let assentosSelecionado = JSON.parse(sessionStorage.getItem("assentoSelec"));
let ingressoPreco = sessionStorage.getItem("ValorIngresso");

let filme = document.getElementById("filme-selecionado");
let assentos = document.getElementById("assentos-selecionado");
let preco = document.getElementById("ingresso-preco");

filme.textContent = filmeSelecionado.titulo;
assentos.textContent = assentosSelecionado;
preco.textContent = "R$" + ingressoPreco + ",00";

function adicionarProdutoTabela(){
        let total = 0;
    let produtos = JSON.parse(sessionStorage.getItem("produtosComprados"));
    var corpoTabela = document.querySelector("#tabelaProdutos tbody");
    if(produtos.length > 0){
        produtos.forEach((produto) => {
            var novaLinha = document.createElement("tr");
            novaLinha.innerHTML = `
            <td>${produto.nome}</td>
            <td>${produto.quantidade}</td>
            <td>R$${produto.preco},00</td>
            <td>R$${produto.preco * produto.quantidade},00</td>
        `;
        corpoTabela.appendChild(novaLinha);
        total += produto.preco * produto.quantidade;
        });
    }else{
        document.getElementById('tabelaProdutos').style.display = "none";
    }
    total += parseInt(ingressoPreco);
    document.getElementById('preco-total').textContent = 'R$ ' + total + ',00';
}


document.getElementById('confirmar-btn').addEventListener('click', function(){
    window.location.href="main.html";
    alert('Pedido Confirmado!');
    sessionStorage.clear();
});

adicionarProdutoTabela();
