package TrabalhoM2Academia;

import java.util.*;

public class Aluno extends Usuario{
    private int idAluno;

    public Aluno(String n, String cpf, String dn, String e, int idA){
        super(n, cpf, dn, e);
        this.idAluno = idA;
    }

    public void login(){
        Scanner sc = new Scanner(System.in);
        System.out.print("Digite seu CPF: ");
        String cpf = sc.nextLine();
        System.out.print("Digite seu Nome: ");
        String nome = sc.nextLine();
        verificarLogin(cpf, nome);
    }

    public void verificarTreinos(List<Treino> treinos){
        System.out.print("Treinos do aluno(a) " + getNome() + ": ");
            for(Treino treino : treinos){
                if(treino.getAluno().getIdAluno() == this.idAluno){
                    System.out.println(treino.getNomeTreino() + " | Intensidade: " + treino.getIntensidade());
            }
        }
    }

    // Get
    public int getIdAluno() {
        return idAluno;
    }

    // Set
    public void setIdAluno(int idAluno) {
        this.idAluno = idAluno;
    }

}
