#include <iostream>
#include <fstream>
#include <string>
#include <map>

using namespace std;

void decodificar_instrucao(string hexadecimal, map<string, int> &tipos_instrucoes){ 
    if (hexadecimal.length() == 8) // 32 bits = 8 caracteres hexadecimais
    {
        // Extrai o opcode diretamente dos últimos dois caracteres
        string opcode = hexadecimal.substr(6, 2);
        
        if (opcode == "33" || opcode == "b3")
        {
            cout << hexadecimal <<  ": tipo ALU" << endl;
            tipos_instrucoes["ALU"]++;
        }
        else if (opcode == "13" || opcode == "73" || opcode == "93")
        {
            cout << hexadecimal <<  ": tipo ALU Immediate" << endl;
            tipos_instrucoes["ALU Immediate"]++;
        }
        else if (opcode == "03")
        {
            cout << hexadecimal <<  ": tipo Memory" << endl;
            tipos_instrucoes["Memory"]++; // Instruções de load
        }
        else if (opcode == "23")
        {
            cout << hexadecimal <<  ": tipo Memory" << endl;
            tipos_instrucoes["Memory"]++; // Store
        }
        else if (opcode == "63") 
        {
            cout << hexadecimal <<  ": tipo Branch" << endl;
            tipos_instrucoes["Branch"]++; // Branch
        }
        else if (opcode == "37" || opcode == "17")
        {
            cout << hexadecimal <<  ": tipo Other" << endl;
            tipos_instrucoes["Other"]++; // LUI e AUIPC
        }
        else if (opcode == "6f")
        {
            cout << hexadecimal <<  ": tipo Jump" << endl;
            tipos_instrucoes["Jump"]++; /// JAL
        }
        else if (opcode == "67")
        {
            cout << hexadecimal <<  ": tipo Other" << endl;
            tipos_instrucoes["Other"]++; // JALR
        }
        else
        {
            cout << "Opcode nao implementado" << endl;
        }
    }else{
        cout << "A instrucao nao tem 32 bits." << endl;
    }
}

void ler_arquivo(string &arquivo_entrada, map<string, int> &tipos_instrucoes){
    fstream arquivo(arquivo_entrada);
    if (arquivo.is_open()){
        string linha;
        while (getline(arquivo, linha)){
            if(linha.length() == 8){
            decodificar_instrucao(linha, tipos_instrucoes);
            }else{
                cout << "Linha ignorada: " << linha << " (nao possui 8 caracteres)" << endl;
            }
        }
        arquivo.close();
    }else{
        cout << "Nao foi possivel abrir o arquivo." << arquivo_entrada << endl;
    }
}

int main(){
    string arquivo_entrada = "dumpfile.txt";
    map<string, int> tipos_instrucoes = {{"ALU", 0}, {"ALU Immediate", 0}, {"Memory", 0}, {"Branch", 0}, {"Other", 0}, {"Jump", 0}};

    ler_arquivo(arquivo_entrada, tipos_instrucoes);

    int total_intrucoes = 0;
    for (const auto &li : tipos_instrucoes){
        total_intrucoes += li.second;
    }
    
    cout << "\nClassificacao de Instrucoes: " << endl << endl;
    cout << "\tTotal de Instrucoes: " << total_intrucoes << endl;
    for (const auto &li : tipos_instrucoes){
        cout << "\tTipo " << li.first << ": " << li.second << endl;
    }

    return 0;
}
