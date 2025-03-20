/*Versão beta desenvolvida por Professor Thiago para disciplina de Algoritmos*/
#include <iostream>
#include <windows.h>
#include <conio.h> ///para o getch() /// https://stackoverflow.com/questions/34474627/linux-equivalent-for-conio-h-getch
#include <cstdlib>
#include <time.h>
#define ACELERACAO 30
#define QUANTIDADE_OBSTACULO_PARA_ACELERAR 5

using namespace std;

/*
    F L A P B I R D (M2 Algoritmos)
    - Lembrando: não permitido o uso de funções e variáveis compostas como structs, vetores e matrizes
    - Corrigir os rastros (pássaro e obstáculos)
    - Implementar colisão
    - Implementar pontuação (mais um ponto para cada obstáculo superado)
    - Fazer 2 obstáculos simultâneos (obstaculo1 e obstaculo2)
    - Deixar a pontuação visível durante todo o jogo
    - Definir marcos para acelerar a velocidade
*/

int main()
{
    /// ALERTA: NÃO MODIFICAR O TRECHO DE CÓDIGO, A SEGUIR.
    // INICIO: COMANDOS PARA QUE O CURSOR NÃO FIQUE PISCANDO NA TELA
    HANDLE out = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO cursorInfo;
    GetConsoleCursorInfo(out, &cursorInfo);
    cursorInfo.bVisible = false; // set the cursor visibility
    SetConsoleCursorInfo(out, &cursorInfo);
    // FIM: COMANDOS PARA QUE O CURSOR NÃO FIQUE PISCANDO NA TELA
    // INÍCIO: COMANDOS PARA REPOSICIONAR O CURSOR NO INÍCIO DA TELA
    COORD coord;
    // FIM: COMANDOS PARA REPOSICIONAR O CURSOR NO INÍCIO DA TELA
    /// ALERTA: NÃO MODIFICAR O TRECHO DE CÓDIGO, ACIMA.

    float bird_x = 15, bird_y = 10, sleeptime = 150;
    int obstaculo_x1 = 129, obstaculo_y1 = 0;
    int obstaculo_x2 = 129, obstaculo_y2 = 0;
    int tecla;
    int barreiraaleatoria1, barreiraaleatoria2;
    int barreira1ativa = 0, barreira2ativa = 0, comecarbarreira2 = 0;
    int pontuacao = 0;
    int tamanhoBarreira = 0;

    srand(time(NULL));

    // MENU DO JOGO

    int opcao;
    cout << "------------------------------------------------------------------------------------------------------------------------";
    cout << "\n\n\n\n";
    cout << "                                                   Seja bem-vindo ao nosso jogo!\n\n\n";
    cout << "                                              Aviso: Pressione 1 ou 2 para comecar...\n\n";
    cout << "                                              1. Comecar o jogo! (Dificuldade Facil)\n";
    cout << "                                              2. Comecar o jogo! (Dificuldade Normal)\n";
    cout << "                                              3. Comecar o jogo! (Dificuldade Dificil)\n";
    cout << "\n\n\n\n\n\n\n\n";
    cout << "------------------------------------------------------------------------------------------------------------------------";

    cin >> opcao;

    do
    {
        if (opcao != 1 && opcao != 2 && opcao != 3)
        {
            cout << "1 ou 2!!!\n";
            cin >> opcao;
        }
    } while (opcao != 1 && opcao != 2 && opcao != 3);

    if (opcao == 1)
    {
        tamanhoBarreira = 5;
    }
    else if (opcao == 2)
    {
        tamanhoBarreira = 3;
    }
    else if (opcao == 3)
    {
        tamanhoBarreira = 1;
    }

    while (true)
    { // esse laço faz o jogo rodar para sempre

        // POSICIONA O PÁSSARO
        coord.X = bird_x;
        coord.Y = bird_y;
        SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
        cout << char(190);
        // POSICIONA O PÁSSARO

        // VERIFICA COMANDO DO JOGADOR
        if (kbhit()) /// verifica se uma tecla foi pressionada
        {
            tecla = getch(); /// verifica comando do jogador
        }

        if (tecla == 32 || tecla == 'w' || tecla == 'W')
        {
            system("cls");
            bird_y = bird_y - 2;
            tecla = '0';
        }
        else
        {
            system("cls");
            bird_y++; // PÁSSARO CAI 1 POSIÇÃO SE NÃO FOI PRESSIONADO PARA SUBIR
        }
        // VERIFICA COMANDO DO JOGADOR

        // DESENHO DO CENÁRIO
        cout << "------------------------------------------------------------------------------------------------------------------------";
        cout << "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
        cout << "------------------------------------------------------------------------------------------------------------------------";
        cout << "Pontuacao: " << pontuacao << endl;
        cout << "Velocidade: " << 150.0 / sleeptime << "X" << endl;
        cout << "Sleeptime: " << sleeptime << endl;
        // DESENHO DO CENÁRIO

        // COLISAO AO BATER NA LINHA DE CIMA OU DE BAIXO
        if (bird_y == 20 || bird_y == 0)
        {
            cout << "\nGAME OVER\n\n";
            break;
        }
        // COLISAO AO BATER NA LINHA DE CIMA OU DE BAIXO

        // OBSTACULO 1
        obstaculo_y1 = 1;
        if (barreira1ativa == 0) // GERA NUMERO ALEATORIO SE OBSTACULO 1 NAO ESTA NA TELA
        {
            barreiraaleatoria1 = rand() % 20;
            barreira1ativa = 1;
            if (barreiraaleatoria1 < (tamanhoBarreira + 1)) // EVITA BUG DE BARREIRA SEM BURACO OU COM BURACO MENOR NAS EXTREMIDADES
            {
                barreiraaleatoria1 = (tamanhoBarreira + 1);
            }
        }
        while (obstaculo_y1 < 20)
        {

            coord.X = obstaculo_x1;
            coord.Y = obstaculo_y1;
            SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
            if (obstaculo_y1 < (barreiraaleatoria1 - tamanhoBarreira) || obstaculo_y1 > barreiraaleatoria1)
            {
                cout << char(219);
            }
            else
            {
                cout << "  ";
            }

            obstaculo_y1++;
        }

        // OBSTACULO 1 AVANÇA UMA POSIÇÃO PARA ESQUERDA
        obstaculo_x1--;

        // OBSTACULO 1 AVISA O 2 PARA SURGIR QUANDO CHEGA NA DISTANCIA CERTA
        if (obstaculo_x1 < 65 && obstaculo_x1 > 50)
        {
            comecarbarreira2 = 1;
        }

        if (obstaculo_x1 <= -1) // OBSTACULO 1 RETORNA PARA O COMECO E INFORMA QUE SAIU DA TELA
        {
            barreira1ativa = 0;
            obstaculo_x1 = 129, obstaculo_y1 = 0;
        }

        // OBSTACULO 2

        if (comecarbarreira2 == 1)
        { // VERIFICACAO SE O OBSTACULO 1 JA TOMOU DISTANCIA SUFICIENTE
            obstaculo_y2 = 1;
            if (barreira2ativa == 0) // GERA NUMERO ALEATORIO SE OBSTACULO 2 NAO ESTA NA TELA
            {
                barreiraaleatoria2 = rand() % 20;
                barreira2ativa = 1;
                if (barreiraaleatoria2 < (tamanhoBarreira + 1)) // EVITA BUG DE BARREIRA SEM BURACO OU COM BURACO MENOR NAS EXTREMIDADES
                {
                    barreiraaleatoria2 = (tamanhoBarreira + 1);
                }
            }
            while (obstaculo_y2 < 20)
            {

                coord.X = obstaculo_x2;
                coord.Y = obstaculo_y2;
                SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
                if (obstaculo_y2 < (barreiraaleatoria2 - tamanhoBarreira) || obstaculo_y2 > barreiraaleatoria2)
                {
                    cout << char(219);
                }
                else
                {
                    cout << " ";
                }

                obstaculo_y2++;
            }
            // OBSTACULO 2 AVANÇA UMA POSIÇÃO PARA ESQUERDA
            obstaculo_x2--;

            if (obstaculo_x2 <= -1) // OBSTACULO 2 RETORNA PARA O COMECO E INFORMA QUE SAIU DA TELA
            {
                barreira2ativa = 0;
                obstaculo_x2 = 129, obstaculo_y1 = 0;
                comecarbarreira2 = 0;
            }
        }
        // DETECCAO DE COLISOES COM BARREIRA OU AUMENTO DE PONTUACAO DO OBSTACULO 1
        if (obstaculo_x1 == 15 && (bird_y > barreiraaleatoria1 || bird_y < (barreiraaleatoria1 - tamanhoBarreira)))
        {
            cout << "\nGAME OVER\n\n";
            break;
        }
        else if (obstaculo_x1 == 15 && (bird_y <= barreiraaleatoria1 || bird_y >= (barreiraaleatoria1 - tamanhoBarreira)))
        {
            pontuacao++;
            // AUMENTO DE VELOCIDADE A CADA X PONTOS
            if (pontuacao % QUANTIDADE_OBSTACULO_PARA_ACELERAR == 0 && pontuacao != 0 && sleeptime > (ACELERACAO))
            {
                sleeptime = sleeptime - ACELERACAO;
            }
            else if (pontuacao % QUANTIDADE_OBSTACULO_PARA_ACELERAR == 0 && pontuacao != 0 && sleeptime <= ACELERACAO)
            {
                sleeptime = 20;
            }
        }

        // DETECCAO DE COLISOES COM BARREIRA OU AUMENTO DE PONTUACAO DO OBSTACULO 2
        if (obstaculo_x2 == 15 && (bird_y > barreiraaleatoria2 || bird_y < (barreiraaleatoria2 - tamanhoBarreira)))
        {
            cout << "\nGAME OVER\n\n";
            break;
        }
        else if (obstaculo_x2 == 15 && (bird_y <= barreiraaleatoria2 || bird_y >= (barreiraaleatoria2 - tamanhoBarreira)))
        {
            pontuacao++;
            // AUMENTO DE VELOCIDADE A CADA X PONTOS
            if (pontuacao % QUANTIDADE_OBSTACULO_PARA_ACELERAR == 0 && pontuacao != 0 && sleeptime > ACELERACAO)
            {
                sleeptime = sleeptime - ACELERACAO;
            }
            else if (pontuacao % QUANTIDADE_OBSTACULO_PARA_ACELERAR == 0 && pontuacao != 0 && sleeptime <= ACELERACAO)
            {
                sleeptime = 20;
            }
        }

        // TEMPO DE ESPERA
        Sleep(sleeptime);
    }

    return 0;
}
