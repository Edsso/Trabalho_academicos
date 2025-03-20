programa
{
	inclua biblioteca Tipos --> tp
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> tex


	
	funcao menu()
	{
		inteiro fundoMenu = g.carregar_imagem("mine.png")
		inteiro setaOP = g.carregar_imagem("seta.png")

		inteiro larguraTela= 1000, alturaTela = 800
		g.iniciar_modo_grafico(verdadeiro)
		g.definir_dimensoes_janela(larguraTela, alturaTela)

		fundoMenu = g.redimensionar_imagem(fundoMenu, larguraTela, alturaTela, verdadeiro)
		setaOP = g.redimensionar_imagem(setaOP, 100, 100, verdadeiro)

		inteiro op = 0
		enquanto (verdadeiro)
			g.limpar()
			g.desenhar_imagem(0, 0, fundoMenu)

			g.definir_cor(g.COR_BRANCO)
			g.definir_tamanho_texto(60)
			g.desenhar_texto(larguraTela-500, alturaTela-420, "Jogar")
			g.definir_cor(g.criar_cor(150, 150, 150))
			g.desenhar_texto(larguraTela-498, alturaTela-418, "Jogar")
			

			g.definir_cor(g.COR_BRANCO)
			g.desenhar_texto(larguraTela-400, alturaTela-350, "Sair")
			g.definir_cor(g.criar_cor(150, 150, 150))
			g.desenhar_texto(larguraTela-398, alturaTela-348, "Sair")

			se (op==0)
			{
				g.desenhar_imagem(larguraTela-200, alturaTela-510, setaOP)
				se (t.alguma_tecla_pressionada()){
					se (t.tecla_pressionada(t.TECLA_SETA_ABAIXO)){
						op = 1
					}senao se(t.tecla_pressionada(t.TECLA_ENTER)){
						/* Tela de Load*/ /*Jogo*/
					}
				}
			}
			senao
			{
				g.desenhar_imagem(larguraTela-300, alturaTela-410, setaOP)
				se (t.alguma_tecla_pressionada()){
					se (t.tecla_pressionada(t.TECLA_SETA_ACIMA)){
						op = 0
					}senao se(t.tecla_pressionada(t.TECLA_ENTER)){
						retorne
					}
				}
			}
			
			g.renderizar()
	
	}
	funcao inicio()
	{
		menu()
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 682; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */