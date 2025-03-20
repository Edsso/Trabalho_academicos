const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Conexão com o banco de dados
const conexao = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'Biblioteca'
});

conexao.connect(err => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err);
        return;
    }
    console.log('Conectado ao banco de dados!');
});

// CREATE - Adicionar um novo usuário
app.post('/usuarios', (req, res) => {
    const { nome, endereco, telefone, email } = req.body;
    const query = 'INSERT INTO Usuario (nome, endereco, telefone, email) VALUES (?, ?, ?, ?)';
    conexao.query(query, [nome, endereco, telefone, email], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao cadastrar usuário.');
        } else {
            res.status(201).send('Usuário cadastrado com sucesso!');
        }
    });
});

// READ - Listar todos os usuários
app.get('/usuarios', (req, res) => {
    const query = 'SELECT * FROM Usuario';
    conexao.query(query, (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao listar usuários.');
        } else {
            res.status(200).json(results);
        }
    });
});

// UPDATE - Atualizar um usuário
app.put('/usuarios/:id', (req, res) => {
    const { id } = req.params;
    const { nome, endereco, telefone, email } = req.body;

    const query = 'UPDATE Usuario SET nome = ?, endereco = ?, telefone = ?, email = ? WHERE ID_usuario = ?';

    conexao.query(query, [nome, endereco, telefone, email, id], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao atualizar usuário.');
        } else {
            res.status(200).send('Usuário atualizado com sucesso!');
        }
    });
});

// DELETE - Remover um usuário
app.delete('/usuarios/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Usuario WHERE ID_usuario = ?';
    conexao.query(query, [id], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao excluir usuário.');
        } else {
            res.status(200).send('Usuário excluído com sucesso!');
        }
    });
});

// CREATE - Adicionar um novo livro
app.post('/livros', (req, res) => {
    const { titulo, autor, ano_publicacao, editora, genero } = req.body;
    const query = 'INSERT INTO Livro (titulo, autor, ano_publicacao, editora, genero) VALUES (?, ?, ?, ?, ?)';
    conexao.query(query, [titulo, autor, ano_publicacao, editora, genero], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao cadastrar livro.');
        } else {
            res.status(201).send('Livro cadastrado com sucesso!');
        }
    });
});

// READ - Listar todos os livros
app.get('/livros', (req, res) => {
    const query = 'SELECT * FROM Livro';
    conexao.query(query, (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao listar livros.');
        } else {
            res.status(200).json(results);
        }
    });
});

// DELETE - Remover um livro
app.delete('/livros/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Livro WHERE ID_livro = ?';
    conexao.query(query, [id], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao excluir livro.');
        } else {
            res.status(200).send('Livro excluído com sucesso!');
        }
    });
});

// CREATE - Registrar um novo empréstimo
app.post('/emprestimos', (req, res) => {
    const { ID_usuario, ID_livro, data_emprestimo, data_devolucao } = req.body;

    // Verifica e ajusta o formato das datas (caso necessário)
    const formattedDataEmprestimo = new Date(data_emprestimo).toISOString().split('T')[0]; // Formato YYYY-MM-DD
    const formattedDataDevolucao = data_devolucao ? new Date(data_devolucao).toISOString().split('T')[0] : null; // Verifica se existe data de devolução

    console.log('Dados recebidos:', { ID_usuario, ID_livro, formattedDataEmprestimo, formattedDataDevolucao });

    const query = 'INSERT INTO Emprestimo (ID_usuario, ID_livro, data_emprestimo, data_devolucao) VALUES (?, ?, ?, ?)';
    conexao.query(query, [ID_usuario, ID_livro, formattedDataEmprestimo, formattedDataDevolucao], (err, results) => {
        if (err) {
            console.error('Erro ao registrar empréstimo:', err);
            res.status(500).send('Erro ao registrar empréstimo.');
        } else {
            console.log('Empréstimo registrado com sucesso!');
            res.status(201).send('Empréstimo registrado com sucesso!');
        }
    });
});

// READ - Listar todos os empréstimos com dados do usuário e livro
app.get('/emprestimos', (req, res) => {
    const query = `
        SELECT e.ID_emprestimo, u.nome AS usuario, l.titulo AS livro, e.data_emprestimo, e.data_devolucao
        FROM Emprestimo e
        JOIN Usuario u ON e.ID_usuario = u.ID_usuario
        JOIN Livro l ON e.ID_livro = l.ID_livro;
    `;
    conexao.query(query, (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao listar empréstimos.');
        } else {
            res.status(200).json(results);
        }
    });
});

// DELETE - Remover um empréstimo
app.delete('/emprestimos/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM Emprestimo WHERE ID_emprestimo = ?';
    conexao.query(query, [id], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Erro ao excluir empréstimo.');
        } else {
            res.status(200).send('Empréstimo excluído com sucesso!');
        }
    });
});

// Servidor
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});