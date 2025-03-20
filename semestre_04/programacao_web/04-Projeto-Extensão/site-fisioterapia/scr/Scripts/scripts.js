// Função para carregar o cabeçalho do site dinamicamente
function loadHeader() {
    fetch('Componentes/header.html') // Busca o arquivo HTML do cabeçalho
        .then(response => response.text()) // Converte a resposta para texto
        .then(data => {
            // Insere o conteúdo do cabeçalho no elemento com ID 'header-placeholder'
            document.getElementById('header-placeholder').innerHTML = data;
        });
}

// Função para carregar o carrossel dinamicamente
function loadCarousel() {
    fetch('Componentes/carousel.html') // Busca o arquivo HTML do carrossel
        .then(response => response.text()) // Converte a resposta para texto
        .then(data => {
            // Insere o conteúdo do carrossel no elemento com ID 'carousel-mainpage'
            document.getElementById('carousel-mainpage').innerHTML = data;
        });
}

// Função para carregar os cards dinamicamente
function loadCards() {
    fetch('Componentes/card.html') // Busca o arquivo HTML dos cards
        .then(response => response.text()) // Converte a resposta para texto
        .then(data => {
            let initialCards = ''; // Armazena os cards iniciais visíveis
            let hiddenCards = ''; // Armazena os cards ocultos

            for (let i = 1; i <= 1; i++) { // Itera para criar cards (atualmente limitado a 1)
                if (i <= 1) {
                    initialCards += data; // Adiciona o card ao conjunto inicial
                } else {
                    // Adiciona o card ao conjunto oculto, com a classe 'd-none'
                    hiddenCards += `<div class="conteudo-escondido d-none">${data}</div>`;
                }
            }

            // Insere os cards visíveis e ocultos no elemento com ID 'card-mainpage'
            document.getElementById('card-mainpage').innerHTML = initialCards + hiddenCards;
        });
}

// Carrega o carrossel ao carregar o DOM
document.addEventListener('DOMContentLoaded', loadCarousel);

// Carrega os cards ao carregar o DOM
document.addEventListener('DOMContentLoaded', loadCards);

// Carrega o cabeçalho ao carregar o DOM
document.addEventListener('DOMContentLoaded', loadHeader);

// Adiciona comportamento ao botão "Ver Mais / Ver Menos"
document.addEventListener("DOMContentLoaded", function () {
    const toggleButton = document.getElementById("toggleConteudo"); // Seleciona o botão

    toggleButton.addEventListener("click", function () {
        const hiddenCards = document.querySelectorAll(".conteudo-escondido"); // Seleciona todos os cards ocultos

        hiddenCards.forEach(card => {
            // Alterna a visibilidade dos cards ocultos
            card.classList.toggle("d-none");
        });

        // Atualiza o texto do botão com base na visibilidade dos cards
        toggleButton.textContent = hiddenCards[0].classList.contains("d-none") ? "Ver Mais +" : "Ver Menos -";
    });
});

// Adiciona comportamento para exibir e ocultar vídeos
document.addEventListener("DOMContentLoaded", function () {
    // Escuta cliques no body para verificar se um botão de vídeo foi clicado
    document.body.addEventListener("click", function (event) {
        // Verifica se o clique foi em um botão com a classe 'show-video-btn'
        if (event.target && event.target.classList.contains("show-video-btn")) {
            const button = event.target; // Botão clicado
            const cardBody = button.closest(".card-body"); // Seleciona o card correspondente
            const video = cardBody.querySelector(".exercise-video"); // Seleciona o vídeo dentro do card
            const description = cardBody.querySelector(".card-text"); // Seleciona a descrição do card

            if (video.classList.contains("d-none")) {
                // Exibe o vídeo e oculta a descrição
                video.classList.remove("d-none");
                description.classList.add("d-none");
                button.textContent = "Ocultar Vídeo"; // Altera o texto do botão

                // Move o botão para baixo do vídeo
                cardBody.appendChild(button);
            } else {
                // Oculta o vídeo e exibe a descrição
                video.classList.add("d-none");
                description.classList.remove("d-none");
                button.textContent = "Ver Vídeo"; // Altera o texto do botão

                // Move o botão de volta para cima
                cardBody.insertBefore(button, video);
            }
        }
    });
});
