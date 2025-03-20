package TrabalhoM2Academia;

import java.time.*;
import java.util.*;

public class Instrutor extends Usuario{
    private int idProfessor;

    public Instrutor(String n, String cpf, String dn, String e, int idP){
        super(n, cpf, dn, e);
        this.idProfessor = idP;
    }

    public void criarTreinos(List<Treino> treinos, Treino treino){
        treinos.add(treino);
        System.out.println("Treino " + treino.getNomeTreino() + " criado com sucesso!");

    }

    public void modificarTreinos(Treino treino, String novoNome, LocalDate novaDataIncio, LocalDate novaDataFim, int novaFrequencia, String novaIntensidade){
        treino.setNomeTreino(novoNome);
        treino.setDataInicio(novaDataIncio);
        treino.setDataFim(novaDataFim);
        treino.setFrequencia(novaFrequencia);
        treino.setIntensidade(novaIntensidade);
        System.out.println("Treino " + treino.getNomeTreino() + " modificado com sucesso!");
    }

    public void removerTreinos(List<Treino> treinos, Treino treino){
        treinos.remove(treino);
        System.out.println("Treino " + treino.getNomeTreino() + " removido com sucesso!");
    }


    // Get
    public int getIdProfessor() {
        return idProfessor;
    }

    // Set
    public void setIdProfessor(int idProfessor) {
        this.idProfessor = idProfessor;
    }

}
