# Disciplina: Arquitetura e Organiza��o de Processadores
# Atividade: Avalia��o 01 � Programa��o em Linguagem de Montagem
# Programa 01

.data

	num1: .asciz "Primeiro numero: "
	num2: .asciz "Segundo numero: "
	resultado: .asciz "Resultado: "

.text

	# Leitura do Primeiro Numero
	li a7, 4
	la a0, num1
	ecall
	
	li a7, 5
	ecall
	
	mv t0, a0

	# Leitura do Segundo Numero
	li a7, 4
	la a0, num2
	ecall
	
	li a7, 5
	ecall
	
	mv t1, a0
	
	# Inicializa o resultado com zero
	li t2, 0

	Loop:
	   
	     # Verifica se t1 � igual a zero (fim da multiplica��o)
	    beqz t1, Verificador_Loop
	
	    # Verifica se o bit menos significativo de t1 � 1
	    andi t3, t1, 1
	    beqz t3, Shift
	
	    # Soma t0 ao resultado
	    add t2, t2, t0
	
	Shift:
	
	    # Desloca t1 para a direita (divis�o por 2)
	    srli t1, t1, 1
	
	    # Desloca t0 para a esquerda (multiplica��o por 2)
	    slli t0, t0, 1
	
	    j Loop
	
	Verificador_Loop:
	
	    # Exibe o resultado
	    li a7, 4
	    la a0, resultado
	    ecall
	
	    li a7, 1
	    mv a0, t2
	    ecall