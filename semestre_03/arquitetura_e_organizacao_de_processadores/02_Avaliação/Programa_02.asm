# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 02 – Programação em Linguagem de Montagem
# Programa 02

.data
    v: .word 3, 9, 2, 13, 27, 6, 1, 8, 50, 23, 7, 15, 31, 2, 9, 18, 22, 14, 30, 5
    texto_input: .asciz "\nInforme até qual posição o vetor será multiplicado (2-20): "

.text
    # Carrega o endereço base do vetor
    la a1, v

    # Imprime a mensagem pedindo para o usuário inserir o tamanho do vetor
    la a0, texto_input  # Carrega o endereço da mensagem ao registrador a0
    li a7, 4            # Carrega o código do serviço de impressão de string ao a7
    ecall               # Chama a syscall para imprimir a string

    # Lê a última posição a ser multiplicada (entrada do usuário)
    li a7, 5            # Carrega o código do serviço de leitura de inteiro ao a7
    ecall               # Chama a syscall para ler o tamanho do vetor
    add a2, zero, a0    # Guarda o valor lido em a2

    # Chama a função rec_mul_vet
    jal ra, rec_mul_vet

    # Chamada de sistema para imprimir inteiro
    li a7, 1            # Carrega o código do serviço de impressão de inteiro ao a7
    ecall               # Chama a syscall para imprimir o resultado

    # Termina o programa
    li a7, 10           # Carrega o código do serviço de saída ao a7
    ecall               # Chama a syscall para encerrar o programa

rec_mul_vet:
    # Reserva espaço na pilha para armazenar ra, a2 e a0
    addi sp, sp, -12
    sw ra, 0(sp)
    sw a2, 4(sp)
    sw a0, 8(sp)        # Armazena o valor atual de a0

    # Inicializa o produto como 1
    li a0, 1

    # Inicializa o contador i como 0
    li t0, 0

loop:
    # Verifica se i >= a2 (condição de parada)
    bge t0, a2, end_loop   # Corrigido para comparar t0 com a2

    # Calcula o endereço do elemento vet[i]
    slli t1, t0, 2      # Multiplica i por 4 (tamanho da palavra)
    add t1, a1, t1      # Calcula o endereço vet[i]
    lw t2, 0(t1)        # Carrega vet[i] em t2

    # Multiplica a0 pelo valor do elemento atual do vetor
    mul a0, a0, t2

    # Incrementa i
    addi t0, t0, 1

    # Salva a0 na pilha antes de chamar loop
    sw a0, 8(sp)

    # Salta para o início do loop
    jal ra, loop

end_loop:
    # Restaura os valores de ra, a2 e a0 da pilha
    lw ra, 0(sp)
    lw a2, 4(sp)
    lw a0, 8(sp)        # Restaura o valor de a0
    addi sp, sp, 12

    # Retorna o produto
    jalr zero, ra, 0

