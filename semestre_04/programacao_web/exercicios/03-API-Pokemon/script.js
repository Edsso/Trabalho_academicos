async function fetchPokemons() {
    const response = await fetch('https://pokeapi.co/api/v2/pokemon/?limit=50');
    const data = await response.json();
    const pokemonList = document.getElementById('pokemon-list');

    data.results.forEach(async (pokemon) => {
        const pokemonResponse = await fetch(pokemon.url);
        const pokemonData = await pokemonResponse.json();

        const card = document.createElement('div');
        card.className = 'col-md-4 mb-4';
        card.innerHTML = `
                <div class="card">
                    <img src="${pokemonData.sprites.front_default}" class="card-img-top" alt="${pokemonData.name}">
                    <div class="card-body">
                        <h5 class="card-title">${pokemonData.name.charAt(0).toUpperCase() + pokemonData.name.slice(1)}</h5>
                        <p class="card-text">ID: ${pokemonData.id}</p>
                    </div>
                </div>
            `;
        pokemonList.appendChild(card);
    });
}

fetchPokemons();
