# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 02 – Programação em Linguagem de Montagem
# Programa 01

.data
    v: .word 3, 9, 2, 13, 27, 6, 1, 8, 50, 23, 7, 15, 31, 2, 9, 18, 22, 14, 30, 5
    texto_input: .asciz "\nInforme até qual posição o vetor será multiplicado (2-20): "

.text
    # Imprime a mensagem pedindo para o usuário inserir o tamanho do vetor
    la a0, texto_input  # Carrega o endereço da mensagem ao registrador a0
    li a7, 4            # Carrega o código do serviço de impressão de string ao a7
    ecall               # Chama a syscall para imprimir a string
    
    # Solicita o tamanho do vetor
    li a7, 5            # Carrega o código do serviço de leitura de inteiro ao a7
    ecall               # Chama a syscall para ler o tamanho do vetor
    mv t0, a0           # Move o tamanho do vetor (posição) para t0

    # Configura os registradores para o loop iterativo
    la a1, v            # Carrega o endereço do vetor no registrador a1
    addi a2, t0, 0      # Configura a posição final do vetor (a2 = t0)
    li s0, 1            # Inicializa o produto como 1
    li t1, 0            # Inicializa o índice como 0

loop:
    bge t1, a2, end_loop  # Verifica se o índice alcançou a posição final do vetor
    lw t2, 0(a1)          # Carrega o valor do vetor em t2
    mul s0, s0, t2        # Multiplica o produto atual pelo valor do vetor
    addi a1, a1, 4        # Avança o ponteiro do vetor para a próxima posição
    addi t1, t1, 1        # Incrementa o índice
    jal zero, loop        # Repete o loop

end_loop:
    # Imprime o resultado
    mv a0, s0             # Move o resultado da multiplicação para a0
    li a7, 1              # Carrega o código do serviço de impressão de inteiro ao a7
    ecall                 # Chama a syscall para imprimir o resultado

    # Finaliza o programa
    li a7, 10             # Carrega o código do serviço de saída ao a7
    ecall                 # Chama a syscall para encerrar o programa
