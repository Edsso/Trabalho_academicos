# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem
# Programa 01

.data

	texto1: .asciz "Informe um valor para Mx: "
	texto2: .asciz "Informe um valor para My: "
	texto3: .asciz "Solicite uma operacao (0 para manter, 1 para inverter): "
	texto4: .asciz "Valor de Mx: "
	texto5: .asciz "\nValor de My: "
	Mx: .word 0   # Variável Mx inicializada com 0
	My: .word 0   # Variável My inicializada com 0

.text

	# Leitura do Primeiro Numero
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto1  # Endereço da mensagem
	ecall          # Imprime a mensagem
	    
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # Lê o inteiro
	la a1, Mx      # Carrega o endereço de Mx
	sw a0, 0(a1)   # Salva o valor lido em Mx
	
	# Leitura do Segundo Numero
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto2 # Endereço da mensagem
	ecall          # Imprime a mensagem
	    
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # Lê o inteiro
	la a1, My      # Carrega o endereço de My
	sw a0, 0(a1)   # Salva o valor lido em My
	
	# Solicitação de operação
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto3 # Endereço da mensagem
	ecall          # Imprime a mensagem
	
	li a7, 5       # Chamada do sistema para ler inteiro
	ecall          # Lê o inteiro
	
	# Verifica se deve inverter os valores
	beqz a0, Mostrar  # Se a escolha for 0 (não inverter), vá para imprimir os valores
	
	la a1, Mx      # Carrega o endereço de Mx
	la a2, My      # Carrega o endereço de My
	lw a3, 0(a1)   # Carrega o valor de Mx
	lw a4, 0(a2)   # Carrega o valor de My
	sw a4, 0(a1)   # Salva o valor de My em Mx
	sw a3, 0(a2)   # Salva o valor de Mx em My
		
	Mostrar:
	
	# Exibição dos valores de Mx e My
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto4 # Endereço da mensagem
	ecall          # Imprime a mensagem
	
	la a1, Mx      # Carrega o endereço de Mx
	lw a0, 0(a1)   # Carrega o valor de Mx
	li a7, 1       # Chamada do sistema para imprimir inteiro
	ecall          # Imprime o valor de Mx
	
	li a7, 4       # Chamada do sistema para imprimir string
	la a0, texto5 # Endereço da mensagem
	ecall          # Imprime a mensagem
	
	la a1, My      # Carrega o endereço de My
	lw a0, 0(a1)   # Carrega o valor de My
	li a7, 1       # Chamada do sistema para imprimir inteiro
	ecall          # Imprime o valor de My
	
	# Terminação do programa
	li a7, 10      # Chamada do sistema para terminar o programa
	ecall
	



