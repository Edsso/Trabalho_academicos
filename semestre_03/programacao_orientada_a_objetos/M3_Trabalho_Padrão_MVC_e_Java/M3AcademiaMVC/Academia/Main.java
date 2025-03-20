// package Academia;

import java.util.*;

public class Main {
    public static void main(String[] args) {

        List<Aluno> model = new ArrayList<>();
        AlunoView view = new AlunoView();
        AlunoController controller = new AlunoController(null, null);
        Scanner sc = new Scanner(System.in);
        int op;

        do { // Sistema principal
            System.out.println("\n======== Menu ========\n");
            System.out.println("\t1 - Cadastrar Aluno");
            System.out.println("\t2 - Visualizar dado de Aluno");
            System.out.println("\t3 - Mostrar todos os Alunos");
            System.out.println("\t4 - Atualizar Aluno");
            System.out.println("\t5 - Associar Instrutor a Aluno");
            System.out.println("\t6 - Sair");
            System.out.printf("\nDigite a sua escolha: ");
            op = sc.nextInt();
            sc.nextLine();

            switch (op) {
                case 1: { // Cadastrar um Aluno
                    String nome, matricula, email;
                    int idade;

                    System.out.printf("Nome do Aluno: ");
                    nome = sc.nextLine();
                    System.out.printf("Matricula: ");
                    matricula = sc.nextLine();
                    System.out.printf("Email: ");
                    email = sc.nextLine();
                    System.out.printf("Idade: ");
                    idade = sc.nextInt();

                    Aluno novoAluno = new Aluno(nome, matricula, email, idade);
                    model.add(novoAluno);

                    break;
                }
                case 2: { // Mostrar dados de um Aluno
                    System.out.print("Digite a matricula do aluno: \n");
                    String matricula = sc.nextLine();

                    Aluno alunoEncontrado = null;
                    for (Aluno aluno : model) {
                        if (aluno.getMatricula().equals(matricula)) {
                            alunoEncontrado = aluno;
                            break;
                        }
                    }

                    if (alunoEncontrado != null) {
                        controller = new AlunoController(alunoEncontrado, view);
                        controller.atualizarView();
                    } else {
                        System.out.println("Aluno nao encontrado.");
                    }

                    break;
                }
                case 3: { // Mostrar todos os Alunos criados
                    System.out.println("Lista de todos os alunos: \n");
                    for (Aluno aluno : model) {
                        controller = new AlunoController(aluno, view);
                        controller.atualizarView();
                    }
                    break;
                }
                case 4: { // Atualizar a uma matricula de um Aluno
                    System.out.print("Digite a matricula do aluno para atualizar: ");
                    String matricula = sc.nextLine();

                    Aluno alunoEncontrado = null;
                    for (Aluno aluno : model) {
                        if (aluno.getMatricula().equals(matricula)) {
                            alunoEncontrado = aluno;
                            break;
                        }
                    }

                    if (alunoEncontrado != null) {
                        String nome, email;
                        int idade;

                        System.out.printf("Novo nome do Aluno: ");
                        nome = sc.nextLine();
                        System.out.printf("Novo email: ");
                        email = sc.nextLine();
                        System.out.printf("Nova idade: ");
                        idade = sc.nextInt();
                        sc.nextLine();

                        controller = new AlunoController(alunoEncontrado, view);
                        controller.setNomeAluno(nome);
                        controller.setEmailAluno(email);
                        controller.setIdadeAluno(idade);
                    } else {
                        System.out.println("Aluno nao encontrado.");
                    }

                    break;
                }
                case 5: { // Associando um instrutor para um Aluno
                    System.out.print("Digite a matricula do aluno para associar um instrutor: ");
                    String matricula = sc.nextLine();
                
                    Aluno alunoEncontrado = null;
                    for (Aluno aluno : model) {
                        if (aluno.getMatricula().equals(matricula)) {
                            alunoEncontrado = aluno;
                            break;
                        }
                    }
                
                    if (alunoEncontrado != null) {
                        if (alunoEncontrado.getInstrutor() != null) {
                            System.out.println("Este aluno ja possui um instrutor.");
                        } else {
                            System.out.println("Escolha o tipo de instrutor:");
                            System.out.println("\t1 - Instrutor 'Normal'");
                            System.out.println("\t2 - Instrutor CrossFit");
                            System.out.println("\t3 - Instrutor de Danca");
                            System.out.print("Digite sua escolha: ");
                            int tipoInstrutor = sc.nextInt();
                            sc.nextLine();
                
                            switch (tipoInstrutor) {
                                case 1: { // Criacao do Instrutor 'Normal'
                                    System.out.print("Nome do Instrutor: ");
                                    String nomeInstrutor = sc.nextLine();
                                    System.out.print("Idade do Instrutor: ");
                                    int idadeInstrutor = sc.nextInt();
                                    sc.nextLine();
                                    System.out.print("Anos de Experiencia: ");
                                    int anosExperiencia = sc.nextInt();
                                    sc.nextLine();
                                    List<String> tiposValidosTreino = Arrays.asList("perna", "braco", "costas", "peito", "abdominal", "cardio");
                                    String tipoTreino;
                            
                                    do {
                                        System.out.print("Tipo de Treino: ");
                                        tipoTreino = sc.nextLine();
                                        if (!tiposValidosTreino.contains(tipoTreino.toLowerCase())) {
                                            System.out.println("Tipo de treino invalido. Por favor, escolha um dos seguintes tipos: perna, braco, costas, peito, abdominal, cardio.");
                                        }
                                    } while (!tiposValidosTreino.contains(tipoTreino.toLowerCase()));
                            
                                    Instrutor novoInstrutor = new Instrutor(nomeInstrutor, idadeInstrutor, anosExperiencia);
                                    novoInstrutor.setTipoTreino(tipoTreino); 
                                    alunoEncontrado.setInstrutor(novoInstrutor);
                                    System.out.println("Instrutor Normal associado com sucesso.");
                                    break;
                                }                           
                                case 2: { // Criacao do Instrutor de CrossFit
                                    System.out.print("Nome do Instrutor de CrossFit: ");
                                    String nomeInstrutor = sc.nextLine();
                                    System.out.print("Idade do Instrutor: ");
                                    int idadeInstrutor = sc.nextInt();
                                    sc.nextLine();
                                    System.out.print("Anos de Experiencia: ");
                                    int anosExperiencia = sc.nextInt();
                                    sc.nextLine();
                                    System.out.print("Certificacao: ");
                                    String certificacao = sc.nextLine();
                
                                    InstrutorCrossFit novoInstrutor = new InstrutorCrossFit(nomeInstrutor, idadeInstrutor, anosExperiencia, certificacao);
                                    alunoEncontrado.setInstrutor(novoInstrutor);
                                    System.out.println("Instrutor de CrossFit associado com sucesso.");
                                    break;
                                }
                                case 3: { // Criacao do Instrutor de Danca
                                    System.out.print("Nome do Instrutor de Danca: ");
                                    String nomeInstrutor = sc.nextLine();
                                    System.out.print("Idade do Instrutor: ");
                                    int idadeInstrutor = sc.nextInt();
                                    sc.nextLine();
                                    System.out.print("Anos de Experiencia: ");
                                    int anosExperiencia = sc.nextInt();
                                    sc.nextLine();
                                    System.out.print("Estilo de Danca: ");
                                    String estiloDanca = sc.nextLine();
                
                                    InstrutorDanca novoInstrutor = new InstrutorDanca(nomeInstrutor, idadeInstrutor, anosExperiencia, estiloDanca);
                                    alunoEncontrado.setInstrutor(novoInstrutor);
                                    System.out.println("Instrutor de Danca associado com sucesso.");
                                    break;
                                }
                                default:
                                    System.out.println("Opcao invalida.");
                            }
                        }
                    } else {
                        System.out.println("Aluno nao encontrado.");
                    }
                
                    break;
                }
            }

        } while (op != 6);

        sc.close();

    }
}