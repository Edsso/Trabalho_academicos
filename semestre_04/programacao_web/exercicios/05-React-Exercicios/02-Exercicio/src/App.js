import React, { useState } from "react";
import "./App.css";

function ContadorCaracteres() {
  // Estado para armazenar o texto digitado
  const [texto, setTexto] = useState("");
  // Estado para armazenar a mensagem de limite excedido
  const [limiteExcedido, setLimiteExcedido] = useState(false);

  // Limite de caracteres
  const limiteCaracteres = 100;

  // Função para manipular a entrada do usuário
  const handleChange = (event) => {
    const textoDigitado = event.target.value;
    setTexto(textoDigitado);
    setLimiteExcedido(textoDigitado.length > limiteCaracteres);
  };

  return (
    <div style={{ textAlign: "center", marginTop: "20px" }}>
      <h2>Contador de Caracteres</h2>
      <textarea
        value={texto}
        onChange={handleChange}
        placeholder="Digite seu texto aqui..."
        rows="4"
        cols="50"
        style={{
          borderColor: limiteExcedido ? "red" : "black",
          borderWidth: "2px",
          padding: "10px",
          fontSize: "16px",
        }}
      />
      <p>
        Caracteres: {texto.length}/{limiteCaracteres}
      </p>
      {/* Renderização condicional da mensagem de limite excedido */}
      {limiteExcedido && (
        <p style={{ color: "red", fontWeight: "bold" }}>
          Limite de caracteres excedido!
        </p>
      )}
    </div>
  );
}

export default ContadorCaracteres;
