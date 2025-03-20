# Disciplina: Organização de Computadores
# Atividade: Avaliação 03 – Hierarquia de Memória

.data
    Matriz_A:       .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 
                    35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 
                    69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99
    
    Matriz_B:  	   .word 0, 10, 0, 10, 0, 10, 0, 10, 0, 10,0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10,
                   0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 
                   0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10

    
    Matriz_C:       .word 0:100
    
    prompt:         .asciz "\n\t(Insira o tamanho dos índices da matriz, mínimo = 2 e máximo = 10) "   # Mensagem para solicitar tamanho da matriz
    valorInvalido:  .asciz "\tValor inválido. Tente novamente!\n" # Mensagem de erro para valor inválido
    tipoPercurso:   .asciz "\tEscolha o tipo de percurso da matriz (1 = coluna-linha, 0 = linha-coluna)"  # Solicitação do tipo de percurso
    novaLinha:      .asciz "\n"       # Sequência de nova linha
    tab:            .asciz "\t"       # Sequência de tab
    
.text
    jal zero, inicio     # O código começa em 'inicio'

inicio:
    addi t0, zero, 2    # Tamanho mínimo = 2
    addi t1, zero, 10   # Tamanho máximo = 10
    
    loopTamanho:
        # Imprime string para solicitar o tamanho da matriz
        addi a7, zero, 4    # Armazena código de chamada de sistema para imprimir string
        la a0, prompt       # Carrega o endereço da string 'prompt'
        ecall               # Chamada de sistema para exibir 'prompt'
    
        # Lê o valor do tamanho da matriz
        addi a7, zero, 5    # a7 = 5 -> Chama o sistema para ler um inteiro
        ecall               # Chamada de sistema para ler valor
        
        # Verificação condicional para garantir que o tamanho esteja entre 2 e 10
        blt a0, t0, tratarErro   # Se o valor de a0 for menor que 2, vai para 'tratarErro'
        bgt a0, t1, tratarErro   # Se o valor de a0 for maior que 10, vai para 'tratarErro'

        add s0, a0, zero    # Armazena o valor do tamanho em s0
        jal zero, fimLoopTamanho
    fimLoopTamanho:
    
    addi t0, zero, 0    # Tipo 0 -> linha-coluna
    addi t1, zero, 1    # Tipo 1 -> coluna-linha
    
    loopTipo:
        # Imprime string para solicitar o tipo de percurso
        addi a7, zero, 4     # Armazena código de chamada de sistema para imprimir string
        la a0, tipoPercurso # Carrega o endereço da string 'tipoPercurso'
        ecall                # Chamada de sistema para exibir 'tipoPercurso'
    
        # Lê o valor do tipo de percurso
        addi a7, zero, 5     # a7 = 5 -> Chama o sistema para ler um inteiro
        ecall               # Chamada de sistema para ler valor

        # Verificação condicional para garantir que o tipo de percurso seja válido (0 ou 1)
        blt a0, t0, tratarErro   # Se o valor de a0 for menor que 0, vai para 'tratarErro'
        bgt a0, t1, tratarErro  # Se o valor de a0 for maior que 1, vai para 'tratarErro'

        add s4, a0, zero    	# Armazena o tipo de percurso em s4
        jal zero, fimLoopTipo
    fimLoopTipo:
    
     # Carrega os endereços das matrizes na memória
    la s1, Matriz_A     	# Carrega o endereço de Matriz_A em s1
    la s2, Matriz_B      	# Carrega o endereço de Matriz_B em s2
    la s3, Matriz_C      	# Carrega o endereço de Matriz_C em s3
    jal ra, verificacao   	# Chama a sub-rotina de verificação
    
    # Chama a sub-rotina exibirMatriz para exibir as matrizes
    la a1, Matriz_A
    jal ra, exibirMatriz  
    
    la a1, Matriz_B
    jal ra, exibirMatriz   
    
    la a1, Matriz_C
    jal ra, exibirMatriz  
    ecall
          

tratarErro:
    # Imprime mensagem de erro para valor inválido
    addi a7, zero, 4    	# Armazena código de chamada de sistema para imprimir string
    la a0, valorInvalido 	# Carrega a mensagem de erro 'valorInvalido'
    ecall               	# Chamada de sistema para exibir a mensagem de erro

    # Salta de volta para o loop apropriado com base no valor de s0 (tamanho da matriz) ou s4 (tipo de percurso)
    beq s0, zero, loopTamanho   # Se s0 for zero, vai para 'loopTamanho'
    jal zero, loopTipo       	# Caso contrário, vai para 'loopTipo'
    
exibirMatriz:
    addi t0, zero, 0    	# Inicializa t0 para 0 (contador de linhas)
    add t6, zero, s0    	# t6 contém a ordem da matriz (número de linhas ou colunas)
    
    # Imprime nova linha
    addi a7, zero, 4
    la a0, novaLinha
    ecall
    
    # Imprime tabulação
    addi a7, zero, 4
    la a0, tab
    ecall
    
     loopExterna:
        beq t0, t6, fimLoopExterno    # Se t0 for igual a ordem da matriz, termina o loop externo
        add t1, zero, zero  	# Inicializa j = 0
        
        loopInterna:
            beq t1, t6, fimLoopInterno  # Se t1 for igual a ordem da matriz, termina o loop interno
            
            # Calcula posição da matriz (i, j)
            mul t2, t0, t6  	# t2 = i * ordem 
            slli t2, t2, 2  	# Multiplica t2 por 4 (tamanho de palavra)
            slli t3, t1, 2  	# Multiplica j por 4 (tamanho de palavra)
            add t4, t2, t3  	# t4 = posição da célula
            add t5, t4, a1  	# Carrega endereço de Matriz_A + posição
            lw a0, 0(t5)    	# Lê valor de Matriz_A[i][j]
            
            # Lê e imprime valor da matriz
            addi a7, zero, 1 	# Exibe valor inteiro
            ecall
            
            addi a7, zero, 4 	# Exibe espaço em branco após o valor
            la a0, tab
            ecall

            addi t1, t1, 1    # Incrementa contador de colunas
            jal zero, loopInterna   # Retorna para o loop interno
        fimLoopInterno:
        
        # Imprime nova linha
        addi a7, zero, 4
        la a0, novaLinha
        ecall
    
        # Imprime o tab
        addi a7, zero, 4
        la a0, tab
        ecall

        addi t0, t0, 1    # Incrementa contador de linhas
        jal zero, loopExterna   # Retorna para o loop externo
    fimLoopExterno:
    jalr ra, 0	# Retorna da função de verificação
    
verificacao:
    # Verifica se o tipo de percurso é linha (s4 == 0) ou coluna (s4 == 1)
    beq s4, t0, somaMatrizLinha      # Se s4 == 0, chama a sub-rotina somaMatrizLinha
    beq s4, t1, somaMatrizColuna     # Se s4 == 1, chama a sub-rotina somaMatrizColuna
    
# Sub-rotina para soma das matrizes por linha
somaMatrizLinha:
    addi t0, zero, 0    # Inicializa t0 para 0 (contador de linhas)
    add t6, zero, s0    # t6 contém a ordem da matriz (número de linhas ou colunas)
    
    loopSomaLinha:
        beq t0, t6, fimSomaLinha   # Se t0 for igual à ordem da matriz, termina o loop de soma das linhas
        add t1, zero, zero    # Inicializa t1 para 0 (contador de colunas)
        
        loopSomaInterno:
            beq t1, t6, fimSomaInterno  # Se t1 for igual à ordem da matriz, termina o loop de soma das colunas
            
            # Calcula a posição da célula na matriz (i, j)
            mul t2, t0, t6   # t2 = i * ordem
            slli t2, t2, 2    # Multiplica t2 por 4 (tamanho de palavra)
            slli t3, t1, 2    # Multiplica j por 4 (tamanho de palavra)
            add t4, t2, t3    # t4 = posição da célula
            
            add t5, t4, s1    # s1 aponta para Matriz_A, então adiciona a posição à base
            lw t2, 0(t5)      # Carrega o valor da célula A[i][j] em t2
            
            add t5, t4, s2  # m[t2][t3] em s2
            lw t3, 0(t5)    # a0 = m[t2][t3]
            
            # Soma os valores das matrizes
            add t6, t3, t2
            add t5, t4, s3  # m[t2][t3] em s3
            sw t6, 0(t5)    # m[t2][t3] = t6 em s3
            
            add t6, zero, s0    # Soma o valor de A[i][j] ao acumulador s4
            addi t1, t1, 1    # Incrementa contador de colunas
            jal zero, loopSomaInterno  # Retorna para o loop de soma das colunas
        fimSomaInterno:
    
        addi t0, t0, 1     # Incrementa contador de linhas
        jal zero, loopSomaLinha  # Retorna para o loop de soma das linhas
    fimSomaLinha:
    jalr ra, 0           # Retorna da sub-rotina somaMatrizLinha

# Sub-rotina para soma das matrizes por coluna
somaMatrizColuna:
    addi t1, zero, 0     # Inicializa t0 para 0 (contador de linhas)
    add t6, zero, s0     # t6 contém a ordem da matriz (número de linhas ou colunas)
    
    loopSomaColuna:
        beq t1, t6, fimSomaColuna   # Se t0 for igual à ordem da matriz, termina o loop de soma das colunas
        addi t0, zero, 0    # Inicializa t1 para 0 (contador de linhas)
    
        loopSomaInternaColuna:
            beq t0, t6, fimSomaInternaColuna  # Se t1 for igual à ordem da matriz, termina o loop de soma das linhas
            
            # Calcula a posição da célula na matriz (i, j)
            mul t2, t0, t6   # t2 = j * ordem
            slli t2, t2, 2    # Multiplica t2 por 4 (tamanho de palavra)
            slli t3, t1, 2    # Multiplica i por 4 (tamanho de palavra)
            add t4, t2, t3    # t4 = posição da célula
            
            add t5, t4, s1    # s2 aponta para Matriz_B, então adiciona a posição à base
            lw t2, 0(t5)      # t2 = m[t2][t3] em s1 
            
            add t5, t4, s2   # m[t2][t3] em s2
            lw t3, 0(t5)     # m[t2][t3] em s2
            
            # Soma os valores das matrizes
            add t6, t3, t2
            add t5, t4, s3  # m[t2][t3] em s3
            sw t6, 0(t5)    # m[t2][t3] = t6 em s3
            
            add t6, zero, s0    # Soma o valor de Matriz_B[i][j] ao acumulador s4
            addi t0, t0, 1    # Incrementa contador de linhas
            jal zero, loopSomaInternaColuna  # Retorna para o loop de soma das linhas
        fimSomaInternaColuna:

        addi t1, t1, 1     # Incrementa contador de colunas
        jal zero, loopSomaColuna  # Retorna para o loop de soma das colunas
    fimSomaColuna:
    jalr ra, 0           # Retorna da sub-rotina somaMatrizColuna

