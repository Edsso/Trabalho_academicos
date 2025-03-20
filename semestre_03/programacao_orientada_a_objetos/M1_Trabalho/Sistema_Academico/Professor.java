package Sistema_Academico;

public class Professor {

    private String nome;
    private int registro;
    private String disciplinas;
    private long CPF;

    // Construtores
    public Professor(String n, int r, String d, long cpf){
        nome = n;
        registro = r;
        disciplinas = d;
        CPF = cpf;
    }

    // Gettes e Setts
    public String getNomeProfessor(){
        return nome;
    }
    
    public int getRegistroProfessor(){
        return registro;
    }

    public String getDisciplinasProfessor(){
        return disciplinas;
    }

    public long getCPFProfessor(){
        return CPF;
    }
    
    public void setNomeProfessor(String n){
        nome = n;
    }
    
    public void setRegistroProfessor(int r){
        registro = r;
    }

    public void setDisciplinasProfessor(String d){
        disciplinas = d;
    }

    public void setCPFProfessor(long cpf){
        CPF = cpf;
    }
    
}
