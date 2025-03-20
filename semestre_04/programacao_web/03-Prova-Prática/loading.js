
function loadCards() {
    fetch('card.html')
        .then(response => response.text())
        .then(data => {
            let allCards = '';
            for (let i = 0; i < 4; i++) {
                allCards += data;
            }
            document.getElementById('card-mainpage').innerHTML = allCards;
        });
}

document.addEventListener('DOMContentLoaded', loadCards);