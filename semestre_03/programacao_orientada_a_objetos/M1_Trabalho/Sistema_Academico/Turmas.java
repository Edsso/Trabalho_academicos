package Sistema_Academico;

import java.util.*;

public class Turmas {
    
    private String codigo;
    private Curso curso;
    private Professor professor;
    private List<Alunos> alunos;

    // Construtores
    public Turmas(String c) {
        codigo = c;
        alunos = new ArrayList<>();
    }
    
    // Gettes e Setts
    public String getCodigo(){
        return codigo;
    }
    
    public Curso getCurso(){
        return curso;
    }

    public Professor getProfessor(){
        return professor;
    }

    public List<Alunos> getAlunos(){
        return alunos;
    }
    
    public void setCodigo(String c){
        codigo = c;
    }
    
    public void setCurso(Curso c){
        curso = c;
    }

    public void setProfessor(Professor p){
        professor = p;
    }

    public void setAlunos(List<Alunos> a){
        alunos = a;
    }

}
