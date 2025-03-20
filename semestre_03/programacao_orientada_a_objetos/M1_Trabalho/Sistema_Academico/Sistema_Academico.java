package Sistema_Academico;

import java.util.*;

public class Sistema_Academico {
    
    public static void main(String[] args) {
        
        Scanner leitura = new Scanner (System.in);

        // Inicializando as ArrayList
        List<Curso> cursos = new ArrayList<Curso>();
        List<Turmas> turmas = new ArrayList<Turmas>();
        List<Alunos> alunos = new ArrayList<Alunos>(40);
        List<Professor> professores = new ArrayList<Professor>();

        int op = 0;

        do{

            System.out.println("\nBem vindo ao Sistema Acadêmico\n");
            System.out.println("\tDeseja acessar o que?\n");
            System.out.println("\t1- Curso?");
            System.out.println("\t2- Turma?");
            System.out.println("\t3- Alunos?");
            System.out.println("\t4- Professores?");
            System.out.println("\t5- Sair\n");
        
            System.out.print("A sua escolha foi: ");
            op = leitura.nextInt();

            switch (op) {
                case 1: menu_Curso(cursos, alunos, professores, turmas, leitura); break;
                case 2: menu_Turmas(cursos, alunos, professores, turmas, leitura); break;
                case 3: menu_Alunos(alunos, leitura); break;
                case 4: menu_Professor(professores, leitura); break;
                case 5: break;
                default: System.out.println("Opções disponíveis são entre 1 a 4!!!");

            }

        }while (op != 5);

    }

    // Metódo do menu do curso
    public static void menu_Curso(List<Curso> cursos, List<Alunos> alunos, List<Professor> professores, List<Turmas> turmas, Scanner leitura){ 
    
        int op;
        String nome;
        String sigla;
        
        do {

            System.out.println("\n\tDeseja fazer o que?\n");
            System.out.println("\t1- Criar um curso?");
            System.out.println("\t2- Ver o nome do Curso?");
            System.out.println("\t3- Ver todas as informacoes do Curso criado?");
            System.out.println("\t4- Sair\n");
            System.out.print("A sua escolha sera: ");
            op = leitura.nextInt();
        
            switch (op) {
                case 1:{ // Case para criar um curso
                    leitura.nextLine();
                    System.out.println("\nQual o Nome que deseja por no curso (Se possivel cria o nome como Ciencia da Computacao)?");
                    nome = leitura.nextLine();
        
                    System.out.println("\nQual a Sigla que deseja por no curso?");
                    sigla = leitura.nextLine();
        
                    Curso curso = new Curso(nome, sigla);
                    cursos.add(curso);

                    break;
                }

                case 2:{ // Case para ver o curso
                    if (!cursos.isEmpty()){
                        for (Curso cursoExistente : cursos) {
                            System.out.printf("\nO nome do curso atualmente e: %s (Sigla: %s)\n", cursoExistente.getNomeCurso(), cursoExistente.getSiglaCurso()); 
                        }
                    } 

                    else {
                        System.out.println("\nO curso ainda não foi criado.\n");
                    }
                    break;
                }

                case 3:{ // Case para ver todas as infomações do curso (Curso, Turma, Alunos e Professores)
                    if (!cursos.isEmpty()){
                        for (Curso cursoExistente : cursos) {
                            System.out.printf("\nO nome do curso atualmente e: %s (Sigla: %s)\n", cursoExistente.getNomeCurso(), cursoExistente.getSiglaCurso());
                        }
                
                        System.out.println("Digite o código da turma:");
                        String codigoTurma = leitura.next();
                        Turmas turma = turmas.stream()
                            .filter(t -> t.getCodigo().equals(codigoTurma))
                            .findFirst()
                            .orElse(null);
                        if(turma != null) {
                            System.out.println("\nInformações da turma:");
                            System.out.println("Código: " + turma.getCodigo());
                            System.out.println("Professor: " + turma.getProfessor().getNomeProfessor());
                            System.out.println("Alunos:");
                            for(Alunos aluno : turma.getAlunos()) {
                                System.out.println("- " + aluno.getNomeAluno());
                            }
                        } else {
                            System.out.println("Turma não encontrada!");
                        }
                
                        System.out.println("\nInformações dos alunos:");
                        for(Alunos aluno : alunos){
                            System.out.println("Nome: " + aluno.getNomeAluno());
                            System.out.println("Registro: " + aluno.getMatriculaAluno());
                            System.out.println("Disciplina: " + aluno.getDisciplinasAluno());
                            System.out.println("Contato: " + aluno.getContatoAluno());
                            System.out.println("CPF: " + aluno.getCPFAluno());
                            System.out.println();
                        }
                
                        System.out.println("Informações dos professores:");
                        for (Professor prof : professores) {
                            System.out.println("Nome: " + prof.getNomeProfessor());
                            System.out.println("Registro: " + prof.getRegistroProfessor());
                            System.out.println("Disciplina: " + prof.getDisciplinasProfessor());
                            System.out.println("CPF: " + prof.getCPFProfessor());
                        }
                    }
                
                    else {
                        System.out.println("\nO curso ainda não foi criado.\n");
                    }

                        break;
                    } 

                case 4:  // Sai do programa
                    break;

            }

        } while (op != 4);
    
    }

    // Metódo do menu das turmas
    public static void menu_Turmas(List<Curso> cursos, List<Alunos> alunos, List<Professor> professores, List<Turmas> turmas, Scanner leitura){

        int op;
        
        do{
        
            System.out.println("\n\tDeseja fazer o que?\n");
            System.out.println("\t1- Criar codigo da turma?");
            System.out.println("\t2- Adicionar Alunos na turma?");
            System.out.println("\t3- Adicionar Professores na turma?");
            System.out.println("\t4- Quer ver uma turma?");
            System.out.println("\t5- Sair\n");
            
            System.out.print("A sua escolha foi: ");
            op = leitura.nextInt();

            switch (op) {
                case 1:{ // Case para criar o codigo da turma
                    if(!cursos.isEmpty()){
                        System.out.println("Digite o código da turma:");
                        String codigo = leitura.next();
                        Turmas turma = new Turmas(codigo);
                        turmas.add(turma);
                        System.out.println("Turma criada com sucesso!");
                    } else {
                        System.out.println("Você precisa criar um curso primeiro!");
                    }
                    break;
                }

                case 2:{ // Case para adicionar alunos na turma
                    System.out.println("Digite o código da turma:");
                    String codigoTurma = leitura.next();
                    Turmas turma = turmas.stream()
                        .filter(t -> t.getCodigo().equals(codigoTurma))
                        .findFirst()
                        .orElse(null);
                    if(turma != null){
                        System.out.println("Digite o nome do aluno:");
                        String nomeAluno = leitura.next();
                        
                        // Encontre o aluno na lista de alunos
                        Alunos aluno = alunos.stream()
                            .filter(a -> a.getNomeAluno().equals(nomeAluno))
                            .findFirst()
                            .orElse(null);
                        
                        if(aluno != null) {
                            adicionarAlunoNaTurma(turma, aluno); // Chame o método adicionarAlunoNaTurma
                        } else {
                            System.out.println("Aluno não encontrado!");
                        }
                    } else {
                        System.out.println("Turma não encontrada!");
                    }
                    break;
                }

                case 3:{ // Case para adicionar professor na turma
                    System.out.println("Digite o código da turma:");
                    String codigoTurma = leitura.next();
                    Turmas turma = turmas.stream()
                        .filter(t -> t.getCodigo().equals(codigoTurma))
                        .findFirst()
                        .orElse(null);
                    if(turma != null){
                        if(turma.getProfessor() == null) {
                            System.out.println("Digite o nome do professor:");
                            String nomeProfessor = leitura.next();
                            
                            // Encontre o professor na lista de professores
                            Professor professor = professores.stream()
                                .filter(p -> p.getNomeProfessor().equals(nomeProfessor))
                                .findFirst()
                                .orElse(null);
                            
                            if(professor != null) {
                                adicionarProfessorNaTurma(turma, professor); // Chame o método adicionarProfessorNaTurma
                            } else {
                                System.out.println("Professor não encontrado!");
                            }
                        } else {
                            System.out.println("Já existe um professor nesta turma!");
                        }
                    } else {
                        System.out.println("Turma não encontrada!");
                    }
                    break;
                } 

                case 4:{ // Case para ver toda a turma (Turma, Alunos e Professores)
                    System.out.println("Digite o código da turma:");
                    String codigoTurma = leitura.next();
                    Turmas turma = turmas.stream()
                        .filter(t -> t.getCodigo().equals(codigoTurma))
                        .findFirst()
                        .orElse(null);
                    if(turma != null) {
                        System.out.println("\nInformações da turma:");
                        System.out.println("Código: " + turma.getCodigo());
                        System.out.println("Professor: " + turma.getProfessor().getNomeProfessor());
                        System.out.println("Alunos:");
                        for(Alunos aluno : turma.getAlunos()) {
                            System.out.println("- " + aluno.getNomeAluno());
                        }
                    } else {
                        System.out.println("Turma não encontrada!");
                    }
                    break;
                }

                case 5:  // Retorna ao menu principal
                    break;
    
            }
    
        }while (op != 5);
    
    }
    
    // Metódo do menu dos alunos
    public static void menu_Alunos(List<Alunos> alunos, Scanner leitura){

        int op;

        String nome, disciplina;
        int numAlunos = 0;
        int matricula = 0;
        int contato = 0;
        long CPF = 0;

        do{

            System.out.println("\n\tDeseja fazer o que?\n");
            System.out.println("\t1- Adicionar um Aluno?");
            System.out.println("\t2- Mostrar todos os Alunos?");
            System.out.println("\t3- Sair\n");
        
            System.out.print("A sua escolha foi: ");
            op = leitura.nextInt();

            switch (op) {
                case 1:{ // Case para "criar" um aluno
                    if( numAlunos < 40){
                        System.out.print( "Nome: " );
                        nome = leitura.next();

                        System.out.print( "Matricula: " );

                        do {
                            matricula = leitura.nextInt();
                            if(matricula < 100 || matricula > 999) {
                                System.out.print("A matricula do aluno deve estar entre 100 e 999. Por favor, digite novamente: ");
                            }
                        } while(matricula < 100 || matricula > 999);

                        leitura.nextLine();

                        System.out.print( "Disciplina: " );
                        disciplina = leitura.nextLine();

                        List<String> disciplinasPermitidas = Arrays.asList("Estrutura de Dados", "Calculo 2", "Programacao Orientada a Objetos", "Paradigmas de Programacao", "Arquitetura e Organizaocao de Processadores");
                    
                        // Verifique se a disciplina digitada pelo usuário está na lista de disciplinas permitidas
                        while(!disciplinasPermitidas.contains(disciplina)) {
                            System.out.println("Disciplina não existente. As disciplinas que existe atualmente são: Estrutura de Dados, Calculo 2, Programacao Orientada a Objetos, Paradigmas de Programacao e Arquitetura e Organizaocao de Processadores");
                            System.out.print("Por favor, digite novamente: ");
                            disciplina = leitura.nextLine();
                        }

                        int numDigitados;

                        System.out.print( "Contato: " );

                        do {
                            contato = leitura.nextInt();
                        
                            // Calcula o número de dígitos
                            numDigitados = (int) Math.log10(contato) + 1;

                            if(numDigitados != 9) {
                                System.out.print( "Contato deve conter 9 números, por favor digite novamente: " );
                            }

                        } while(numDigitados != 9);

                        int numCPFDigitados;

                        System.out.print( "CPF: " );

                        do {
                            CPF = leitura.nextLong();
                        
                            // Calcula o número de dígitos
                            numCPFDigitados = (int) Math.log10(CPF) + 1;

                            if(numCPFDigitados != 11) {
                                System.out.print( "CPF deve conter 11 números, por favor digite novamente: " );
                            }

                        } while(numCPFDigitados != 11);

                        Alunos aluno = new Alunos(nome, matricula, disciplina, contato, CPF);
                        alunos.add(aluno);
                        numAlunos++;
                    }
                    else System.out.println( "Numero maximo de alunos!" ); 
                    
                        break;
                }

                case 2:{ // Case para mostrar todos os alunos
                    for( Alunos aluno : alunos ){
                        System.out.println("Nome: " + aluno.getNomeAluno());
                        System.out.println("Registro: " + aluno.getMatriculaAluno());
                        System.out.println("Disciplina: " + aluno.getDisciplinasAluno());
                        System.out.println("Contato: " + aluno.getContatoAluno());
                        System.out.println("CPF: " + aluno.getCPFAluno());
                        System.out.println();
                    }

                        break;  
                }

                case 3:  // Retorna ao menu
                    break;

            }

        }while (op != 3);

    }
    
    // Metódo do menu do professor
    public static void menu_Professor(List<Professor> professores, Scanner leitura){

        int op;

        String nomeProfessor, disciplinaProfessor;
        int registroProfessor = 0;
        long CPFProfessor = 0;
    
        do{
    
            System.out.println("\n\tDeseja fazer o que?\n");
            System.out.println("\t1- Adicionar professor?");
            System.out.println("\t2- Mostrar todos os professores!");
            System.out.println("\t3- Sair\n");
        
            System.out.print("A sua escolha foi: ");
            op = leitura.nextInt();
    
            switch (op) {
                case 1:{ // Case para "criar" um professor
                    System.out.print("Nome do Professor: ");
                    nomeProfessor = leitura.next();

                    System.out.print("Registro do professor: ");
                    
                    do {
                        registroProfessor = leitura.nextInt();
                        if(registroProfessor < 4000 || registroProfessor > 4999) {
                            System.out.print("O registro do professor deve estar entre 4000 e 4999. Por favor, digite novamente: ");
                        }
                    } while(registroProfessor < 4000 || registroProfessor > 4999);
                    
                    leitura.nextLine();

                    System.out.print("Disciplina do Professor: ");
                    disciplinaProfessor = leitura.nextLine();

                    List<String> disciplinasPermitidas = Arrays.asList("Estrutura de Dados", "Calculo 2", "Programacao Orientada a Objetos", "Paradigmas de Programacao", "Arquitetura e Organizaocao de Processadores");
                    
                    // Verifique se a disciplina digitada pelo usuário está na lista de disciplinas permitidas
                    while(!disciplinasPermitidas.contains(disciplinaProfessor)) {
                        System.out.println("Disciplina não existente. As disciplinas que existe atualmente são: Estrutura de Dados, Calculo 2, Programacao Orientada a Objetos, Paradigmas de Programacao e Arquitetura e Organizaocao de Processadores");
                        System.out.print("Por favor, digite novamente: ");
                        disciplinaProfessor = leitura.nextLine();
                    }

                    int numerosCPF;

                    System.out.print( "CPF: " );

                    do{
                        CPFProfessor = leitura.nextLong();
                    
                        // Calcula o número de dígitos
                        numerosCPF = (int) Math.log10(CPFProfessor) + 1;

                        if(numerosCPF != 11) {
                            System.out.print( "CPF deve conter 11 números, por favor digite novamente: " );
                        }

                    } while(numerosCPF != 11);
        
                    Professor professor = new Professor(nomeProfessor, registroProfessor, disciplinaProfessor, CPFProfessor);
                    professores.add(professor);
        
                        break;  
                }

                case 2:{ // Case para mostrar todos os professores
                    for (Professor prof : professores) {
                        System.out.println("Nome: " + prof.getNomeProfessor());
                        System.out.println("Registro: " + prof.getRegistroProfessor());
                        System.out.println("Disciplina: " + prof.getDisciplinasProfessor());
                        System.out.println("CPF: " + prof.getCPFProfessor());
                    }

                        break;
                }

                case 3:  // Retorna ao menu
                    break;
            }
    
        }while (op != 3);
    
    }

    // Metódo para adicionar professor na turma
    public static void adicionarProfessorNaTurma(Turmas turma, Professor professor) {
        if(professor != null && turma != null){
            turma.setProfessor(professor);
            System.out.println("Professor adicionado com sucesso na turma!");
        } else {
            System.out.println("Professor ou Turma não pode ser nulo!");
        }
    }
    
    // Metódo para adicionar alunos na turma
    public static void adicionarAlunoNaTurma(Turmas turma, Alunos aluno) {
        if(aluno != null && turma != null){
            turma.getAlunos().add(aluno);
            System.out.println("Aluno adicionado com sucesso na turma!");
        } else {
            System.out.println("Aluno ou Turma não pode ser nulo!");
        }
    }

}