// package Academia;

public class Aluno {

    // MODEL
    
    private String nome;
    private String matricula;
    private String email;
    private int idade;
    private Instrutor instrutor;

    // Construtor 
    public Aluno(String nome, String matricula, String email, int idade) {
        this.nome = nome;
        this.matricula = matricula;
        this.email = email;
        this.idade = idade;
    }

    // Getters
    public String getNome() {
        return nome;
    }

    public String getMatricula() {
        return matricula;
    }

    public String getEmail() {
        return email;
    }

    public int getIdade() {
        return idade;
    }

    public Instrutor getInstrutor() {
        return instrutor;
    }

    // Setters
    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setIdade(int idade) {
        this.idade = idade;
    }

    public void setInstrutor(Instrutor instrutor) {
        this.instrutor = instrutor;
    }
}
