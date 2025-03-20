// package Academia;

class Instrutor {
    private String nome;
    private int idade;
    private int anosExperiencia;
    private String tipoTreino;

    // Construtor
    public Instrutor(String nome, int idade, int anosExperiencia) {
        this.nome = nome;
        this.idade = idade;
        this.anosExperiencia = anosExperiencia;
    }

    // Getters
    public String getNome() {
        return nome;
    }
    
    public int getIdade() {
        return idade;
    }
    
    public int getAnosExperiencia() {
        return anosExperiencia;
    }
    
    public String getTipoTreino() {
        return tipoTreino;
    }
    
    // Setters
    public void setNome(String nome) {
        this.nome = nome;
    }
    
    public void setIdade(int idade) {
        this.idade = idade;
    }
    
    public void setAnosExperiencia(int anosExperiencia) {
        this.anosExperiencia = anosExperiencia;
    }
    
    public void setTipoTreino(String tipoTreino) {
        this.tipoTreino = tipoTreino;
    }
    
}

class InstrutorCrossFit extends Instrutor {
    private String certificacao;

    // Construtor
    public InstrutorCrossFit(String nome, int idade, int anosExperiencia, String certificacao) {
        super(nome, idade, anosExperiencia);
        this.certificacao = certificacao;
    }

    // Get e Set
    public String getCertificacao() {
        return certificacao;
    }

    public void setCertificacao(String certificacao) {
        this.certificacao = certificacao;
    }
}

class InstrutorDanca extends Instrutor {
    private String estiloDanca;

    // Construtor
    public InstrutorDanca(String nome, int idade, int anosExperiencia, String estiloDanca) {
        super(nome, idade, anosExperiencia);
        this.estiloDanca = estiloDanca;
    }

    // Get e Set
    public String getEstiloDanca() {
        return estiloDanca;
    }

    public void setEstiloDanca(String estiloDanca) {
        this.estiloDanca = estiloDanca;
    }
}
