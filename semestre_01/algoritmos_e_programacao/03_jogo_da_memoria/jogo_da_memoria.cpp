#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <conio.h>
#include <stdlib.h>
#include <windows.h>

using namespace std;

int main()
{
    int matrizprincipal[4][4], matrizgabarito[4][4], matrizjogo[4][4], par = 1, pecas = 1, operacao, linha[2], coluna[2], tentativas = 24, resolvidos = 0, valor1 = 0, valor2 = 0;
    srand(time(NULL));

    // gera a matriz principal
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            matrizprincipal[i][j] = 0;
        }
    }

    // posiciona os pares aleatoriamente na matriz
    do
    {
        int linharand = rand() % 4, colunarand = rand() % 4;
        if (matrizprincipal[linharand][colunarand] == 0 && pecas == 1)
        {
            matrizprincipal[linharand][colunarand] = par;
            pecas = 2;
        }
        else if (matrizprincipal[linharand][colunarand] == 0 && pecas == 2)
        {
            matrizprincipal[linharand][colunarand] = par;
            pecas = 1;
            par++;
        }
    } while (par <= 8);

    // define a operacao a ser feita com a matriz principal para gerar a gabarito
    operacao = rand() % 4;

    /*mostra a operacao definida
    cout << operacao << endl<< endl; */

    switch (operacao)
    {
    // operacao transposta
    case 0:
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                matrizgabarito[i][j] = matrizprincipal[j][i];
            }
        }
        break;
    // operacao inverte linha
    case 1:
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                matrizgabarito[i][j] = matrizprincipal[3 - i][j];
            }
        }
        break;
    // opearcao inverte coluna
    case 2:
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                matrizgabarito[i][j] = matrizprincipal[i][3 - j];
            }
        }
        break;
    // operacao copia identica
    case 3:
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                matrizgabarito[i][j] = matrizprincipal[i][j];
            }
        }
        break;

    default:
        break;
    }

    // cria matriz jogo
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            matrizjogo[i][j] = 0;
        }
    }

    // inicio do jogo
    do
    {

        // exibe matriz jogo
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                cout << matrizjogo[i][j] << "   ";
            }
            cout << "\n\n";
        }

        cout << "\nTenataivas restantes: " << tentativas << endl;

        // garante que o jogador nao vai digitar uma célula já resolvida
        do
        {
            cout << "\nInsira o valor da linha: ";
            cin >> linha[0];
            cout << "\nInsira o valor da coluna: ";
            cin >> coluna[0];
        } while (matrizjogo[linha[0] - 1][coluna[0] - 1] != 0);

        // iguala as células selecionadas pelo jogador na matriz jogo às da matriz gabarito
        matrizjogo[linha[0] - 1][coluna[0] - 1] = matrizgabarito[linha[0] - 1][coluna[0] - 1];
        // salva o valor da primeira célula
        valor1 = matrizgabarito[linha[0] - 1][coluna[0] - 1];

        system("clS");

        // exibe e matriz jogo
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                cout << matrizjogo[i][j] << "   ";
            }
            cout << "\n\n";
        }

        cout << "\nTenataivas restantes: " << tentativas << endl;

        // garante que o jogador nao vai digitar uma célula já resolvida ou a celula anterior, já que ela ja recebeu um valor diferente de zero
        do
        {
            cout << "\nInsira o valor da linha: ";
            cin >> linha[1];
            cout << "\nInsira o valor da coluna: ";
            cin >> coluna[1];
        } while (matrizjogo[linha[1] - 1][coluna[1] - 1] != 0);

        // iguala as células selecionadas pelo jogador na matriz jogo às da matriz gabarito
        matrizjogo[linha[1] - 1][coluna[1] - 1] = matrizgabarito[linha[1] - 1][coluna[1] - 1];
        valor2 = matrizgabarito[linha[1] - 1][coluna[1] - 1];

        system("clS");

        // exibe a matriz jogo
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                cout << matrizjogo[i][j] << "   ";
            }
            cout << "\n\n";
        }

        cout << "\nTentativas restantes: " << tentativas << endl;

        // teste se achou par
        if (valor1 == valor2)
        {
            cout << "\njogada OK \nLimpando a tela..."; // caso o par tenha sido achado, as "cartas" ficam viradas, exibindo o número
            resolvidos++;
        }
        else
        {
            cout << "\njogada NOK \nLimpando a tela...";
            matrizjogo[linha[0] - 1][coluna[0] - 1] = 0; // caso o par nao tenha sido achado, as "cartas" voltam a ter valor zero (viradas)
            matrizjogo[linha[1] - 1][coluna[1] - 1] = 0;
        }

        // tempo para o jogador memorizar os números que ele virou
        Sleep(5);

        system("clS");

        tentativas--;

    } while (tentativas > 0 && resolvidos < 8);

    // vitória
    if (tentativas > 0 && resolvidos == 8)
    {
        cout << "________________________\n";
        cout << "|                      |\n";
        cout << "|   Voce ganhou!!!!!   |\n";
        cout << "|                      |\n";
        cout << "________________________\n\n";
        cout << "a solucao foi: \n\n";
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                cout << matrizjogo[i][j] << "   ";
            }
            cout << "\n\n";
        }
    }
    // derrota
    else
    {
        cout << "________________________\n";
        cout << "|                      |\n";
        cout << "| tentativas esgotadas |\n";
        cout << "|                      |\n";
        cout << "________________________\n\n";
        cout << "a solucao era: \n\n";
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                cout << matrizgabarito[i][j] << "   ";
            }
            cout << "\n\n";
        }
    }

    /*

    códigos para copiar e colar

    mostra a matriz principal e a gabarito

    for(int i=0; i<4; i++)
    {
         for(int j=0; j<4; j++)
         {
            cout << matrizprincipal[i][j] << "   ";
         }
        cout <<  "\n\n";
    }

    cout << endl;

    for(int i=0; i<4; i++)
    {
         for(int j=0; j<4; j++)
         {
            cout << matrizgabarito[i][j] << "   ";
         }
        cout << "\n\n";
    }

    mostra a matriz

    for(int i=0; i<4; i++)
    {
         for(int j=0; j<4; j++)
         {
            cout << matrizprincipal[i][j] << "   ";
         }
        cout <<  "\n\n";
    }

    */
    return 0;
}
