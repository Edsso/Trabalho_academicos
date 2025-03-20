# Disciplina: Arquitetura e Organiza��o de Processadores
# Atividade: Avalia��o 01 � Programa��o em Linguagem de Montagem
# Programa 01

.data

	texto1: .asciz "Informe um valor para Mx: "
	texto2: .asciz "Informe um valor para My: "
	texto3: .asciz "Solicite uma operacao (0 para manter, 1 para inverter): "
	texto4: .asciz "Valor de Mx: "
	texto5: .asciz "\nValor de My: "
	Mx: .word 0   # Vari�vel Mx inicializada com 0
	My: .word 0   # Vari�vel My inicializada com 0

.text

	# Leitura do Primeiro Numero
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto1  # Endere�o da mensagem
	ecall          # Imprime a mensagem
	    
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # L� o inteiro
	la a1, Mx      # Carrega o endere�o de Mx
	sw a0, 0(a1)   # Salva o valor lido em Mx
	
	# Leitura do Segundo Numero
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto2 # Endere�o da mensagem
	ecall          # Imprime a mensagem
	    
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # L� o inteiro
	la a1, My      # Carrega o endere�o de My
	sw a0, 0(a1)   # Salva o valor lido em My
	
	# Solicita��o de opera��o
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto3 # Endere�o da mensagem
	ecall          # Imprime a mensagem
	
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # L� o inteiro
	
	# Verifica se deve inverter os valores
	beqz a0, Mostrar  # Se a escolha for 0 (n�o inverter), v� para imprimir os valores
	
	la a1, Mx      # Carrega o endere�o de Mx
	la a2, My      # Carrega o endere�o de My
	lw a3, 0(a1)   # Carrega o valor de Mx
	lw a4, 0(a2)   # Carrega o valor de My
	sw a4, 0(a1)   # Salva o valor de My em Mx
	sw a3, 0(a2)   # Salva o valor de Mx em My
		
	Mostrar:
	
	# Exibi��o dos valores de Mx e My
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto4 # Endere�o da mensagem
	ecall          # Imprime a mensagem
	
	la a1, Mx      # Carrega o endere�o de Mx
	lw a0, 0(a1)   # Carrega o valor de Mx
	li a7, 1       # Chamada do sistema para imprimir inteiro
	ecall          # Imprime o valor de Mx
	
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto5 # Endere�o da mensagem
	ecall          # Imprime a mensagem
	
	la a1, My      # Carrega o endere�o de My
	lw a0, 0(a1)   # Carrega o valor de My
	li a7, 1       # Chamada do sistema para imprimir inteiro
	ecall          # Imprime o valor de My
	
	# Termina��o do programa
	li a7, 10      # Chamada do sistema para terminar o programa
	ecall
	



