module OperacaoNot8Bits(
    input [7:0] A,    // Entrada A de 8 bits
    output [7:0] Y    // Saída Y de 8 bits
);
    // Instanciando dois módulos de OperacaoNot4Bits para os 4 bits inferiores e superiores
    OperacaoNot4Bits Not4Bits0(A[3:0], Y[3:0]);   // Operação NOT para os 4 bits inferiores
    OperacaoNot4Bits Not4Bits1(A[7:4], Y[7:4]);   // Operação NOT para os 4 bits superiores
endmodule
