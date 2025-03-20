package TrabalhoM2Academia;

public class Usuario {
    private String Nome;
    private String CPF;
    private String dataNascimento;
    private String Endereco;

    public Usuario(String n, String cpf, String dn, String e){
        this.Nome = n;
        this.CPF = cpf;
        this.dataNascimento = dn;
        this.Endereco = e;
    }

    public void cadastrar(){
        System.out.println("Usuario " + Nome + " cadastrado com sucesso!");
    }

    public void verificarLogin(String cpf, String nome){
        if(this.CPF.equals(cpf) && this.Nome.equals(nome)){
            System.out.println("Login realizado com sucesso!");
        } else {
            System.out.println("Falha no login. Verifique suas credenciais.");
        }
    }

    // Get
    public String getNome() {
        return Nome;
    }

    public String getCPF() {
        return CPF;
    }

    public String getDataNascimento() {
        return dataNascimento;
    }

    public String getEndereco() {
        return Endereco;
    }

    // Set
    public void setNome(String nome) {
        Nome = nome;
    }

    public void setCPF(String cPF) {
        CPF = cPF;
    }

    public void setDataNascimento(String datanascimento) {
        this.dataNascimento = datanascimento;
    }

    public void setEndereco(String endereco) {
        Endereco = endereco;
    }

}
