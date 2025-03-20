// Cada grupo deve escolher e implementar todos os algoritmos de ordena��o visto em sala: inser��o direta, shellsort, bolha (bubblesort),
// quicksort, sele��o direta e mergesort.
// O seu programa dever� preparar um conjunto de M vetores de tamanho N de n�meros inteiros que dever�o ser submetidos X vezes aos
// algoritmos implementados (com X, M e N solicitados ao usu�rio).
// Desses vetores, um deve ser o melhor caso (valores j� ordenados), outro deve ser o pior caso (valores na ordem inversa) e os demais devem ser
// gerados aleatoriamente.
// Solicite ao usu�rio a quantidade M de vetores e o tamanho N de cada um deles.
// Seu algoritmo tamb�m dever� solicitar ao usu�rio quantas vezes ele deseja executar (X) cada um dos
// m�todos.
// Feito isso, ele ir� chamar cada um dos m�todos, para cada um dos vetores, todas as vezes solicitadas.
// Em cada uma delas, voc� deve pegar o hor�rio do computador antes da chamada e imediatamente na sua volta.
// Ao final, voc� deve apresentar a diferen�a entre a hora inicial e a final para mostrar quanto tempo levou a execu��o.
// Al�m disso, quanto tudo terminar, para cada m�todo voc� dever� mostrar: qual vetor demorou mais, qual demorou menos e a m�dia dos casos.

#include <iostream>

using namespace std;

// Todos as fun��es foi implementado usando como base os slides do professor Carrard

// Fun��o que faz a Insercao Direta
template <typename T>
void insercaoDireta(T vet[], int TAM)
{
    for (int j = 1; j < TAM; ++j)
    {
        int chave = vet[j];
        int i = j - 1;
        while (i >= 0 && vet[i] > chave)
        {
            vet[i + 1] = vet[i];
            --i;
        }
        vet[i + 1] = chave;
    }
}

// Fun��o que faz o Shell Sort
template <typename T>
void shellSort(T vet[], int TAM)
{
    for (int np = TAM / 2; np > 0; np /= 2)
    {
        for (int i = np; i < TAM; ++i)
        {
            T chave = vet[i];
            int j = i;
            while (j >= np && vet[j - np] > chave)
            {
                vet[j] = vet[j - np];
                j -= np;
            }
            vet[j] = chave;
        }
    }
}

// Fun��o que faz a Bolha (Bubble Sort)
template <typename T>
void bolha(T vet[], int TAM)
{
    bool troca = true;
    int lim = TAM - 1;

    while (troca)
    {
        troca = false;
        for (int i = 0; i < lim; ++i)
        {
            if (vet[i] > vet[i + 1])
            {
                T temp = vet[i];
                vet[i] = vet[i + 1];
                vet[i + 1] = temp;
                troca = true;
            }
        }
        --lim;
    }
}

// Fun��o que faz o Quick Sort
template <typename T>
void quickSort(T vet[], int esq, int dir)
{
    int i = esq;
    int j = dir;
    T x = vet[(i + j) / 2];

    do
    {
        while (x > vet[i])
        {
            ++i;
        }
        while (x < vet[j])
        {
            --j;
        }
        if (i <= j)
        {
            T aux = vet[i];
            vet[i] = vet[j];
            vet[j] = aux;
            ++i;
            --j;
        }
    } while (i <= j);

    if (esq < j)
    {
        quickSort(vet, esq, j);
    }
    if (dir > i)
    {
        quickSort(vet, i, dir);
    }
}

// Fun��o que faz a Sele��o Direta
template <typename T>
void selecaoDireta(T vet[], int TAM)
{
    for (int i = 0; i < TAM - 1; ++i)
    {
        int pos_menor = i;
        for (int j = i + 1; j < TAM; ++j)
        {
            if (vet[j] < vet[pos_menor])
            {
                pos_menor = j;
            }
        }
        T temp = vet[i];
        vet[i] = vet[pos_menor];
        vet[pos_menor] = temp;
    }
}

// Fun��o que Mescla para poder usar a Merge Sort
template <typename T>
void mesclar(T v[], int comeco, int meio, int fim)
{
    int com1 = comeco;
    int com2 = meio + 1;
    int tam = fim - comeco + 1;
    T *vetAux = new T[tam];
    int comAux = 0;

    while (com1 <= meio && com2 <= fim)
    {
        if (v[com1] < v[com2])
        {
            vetAux[comAux] = v[com1];
            com1++;
        }
        else
        {
            vetAux[comAux] = v[com2];
            com2++;
        }
        comAux++;
    }

    while (com1 <= meio)
    {
        vetAux[comAux] = v[com1];
        comAux++;
        com1++;
    }

    while (com2 <= fim)
    {
        vetAux[comAux] = v[com2];
        comAux++;
        com2++;
    }

    for (comAux = comeco; comAux <= fim; comAux++)
    {
        v[comAux] = vetAux[comAux - comeco];
    }

    delete[] vetAux;
}

// Fun��o que faz a Merge Sort
template <typename T>
void mergeSort(T v[], int comeco, int fim)
{
    if (comeco == fim)
    {
        return;
    }

    int meio = (comeco + fim) / 2;
    mergeSort(v, comeco, meio);
    mergeSort(v, meio + 1, fim);
    mesclar(v, comeco, meio, fim);
}