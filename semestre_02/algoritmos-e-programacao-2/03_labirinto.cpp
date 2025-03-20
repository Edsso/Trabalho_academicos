#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <windows.h> // Só serve para mostrar corzinha
#include <iomanip>   // Só serve para mostrar a matriz com espaço e por os números nas linhas e colunas

using namespace std;

#define RESET "\033[0m"
#define RED "\033[31m"
#define GREEN "\033[32m"

// Struct para as linhas e colunas
struct Jogadas
{
    int primeiraLinha, primeiraColuna;
    int ultimaLinha, ultimaColuna;
};

// Função para limpar o terminal
void limparTela()
{
    system("cls");
}

// Função para verificar se uma posição no labirinto possui caminhos duplos
bool possuiCaminhosDuplos(const vector<string> &labirinto, int linha, int coluna)
{
    int countVazios = 0;

    // Verificar para cima
    if (linha - 1 >= 0 && labirinto[linha - 1][coluna] == '_')
        countVazios++;

    // Verificar para baixo
    if (linha + 1 < labirinto.size() && labirinto[linha + 1][coluna] == '_')
        countVazios++;

    // Verificar à esquerda
    if (coluna - 1 >= 0 && labirinto[linha][coluna - 1] == '_')
        countVazios++;

    // Verificar à direita
    if (coluna + 1 < labirinto[0].size() && labirinto[linha][coluna + 1] == '_')
        countVazios++;

    // Verificar se possui exatamente três vizinhos vazios
    return countVazios >= 3;
}

// Função para imprimir o labirinto com cores
void imprimirLabirinto(const vector<string> &labirinto)
{
    // Imprimir números de coluna na primeira linha
    cout << setw(4) << ""; // Espaço para o canto superior esquerdo

    for (int i = 0; i < labirinto[0].size(); i++)
    {
        cout << setw(4) << i;
    }
    cout << endl;

    // Imprimir a matriz com números de linha e conteúdo
    for (int i = 0; i < labirinto.size(); i++)
    {
        cout << setw(4) << i; // Número de linha

        for (int j = 0; j < labirinto[0].size(); j++)
        {
            // Adiciona cor verde para 'P' e vermelho para 'N'
            if (labirinto[i][j] == 'P')
            {
                cout << GREEN << setw(4) << labirinto[i][j] << RESET;
            }
            else if (labirinto[i][j] == 'N')
            {
                cout << RED << setw(4) << labirinto[i][j] << RESET;
            }
            else
            {
                cout << setw(4) << labirinto[i][j]; // Não adiciona cor
            }
        }

        cout << endl;
    }
    cout << endl;
}

// Função recursiva para o sistema do jogo
bool jogarOLabirinto(vector<string> &labirinto, Jogadas &jogada)
{
    // Verificar se a posição é válida
    if (jogada.primeiraLinha < 0 || jogada.primeiraLinha >= labirinto.size() ||
        jogada.primeiraColuna < 0 || jogada.primeiraColuna >= labirinto[0].size() ||
        labirinto[jogada.primeiraLinha][jogada.primeiraColuna] == 'X' ||
        labirinto[jogada.primeiraLinha][jogada.primeiraColuna] == 'P' ||
        labirinto[jogada.primeiraLinha][jogada.primeiraColuna] == 'L')
    {
        return false; // Posição inválida, barreira ou já visitada, retorna false
    }

    // Marcar a posição atual
    labirinto[jogada.primeiraLinha][jogada.primeiraColuna] = 'P';

    limparTela();
    imprimirLabirinto(labirinto);

    // Sistema de vitória e derrota
    if (jogada.primeiraLinha == jogada.ultimaLinha && jogada.primeiraColuna == jogada.ultimaColuna)
    {
        cout << "Voce conseguiu chegar ao seu destino!!!" << endl;
        return true; // Chegou ao destino, retorna true
    }
    else
        cout << "Parece que voce nao conseguiu chegar ao destino..." << endl;

    // Tentar mover para cima
    jogada.primeiraLinha--;
    if (jogarOLabirinto(labirinto, jogada))
        return true;
    jogada.primeiraLinha++; // Desfazer o movimento

    // Tentar mover para baixo
    jogada.primeiraLinha++;
    if (jogarOLabirinto(labirinto, jogada))
        return true;
    jogada.primeiraLinha--; // Desfazer o movimento

    // Tentar mover para a esquerda
    jogada.primeiraColuna--;
    if (jogarOLabirinto(labirinto, jogada))
        return true;
    jogada.primeiraColuna++; // Desfazer o movimento

    // Tentar mover para a direita
    jogada.primeiraColuna++;
    if (jogarOLabirinto(labirinto, jogada))
        return true;
    jogada.primeiraColuna--; // Desfazer o movimento

    // Se nenhum movimento for possível, marcar como visitado e retornar false
    labirinto[jogada.primeiraLinha][jogada.primeiraColuna] = 'N';
    return false;
}

// Função para a leitura do arquivo e jogar (Não conseguimos fazer que o arquivo lido seja verificado com caminhos duplos)
void leituraDoLabirinto(vector<string> &labirinto, Jogadas &jogada)
{

    limparTela();
    do
    {
        string leitura;
        cout << "Qual o nome do seu arquivo?" << endl;
        cin >> leitura;
        cout << endl;

        ifstream arquivoEntrada(leitura);

        if (arquivoEntrada.is_open())
        {
            string linha;
            int contadorLinha = 0;
            int contadorColuna = 0;

            // Vai ler cada linha da matriz e colocar na variável 'labirinto' e vai adicionar um contador para contar quantas linhas e colunas há na matriz
            while (getline(arquivoEntrada, linha))
            {
                labirinto.push_back(linha);
                contadorLinha++;

                if (contadorLinha == 1)
                {
                    contadorColuna = linha.size();
                }
            }

            /*bool possuiDuplos;

                do{
                    possuiDuplos = false;
                    for (int i = 0; i < contadorLinha; i++)
                    {
                        for (int j = 0; j < contadorColuna; j++)
                        {
                            if (labirinto[i][j] == '_' && possuiCaminhosDuplos(labirinto, i, j))
                            {
                                possuiDuplos = true;
                                break;
                            }
                        }
                        if (possuiDuplos)
                        {
                            cout << "Caminho Duplo" << endl;
                            break;
                        }
                    }
                } while (possuiDuplos); */

            arquivoEntrada.close();

            // Imprimir a matriz com números de linha e coluna começando do zero
            cout << setw(4) << ""; // Espaço para o canto superior esquerdo

            // Imprimir números de coluna na primeira linha
            for (int i = 0; i < contadorColuna; i++)
            {
                cout << setw(4) << i;
            }
            cout << endl;

            // Imprimir a matriz com números de linha e conteúdo
            for (int i = 0; i < contadorLinha; i++)
            {
                cout << setw(4) << i; // Número de linha

                for (int j = 0; j < contadorColuna; j++)
                {
                    cout << setw(4) << labirinto[i][j]; // Conteúdo da matriz
                }

                cout << endl;
            }

            cout << endl
                 << "Seu arquivo tem " << contadorLinha << " linhas e " << contadorColuna << " colunas!!!" << endl
                 << endl;
            break;
        }
        else
        {
            cout << "Erro ao abrir o arquivo, escreva o nome correto do arquivo." << endl
                 << endl;
        }

    } while (true);
}

// Função para exibir o menu do iniciador da jogada
void exibirMenuIniciador(Jogadas &jogada, const vector<string> &labirinto)
{
    do
    {
        cout << "Escolha a linha e depois a coluna para iniciar o labirinto!!!" << endl;
        cout << "Qual a linha?" << endl;
        cin >> jogada.primeiraLinha;
        cout << "Qual a coluna?" << endl;
        cin >> jogada.primeiraColuna;

        // Verificar se a posição inicial é válida
        if (jogada.primeiraLinha < 0 || jogada.primeiraLinha >= labirinto.size() ||
            jogada.primeiraColuna < 0 || jogada.primeiraColuna >= labirinto[0].size() ||
            labirinto[jogada.primeiraLinha][jogada.primeiraColuna] != '_')
        {
            cout << endl
                 << "Posicao inicial invalida. Escolha uma posicao em branco ('_')." << endl
                 << endl;
        }
        else
        {
            break; // Saia do loop se a posição inicial for válida
        }
    } while (true);

    do
    {
        cout << endl
             << "Escolha a linha e depois a coluna para a segunda jogada!!!" << endl;
        cout << "Qual a linha?" << endl;
        cin >> jogada.ultimaLinha;
        cout << "Qual a coluna?" << endl;
        cin >> jogada.ultimaColuna;

        // Verificar se a segunda jogada é válida
        if (jogada.ultimaLinha < 0 || jogada.ultimaLinha >= labirinto.size() ||
            jogada.ultimaColuna < 0 || jogada.ultimaColuna >= labirinto[0].size() ||
            labirinto[jogada.ultimaLinha][jogada.ultimaColuna] != '_')
        {
            cout << endl
                 << "Segunda jogada invalida. Escolha uma posicao em branco ('_')." << endl
                 << endl;
        }
        else
        {
            break; // Saia do loop se a segunda jogada for válida
        }
    } while (true);
}

// Função para criar o labirinto e jogar
void criarLabirintoEJogar(vector<string> &labirinto, Jogadas &jogada)
{
    limparTela();

    int linhas, colunas;
    cout << "Digite o numero de linhas do labirinto: ";
    cin >> linhas;
    cout << "Digite o numero de colunas do labirinto: ";
    cin >> colunas;

    // Inicializar o labirinto com 'L'
    labirinto.resize(linhas, string(colunas, 'L'));

    cout << endl
         << "Agora, defina manualmente as paredes e caminhos do labirinto." << endl;
    cout << "Use 'X' para representar as paredes e '_' para espacos em branco." << endl
         << endl;

    bool possuiDuplos;

    do
    {
        possuiDuplos = false;

        for (int i = 0; i < linhas; ++i)
        {
            for (int j = 0; j < colunas; ++j)
            {
                char novoElemento;
                do
                {
                    cout << "Labirinto[" << i << "][" << j << "]: ";
                    cin >> novoElemento;

                    // Verificar se o novo elemento é válido
                    if (novoElemento != '_' && novoElemento != 'X')
                    {
                        cout << endl
                             << "Erro: Caractere invalido. Use '_' para caminho e 'X' para parede." << endl
                             << endl;
                    }
                } while (novoElemento != '_' && novoElemento != 'X');

                labirinto[i][j] = novoElemento;
                limparTela();
                imprimirLabirinto(labirinto);
            }
        }

        // Verificar se o labirinto possui caminhos duplos
        for (int i = 0; i < linhas; ++i)
        {
            for (int j = 0; j < colunas; ++j)
            {
                if (labirinto[i][j] == '_' && possuiCaminhosDuplos(labirinto, i, j))
                {
                    possuiDuplos = true;
                    break;
                }
            }
            if (possuiDuplos)
            {
                break;
            }
        }

        if (possuiDuplos)
        {
            cout << endl
                 << "O labirinto possui caminhos duplos. Por favor, defina novamente." << endl
                 << endl;
        }

    } while (possuiDuplos);

    // Mostrar o labirinto após definir manualmente
    cout << endl;
    imprimirLabirinto(labirinto);

    // Salvar o labirinto em um arquivo
    string nomeArquivo;
    cout << "Digite o nome do arquivo para salvar o labirinto: ";
    cin >> nomeArquivo;

    ofstream arquivoSaida(nomeArquivo);

    if (arquivoSaida.is_open())
    {
        for (const string &linha : labirinto)
        {
            arquivoSaida << linha << endl;
        }

        arquivoSaida.close();
        cout << endl
             << "Labirinto salvo com sucesso em " << nomeArquivo << endl
             << endl;
    }
    else
    {
        cout << "Erro ao abrir o arquivo para salvar o labirinto." << endl;
    }
}

// Função para exibir o menu de regras
void exibirMenuRegras()
{
    limparTela();

    cout << "Seja bem-vindo ao trabalho M3 (Vulgo Labirinto em C++)" << endl
         << endl;
    cout << "Regras do jogo:" << endl;
    cout << "O objetivo vai ser passar por um labirinto que foi criado ou usando um ja feito (nao pode haver corredor duplo)." << endl
         << endl;

    cout << "Legenda do Labirinto:" << endl;
    cout << GREEN << "P" << RESET << " = PASSOU" << endl;
    cout << RED << "N" << RESET << " = NAO PASSOU" << endl;
    cout << "X = PAREDE OU BLOQUEIO" << endl;
    cout << "_ = ESPACO EM BRANCO" << endl
         << endl;

    cout << "O que deseja fazer?" << endl
         << endl;
    cout << "\t1- Ler um arquivo para jogar" << endl;
    cout << "\t2- Criar um labirinto para jogar" << endl
         << endl;
}

// Função principal
int main()
{
    limparTela();
    exibirMenuRegras();

    string op;

    do
    {
        cout << "Qual a sua escolha? " << endl;
        cin >> op;
    } while (op < "1" || op > "2");

    Jogadas jogada;
    vector<string> labirinto; // Adicionado a definição da variável labirinto

    // Leitura e jogar
    if (op == "1")
    {
        leituraDoLabirinto(labirinto, jogada);

        exibirMenuIniciador(jogada, labirinto);

        jogarOLabirinto(labirinto, jogada);
    }

    else if (op == "2")
    {
        criarLabirintoEJogar(labirinto, jogada);

        exibirMenuIniciador(jogada, labirinto);

        jogarOLabirinto(labirinto, jogada);
    }
    return 0;
}
