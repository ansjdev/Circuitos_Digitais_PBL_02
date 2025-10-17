module OperacaoOr8Bits(
    input [7:0] A,    // Entrada A de 8 bits
    input [7:0] B,    // Entrada B de 8 bits
    output [7:0] Y    // Saída Y de 8 bits
);
    // Instanciando dois módulos de OperacaoOr4Bits
    OperacaoOr4Bits Or4Bits0(Y[3:0], A[3:0], B[3:0]);   // Operação OR para os 4 bits inferiores
    OperacaoOr4Bits Or4Bits1(Y[7:4], A[7:4], B[7:4]);   // Operação OR para os 4 bits superiores
endmodule
