CREATE SCHEMA Biblioteca;
USE Biblioteca;

CREATE TABLE Usuario (
    ID_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Livro(
    ID_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano_publicacao INT NOT NULL,
    editora VARCHAR(255) NOT NULL,
    genero VARCHAR(255) NOT NULL
);

CREATE TABLE Emprestimo(
    ID_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    ID_usuario INT NOT NULL,
    ID_livro INT NOT NULL,
    FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario),
    FOREIGN KEY (ID_livro) REFERENCES Livro(ID_livro)
);

CREATE TABLE Categoria(
    ID_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL
);
