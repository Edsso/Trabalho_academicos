// package Academia;

public class AlunoView {

    // VIEW

    public void mostrarDetalhesAluno(String nome, String matricula, String email, int idade, Instrutor instrutor) {
        System.out.println("Detalhes do Aluno:");
        System.out.println("Nome: " + nome);
        System.out.println("Matricula: " + matricula);
        System.out.println("Email: " + email);
        System.out.println("Idade: " + idade);
        if (instrutor != null) {
            System.out.println("Instrutor: " + instrutor.getNome());
            System.out.println("Idade do Instrutor: " + instrutor.getIdade());
            System.out.println("Anos de Experiencia do Instrutor: " + instrutor.getAnosExperiencia());
            if (instrutor instanceof InstrutorCrossFit) {
                System.out.println("Certificacao do Instrutor de CrossFit: " + ((InstrutorCrossFit) instrutor).getCertificacao());
            } else if (instrutor instanceof InstrutorDanca) {
                System.out.println("Estilo de Danca do Instrutor de Danca: " + ((InstrutorDanca) instrutor).getEstiloDanca());
            }
        } else {
            System.out.println("Instrutor: Nenhum");
        }
        System.out.println("---------------------------------------");
    }
}