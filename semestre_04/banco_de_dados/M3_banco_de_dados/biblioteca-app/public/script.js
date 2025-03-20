const API_URL = 'http://localhost:3000';

// Funções de carregamento
async function loadUsuarios() {
    const res = await fetch(`${API_URL}/usuarios`);
    const usuarios = await res.json();

    const usuariosDiv = document.getElementById('usuarios');
    const usuarioEmprestimoSelect = document.getElementById('usuarioEmprestimo');

    usuariosDiv.innerHTML = '';
    usuarioEmprestimoSelect.innerHTML = '<option value="">Selecione um Usuário</option>';

    usuarios.forEach(usuario => {
        const div = document.createElement('div');
        div.className = 'usuario';
        div.innerHTML = `
            <strong>${usuario.nome}</strong> (${usuario.email})<br>
            Endereço: ${usuario.endereco} | Telefone: ${usuario.telefone}
            <button class="delete" onclick="deleteUsuario(${usuario.ID_usuario})">Excluir</button>
        `;
        div.innerHTML = `
            <strong>${usuario.nome}</strong> (${usuario.email})<br>
            Endereço: ${usuario.endereco} | Telefone: ${usuario.telefone}
            <button class="delete" onclick="deleteUsuario(${usuario.ID_usuario})">Excluir</button>
            <button class="edit" onclick="editUsuario(${usuario.ID_usuario}, '${usuario.nome}', '${usuario.endereco}', '${usuario.telefone}', '${usuario.email}')">Editar</button>
        `;
        usuariosDiv.appendChild(div);

        const option = document.createElement('option');
        option.value = usuario.ID_usuario;
        option.textContent = usuario.nome;
        usuarioEmprestimoSelect.appendChild(option);
    });
};

function editUsuario(id, nome, endereco, telefone, email) {
    // Preenche o formulário com os dados do usuário
    document.getElementById('nome').value = nome;
    document.getElementById('endereco').value = endereco;
    document.getElementById('telefone').value = telefone;
    document.getElementById('email').value = email;

    // Adiciona um atributo ao formulário para indicar edição
    document.getElementById('usuarioForm').setAttribute('data-editing-id', id);
}

async function loadLivros() {
    const res = await fetch(`${API_URL}/livros`);
    const livros = await res.json();

    const livrosDiv = document.getElementById('livros');
    const livroEmprestimoSelect = document.getElementById('livroEmprestimo');

    livrosDiv.innerHTML = '';
    livroEmprestimoSelect.innerHTML = '<option value="">Selecione um Livro</option>';

    livros.forEach(livro => {
        const div = document.createElement('div');
        div.className = 'livro';
        div.innerHTML = `
            <strong>${livro.titulo}</strong> por ${livro.autor}<br>
            Editora: ${livro.editora} | Ano: ${livro.ano_publicacao}<br>
            <button class="delete" onclick="deleteLivro(${livro.ID_livro})">Excluir</button>
        `;
        
        livrosDiv.appendChild(div);

        const option = document.createElement('option');
        option.value = livro.ID_livro;
        option.textContent = livro.titulo;
        livroEmprestimoSelect.appendChild(option);
    });
}

// Função para formatar a data no formato 'YYYY-MM-DD'
function formatarData(data) {
    const d = new Date(data);
    return d.toISOString().split('T')[0]; // Extrai a parte da data no formato 'YYYY-MM-DD'
}

async function loadEmprestimos() {
    const res = await fetch(`${API_URL}/emprestimos`);
    const emprestimos = await res.json();
    console.log(emprestimos);  // Verifique se os dados estão sendo carregados corretamente

    const emprestimosDiv = document.getElementById('emprestimos');
    emprestimosDiv.innerHTML = '';  // Limpa a área de exibição antes de adicionar novos registros

    if (emprestimos.length === 0) {
        emprestimosDiv.innerHTML = '<p>Não há empréstimos registrados.</p>';
        return;
    }

    emprestimos.forEach(emprestimo => {
        const div = document.createElement('div');
        div.className = 'emprestimo';

        const dataEmprestimo = formatarData(emprestimo.data_emprestimo); // Formata a data de empréstimo
        const dataDevolucao = emprestimo.data_devolucao ? formatarData(emprestimo.data_devolucao) : 'Não definida'; // Formata a data de devolução se existir

        div.innerHTML = `
            <strong>Usuário:</strong> ${emprestimo.usuario}<br>
            <strong>Livro:</strong> ${emprestimo.livro}<br>
            <strong>Data de Empréstimo:</strong> ${dataEmprestimo}<br>
            <strong>Data de Devolução:</strong> ${dataDevolucao}<br>
            <button class="delete" onclick="deleteEmprestimo(${emprestimo.ID_emprestimo})">Excluir</button>
        `;
        emprestimosDiv.appendChild(div);
    });
}

// Adicionar funcionalidades
document.getElementById('usuarioForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const data = {
        nome: form.nome.value,
        endereco: form.endereco.value,
        telefone: form.telefone.value,
        email: form.email.value,
    };

    const editingId = form.getAttribute('data-editing-id');

    if (editingId) {
        // Edição
        await fetch(`${API_URL}/usuarios/${editingId}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });
        form.removeAttribute('data-editing-id'); // Remove o atributo após a edição
    } else {
        // Criação
        await fetch(`${API_URL}/usuarios`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });
    }

    form.reset();
    loadUsuarios();
});


document.getElementById('livroForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const form = e.target;
    const data = {
        titulo: form.titulo.value,
        autor: form.autor.value,
        ano_publicacao: form.ano_publicacao.value,
        editora: form.editora.value,
        genero: form.genero.value,
    };

    await fetch(`${API_URL}/livros`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
    });

    form.reset();
    loadLivros();
});

document.getElementById('emprestimoForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    const data = {
        ID_usuario: document.getElementById('usuarioEmprestimo').value,
        ID_livro: document.getElementById('livroEmprestimo').value,
        data_emprestimo: new Date().toISOString().split('T')[0], // Data atual como data de empréstimo
        data_devolucao: document.getElementById('dataDevolucao').value,
    };

    await fetch(`${API_URL}/emprestimos`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
    });

    loadEmprestimos();  // Recarregar empréstimos após o envio do formulário
});

// Excluir Usuário
async function deleteUsuario(id) {
    await fetch(`${API_URL}/usuarios/${id}`, { method: 'DELETE' });
    loadUsuarios();
}

// Excluir Livro
async function deleteLivro(id) {
    await fetch(`${API_URL}/livros/${id}`, { method: 'DELETE' });
    loadLivros();
}

// Excluir Empréstimo
async function deleteEmprestimo(id) {
    await fetch(`${API_URL}/emprestimos/${id}`, { method: 'DELETE' });
    loadEmprestimos();  // Recarregar a lista de empréstimos após exclusão
}

// Inicializar a aplicação
loadUsuarios();
loadLivros();
loadEmprestimos();