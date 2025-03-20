#include <iostream>
#include <fstream>
#include <string>
#include <map>

using namespace std;

string hexadecimal_para_binario(char hexadecimal){
    switch (toupper(hexadecimal)){
    case '0':
        return "0000";
    case '1':
        return "0001";
    case '2':
        return "0010";
    case '3':
        return "0011";
    case '4':
        return "0100";
    case '5':
        return "0101";
    case '6':
        return "0110";
    case '7':
        return "0111";
    case '8':
        return "1000";
    case '9':
        return "1001";
    case 'A':
        return "1010";
    case 'B':
        return "1011";
    case 'C':
        return "1100";
    case 'D':
        return "1101";
    case 'E':
        return "1110";
    case 'F':
        return "1111";
    default:
        return "Não foi possível converter a instrução de hexadecimal para binário.";
    }
}

string hexadecimal_para_binario(string hexadecimal){
    string binario;
    for (char c : hexadecimal)
        binario += hexadecimal_para_binario(c);
    return binario;
}

void decodificar_instrucao(string hexadecimal, map<string, int> &tipos_instrucoes){ 
    string instrucao_completa = hexadecimal_para_binario(hexadecimal);
    if (instrucao_completa.length() == 32){
        string opcode = instrucao_completa.substr(25, 7);
        if (opcode == "0110011")
        {
            cout << instrucao_completa <<  ": tipo ALU" << endl;
            tipos_instrucoes["ALU"]++;
        }
        else if (opcode == "1110011" || opcode == "0010011")
        {
            cout << instrucao_completa <<  ": tipo ALU Immediate" << endl;
            tipos_instrucoes["ALU Immediate"]++;
        }
        else if (opcode == "0000011") 
        {
            cout << instrucao_completa <<  ": tipo Memory" << endl;
            tipos_instrucoes["Memory"]++; // Instruções de load
        }
        else if (opcode == "0100011")
        {
            cout << instrucao_completa <<  ": tipo Memory" << endl;
            tipos_instrucoes["Memory"]++;
        }
        else if (opcode == "1100011")
        {
            cout << instrucao_completa <<  ": tipo Branch" << endl;
            tipos_instrucoes["Branch"]++;
        }
        else if (opcode == "0110111" || opcode == "0010111")
        {
            cout << instrucao_completa <<  ": tipo Other" << endl;
            tipos_instrucoes["Other"]++;
        }
        else if (opcode == "1101111")
        {
            cout << instrucao_completa <<  ": tipo Jump" << endl;
            tipos_instrucoes["Jump"]++;
        }
        else if (opcode == "1100111")
        {
            cout << instrucao_completa <<  ": tipo Other" << endl;
            tipos_instrucoes["Other"]++; //JALR
        }
        else
        {
            cout << "Opcode não implementado" << endl;
        }
    }else{
        cout << "A instrução não tem 32 bits." << endl;
    }
}

void ler_arquivo(string &arquivo_entrada, map<string, int> &tipos_instrucoes){
    fstream arquivo(arquivo_entrada);
    if (arquivo.is_open()){
        string linha;
        while (getline(arquivo, linha)){
            decodificar_instrucao(linha, tipos_instrucoes);
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
