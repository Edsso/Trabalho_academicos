package Sistema_Academico;

public class Alunos {

    private String nome;
    private int matricula;
    private String disciplina;
    private int contato;
    private long CPF;

    // Construtores
    public Alunos(String n, int m, String d, int c, long cpf){
        nome = n;
        matricula = m;
        disciplina = d;
        contato = c;
        CPF = cpf;
    }

    // Gettes e Setts
    public String getNomeAluno(){
        return nome;
    }
    
    public int getMatriculaAluno(){
        return matricula;
    }

    public String getDisciplinasAluno(){
        return disciplina;
    }

    public int getContatoAluno(){
        return contato;
    }

    public long getCPFAluno(){
        return CPF;
    }

    public void setNomeAluno(String n){
        nome = n;
    }
    
    public void setMatriculaAluno(int m){
        matricula = m;
    }

    public void setDisciplinasAluno(String d){
        disciplina = d;
    }

    public void setContatoAluno(int c){
        contato = c;
    }

    public void setCPFAluno(long cpf){
        CPF = cpf;
    }
}
