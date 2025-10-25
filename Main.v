module Main(    
	input [7:0] A_in,         // Entrada A de 8 bits
    input [7:0] B_in,         // Entrada B de 8 bits
    input C_in,               // Entrada de carry-in
    input [2:0] Operacao_in,  // Seletor de operação
    
    output [7:0] Saida_out,   // Saída de 8 bits
    output [2:0] Flags_out    // Saída das flags (3 bits)
);
    // Instanciando o módulo ULA_8Bits
    ULA_8Bits ula (
        .A_in(A_in),          // Passando A_in para o ULA_8Bits
        .B_in(B_in),          // Passando B_in para o ULA_8Bits
        .C_in(C_in),          // Passando C_in para o ULA_8Bits
        .Operacao_in(Operacao_in),  // Passando Operacao_in para o ULA_8Bits
        .Saida_out(Saida_out),  // Recebendo a saída de 8 bits
        .Flags_out(Flags_out)   // Recebendo as flags
    );
	 
    
endmodule