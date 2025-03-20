package TrabalhoM2Academia;

import java.time.*;
import java.util.*;

import java.util.ArrayList;

public class Treino {
    private Instrutor instrutor;
    private Aluno aluno;
    private int idTreino;
    private String nomeTreino;
    private LocalDate dataInicio;
    private LocalDate dataFim;
    private int frequencia;
    private String intensidade;
    private List<InformacoesTreino> informacoesTreinoList = new ArrayList<>();

    public Treino(Instrutor in, Aluno al, int idT, String nt, LocalDate di, LocalDate df, int f, String inten){
        this.instrutor = in;
        this.aluno = al;
        this.idTreino = idT;
        this.nomeTreino = nt;
        this.dataInicio = di;
        this.dataFim = df;
        this.frequencia = f;
        this.intensidade = inten;
    }

    public void verificarTreino(){
        System.out.println("Treino: " + nomeTreino);
        System.out.println("Instrutor: " + instrutor.getNome());
        System.out.println("Aluno(a): " + aluno.getNome());
        System.out.println("Data de Incio: " + dataInicio);
        System.out.println("Data Fim: " + dataFim);
        System.out.println("Frequencia: " + frequencia);
        System.out.println("Intensidade: " + intensidade);
            
            for(InformacoesTreino info : informacoesTreinoList){
                System.out.println("Exercicio: " + info.getTipoExercicio());
                System.out.println("Series: " + info.getNumeroSeries());
                System.out.println("Repeticao: " + info.getNumeroRepeticoes());
                System.out.println("Carga: " + info.getCarga() + "Kg");
                System.out.println("Descanso: " + info.getTempoDescanso() + " segundos");
            }

    }

    // Get
    public Instrutor getInstrutor() {
        return instrutor;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public int getIdTreino() {
        return idTreino;
    }

    public String getNomeTreino() {
        return nomeTreino;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public LocalDate getDataFim() {
        return dataFim;
    }

    public int getFrequencia() {
        return frequencia;
    }

    public String getIntensidade() {
        return intensidade;
    }

    public List<InformacoesTreino> getInformacoesTreinoList() {
        return informacoesTreinoList;
    }

    // Set
    public void setInstrutor(Instrutor instrutor) {
        this.instrutor = instrutor;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public void setIdTreino(int idTreino) {
        this.idTreino = idTreino;
    }

    public void setNomeTreino(String nomeTreino) {
        this.nomeTreino = nomeTreino;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public void setDataFim(LocalDate dataFim) {
        this.dataFim = dataFim;
    }

    public void setFrequencia(int frequencia) {
        this.frequencia = frequencia;
    }

    public void setIntensidade(String intensidade) {
        this.intensidade = intensidade;
    }

    public void setInformacoesTreinoList(List<InformacoesTreino> itl) {
        this.informacoesTreinoList = itl;
    }

}
