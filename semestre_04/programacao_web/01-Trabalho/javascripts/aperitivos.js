function calcularTotal(){
    let total = 0;
    document.querySelectorAll('.produto').forEach(function(produto){
        const preco = parseFloat(produto.querySelector('.preco').textContent.replace('R$ ', '').replace(',','.'));
        const quantidade = parseInt(produto.querySelector('.quantidade').value);
        total += preco * quantidade;
    });
    document.getElementById('total').textContent = 'R$ ' + total.toFixed(2).replace('.', ',');
    return total;
}

// event para cada input
document.querySelectorAll('.quantidade').forEach(function(produto){
    produto.addEventListener('input', function(){
        calcularTotal();
    });
});

// Inicia o calculo inicial ao carregar a pagina
calcularTotal();

function armazenarProdutosComprados(){
    const produtosComprados = [];
    document.querySelectorAll('.produto').forEach(function(produto){
        const nome = produto.querySelector('.produto-nome').textContent;
        const preco = parseFloat(produto.querySelector('.preco').textContent.replace('R$ ', '').replace(',', '.'));
        const quantidade = parseInt(produto.querySelector('.quantidade').value);
        if(quantidade > 0){
            produtosComprados.push({
                nome: nome,
                preco: preco,
                quantidade: quantidade
            });
        }
    });
    sessionStorage.setItem('produtosComprados', JSON.stringify(produtosComprados));
}

document.getElementById('confirmar-btn').addEventListener('click', function(){
    window.location.href="pagamento.html";
    armazenarProdutosComprados();
    sessionStorage.setItem('totalAperitivos', calcularTotal())
});