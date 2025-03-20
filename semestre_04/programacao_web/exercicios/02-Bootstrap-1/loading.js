function loadNavbar() {
    fetch('navbar.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('navbar-mainpage').innerHTML = data;
        });
}

function loadCarousel() {
    fetch('carousel.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('carousel-mainpage').innerHTML = data;
        });
}

function loadMinicards() {
    fetch('minicard.html')
        .then(response => response.text())
        .then(data => {
            let allMinicards = '';
            for (let i = 0; i < 5; i++) {
                allMinicards += data;
            }
            document.getElementById('minicards-mainpage').innerHTML = allMinicards;
        });
}

function loadCards() {
    fetch('card.html')
        .then(response => response.text())
        .then(data => {
            let allCards = '';
            for (let i = 0; i < 6; i++) {
                allCards += `<div class="col-md-4">${data}</div>`;
            }
            document.getElementById('card-mainpage').innerHTML = allCards;
        });
}

document.addEventListener('DOMContentLoaded', loadNavbar);
document.addEventListener('DOMContentLoaded', loadCarousel);
document.addEventListener('DOMContentLoaded', loadMinicards);
document.addEventListener('DOMContentLoaded', loadCards);