module Somador2Bits(S, Cout, A, B, Cin);
    input [1:0] A, B;    // Array de inputs de 2 bits
    input Cin;           // Carry-in  (Entrada)
    output [1:0] S;      // Resultado da soma
    output Cout;         // Carry-out (Saida)

    wire C1;

    // Instanciando 2 somadores de 1 bit
    Somador1Bit bit0(S[0], C1, A[0], B[0], Cin);
    Somador1Bit bit1(S[1], Cout, A[1], B[1], C1);
endmodule

