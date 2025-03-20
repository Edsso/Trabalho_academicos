programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	inclua biblioteca Tipos --> tp

	inteiro fundo = 0
	inteiro boox = 0
	inteiro pizza = 0,
	fantasma= 0

	const inteiro LARGURA_TELA = 1000
	const inteiro ALTURA_TELA = 800
	const inteiro ATRASO_ATUALIZACAO = 5

	logico tratar_colisoes = verdadeiro

	inteiro boox_x = 0, boox_y = 0
	inteiro largura_boox_1 = 100	
	inteiro altura_boox_1 = 100
	

	inteiro pizza_x2 = 300	
	inteiro pizza_y2 = 210
	inteiro altura_pizza_y = 260, largura_pizza_x=350
	
	inteiro temp
	
	funcao inicio()
	{
		inicializar()		

		enquanto (nao t.tecla_pressionada(t.TECLA_ESC))
		{
			atualizar()
		}
	}
	funcao inicializar()
	{	
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(LARGURA_TELA, ALTURA_TELA)
		g.definir_titulo_janela("PIZZARIA")
		fundo = g.carregar_imagem("mine.png")
		boox = g.carregar_imagem("boox.png")
		fantasma=g.carregar_imagem("fantasma.png")
		pizza=g.carregar_imagem("pizza2.png")
		
			
	}
	funcao atualizar()
	{
		
		mover()
		desenhar ()
	//	mover_boox_horizontal()

		se (ATRASO_ATUALIZACAO > 0)
		{
			u.aguarde(ATRASO_ATUALIZACAO)
		}
	}
	funcao desenhar()
	{
			g.desenhar_imagem(0, 0, fundo)
			g.desenhar_imagem(boox_x, boox_y, boox)
			g.desenhar_imagem(pizza_x2,pizza_y2,pizza)
			g.renderizar()


	}
	funcao mover()
	{
			se(t.tecla_pressionada(t.TECLA_A)){
				boox_x--
				se (ocorreu_colisao() e tratar_colisoes)
			{
				boox_x++		
			}

			travar_movimento(t.TECLA_A)
			}
			se(t.tecla_pressionada(t.TECLA_D)){
				boox_x++
				se (ocorreu_colisao() e tratar_colisoes)
			{
				boox_x--		
			}

			travar_movimento(t.TECLA_D)
			}
			se(t.tecla_pressionada(t.TECLA_W)){
				boox_y--
				se (ocorreu_colisao())
			{
				escreva ("colisão  ")
				boox_y++	
			}
			}
			se(t.tecla_pressionada(t.TECLA_S)){
				boox_y++
				se (ocorreu_colisao())
			{
				escreva ("colisão  ")
				boox_y--	
			}
			}
		
			
	
	}
	funcao mover_boox_horizontal()
	{
		se (t.tecla_pressionada(t.TECLA_A))
		{
			boox_x--			

			se (ocorreu_colisao() e tratar_colisoes)
			{
				boox_x++		
			}

			travar_movimento(t.TECLA_A)
		}
		senao se (t.tecla_pressionada(t.TECLA_D))
		{
			boox_x++			

			se (ocorreu_colisao() e tratar_colisoes)
			{
				boox_x--		
			}

			travar_movimento(t.TECLA_D)
		}
	}
	funcao travar_movimento(inteiro tecla)
	{
		se (t.tecla_pressionada(t.TECLA_SHIFT) e t.tecla_pressionada(tecla)) 
		{
			desenhar()
			u.aguarde(100)			
		}
	}
	funcao logico ocorreu_colisao()
	{
		
		inteiro dr = boox_x + largura_boox_1 	
		inteiro br = boox_y + altura_boox_1	

		retorne ponto_dentro_retangulo(largura_pizza_x, altura_pizza_y, dr, br)
	
	}
	funcao logico ponto_dentro_retangulo(inteiro x, inteiro y, inteiro dr, inteiro br)
	{
		retorne (x >= boox_x e x <= dr e y >= boox_y e y <= br)
	}
	funcao inteiro valor_absoluto(inteiro numero)
	{
		se (numero < 0)	
		{
			numero = numero * -1
		}

		retorne numero
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 879; 
 * @DOBRAMENTO-CODIGO = [29, 50, 62, 71, 111, 136, 144, 153, 157];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */