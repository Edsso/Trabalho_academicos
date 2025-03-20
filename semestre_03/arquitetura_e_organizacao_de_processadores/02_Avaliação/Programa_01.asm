# Disciplina: Arquitetura e Organiza��o de Processadores
# Atividade: Avalia��o 02 � Programa��o em Linguagem de Montagem
# Programa 01

.data
    v: .word 3, 9, 2, 13, 27, 6, 1, 8, 50, 23, 7, 15, 31, 2, 9, 18, 22, 14, 30, 5
    texto_input: .asciz "\nInforme at� qual posi��o o vetor ser� multiplicado (2-20): "

.text
    # Imprime a mensagem pedindo para o usu�rio inserir o tamanho do vetor
    la a0, texto_input  # Carrega o endere�o da mensagem ao registrador a0
    li a7, 4            # Carrega o c�digo do servi�o de impress�o de string ao a7
    ecall               # Chama a syscall para imprimir a string
    
    # Solicita o tamanho do vetor
    li a7, 5            # Carrega o c�digo do servi�o de leitura de inteiro ao a7
    ecall               # Chama a syscall para ler o tamanho do vetor
    mv t0, a0           # Move o tamanho do vetor (posi��o) para t0

    # Configura os registradores para o loop iterativo
    la a1, v            # Carrega o endere�o do vetor no registrador a1
    addi a2, t0, 0      # Configura a posi��o final do vetor (a2 = t0)
    li s0, 1            # Inicializa o produto como 1
    li t1, 0            # Inicializa o �ndice como 0

loop:
    bge t1, a2, end_loop  # Verifica se o �ndice alcan�ou a posi��o final do vetor
    lw t2, 0(a1)          # Carrega o valor do vetor em t2
    mul s0, s0, t2        # Multiplica o produto atual pelo valor do vetor
    addi a1, a1, 4        # Avan�a o ponteiro do vetor para a pr�xima posi��o
    addi t1, t1, 1        # Incrementa o �ndice
    jal zero, loop        # Repete o loop

end_loop:
    # Imprime o resultado
    mv a0, s0             # Move o resultado da multiplica��o para a0
    li a7, 1              # Carrega o c�digo do servi�o de impress�o de inteiro ao a7
    ecall                 # Chama a syscall para imprimir o resultado

    # Finaliza o programa
    li a7, 10             # Carrega o c�digo do servi�o de sa�da ao a7
    ecall                 # Chama a syscall para encerrar o programa
