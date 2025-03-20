import React from "react";
import "./ListaDePokemons.css";

const pokemons = {
  "Geração I": [
    { name: "Bulbasaur", description: "Pokémon planta do tipo grama." },
    { name: "Charmander", description: "Pokémon de fogo." },
    { name: "Squirtle", description: "Pokémon de água." },
  ],
  "Geração II": [
    { name: "Chikorita", description: "Pokémon planta." },
    { name: "Cyndaquil", description: "Pokémon de fogo." },
    { name: "Totodile", description: "Pokémon de água." },
  ],
  "Geração III": [
    { name: "Treecko", description: "Pokémon planta." },
    { name: "Torchic", description: "Pokémon de fogo." },
    { name: "Mudkip", description: "Pokémon de água." },
  ],
};

const ListaPokemon = () => {
  return (
    <div className="lista-pokemons">
      {Object.entries(pokemons).map(([geracao, pokemons]) => (
        <div key={geracao} className="geracao">
          <h2>{geracao}:</h2>
          <div className="cards">
            {pokemons.map((pokemon) => (
              <div key={pokemon.name} className="card">
                <h3>{pokemon.name}</h3>
                <p>{pokemon.description}</p>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
};

export default ListaPokemon;
