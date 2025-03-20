#include <iostream> // Biblioteca padrao do c++
#include <vector>   // Biblioteca para usar arrays dinâmicos
#include <cmath>    // Biblioteca para usar funções matemáticas

using namespace std;

// Struct, ou estrutura, é um bloco que armazena diversas informações, que está definindo a estrutura Monomio
struct Monomio
{
    float coeficiente;
    int expoente;
};

// Struct, ou estrutura, é um bloco que armazena diversas informações, que está definindo a estrutura Polinomio
struct Polinomio
{
    vector<Monomio> termos;
};

// Função para somar/adição dois polinômios
Polinomio somaDePolinomios(const Polinomio &p1, const Polinomio &p2)
{
    // Cria um novo objeto Polinomio chamado 'resultado' e inicializa-o com o polinômio de entrada 'p1'.
    Polinomio resultado = p1;

    // Percorre todos os termos do segundo polinômio (p2).
    for (const Monomio &monomio2 : p2.termos)
    {
        // Inicializa uma variável booleana 'termoJaExiste' como falsa.
        bool termoJaExiste = false;

        // Percorre todos os termos do polinômio 'resultado'.
        for (Monomio &monomio1 : resultado.termos)
        {
            // Verifica se o expoente do termo do polinômio 'resultado' é igual ao expoente do termo do polinômio 'p2'.
            if (monomio1.expoente == monomio2.expoente)
            {
                // Adiciona o coeficiente do termo do polinômio 'p2' ao coeficiente do termo do polinômio 'resultado'.
                monomio1.coeficiente += monomio2.coeficiente;

                // Marca que o termo já existe no polinômio 'resultado'.
                termoJaExiste = true;

                // Sai do loop interno, pois o termo já foi encontrado e atualizado.
                break;
            }
        }

        // Se o termo do polinômio 'p2' não foi encontrado no polinômio 'resultado', adiciona-o.
        if (!termoJaExiste)
        {
            resultado.termos.push_back(monomio2);
        }
    }

    // Retorna o polinômio resultante da adição.
    return resultado;
}

// Função para subtrair/diferença dois polinômios
Polinomio diferencaDePolinomios(const Polinomio &p1, const Polinomio &p2)
{
    // Cria um novo objeto Polinomio chamado 'resultado' e inicializa-o com o polinômio de entrada 'p1'.
    Polinomio resultado = p1;

    // Percorre todos os termos do segundo polinômio (p2).
    for (const Monomio &monomio2 : p2.termos)
    {
        // Inicializa uma variável booleana 'termoJaExiste' como falsa.
        bool termoJaExiste = false;

        // Percorre todos os termos do polinômio 'resultado'.
        for (Monomio &monomio1 : resultado.termos)
        {
            // Verifica se o expoente do termo do polinômio 'resultado' é igual ao expoente do termo do polinômio 'p2'.
            if (monomio1.expoente == monomio2.expoente)
            {
                // Subtrai o coeficiente do termo do polinômio 'p2' do coeficiente do termo do polinômio 'resultado'.
                monomio1.coeficiente -= monomio2.coeficiente;

                // Marca que o termo já existe no polinômio 'resultado'.
                termoJaExiste = true;

                // Sai do loop interno, pois o termo já foi encontrado e atualizado.
                break;
            }
        }

        // Se o termo do polinômio 'p2' não foi encontrado no polinômio 'resultado', adiciona-o com um coeficiente negativo.
        if (!termoJaExiste)
        {
            resultado.termos.push_back({-monomio2.coeficiente, monomio2.expoente});
        }
    }

    // Retorna o polinômio resultante da subtração.
    return resultado;
}

// Função para multiplicar um polinômio por um valor constante
Polinomio multiplicacaoPorConstante(const Polinomio &p, float constante)
{
    // Cria um novo objeto Polinomio chamado 'resultado' e inicializa-o com o polinômio de entrada 'p'.
    Polinomio resultado = p;

    // Percorre todos os termos do polinômio 'resultado'.
    for (Monomio &monomio : resultado.termos)
    {
        // Multiplica o coeficiente de cada termo do 'resultado' pela constante de entrada.
        monomio.coeficiente *= constante;
    }

    // Retorna o polinômio resultante da multiplicação.
    return resultado;
}

// Função para multiplicar um polinômio por um monomio
Polinomio multiplicacaoPorMonomio(const Polinomio &p, const Monomio &monomio)
{
    // Cria um novo objeto Polinomio chamado 'resultado' e inicializa-o com o polinômio de entrada 'p'.
    Polinomio resultado = p;

    // Percorre todos os termos do polinômio 'resultado'.
    for (Monomio &termo : resultado.termos)
    {
        // Multiplica o coeficiente de cada termo do 'resultado' pelo coeficiente do 'monomio' de entrada.
        termo.coeficiente *= monomio.coeficiente;

        // Soma o expoente de cada termo do 'resultado' com o expoente do 'monomio' de entrada.
        termo.expoente += monomio.expoente;
    }

    // Retorna o polinômio resultante da multiplicação.
    return resultado;
}

// Função para multiplicar dois polinômios entre si
Polinomio multiplicacaoDePolinomios(const Polinomio &p1, const Polinomio &p2)
{
    // Cria um objeto Polinomio chamado 'resultado' para armazenar o resultado da multiplicação.
    Polinomio resultado;

    // Percorre os termos do primeiro polinômio (p1).
    for (const Monomio &monomio1 : p1.termos)
    {
        // Para cada termo em p1, percorre os termos do segundo polinômio (p2).
        for (const Monomio &monomio2 : p2.termos)
        {
            // Cria um novo monomio para armazenar o resultado da multiplicação dos monômios.
            Monomio novoMonomio;

            // Multiplica os coeficientes dos monômios de p1 e p2 e atribui o resultado ao coeficiente do novo monomio.
            novoMonomio.coeficiente = monomio1.coeficiente * monomio2.coeficiente;

            // Soma os expoentes dos monômios de p1 e p2 e atribui o resultado ao expoente do novo monomio.
            novoMonomio.expoente = monomio1.expoente + monomio2.expoente;

            // Adiciona o novo monomio ao resultado.
            resultado.termos.push_back(novoMonomio);
        }
    }

    // Retorna o polinômio resultante da multiplicação.
    return resultado;
}

// Função para imprimir um polinômio
void imprimirPolinomio(const Polinomio &p)
{
    // Inicializa uma variável booleana 'primeiroTermo' como verdadeira.
    bool primeiroTermo = true;

    // Percorre todos os termos do polinômio 'p'.
    for (const Monomio &monomio : p.termos)
    {
        // Verifica se este é o primeiro termo do polinômio.
        if (primeiroTermo)
        {
            primeiroTermo = false;
        }
        else
        {
            // Se não for o primeiro termo, imprime o sinal de adição.
            cout << " + ";
        }

        // Imprime o coeficiente e o expoente do termo.
        cout << monomio.coeficiente << "x^" << monomio.expoente;
    }

    // Se o polinômio não tiver termos, imprime "0".
    if (primeiroTermo)
    {
        cout << "0";
    }

    // Imprime uma nova linha para separar o resultado.
    cout << endl;
}

// Começo do int main
int main()
{
    // Laço de repetição só para funcionar de forma "infinita"
    while (true)
    {
        system("cls"); // Serve exclusivamente para limpar o terminal, não funciona em alguns compiladores

        // Menu de escolhas
        cout << "Seja bem vindo ao Trabalho M2 de Programacao 2 !!!" << endl;
        cout << "Trabalho feito por Douglas e Edson." << endl;

        int opcoes;

        cout << endl
             << "Deseja fazer qual operacao a seguir?" << endl
             << endl;
        cout << "\t1 - Calcular o valor numerico do polinomio" << endl;
        cout << "\t2 - Somar dois polinomios" << endl;
        cout << "\t3 - Subtrair dois polinomios" << endl;
        cout << "\t4 - Multiplicar um polinomio por um valor constante" << endl;
        cout << "\t5 - Multiplicar um polinomio por um monomio" << endl;
        cout << "\t6 - Multiplicar dois polinomios entre si" << endl;
        cout << "\t7 - Sair" << endl
             << endl;

        cin >> opcoes;
        // Menu de escolhas

        // Switch para fazer as escolhas 1, 2, 3, 4, 5 e 6
        switch (opcoes)
        {
        case 1: // Opcao de calcular o valor numerico do polinomio
        {
            // Coleta o valor de x
            float x;

            cout << endl
                 << "Primeiramente digite a parte literal (Vulgo valor do X)." << endl;
            cin >> x;

            // Coleta o polinômio
            Polinomio p;

            cout << endl
                 << "Digite o(s) polinomio(s) que deseja calcular o valor numerico." << endl;
            cout << "Digitando o coeficiente 0, voce encerra o(s) polinomio(s):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p.termos.push_back(monomio);
            }

            // Exibe a expressao de forma detalhado
            cout << endl
                 << "A(as) expressao(oes) que voce digitou foi:" << endl
                 << endl;

            // Calcula o valor numerico
            for (const Monomio &monomio : p.termos)
            {
                float termoParcial = monomio.coeficiente * pow(x, monomio.expoente); // Calcula o termo parcial multiplicando o coeficiente pelo resultado de elevar 'x' à potência 'expoente'.
                cout << monomio.coeficiente << "x^" << monomio.expoente << " = ";
                cout << monomio.coeficiente << " * (" << x << "^" << monomio.expoente << ") = ";
                cout << termoParcial << " " << endl;
            }

            cout << endl
                 << "O valor de x foi = " << x << endl;

            break;
        }

        case 2: // Opcao de somar dois polinomios
        {
            // Coleta os polinômios
            Polinomio p1, p2;

            cout << endl
                 << "Digite o primeiro polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p1.termos.push_back(monomio);
            }

            cout << endl;

            cout << "Digite o segundo polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p2.termos.push_back(monomio);
            }

            // Realiza a soma dos polinômios
            Polinomio soma = somaDePolinomios(p1, p2);

            cout << endl
                 << "A soma dos 2 polinomios vai ser: ";

            // Imprime a soma dos polinômios
            imprimirPolinomio(soma);

            break;
        }

        case 3: // Opcao de subtrair dois polinomios
        {
            // Coleta os polinômios
            Polinomio p1, p2;
            cout << endl
                 << "Digite o primeiro polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p1.termos.push_back(monomio);
            }

            cout << endl;

            cout << "Digite o segundo polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p2.termos.push_back(monomio);
            }

            // Realiza a diferença dos polinômios
            Polinomio diferenca = diferencaDePolinomios(p1, p2);

            cout << endl
                 << "A subtracao dos 2 polinomios vai ser: ";

            // Imprime a diferença dos polinômios
            imprimirPolinomio(diferenca);

            break;
        }

        case 4: // Opcao de Multiplicar um polinomio por um valor constante
        {
            // Coleta o polinômio
            Polinomio p;
            cout << endl
                 << "Digite o(s) polinomio(s) que deseja multiplicar por um valor constante." << endl;
            cout << "Digitando o coeficiente 0, voce encerra o(s) polinomio(s):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p.termos.push_back(monomio);
            }

            cout << endl;

            float constante;
            cout << "Digite o valor da constante: ";
            cin >> constante;

            // Realiza a multiplicação por constante do polinômio
            Polinomio resultado = multiplicacaoPorConstante(p, constante);

            cout << endl
                 << "A multiplicar de um polinomio por um valor constante vai ser: ";

            // Imprime o resultado da multiplicação
            imprimirPolinomio(resultado);

            break;
        }

        case 5: // Opcao de Multiplicar um polinomio por um monomio
        {
            // Coleta o polinômio
            Polinomio p;

            cout << endl
                 << "Digite o(s) polinomio(s) que deseja multiplicar por um monomio." << endl;
            cout << "Digitando o coeficiente 0, voce encerra o(s) polinomio(s):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p.termos.push_back(monomio);
            }

            cout << endl;

            Monomio monomio;
            cout << "Digite o monomio (Digitando o coeficiente 0, voce encerra o monomio):" << endl
                 << endl;
            cout << "Coeficiente: ";
            cin >> monomio.coeficiente;

            if (monomio.coeficiente == 0)
                break;

            cout << "Expoente: ";
            cin >> monomio.expoente;

            // Realiza a multiplicação por monomio do polinômio
            Polinomio resultado = multiplicacaoPorMonomio(p, monomio);

            cout << endl
                 << "A multiplicacao de um polimonio por um monomio vai ser: ";

            // Imprime o resultado da multiplicação
            imprimirPolinomio(resultado);

            break;
        }

        case 6: // Opcao de Multiplicar dois polinomios entre si
        {
            // Coleta os polinômios
            Polinomio p1, p2;

            cout << endl
                 << "Digite o primeiro polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p1.termos.push_back(monomio);
            }

            cout << endl;

            cout << "Digite o segundo polinomio (Digitando o coeficiente 0, voce encerra o polinomio):" << endl
                 << endl;

            // Laço de repetição para pegar os monomios
            while (true)
            {
                Monomio monomio;
                cout << "Coeficiente: ";
                cin >> monomio.coeficiente;

                if (monomio.coeficiente == 0)
                    break;
                cout << "Expoente: ";
                cin >> monomio.expoente;

                // Push_back serve para adicionar o monômio ao vetor
                p2.termos.push_back(monomio);
            }

            // Realiza a multiplicação dos polinômios
            Polinomio resultado = multiplicacaoDePolinomios(p1, p2);

            cout << endl
                 << "A multiplicacao de dois polinomios entre si sera: ";

            // Imprime o resultado da multiplicação
            imprimirPolinomio(resultado);

            break;
        }

        case 7: // Opcao para sair
        {
            cout << "Saindo..." << endl;
            return 0;
        }

        default:
            cout << endl
                 << "Nao tem esse opcao..." << endl;
            break;
        }
        // Final do Switch

        // Menu caso queira quebrar o laço de repetição
        string opfinal;
        cout << endl
             << "Deseja fazer novos calculos?" << endl;

        cout << "Se sim digita qualquer coisa, porem se deseja sair escreva 'Sair' ou 'sair." << endl;
        cin >> opfinal;

        if (opfinal == "Sair" || opfinal == "sair")
        {
            cout << endl
                 << "Saindo..." << endl;
            return 0;
        }
    }
    // Final do laço de repetição

    return 0;
}