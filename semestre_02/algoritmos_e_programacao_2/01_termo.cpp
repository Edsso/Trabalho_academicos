#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <windows.h>
#include <time.h>

using namespace std;

#define TAMANHO_PALAVRA 5
#define NAO_CORRESPONDIDO 0
#define CORRESPONDENCIA_PARCIAL 1
#define CORRESPONDIDO 2

#define NUMERO_DE_TENTATIVAS_PADRAO 6
#define NUMERO_DE_TENTATIVAS_TERMO 6
#define NUMERO_DE_TENTATIVAS_DUETO 7
#define NUMERO_DE_TENTATIVAS_TRIO 8
#define NUMERO_DE_TENTATIVAS_QUARTETO 9

// Gera a palavra do jogo de modo aleatório e sistema que a palavra não irá se repetir. (Douglas)
vector<string> pegarPalavrasAleatorias()
{
    constexpr int NUM_PALAVRAS = 60;
    const string palavras[NUM_PALAVRAS] = {
        "abeto", "termo", "alega", "furia", "antes",
        "balde", "bravo", "canto", "vento", "peito",
        "claro", "cobra", "colhe", "cores", "dente",
        "dobra", "duzia", "facil", "feira", "foice",
        "heroi", "forte", "fruta", "gente", "grama",
        "grupo", "idade", "igual", "jogar", "mania",
        "nobre", "ordem", "parar", "passe", "plano",
        "ponto", "casas", "falar", "quero", "raiva",
        "ronda", "ruiva", "saber", "nasce", "seiva",
        "sinal", "sinto", "talar", "tanto", "fundo",
        "traco", "uniao", "noite", "valor", "velho",
        "mundo", "vigor", "vilao", "viver", "volta"};

    // Vector para armazenar as palavras já usadas.
    static vector<string> palavrasUsadas;

    // Verifica se todas as palavras foram usadas e reinicia o vetor, se necessário.
    if (palavrasUsadas.size() == NUM_PALAVRAS)
    {
        palavrasUsadas.clear();
    }

    // Vector para armazenar as palavras aleatórias a serem retornadas.
    vector<string> palavrasAleatorias;

    // Gera quatro palavras aleatórias que ainda não foram usadas.
    while (palavrasAleatorias.size() < 4)
    {
        int palavra_do_jogo = rand() % NUM_PALAVRAS;
        string palavra = palavras[palavra_do_jogo];

        // Verifique se a palavra já foi usada.
        if (find(palavrasUsadas.begin(), palavrasUsadas.end(), palavra) == palavrasUsadas.end())
        {
            palavrasUsadas.push_back(palavra);
            palavrasAleatorias.push_back(palavra);
        }
    }

    return palavrasAleatorias;
}

// Esta função recebe uma string como entrada e a transforma em letras maiúsculas. (Edson)
// Parâmetros:
// - palavra: a string que será transformada em maiúsculas (passada por referência).
void transformaParaMaiusculo(string &palavra)
{
    // A função transform da STL é usada para converter cada caractere da string em maiúscula.
    transform(palavra.begin(), palavra.end(), palavra.begin(), ::toupper);
}

// Verifica se uma palavra é considerada válida com base em algumas condições. (Douglas)
//
// Parâmetros:
// - palavras: A palavra a ser verificada.
//
// Retorna true se a palavra atender a todas as condições, caso contrário, retorna false.
bool ePalavraValida(string palavras)
{
    // Verifica se o comprimento da palavra é igual a TAMANHO_PALAVRA
    bool tamanhoValido = palavras.length() == TAMANHO_PALAVRA;

    // Verifica se a palavra não contém caracteres que não sejam letras maiúsculas do alfabeto (A-Z)
    bool caracteresValidos = palavras.find_first_not_of("ABCDEFGHIJKLMNOPQRSTUVWXYZ") == string::npos;

    // Retorna true se ambas as condições forem atendidas, indicando que a palavra é válida.
    return tamanhoValido && caracteresValidos;
}

// Marca as correspondências entre a palavra de tentativa e a palavra alvo. (Edson)
//
// Parâmetros:
// - correspondencias: Uma matriz 2D que armazena informações sobre correspondências entre letras.
// - indiceTentativaAtual: O índice da tentativa atual.
// - palavraAlvo: A palavra alvo à qual a palavra de tentativa será comparada.
// - palavraTentativa: A palavra de tentativa a ser comparada com a palavra alvo.
void marcaCorrespondencias(vector<vector<int>> &correspondencias, int indiceTentativaAtual, string palavraAlvo, string palavraTentativa)
{
    // Inicializa todas as correspondências como NAO_CORRESPONDIDO
    for (int j = 0; j < static_cast<int>(palavraAlvo.length()); j++)
    {
        correspondencias[indiceTentativaAtual][j] = NAO_CORRESPONDIDO;
    }

    // Percorre as letras da palavra de tentativa e compara com a palavra alvo
    for (int i = 0; i < static_cast<int>(palavraAlvo.length()); i++)
    {
        for (int j = 0; j < static_cast<int>(palavraAlvo.length()); j++)
        {
            if (palavraTentativa[i] == palavraAlvo[j])
            {
                // Se as letras correspondem e estão na mesma posição, marca como CORRESPONDIDO
                if (i == j)
                {
                    correspondencias[indiceTentativaAtual][i] = CORRESPONDIDO;
                    break;
                }
                else
                {
                    // Se as letras correspondem, mas não estão na mesma posição, marca como CORRESPONDENCIA_PARCIAL
                    correspondencias[indiceTentativaAtual][i] = CORRESPONDENCIA_PARCIAL;
                }
            }
        }
    }
}

// Verifica se todas as letras em duas palavras correspondem nas mesmas posições. (Edson)
//
// Parâmetros:
// - palavraAlvo: A primeira palavra a ser comparada.
// - palavraTentativa: A segunda palavra a ser comparada.
//
// Retorna true se todas as letras nas mesmas posições das duas palavras correspondem, caso contrário, retorna false.
bool todasCorrespondidas(string palavraAlvo, string palavraTentativa)
{
    // Itera através das letras das palavras
    for (int i = 0; i < static_cast<int>(palavraAlvo.length()); i++)
    {
        // Se uma letra em uma posição não corresponder, retorna false
        if (palavraAlvo[i] != palavraTentativa[i])
            return false;
    }

    // Se todas as letras nas mesmas posições corresponderem, retorna true
    return true;
}

// Desenhos do Termo (Douglas e Edson)
void JogarTermo(vector<vector<int>> correspondencias, vector<string> tentativas, int indiceTentativaAtual)
{
    // Limpa o console
    system("cls");

    // https://patorjk.com/software/taag/#p=display&h=0&f=Big%20Money-nw&t=TERMO

    cout << "                         ===========================================================" << endl;
    cout << "                         |  $$$$$$$$\\ $$$$$$$$\\ $$$$$$$\\  $$\\      $$\\  $$$$$$\\    |" << endl;
    cout << "                         |  \\__$$  __|$$  _____|$$  __$$\\ $$$\\    $$$ |$$  __$$\\   |" << endl;
    cout << "                         |     $$ |   $$ |      $$ |  $$ |$$$$\\  $$$$ |$$ /  $$ |  |" << endl;
    cout << "                         |     $$ |   $$$$$\\    $$$$$$$  |$$\\$$\\$$ $$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$  __|   $$  __$$ |$$ \\$$$  $$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$ |      $$ |  $$ |$$ |\\$  /$$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$$$$$$$\\ $$ |  $$ |$$ | \\_/ $$ | $$$$$$  |  |" << endl;
    cout << "                         |     \\__|   \\________|\\__|  \\__|\\__|     \\__| \\______/   |" << endl;
    cout << "                         ===========================================================\n\n";

    for (int i = 0; i <= indiceTentativaAtual && i < static_cast<int>(tentativas.size()); i++)
    {
        string separador = "-";
        string preenchimento = " |";
        string texto = " |";

        for (size_t j = 0; j < tentativas[i].length(); j++)
        {
            separador += "------";
            preenchimento += "     |";
            char valor = toupper(tentativas[i][j]);
            texto += "  ";

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL)
            {
                // Imprime texto com cor
                texto += "\033[33m";
            }
            else if (correspondencias[i][j] == CORRESPONDIDO)
            {
                texto += "\033[32m";
            }

            texto += valor;

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL || correspondencias[i][j] == CORRESPONDIDO)
            {
                // Fecha a cor do texto
                texto += "\033[0m";
            }

            texto += "  |";
        }

        if (i == 0)
        {
            cout << "                                         " << separador << endl;
        }

        cout << "                                        " << preenchimento << endl;
        cout << "                                        " << texto << endl;
        cout << "                                        " << preenchimento << endl;
        cout << "                                         " << separador << endl;
    }
}

// Desenhos do Dueto (Douglas e Edson)
void JogarDueto(vector<vector<int>> correspondencias, vector<string> tentativas, int indiceTentativaAtual)
{
    // Limpa o console
    system("cls");

    // https://patorjk.com/software/taag/#p=display&h=0&f=Big%20Money-nw&t=DUETO

    cout << "                           ========================================================" << endl;
    cout << "                           |  $$$$$$$\\  $$\\   $$\\ $$$$$$$$\\ $$$$$$$$\\  $$$$$$\\    |" << endl;
    cout << "                           |  $$  __$$\\ $$ |  $$ |$$  _____|\\__$$  __|$$  __$$\\   |" << endl;
    cout << "                           |  $$ |  $$ |$$ |  $$ |$$ |         $$ |   $$ /  $$ |  |" << endl;
    cout << "                           |  $$ |  $$ |$$ |  $$ |$$$$$\\       $$ |   $$ |  $$ |  |" << endl;
    cout << "                           |  $$ |  $$ |$$ |  $$ |$$  __|      $$ |   $$ |  $$ |  |" << endl;
    cout << "                           |  $$ |  $$ |$$ |  $$ |$$ |         $$ |   $$ |  $$ |  |" << endl;
    cout << "                           |  $$$$$$$  |\\$$$$$$  |$$$$$$$$\\    $$ |    $$$$$$  |  |" << endl;
    cout << "                           |  \\_______/  \\______/ \\________|   \\__|    \\______/   |" << endl;
    cout << "                           ========================================================\n\n";

    for (int i = 0; i <= indiceTentativaAtual && i < static_cast<int>(tentativas.size()); i++)
    {
        string separador = "-";
        string preenchimento = " |";
        string texto = " |";

        for (size_t j = 0; j < tentativas[i].length(); j++)
        {
            separador += "------";
            preenchimento += "     |";
            char valor = toupper(tentativas[i][j]);
            texto += "  ";

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL)
            {
                // Imprime texto com cor
                texto += "\033[33m";
            }
            else if (correspondencias[i][j] == CORRESPONDIDO)
            {
                texto += "\033[32m";
            }

            texto += valor;

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL || correspondencias[i][j] == CORRESPONDIDO)
            {
                // Fecha a cor do texto
                texto += "\033[0m";
            }

            texto += "  |";
        }

        if (i == 0)
        {
            cout << "                                         " << separador << endl;
        }

        cout << "                                        " << preenchimento << endl;
        cout << "                                        " << texto << endl;
        cout << "                                        " << preenchimento << endl;
        cout << "                                         " << separador << endl;
    }
}

// Desenhos do Trio (Douglas e Edson)
void JogarTrio(vector<vector<int>> correspondencias, vector<string> tentativas, int indiceTentativaAtual)
{
    // Limpa o console
    system("cls");

    // https://patorjk.com/software/taag/#p=display&h=0&f=Big%20Money-nw&t=TRIO

    cout << "                                 ============================================" << endl;
    cout << "                                 |  $$$$$$$$\\ $$$$$$$\\  $$$$$$\\  $$$$$$\\    |" << endl;
    cout << "                                 |  \\__$$  __|$$  __$$\\ \\_$$  _|$$  __$$\\   |" << endl;
    cout << "                                 |     $$ |   $$ |  $$ |  $$ |  $$ /  $$ |  |" << endl;
    cout << "                                 |     $$ |   $$$$$$$  |  $$ |  $$ |  $$ |  |" << endl;
    cout << "                                 |     $$ |   $$  __$$ |  $$ |  $$ |  $$ |  |" << endl;
    cout << "                                 |     $$ |   $$ |  $$ |  $$ |  $$ |  $$ |  |" << endl;
    cout << "                                 |     $$ |   $$ |  $$ |$$$$$$\\  $$$$$$  |  |" << endl;
    cout << "                                 |     \\__|   \\__|  \\__|\\______| \\______/   |" << endl;
    cout << "                                 ============================================\n\n";

    for (int i = 0; i <= indiceTentativaAtual && i < static_cast<int>(tentativas.size()); i++)
    {
        string separador = "-";
        string preenchimento = " |";
        string texto = " |";

        for (size_t j = 0; j < tentativas[i].length(); j++)
        {
            separador += "------";
            preenchimento += "     |";
            char valor = toupper(tentativas[i][j]);
            texto += "  ";

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL)
            {
                // Imprime texto com cor
                texto += "\033[33m";
            }
            else if (correspondencias[i][j] == CORRESPONDIDO)
            {
                texto += "\033[32m";
            }

            texto += valor;

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL || correspondencias[i][j] == CORRESPONDIDO)
            {
                // Fecha a cor do texto
                texto += "\033[0m";
            }

            texto += "  |";
        }

        if (i == 0)
        {
            cout << "                                         " << separador << endl;
        }

        cout << "                                        " << preenchimento << endl;
        cout << "                                        " << texto << endl;
        cout << "                                        " << preenchimento << endl;
        cout << "                                         " << separador << endl;
    }
}

// Desenhos do Quarteto (Douglas e Edson)
void JogarQuarteto(vector<vector<int>> correspondencias, vector<string> tentativas, int indiceTentativaAtual)
{
    // Limpa o console
    system("cls");

    // https://patorjk.com/software/taag/#p=display&h=0&f=Big%20Money-nw&t=QUARTETO

    cout << "             ======================================================================================" << endl;
    cout << "             |   $$$$$$\\  $$\\   $$\\  $$$$$$\\  $$$$$$$\\  $$$$$$$$\\ $$$$$$$$\\ $$$$$$$$\\  $$$$$$ \\   |" << endl;
    cout << "             |  $$  __$$\\ $$ |  $$ |$$  __$$\\ $$  __$$\\ \\__$$  __|$$  _____|\\__$$  __|$$  __$$ \\  |" << endl;
    cout << "             |  $$ /  $$ |$$ |  $$ |$$ /  $$ |$$ |  $$ |   $$ |   $$ |         $$ |   $$ /  $$ |  |" << endl;
    cout << "             |  $$ |  $$ |$$ |  $$ |$$$$$$$$ |$$$$$$$  |   $$ |   $$$$$\\       $$ |   $$ |  $$ |  |" << endl;
    cout << "             |  $$ |  $$ |$$ |  $$ |$$  __$$ |$$  __$$|    $$ |   $$  __|      $$ |   $$ |  $$ |  |" << endl;
    cout << "             |  $$ $$\\$$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |   $$ |   $$ |         $$ |   $$ |  $$ |  |" << endl;
    cout << "             |  \\$$$$$$ / \\$$$$$$  |$$ |  $$ |$$ |  $$ |   $$ |   $$$$$$$$\\    $$ |    $$$$$$  |  |" << endl;
    cout << "             |   \\___$$$\\  \\______/ \\__|  \\__|\\__|  \\__|   \\__|   \\________|   \\__|    \\______/   |" << endl;
    cout << "             |       \\___|                                                                        |" << endl;
    cout << "             ======================================================================================\n\n";

    for (int i = 0; i <= indiceTentativaAtual && i < static_cast<int>(tentativas.size()); i++)
    {
        string separador = "-";
        string preenchimento = " |";
        string texto = " |";

        for (size_t j = 0; j < tentativas[i].length(); j++)
        {
            separador += "------";
            preenchimento += "     |";
            char valor = toupper(tentativas[i][j]);
            texto += "  ";

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL)
            {
                // Imprime texto com cor
                texto += "\033[33m";
            }
            else if (correspondencias[i][j] == CORRESPONDIDO)
            {
                texto += "\033[32m";
            }

            texto += valor;

            if (correspondencias[i][j] == CORRESPONDENCIA_PARCIAL || correspondencias[i][j] == CORRESPONDIDO)
            {
                // Fecha a cor do texto
                texto += "\033[0m";
            }

            texto += "  |";
        }

        if (i == 0)
        {
            cout << "                                         " << separador << endl;
        }

        cout << "                                        " << preenchimento << endl;
        cout << "                                        " << texto << endl;
        cout << "                                        " << preenchimento << endl;
        cout << "                                         " << separador << endl;
    }
}

// O jogo em si
int main()
{
    srand(time(NULL));

    // Puxa as palavras do jogo
    vector<string> tentativas(NUMERO_DE_TENTATIVAS_PADRAO);
    vector<vector<int>> correspondencias(NUMERO_DE_TENTATIVAS_PADRAO, vector<int>(TAMANHO_PALAVRA));

    vector<string> palavras = pegarPalavrasAleatorias();

    transformaParaMaiusculo(palavras[0]);
    transformaParaMaiusculo(palavras[1]);
    transformaParaMaiusculo(palavras[2]);
    transformaParaMaiusculo(palavras[3]);

    string palavraAlvo = palavras[0];
    string palavraAlvo2 = palavras[1];
    string palavraAlvo3 = palavras[2];
    string palavraAlvo4 = palavras[3];

    system("cls");

    cout << "                         ===========================================================" << endl;
    cout << "                         |  $$$$$$$$\\ $$$$$$$$\\ $$$$$$$\\  $$\\      $$\\  $$$$$$\\    |" << endl;
    cout << "                         |  \\__$$  __|$$  _____|$$  __$$\\ $$$\\    $$$ |$$  __$$\\   |" << endl;
    cout << "                         |     $$ |   $$ |      $$ |  $$ |$$$$\\  $$$$ |$$ /  $$ |  |" << endl;
    cout << "                         |     $$ |   $$$$$\\    $$$$$$$  |$$\\$$\\$$ $$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$  __|   $$  __$$ |$$ \\$$$  $$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$ |      $$ |  $$ |$$ |\\$  /$$ |$$ |  $$ |  |" << endl;
    cout << "                         |     $$ |   $$$$$$$$\\ $$ |  $$ |$$ | \\_/ $$ | $$$$$$  |  |" << endl;
    cout << "                         |     \\__|   \\________|\\__|  \\__|\\__|     \\__| \\______/   |" << endl;
    cout << "                         ===========================================================\n\n";

    int escolha;

    do
    {
        cout << "Ola, BEM VINDO AO JOGO TERMO!!!\nDeseja jogar Termo (1), Dueto (2), Trio (3) ou Quarteto (4), e se desejar sair aperte 5...\n";
        cin >> escolha;

        if (escolha == 1)
        {
            string entrada;
            int contadorTentativasAtual = 0;
            // Apenas imprime o título
            JogarTermo(correspondencias, tentativas, -1);

            while (contadorTentativasAtual < NUMERO_DE_TENTATIVAS_TERMO)
            {
                // Caso queira ver a palavra
                cout << palavraAlvo << endl;
                /*cout << palavraAlvo2 << endl;
                cout << palavraAlvo3 << endl;
                cout << palavraAlvo4 << endl;*/

                cout << "\nPor favor, insira sua tentativa (o tamanho da palavra deve ser 5 letras) ou digite Q/q para sair do jogo: ";
                do
                {
                    getline(cin, entrada);
                    transformaParaMaiusculo(entrada);

                } while (entrada != "Q" && !ePalavraValida(entrada));

                if (entrada == "Q")
                {
                    cout << "Jogo encerrado" << endl;
                    break;
                }

                tentativas[contadorTentativasAtual] = entrada;
                marcaCorrespondencias(correspondencias, contadorTentativasAtual, palavraAlvo, entrada);

                JogarTermo(correspondencias, tentativas, contadorTentativasAtual);

                if (todasCorrespondidas(palavraAlvo, entrada))
                {
                    cout << "Voce VENCEU o jogo" << endl;
                    // Só serve para dar uma pausa e tal...
                    Sleep(1000);
                    break;
                }

                contadorTentativasAtual++;
                cout << "Voce tem 6 chances: " << contadorTentativasAtual << " chances" << endl;

                if (contadorTentativasAtual >= NUMERO_DE_TENTATIVAS_TERMO)
                {
                    cout << "Voce PERDEU o jogo" << endl;
                    cout << "A palavra foi: " << palavraAlvo << endl;
                    break;
                }
            }
        }
        else if (escolha == 2)
        {
            string entrada;
            int contadorTentativasAtual = 0;
            // Apenas imprime o título
            JogarDueto(correspondencias, tentativas, -1);

            while (contadorTentativasAtual < NUMERO_DE_TENTATIVAS_DUETO)
            {
                // Caso queira ver a palavra
                cout << palavraAlvo << endl;
                cout << palavraAlvo2 << endl;
                /*cout << palavraAlvo3 << endl;
                cout << palavraAlvo4 << endl;*/

                cout << "\nPor favor, insira sua tentativa (o tamanho da palavra deve ser 5 letras) ou digite Q/q para sair do jogo: ";
                do
                {
                    getline(cin, entrada);
                    transformaParaMaiusculo(entrada);

                } while (entrada != "Q" && !ePalavraValida(entrada));

                if (entrada == "Q")
                {
                    cout << "Jogo encerrado" << endl;
                    break;
                }

                tentativas[contadorTentativasAtual] = entrada;
                marcaCorrespondencias(correspondencias, contadorTentativasAtual, palavraAlvo, entrada);

                JogarTermo(correspondencias, tentativas, contadorTentativasAtual);

                if (todasCorrespondidas(palavraAlvo, entrada))
                {
                    cout << "Voce VENCEU o jogo" << endl;
                    // Só serve para dar uma pausa e tal...
                    Sleep(1000);
                    break;
                }

                contadorTentativasAtual++;
                cout << "Voce tem 7 chances: " << contadorTentativasAtual << " chances" << endl;

                if (contadorTentativasAtual >= NUMERO_DE_TENTATIVAS_DUETO)
                {
                    cout << "Voce PERDEU o jogo" << endl;
                    cout << "A palavra foi: " << palavraAlvo << endl;
                    break;
                }
            }
        }
        else if (escolha == 3)
        {
            string entrada;
            int contadorTentativasAtual = 0;
            // Apenas imprime o título
            JogarTrio(correspondencias, tentativas, -1);

            while (contadorTentativasAtual < NUMERO_DE_TENTATIVAS_TRIO)
            {
                // Caso queira ver a palavra
                cout << palavraAlvo << endl;
                cout << palavraAlvo2 << endl;
                cout << palavraAlvo3 << endl;
                // cout << palavraAlvo4 << endl;

                cout << "\nPor favor, insira sua tentativa (o tamanho da palavra deve ser 5 letras) ou digite Q/q para sair do jogo: ";
                do
                {
                    getline(cin, entrada);
                    transformaParaMaiusculo(entrada);

                } while (entrada != "Q" && !ePalavraValida(entrada));

                if (entrada == "Q")
                {
                    cout << "Jogo encerrado" << endl;
                    break;
                }

                tentativas[contadorTentativasAtual] = entrada;
                marcaCorrespondencias(correspondencias, contadorTentativasAtual, palavraAlvo, entrada);

                JogarTermo(correspondencias, tentativas, contadorTentativasAtual);

                if (todasCorrespondidas(palavraAlvo, entrada))
                {
                    cout << "Voce VENCEU o jogo" << endl;
                    // Só serve para dar uma pausa e tal...
                    Sleep(1000);
                    break;
                }

                contadorTentativasAtual++;
                cout << "Voce tem 8 chances: " << contadorTentativasAtual << " chances" << endl;

                if (contadorTentativasAtual >= NUMERO_DE_TENTATIVAS_TRIO)
                {
                    cout << "Voce PERDEU o jogo" << endl;
                    cout << "A palavra foi: " << palavraAlvo << endl;
                    break;
                }
            }
        }
        else if (escolha == 4)
        {
            string entrada;
            int contadorTentativasAtual = 0;
            // Apenas imprime o título
            JogarQuarteto(correspondencias, tentativas, -1);

            while (contadorTentativasAtual < NUMERO_DE_TENTATIVAS_QUARTETO)
            {
                // Caso queira ver a palavra
                cout << palavraAlvo << endl;
                cout << palavraAlvo2 << endl;
                cout << palavraAlvo3 << endl;
                cout << palavraAlvo4 << endl;

                cout << "\nPor favor, insira sua tentativa (o tamanho da palavra deve ser 5 letras) ou digite Q/q para sair do jogo: ";
                do
                {
                    getline(cin, entrada);
                    transformaParaMaiusculo(entrada);

                } while (entrada != "Q" && !ePalavraValida(entrada));

                if (entrada == "Q")
                {
                    cout << "Jogo encerrado" << endl;
                    break;
                }

                tentativas[contadorTentativasAtual] = entrada;
                marcaCorrespondencias(correspondencias, contadorTentativasAtual, palavraAlvo, entrada);

                JogarTermo(correspondencias, tentativas, contadorTentativasAtual);

                if (todasCorrespondidas(palavraAlvo, entrada))
                {
                    cout << "Voce VENCEU o jogo" << endl;
                    // Só serve para dar uma pausa e tal...
                    Sleep(1000);
                    break;
                }

                contadorTentativasAtual++;
                cout << "Voce tem 9 chances: " << contadorTentativasAtual << " chances" << endl;

                if (contadorTentativasAtual >= NUMERO_DE_TENTATIVAS_QUARTETO)
                {
                    cout << "Voce PERDEU o jogo" << endl;
                    cout << "A palavra foi: " << palavraAlvo << endl;
                    break;
                }
            }
        }
        else if (escolha == 5)
        {
            cout << "Saindo...";
            break;
        }

    } while (escolha != 1 && escolha != 2 && escolha != 3 && escolha != 4 && escolha != 5);
    return 0;
}