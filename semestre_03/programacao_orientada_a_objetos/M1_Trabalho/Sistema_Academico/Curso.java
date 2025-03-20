package Sistema_Academico;

public class Curso {

    private String nome;
    private String sigla;

    // Construtores
    public Curso(String n, String s){
        nome = n;
        sigla = s;
    }

    // Gettes e Setts
    public String getNomeCurso(){
        return nome;
    }
    
    public String getSiglaCurso(){
        return sigla;
    }
    
    public void setNomeCurso(String n){
        nome = n;
    }
    
    public void setSiglaCurso(String s){
        sigla = s;
    }
    
}
