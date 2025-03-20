package TrabalhoM2Academia;

public class InformacoesTreino {

    private Treino treino;
    private int idInformacao;
    private String tipoExercicio;
    private int numeroSeries;
    private int numeroRepeticoes;
    private float carga;
    private int tempoDescanso;

    public InformacoesTreino(Treino tr, int idI, String tipo, int ns, int nr, float c, int td){

        this.treino = tr;
        this.idInformacao = idI;
        this.tipoExercicio = tipo;
        this.numeroSeries = ns;
        this.numeroRepeticoes = nr;
        this.carga = c;
        this.tempoDescanso = td;
    }

    public void verificarInfosTreino(){
        System.out.println("Lista de Treino: ");
        System.out.println("Exercicio: " + tipoExercicio);
        System.out.println("Series: " + numeroSeries);
        System.out.println("Repeticao: " + numeroRepeticoes);
        System.out.println("Carga: " + carga + "Kg");
        System.out.println("Descanso: " + tempoDescanso + " segundos");
    }

    // Get
    public Treino getTreino() {
        return treino;
    }

    public int getIdInformacao() {
        return idInformacao;
    }

    public String getTipoExercicio() {
        return tipoExercicio;
    }

    public int getNumeroSeries() {
        return numeroSeries;
    }

    public int getNumeroRepeticoes() {
        return numeroRepeticoes;
    }

    public float getCarga() {
        return carga;
    }

    public int getTempoDescanso() {
        return tempoDescanso;
    }

    // Set
    public void setTreino(Treino treino) {
        this.treino = treino;
    }

    public void setIdInformacao(int idInformacao) {
        this.idInformacao = idInformacao;
    }

    public void setTipoExercicio(String tipoExercicio) {
        this.tipoExercicio = tipoExercicio;
    }

    public void setNumeroSeries(int numeroSeries) {
        this.numeroSeries = numeroSeries;
    }

    public void setNumeroRepeticoes(int numeroRepeticoes) {
        this.numeroRepeticoes = numeroRepeticoes;
    }

    public void setCarga(float carga) {
        this.carga = carga;
    }

    public void setTempoDescanso(int tempoDescanso) {
        this.tempoDescanso = tempoDescanso;
    }
 
}
