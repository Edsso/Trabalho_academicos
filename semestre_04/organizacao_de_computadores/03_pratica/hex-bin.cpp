#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>

using namespace std;

struct Instruction {
    string full_instruction;
    string opcode;
    string op_code;
    string rd;
    string rs1;
    string rs2;
    string funct3;

    string to_string() const{
        string resul = "Intrucao Completa: " + full_instruction + "\t";
        resul += "Opcode: " + opcode + " | ";
        if (!rd.empty()) resul += "rd: " + rd + " | ";
        if (!rs1.empty()) resul += "rs1: " + rs1 + " | ";
        if (!rs2.empty()) resul += "rs2: " + rs2 + " | ";
        return resul;
    }
};

int mostrar_instrucoes(int instrucoes){
    return instrucoes;
}

// Função para converter hexadecimal para binário
string hexadecimal_para_binario(char hexadecimal) {
    switch (toupper(hexadecimal)) {
    case '0': return "0000";
    case '1': return "0001";
    case '2': return "0010";
    case '3': return "0011";
    case '4': return "0100";
    case '5': return "0101";
    case '6': return "0110";
    case '7': return "0111";
    case '8': return "1000";
    case '9': return "1001";
    case 'A': return "1010";
    case 'B': return "1011";
    case 'C': return "1100";
    case 'D': return "1101";
    case 'E': return "1110";
    case 'F': return "1111";
    default: return "Erro na conversao.";
    }
}

// Função para converter uma string hexadecimal inteira em binário
string hexadecimal_para_binario(string hexadecimal) {
    string binario;
    for (char c : hexadecimal)
        binario += hexadecimal_para_binario(c);
    return binario;
}

// Função para classificar as Intruçoes e Informar opcode, rd, rs1 e rs2
void decodificar_instrucao(const vector<Instruction> &instrucoes, map<string, int> &tipos_instrucoes){ 
    for (const auto &instrucao : instrucoes) {
        if (instrucao.full_instruction.length() == 32) {
            string opcode = instrucao.opcode;
            
            if (opcode == "0110011") {
                cout << "\n" << instrucao.to_string() << " ALU" << endl;
                tipos_instrucoes["ALU"]++;
            }
            else if (opcode == "1110011" || opcode == "0010011") {
                cout << "\n" << instrucao.to_string() << " ALU Immediate" << endl;
                tipos_instrucoes["ALU Immediate"]++;
            }
            else if (opcode == "0000011") {
                cout << "\n" << instrucao.to_string() << " Memory (Load)" << endl;
                tipos_instrucoes["Memory"]++;
            }
            else if (opcode == "0100011") {
                cout << "\n" << instrucao.to_string() << " Memory (Store)" << endl;
                tipos_instrucoes["Memory"]++;
            }
            else if (opcode == "1100011") {
                cout << "\n" << instrucao.to_string() << " Branch" << endl;
                tipos_instrucoes["Branch"]++;
            }
            else if (opcode == "0110111" || opcode == "0010111") {
                cout << "\n" << instrucao.to_string() << " Tipo Other (LUI/AUIPC)" << endl;
                tipos_instrucoes["Other"]++;
            }
            else if (opcode == "1101111") {
                cout << "\n" << instrucao.to_string() << " Jump (JAL)" << endl;
                tipos_instrucoes["Jump"]++;
            }
            else if (opcode == "1100111") {
                cout << "\n" << instrucao.to_string() << " Tipo Other (JALR)" << endl;
                tipos_instrucoes["Other"]++;
            }
            else {
                cout << "\nOpcode nao implementado: " << instrucao.full_instruction << endl;
            }
        } else {
            cout << "A instrucao " << instrucao.full_instruction << " nao tem 32 bits." << endl;
        }
    }
}

// Função para detalhar instrução a partir do formato binário
Instruction detalhar_instrucao(string instrucao_completa) {
    Instruction instrucao;
    instrucao.full_instruction = instrucao_completa;
    instrucao.opcode = instrucao_completa.substr(25, 7);
    instrucao.funct3 = instrucao_completa.substr(17,3);

    if (instrucao.opcode == "0110011") { // Tipo R (ALU)
        instrucao.rd = instrucao_completa.substr(20, 5);
        instrucao.rs1 = instrucao_completa.substr(12, 5);
        instrucao.rs2 = instrucao_completa.substr(7, 5);
    } 
    else if (instrucao.opcode == "0010011" || instrucao.opcode == "1110011") { // Tipo I (Immediate)
        instrucao.rd = instrucao_completa.substr(20, 5);
        instrucao.rs1 = instrucao_completa.substr(12, 5);
    } 
    else if (instrucao.opcode == "0000011" || instrucao.opcode == "0100011") { // Tipo Memory (Load/Store)
        instrucao.rd = instrucao_completa.substr(20, 5);
        instrucao.rs1 = instrucao_completa.substr(12, 5);
    } 
    else if (instrucao.opcode == "1100011") { // Tipo B (Branch)
        instrucao.rs1 = instrucao_completa.substr(12, 5);
        instrucao.rs2 = instrucao_completa.substr(7, 5);
    } 
    else if (instrucao.opcode == "1101111") { // Tipo J (Jump)
        instrucao.rd = instrucao_completa.substr(20, 5);
    } 
    else if (instrucao.opcode == "0110111" || instrucao.opcode == "0010111") { // Other (LUI/AUIPC)
        instrucao.rd = instrucao_completa.substr(20, 5);
    } else {
        cout << "Opcode nao reconhecido: " << instrucao.opcode << endl;
    }
    return instrucao;
}

// Função para resolver conflitos de dados
void resolver_conflito_dados(const vector<Instruction>& instructions, vector<Instruction>& resolvido_instructions) {
    bool tem_conflito = false;
    bool next_tem_conflito = false;

    Instruction nop;
    nop.full_instruction = "00000000000000000000000000010011";

    for (int i = 0; i < instructions.size() - 1; i++) {
        
        const Instruction& current_inst = instructions[i];
        const Instruction& next_inst = instructions[i + 1];
        const Instruction& subsequent_inst = instructions[i + 2];

        resolvido_instructions.push_back(current_inst);
        
        tem_conflito = false;
        next_tem_conflito = false;

        if(current_inst.rd != "00000"){
            if(next_inst.rd == subsequent_inst.rs1 || next_inst.rd == subsequent_inst.rs2)
                next_tem_conflito = true;

            if(next_inst.opcode == "0110011"){
                if (current_inst.rd == next_inst.rs1) { // Verificando se a próxima instrução tem conflito
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop); // 2 nops para completar 2 ciclos antes da próxima instrução
                    resolvido_instructions.push_back(nop);
                } else if (!next_tem_conflito && !tem_conflito && current_inst.rd == subsequent_inst.rs1) { // Verificando se a instrução subsequente tem conflito
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop); // 1 nop para instrução subsequente (1 nop + 1 instrução = 2 ciclos)
                }
            } if(next_inst.opcode != "0110011") { // R etc
                if (current_inst.rd == next_inst.rs1 || current_inst.rd == next_inst.rs2) { // Verificando se a próxima instrução tem conflito
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop); // 2 nops para completar 2 ciclos antes da próxima instrução
                    resolvido_instructions.push_back(nop);
                } else if (!next_tem_conflito && !tem_conflito && (current_inst.rd == subsequent_inst.rs1 || current_inst.rd == subsequent_inst.rs2)) { // Verificando se a instrução subsequente tem conflito
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop); // 1 nop para instrução subsequente (1 nop + 1 instrução = 2 ciclos)
                }
            }
        }

        if(!tem_conflito){
            cout << "\nSem conflito na instrucao: " << current_inst.full_instruction;
        }
    }
    resolvido_instructions.push_back(instructions[instructions.size() - 1]);
}

// forwarding
void forwarding_com_nops(const vector<Instruction>& instructions, vector<Instruction>& resolvido_instructions){
    bool tem_conflito = false;
    bool next_tem_conflito = false;

    Instruction nop;
    nop.full_instruction = "00000000000000000000000000010011";

    for (int i = 0; i < instructions.size() - 1; i++) {
        
        const Instruction& current_inst = instructions[i];
        const Instruction& next_inst = instructions[i + 1];
        const Instruction& subsequent_inst = instructions[i + 2];

        resolvido_instructions.push_back(current_inst);
        
        tem_conflito = false;
        next_tem_conflito = false;

        if(current_inst.opcode == "0000011"){ // Load instructions
            if(next_inst.opcode == "1110011" || next_inst.opcode == "0010011" || next_inst.opcode == "0000011"){
                if(current_inst.rd == next_inst.rs1){
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao Load: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop);
                }
            } else if (next_inst.opcode == "1100011" || next_inst.opcode == "0100011" || next_inst.opcode == "0110011"){
                if(current_inst.rd == next_inst.rs1 || current_inst.rd == next_inst.rs2){
                    tem_conflito = true;
                    cout << "\nConflito detectado na instrucao Load: " << current_inst.full_instruction;
                    resolvido_instructions.push_back(nop);
                }
            }
        }
    }
}

bool ha_dependencia(const Instruction& inst1, const Instruction& inst2) {
    return (inst1.rd == inst2.rs1 || inst1.rd == inst2.rs2);
}

// Reordenar 
void reordenar_instrucoes(vector<Instruction>& instructions, vector<Instruction>& resolved_instructions) {
    bool has_conflict = false;
    bool next_has_conflict = false;
    
    Instruction nop;
    nop.full_instruction = "00000000000000000000000000010011";

    for(int i = 0; i < instructions.size(); i++){
        const Instruction& current_inst = instructions[i];
        const Instruction& next_inst = instructions[i + 1];
        const Instruction& subsequent_inst = instructions[i + 2];

        if(current_inst.full_instruction == "00000000000000000000000000010011") // NOP
            continue;

        // Se a instrução é de salto (JAL ou BEQ), adiciona ao resultado e passa para a próxima
        if(current_inst.opcode == "1101111" || current_inst.opcode == "1100011"){
            resolved_instructions.push_back(current_inst);
            continue;
        }
        resolved_instructions.push_back(current_inst);

        // Reseta as variáveis de conflito
        has_conflict = false;
        next_has_conflict = false;

        if(current_inst.rd != "00000"){
            if(next_inst.rd == subsequent_inst.rs1 || next_inst.rd == subsequent_inst.rs2)
                next_has_conflict = true;

            if(current_inst.rd == next_inst.rs1 || current_inst.rd == next_inst.rs2){
                next_has_conflict = true;

                for(int k = 0; k < 2; k++){ // Realiza até 2 ciclos de reordenação 
                    bool check_for_reorder = false;

                    // Procura uma instrução que possa ser reordenada sem causar conflitos
                    for(int j = i + 1; j < instructions.size(); j++){
                        Instruction& reorder_inst = instructions[j];
                        Instruction& prev_inst = instructions[i - 1];

                        // Interrompe a reordenação se encontrar uma instrução de salto ou uma operação de tipo fixo
                        if(reorder_inst.opcode == "1101111" || reorder_inst.opcode == "1100011" || (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")){
                            break;
                        }
                        
                        if(current_inst.rd == reorder_inst.rs1 || current_inst.rd == reorder_inst.rs2){
                            bool has_conflict_for_reorder = false;

                            if(instructions[i - 2].rd == reorder_inst.rs1 || instructions[i - 2].rd == reorder_inst.rs2){
                                has_conflict_for_reorder = true;
                            }
                            if(prev_inst.rd == reorder_inst.rs1 || prev_inst.rd == reorder_inst.rs2){
                                has_conflict_for_reorder = true;
                            }
                            if(instructions[i + 1].rs1 == reorder_inst.rd || instructions[i + 1].rs2 == reorder_inst.rd){
                                has_conflict_for_reorder = true;
                            }
                            if(instructions[i + 2].rs1 == reorder_inst.rd || instructions[i + 2].rs2 == reorder_inst.rd){
                                has_conflict_for_reorder = true;
                            }
                            if(prev_inst.opcode == "1100011"){ // JALR
                                has_conflict_for_reorder = true;
                            }
                            if(!has_conflict_for_reorder){
                                // Se não houver conflito, reordena a instrução
                                check_for_reorder = true;
                                if (i <= instructions.size()) {
                                    instructions.insert(instructions.begin() + i + 1, reorder_inst); // Insere na nova posição
                                }
                                if (j + 1 < instructions.size()) {
                                    instructions.erase(instructions.begin() + j); // Remove da posição original
                                }
                                break;
                            }
                        }
                    }
                    if(!check_for_reorder){
                        resolved_instructions.push_back(nop);
                    }
                }
            }
            // Verifica se á um conflito com a instrução subsequente, se nenhuma reordenação foi feita
            else if(!next_has_conflict && !has_conflict && (current_inst.rd == subsequent_inst.rs1 || current_inst.rd == subsequent_inst.rs2)){
                bool check_for_reorder = false;

                for(int j = i + 1; j < instructions.size(); j++){
                    Instruction& reorder_inst = instructions[j];
                    Instruction& prev_inst = instructions[i - 1];

                    if(reorder_inst.opcode == "1101111" || reorder_inst.opcode == "1100011" || (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")){
                        break;
                    }

                    if(current_inst.rd == reorder_inst.rs1 || current_inst.rd == reorder_inst.rs2){
                        bool has_conflict_for_reorder = false;

                        if(instructions[i - 2].rd == reorder_inst.rs1 || instructions[i - 2].rd == reorder_inst.rs2){
                            has_conflict_for_reorder = true;
                        }
                        if(prev_inst.rd == reorder_inst.rs1 || prev_inst.rd == reorder_inst.rs2){
                            has_conflict_for_reorder = true;
                        }
                        if(instructions[i + 1].rs1 == reorder_inst.rd || instructions[i + 1].rs2 == reorder_inst.rd){
                            has_conflict_for_reorder = true;
                        }
                        if(instructions[i + 2].rs1 == reorder_inst.rd || instructions[i + 2].rs2 == reorder_inst.rd){
                            has_conflict_for_reorder = true;
                        }
                        if(prev_inst.opcode == "1100011"){ // JALR
                            has_conflict_for_reorder = true;
                        }
                        if(!has_conflict_for_reorder){
                            check_for_reorder = true;
                            if (i <= instructions.size()) {
                                instructions.insert(instructions.begin() + i + 1, reorder_inst);
                            }
                            if (j + 1 < instructions.size()) {
                                instructions.erase(instructions.begin() + j);
                            }
                            break;
                        }
                    }
                }
                if(!check_for_reorder){
                    resolved_instructions.push_back(nop);
                }
            }
        }
    }
    // Loop para verificar as instruções resolvidas e inserir NOPs após JALR
    for (int i = 0; i < resolved_instructions.size(); i++){
        detalhar_instrucao(resolved_instructions[i].full_instruction);
        if (resolved_instructions[i].opcode == "1100111"){ // JALR
            resolved_instructions.insert(resolved_instructions.begin() + i, nop);
            if (i != resolved_instructions.size() - 2){
                resolved_instructions.insert(resolved_instructions.begin() + i + 2, nop);
            }
            i++;
        }
    }
}

// Reordenar forwarding
void reordenar_e_forwarding_com_nops(vector<Instruction>& instructions, vector<Instruction>& resolved_instructions) {
    Instruction nop;
    nop.full_instruction = "00000000000000000000000000010011"; 

    for (int i = 0; i < instructions.size(); i++) {  
        const Instruction& current_inst = instructions[i];
        const Instruction& next_inst = instructions[i + 1];

        resolved_instructions.push_back(current_inst);

        if (current_inst.opcode == "0000011") { // Verifica se a instrução atual é um Load
            if (next_inst.opcode == "1110011" || next_inst.opcode == "0010011" || next_inst.opcode == "0000011") {
                if (current_inst.rd == next_inst.rs1) {
                    bool check_for_reorder = false; // Flag para saber se a instrução foi reordenada

                    // Tenta reordenar instruções para evitar o NOP
                    for (int j = i + 1; j < instructions.size(); j++) {
                        Instruction& reorder_inst = instructions[j];
                        Instruction& prev_inst = instructions[i - 1];

                        // Interrompe a reordenação se encontrar instruções de salto ou operações que não podem ser reordenadas
                        if (reorder_inst.opcode == "1101111" || reorder_inst.opcode == "1100011" || 
                            (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || 
                            (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")) {
                            break;
                        }

                        // Verifica se há conflito de dados entre a instrução atual e a candidata à reordenação
                        if (current_inst.rd == reorder_inst.rs1 || current_inst.rd == reorder_inst.rs2) {
                            bool has_conflict_for_reorder = false;

                            // Confere conflitos com instruções anteriores e posteriores
                            if (instructions[i - 2].rd == reorder_inst.rs1 || instructions[i - 2].rd == reorder_inst.rs2) {
                                has_conflict_for_reorder = true;
                            }
                            if (prev_inst.rd == reorder_inst.rs1 || prev_inst.rd == reorder_inst.rs2) {
                                has_conflict_for_reorder = true;
                            }
                            if (instructions[i + 1].rs1 == reorder_inst.rd || instructions[i + 1].rs2 == reorder_inst.rd) {
                                has_conflict_for_reorder = true;
                            }
                            if (instructions[i + 2].rs1 == reorder_inst.rd || instructions[i + 2].rs2 == reorder_inst.rd) {
                                has_conflict_for_reorder = true;
                            }
                            // Confere conflitos específicos para instruções de salto
                            if (prev_inst.opcode == "1100011" || prev_inst.opcode == "1101111" || 
                                (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || 
                                (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")) {
                                has_conflict_for_reorder = true;
                            }
                            // Caso não haja conflito, reordena a instrução
                            if (!has_conflict_for_reorder) {
                                check_for_reorder = true;
                                if (i <= instructions.size()) {
                                    instructions.insert(instructions.begin() + i + 1, reorder_inst);
                                }
                                if (j + 1 < instructions.size()) {
                                    instructions.erase(instructions.begin() + j);
                                }
                                break;
                            }
                        }
                    }
                    // Caso não tenha sido possível reordenar, insere um NOP
                    if (!check_for_reorder) {
                        resolved_instructions.push_back(nop);
                    }
                }
            } 
            else if (next_inst.opcode == "1100011" || next_inst.opcode == "0100011" || next_inst.opcode == "0110011") {
                if (current_inst.rd == next_inst.rs1 || current_inst.rd == next_inst.rs2) {
                    bool check_for_reorder = false;

                    for (int j = i + 1; j < instructions.size(); j++) {
                        Instruction& reorder_inst = instructions[j];
                        Instruction& prev_inst = instructions[i - 1];

                        if (reorder_inst.opcode == "1101111" || reorder_inst.opcode == "1100011" || 
                            (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || 
                            (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")) {
                            break;
                        }

                        if (current_inst.rd == reorder_inst.rs1 || current_inst.rd == reorder_inst.rs2) {
                            bool has_conflict_for_reorder = false;

                            if (instructions[i - 2].rd == reorder_inst.rs1 || instructions[i - 2].rd == reorder_inst.rs2) {
                                has_conflict_for_reorder = true;
                            }
                            if (prev_inst.rd == reorder_inst.rs1 || prev_inst.rd == reorder_inst.rs2) {
                                has_conflict_for_reorder = true;
                            }
                            if (instructions[i + 1].rs1 == reorder_inst.rd || instructions[i + 1].rs2 == reorder_inst.rd) {
                                has_conflict_for_reorder = true;
                            }
                            if (instructions[i + 2].rs1 == reorder_inst.rd || instructions[i + 2].rs2 == reorder_inst.rd) {
                                has_conflict_for_reorder = true;
                            }
                            if (prev_inst.opcode == "1100011" || prev_inst.opcode == "1101111" || 
                                (prev_inst.opcode == "1110011" && prev_inst.funct3 == "000") || 
                                (prev_inst.opcode == "0010011" && prev_inst.funct3 == "000")) {
                                has_conflict_for_reorder = true;
                            }
                            if (!has_conflict_for_reorder) {
                                check_for_reorder = true;
                                if (i <= instructions.size()) {
                                    instructions.insert(instructions.begin() + i + 1, reorder_inst);
                                }
                                if (j + 1 < instructions.size()) {
                                    instructions.erase(instructions.begin() + j);
                                }
                                break;
                            }
                        }
                    }
                    if (!check_for_reorder) {
                        resolved_instructions.push_back(nop);
                    }
                }
            }
        }
    }
}

// Função para ler um arquivo de instruções
void ler_file(const string& input_file, vector<Instruction>& instructions) {
    fstream file(input_file);
    if (file.is_open()) {
        string line;
        while (getline(file, line)) {
            string instrucao_binaria = hexadecimal_para_binario(line);
            if (instrucao_binaria.length() == 32) {
                instructions.push_back(detalhar_instrucao(instrucao_binaria));
            }
        }
        file.close();
    } else {
        cout << "Nao foi possivel abrir o arquivo: " << input_file << endl;
    }
}

// Função para escrever as instruções resolvidas em um arquivo
void escrever_file(const vector<Instruction>& resolvido_instructions) {
    ofstream output_file("output.txt");
    if (output_file.is_open()) {
        for (const auto& instruction : resolvido_instructions) {
            output_file << instruction.full_instruction << "\n";
        }
        output_file.close();
    } else {
        cout << "Erro ao abrir o arquivo de saida." << endl;
    }
}

int main() {
    string input_file = "TesteReorHex.txt";
    map<string, int> tipos_instrucoes = {{"ALU", 0}, {"ALU Immediate", 0}, {"Memory", 0}, {"Branch", 0}, {"Other", 0}, {"Jump", 0}};
    vector<Instruction> instructions;
    vector<Instruction> resolvido_instructions;

    // Leitura do arquivo
    ler_file(input_file, instructions);

    decodificar_instrucao(instructions, tipos_instrucoes);

    int total_intrucoes = 0;
        for (const auto &li : tipos_instrucoes){
            total_intrucoes += li.second;
        }

    cout << "================================================================" << endl;

    cout << "Menu: " << endl;
    cout << "1 - Resolver Conflitos de Dados com NOPs" << endl;
    cout << "2 - Resolver Conflitos de Dados usando Forwarding" << endl;
    cout << "3 - Resolver Conflitos de Dados Reordenando" << endl;
    cout << "4 - Resolver Conflitos de Dados Reordenando Forwarding" << endl;
    cout << "0 - Sair" << endl;
    int op;
    cin >> op;

    cout << "================================================================" << endl;

    switch(op){
        case 1:{
            cout << "<-------------------------------------------------->" << endl;

            cout << "Iniciando... ";

            cout << "\nClassificacao de Instrucoes: " << endl << endl;
            cout << "\tTotal de Instrucoes: " << mostrar_instrucoes(instructions.size()) << endl;
                for (const auto &li : tipos_instrucoes){
                    cout << "\tTipo " << li.first << ": " << li.second << endl;
                }

            // Resolver conflitos de dados
            cout << "\nResolvendo conflitos de dados com NOPs..." << endl;
            resolver_conflito_dados(instructions, resolvido_instructions);
            cout << "\n\n\tTotal de Instrucoes com NOPs: " << mostrar_instrucoes(resolvido_instructions.size()) << endl;
            cout << "\tA quantidade de NOPs alocado na instrucao: " << mostrar_instrucoes(resolvido_instructions.size()-instructions.size()) << endl;

            // Escrever as instruções resolvidas no arquivo de saída
            cout << "\nAbrir arquivo 'output.txt' para visualizar os conflitos de dados resolvido com NOPs...\n";
            escrever_file(resolvido_instructions);

            cout << "<-------------------------------------------------->" << endl;
            break;
        }
        case 2:{
            cout << "<-------------------------------------------------->" << endl;

            cout << "Iniciando Forwarding... ";

            cout << "\nClassificacao de Instrucoes: " << endl << endl;
            cout << "\tTotal de Instrucoes: " << mostrar_instrucoes(instructions.size()) << endl;
                for (const auto &li : tipos_instrucoes){
                    cout << "\tTipo " << li.first << ": " << li.second << endl;
                }

            // Resolver conflitos de dados
            cout << "\nResolvendo conflitos de dados com NOPs..." << endl;
            forwarding_com_nops(instructions, resolvido_instructions);
            cout << "\n\n\tTotal de Instrucoes com NOPs: " << mostrar_instrucoes(resolvido_instructions.size()) << endl;
            cout << "\tA quantidade de NOPs alocado na instrucao: " << mostrar_instrucoes(resolvido_instructions.size()-instructions.size()) << endl;

            // Escrever as instruções resolvidas no arquivo de saída
            cout << "\nAbrir arquivo 'output.txt' para visualizar os conflitos de dados resolvido com NOPs...\n";
            escrever_file(resolvido_instructions);

            cout << "<-------------------------------------------------->" << endl;
            break;
        }
        case 3:{
            cout << "<-------------------------------------------------->" << endl;

            cout << "Reordenando... ";

            // Resolver conflitos de dados
            cout << "\nResolvendo conflitos de dados com NOPs..." << endl;
            reordenar_instrucoes(instructions, resolvido_instructions);
            cout << "\n\n\tTotal de Instrucoes sem NOPs: " << mostrar_instrucoes(instructions.size()) << endl;
            cout << "\tTotal de Instrucoes com NOPs: " << mostrar_instrucoes(resolvido_instructions.size()) << endl;
            cout << "\tA quantidade de NOPs alocado na instrucao: " << mostrar_instrucoes(resolvido_instructions.size()-instructions.size()) << endl;

            // Escrever as instruções resolvidas no arquivo de saída
            cout << "\nAbrir arquivo 'output.txt' para visualizar os conflitos de dados resolvido com NOPs...\n";
            escrever_file(resolvido_instructions);

            cout << "<-------------------------------------------------->" << endl;
            break;
        }
        case 4:{
            cout << "<-------------------------------------------------->" << endl;

            cout << "Reordenando e Forwarding... ";

            // Resolver conflitos de dados
            cout << "\nResolvendo conflitos de dados com NOPs..." << endl;
            reordenar_e_forwarding_com_nops(instructions, resolvido_instructions);
            cout << "\n\n\tTotal de Instrucoes sem NOPs: " << mostrar_instrucoes(instructions.size()) << endl;
            cout << "\tTotal de Instrucoes com NOPs: " << mostrar_instrucoes(resolvido_instructions.size()) << endl;
            cout << "\tA quantidade de NOPs alocado na instrucao: " << mostrar_instrucoes(resolvido_instructions.size()-instructions.size()) << endl;

            // Escrever as instruções resolvidas no arquivo de saída
            cout << "\nAbrir arquivo 'output.txt' para visualizar os conflitos de dados resolvido com NOPs...\n";
            escrever_file(resolvido_instructions);

            cout << "<-------------------------------------------------->" << endl;
            break;
        }
        case 0:
            return 0;
    }
}
