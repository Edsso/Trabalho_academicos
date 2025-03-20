import React, { useState } from "react";
import "./App.css";

function Contador() {
  const [contador, setContador] = useState(0);

  const incrementar = () => setContador(contador + 1);
  const decrementar = () => setContador(contador - 1);
  const resetar = () => setContador(0);

  return (
    <div style={{ textAlign: "center", marginTop: "20px" }}>
      <h1>Contador: {contador}</h1>
      <button onClick={incrementar}>Incrementar</button>
      <button onClick={decrementar}>Decrementar</button>
      <button onClick={resetar}>Resetar</button>
    </div>
  );
}

export default Contador;
