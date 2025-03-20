package TrabalhoM2Academia;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;

public class Academia {

    private static List<Treino> treinos = new ArrayList<>();
    private static Instrutor instrutor = new Instrutor("Rodolfo", "123.456.789.00", "01/01/2000", "Rua A, 123", 1);
    private static List<Aluno> alunos = new ArrayList<>();

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int op;

        do {
            System.out.println("Menu de opcoes:");
            System.out.println("\t0 - Sair");
            System.out.println("\t1 - Instrutor");
            System.out.println("\t2 - Aluno");
            System.out.print("Opcao: ");
            while (!sc.hasNextInt()) {
                System.out.print("Opcao invalida! Tente novamente: ");
                sc.next();
            }
            op = sc.nextInt();

            switch (op) {
                case 0:
                    break;
                case 1:
                    menuInstrutor();
                    break;
                case 2:
                    menuAluno();
                    break;
                default:
                    System.out.println("Opcao invalida!");
            }

        } while (op != 0);

        sc.close();
    }

    public static void menuInstrutor() {
        Scanner sc = new Scanner(System.in);
        int op;

        do {
            System.out.println("Menu de opcoes:");
            System.out.println("\t0 - Sair");
            System.out.println("\t1 - Cadastrar aluno");
            System.out.println("\t2 - Criar Treino");
            System.out.println("\t3 - Modificar Treino");
            System.out.println("\t4 - Remover Treino");
            System.out.println("\t5 - Verificar Treino");
            System.out.print("Opcao: ");
            while (!sc.hasNextInt()) {
                System.out.print("Opcao invalida! Tente novamente: ");
                sc.next();
            }
            op = sc.nextInt();

            switch (op) {
                case 0:
                    break;
                case 1:
                    cadastrarAluno(sc);
                    break;
                case 2:
                    criarTreino(sc);
                    break;
                case 3:
                    modificarTreino(sc);
                    break;
                case 4:
                    removerTreino(sc);
                    break;
                case 5:
                    verificarTreinoInstrutor(sc);
                    break;
                default:
                    System.out.println("Opcao invalida!");
            }

        } while (op != 0);
    }

    private static void cadastrarAluno(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("\nNome do aluno: ");
        String nome = sc.nextLine();
        System.out.print("CPF: ");
        String cpf = sc.nextLine();
        System.out.print("Data de Nascimento (yyyy-MM-dd): ");
        String dataNasc;
        LocalDate dataNascimento = null;
        boolean dataValida = false;

        while (!dataValida) {
            try {
                dataNasc = sc.nextLine();
                dataNascimento = LocalDate.parse(dataNasc, DateTimeFormatter.ISO_LOCAL_DATE);
                dataValida = true;
            } catch (DateTimeParseException e) {
                System.out.print("Data invalida! Digite novamente (yyyy-MM-dd): ");
            }
        }

        System.out.print("Endereco: ");
        String endereco = sc.nextLine();
        System.out.print("ID: ");
        while (!sc.hasNextInt()) {
            System.out.print("ID invalido! Tente novamente: ");
            sc.next();
        }
        int idAl = sc.nextInt();

        alunos.add(new Aluno(nome, cpf, dataNascimento.toString(), endereco, idAl));
        System.out.println("Aluno cadastrado com sucesso!");
    }

    private static void criarTreino(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("Qual aluno deseja criar o treino: ");
        String nomeAluno = sc.nextLine();
        Aluno alunoEncontrado = encontrarAlunoPorNome(nomeAluno);

        if (alunoEncontrado != null) {
            System.out.print("\nID de Treino: ");
            while (!sc.hasNextInt()) {
                System.out.print("ID de Treino invalido! Tente novamente: ");
                sc.next();
            }
            int idTrei = sc.nextInt();
            sc.nextLine(); // Consumir nova linha
            System.out.print("\nNome do Treino: ");
            String nomeTrein = sc.nextLine();
            System.out.print("\nData de Inicio (yyyy-MM-dd): ");
            LocalDate dataInicio = obterDataValida(sc);
            System.out.print("\nData Fim (yyyy-MM-dd): ");
            LocalDate dataFim = obterDataValida(sc);
            System.out.print("\nFrequencia: ");
            while (!sc.hasNextInt()) {
                System.out.print("Frequencia invalida! Tente novamente: ");
                sc.next();
            }
            int freque = sc.nextInt();
            sc.nextLine(); // Consumir nova linha
            System.out.print("\nIntensidade: ");
            String intensida = sc.nextLine();

            Treino treino = new Treino(instrutor, alunoEncontrado, idTrei, nomeTrein, dataInicio, dataFim, freque, intensida);
            instrutor.criarTreinos(treinos, treino);
            System.out.println("Treino criado com sucesso!");
        } else {
            System.out.println("Aluno com o nome \"" + nomeAluno + "\" nao encontrado.");
        }
    }

    private static void modificarTreino(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("Qual aluno deseja modificar o treino: ");
        String nomeAluno = sc.nextLine();
        Aluno alunoEncontrado = encontrarAlunoPorNome(nomeAluno);

        if (alunoEncontrado != null) {
            Treino treinoDoAluno = encontrarTreinoPorNome(alunoEncontrado);
            if (treinoDoAluno != null) {
                System.out.print("\nNome do Treino: ");
                String nomeTrein = sc.nextLine();
                System.out.print("\nData de Inicio (yyyy-MM-dd): ");
                LocalDate dataInicio = obterDataValida(sc);
                System.out.print("\nData Fim (yyyy-MM-dd): ");
                LocalDate dataFim = obterDataValida(sc);
                System.out.print("\nFrequencia: ");
                while (!sc.hasNextInt()) {
                    System.out.print("Frequencia invalida! Tente novamente: ");
                    sc.next();
                }
                int freque = sc.nextInt();
                sc.nextLine(); // Consumir nova linha
                System.out.print("\nIntensidade: ");
                String intensida = sc.nextLine();

                instrutor.modificarTreinos(treinoDoAluno, nomeTrein, dataInicio, dataFim, freque, intensida);
                System.out.println("Treino modificado com sucesso!");
            } else {
                System.out.println("Treino nao encontrado para o aluno " + nomeAluno);
            }
        } else {
            System.out.println("Aluno nao encontrado.");
        }
    }

    private static void removerTreino(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("Qual aluno deseja excluir o treino: ");
        String nomeAluno = sc.nextLine();
        Aluno alunoEncontrado = encontrarAlunoPorNome(nomeAluno);

        if (alunoEncontrado != null) {
            Treino treinoDoAluno = encontrarTreinoPorNome(alunoEncontrado);
            if (treinoDoAluno != null) {
                instrutor.removerTreinos(treinos, treinoDoAluno);
                System.out.println("Treino removido com sucesso!");
            } else {
                System.out.println("O aluno " + nomeAluno + " nao possui um treino associado.");
            }
        } else {
            System.out.println("Aluno nao encontrado.");
        }
    }

    private static void verificarTreinoInstrutor(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("Qual aluno deseja visualizar o treino: ");
        String nomeAluno = sc.nextLine();
        Aluno alunoEncontrado = encontrarAlunoPorNome(nomeAluno);

        if (alunoEncontrado != null) {
            Treino treinoDoAluno = encontrarTreinoPorNome(alunoEncontrado);
            if (treinoDoAluno != null) {
                treinoDoAluno.verificarTreino();
            } else {
                System.out.println("O aluno " + nomeAluno + " nao possui um treino associado.");
            }
        } else {
            System.out.println("Aluno nao encontrado.");
        }
    }

    public static void menuAluno() {
        Scanner sc = new Scanner(System.in);
        int op;

        do {
            System.out.println("Menu de opcoes:");
            System.out.println("\t0 - Sair");
            System.out.println("\t1 - Verificar Treino");
            System.out.print("Opcao: ");
            while (!sc.hasNextInt()) {
                System.out.print("Opcao invalida! Tente novamente: ");
                sc.next();
            }
            op = sc.nextInt();

            switch (op) {
                case 0:
                    break;
                case 1:
                    verificarTreinoAluno(sc);
                    break;
                default:
                    System.out.println("Opcao invalida!");
            }

        } while (op != 0);
    }

    private static void verificarTreinoAluno(Scanner sc) {
        sc.nextLine(); // Consumir nova linha
        System.out.print("Qual seu nome: ");
        String nomeAluno = sc.nextLine();
        Aluno alunoEncontrado = encontrarAlunoPorNome(nomeAluno);

        if (alunoEncontrado != null) {
            Treino treinoDoAluno = encontrarTreinoPorNome(alunoEncontrado);
            if (treinoDoAluno != null) {
                treinoDoAluno.verificarTreino();
            } else {
                System.out.println("Voce nao possui um treino associado.");
            }
        } else {
            System.out.println("Aluno nao encontrado.");
        }
    }

    private static LocalDate obterDataValida(Scanner sc) {
        LocalDate data = null;
        boolean dataValida = false;

        while (!dataValida) {
            try {
                String dataStr = sc.nextLine();
                data = LocalDate.parse(dataStr, DateTimeFormatter.ISO_LOCAL_DATE);
                dataValida = true;
            } catch (DateTimeParseException e) {
                System.out.print("Data invalida! Digite novamente (yyyy-MM-dd): ");
            }
        }

        return data;
    }

    private static Aluno encontrarAlunoPorNome(String nomeAluno) {
        for (Aluno aluno : alunos) {
            if (aluno.getNome().equalsIgnoreCase(nomeAluno)) {
                return aluno;
            }
        }
        return null;
    }

    private static Treino encontrarTreinoPorNome(Aluno alunoEncontrado) {
        for (Treino treino : treinos) {
            if (treino.getAluno().equals(alunoEncontrado)) {
                return treino;
            }
        }
        return null;
    }
}