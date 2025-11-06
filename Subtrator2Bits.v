module Subtrator2Bits(S, Bout, A, B, Bin);
    input [1:0] A, B;    // Array de inputs de 2 bits
    input Bin;           // Borrow-in  (Entrada)
    output [1:0] S;      // Resultado da subtração
    output Bout;         // Borrow-out (Saida)

    wire C1;

    // Instanciando 2 subtratores de 1 bit
    Subtrator1Bit bit0(S[0], C1, A[0], B[0], Bin);
    Subtrator1Bit bit1(S[1], Bout, A[1], B[1], C1);
endmodule

