# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 01

.data

	num1: .asciz "Entre com o valor de x: "
	num2: .asciz "Entre com o valor de Y: "
	msg: .asciz "O MDC dos valores é: "

.text

	# Imprime a pergunta e Ler do Primeiro Numero
	addi a7, zero, 4
	la a0, num1
	ecall

	addi a7, zero, 5
	ecall

	mv s0, a0

	# Imprime a pergunta e Ler do Segundo Numero
	addi a7, zero, 4
	la a0, num2
	ecall

	addi a7, zero, 5
	ecall

	mv s1, a0

	#Calcula o MDC
	
mdc:

	beqz s1, resultado  # Se s1 ? zero, ent?o o MDC ? s0

	# Calcula o resto da divis?o de s0 por s1
	rem s2, s0, s1

	# Atualiza os valores de s0 e s1
	mv s0, s1
	mv s1, s2

	j mdc

resultado:

	#Exibe o resultado
	li a7, 4
	la a0, msg
	ecall
	
	li a7, 1
	mv a0, s0
	ecall

 	# Finaliza??o do programa
	li a7, 10
	ecall
