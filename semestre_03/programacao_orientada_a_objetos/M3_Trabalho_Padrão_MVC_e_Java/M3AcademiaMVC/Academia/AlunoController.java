// package Academia;

public class AlunoController {
    
    // CONTROLLER

    private Aluno model;
    private AlunoView view;

    // Construtor
    public AlunoController(Aluno model, AlunoView view) {
        this.model = model;
        this.view = view;
    }

    // Setters
    public void setNomeAluno(String nome) {
        model.setNome(nome); 
    }

    public void setMatriculaAluno(String matricula) {
        model.setMatricula(matricula); 
    }

    public void setEmailAluno(String email) {
        model.setEmail(email); 
    }

    public void setIdadeAluno(int idade) {
        model.setIdade(idade); 
    }

    public void setInstrutorAluno(Instrutor instrutor) {
        model.setInstrutor(instrutor); 
    }

    public void atualizarView() {
        view.mostrarDetalhesAluno(model.getNome(), model.getMatricula(), model.getEmail(), model.getIdade(), model.getInstrutor());
    }
}




