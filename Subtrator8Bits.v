module Subtrator8Bits(S, Bout, A, B, Bin);
    input [7:0] A, B;    // Array de inputs
    input Bin;            // Borrow-in  (Entrada)
    output [7:0] S;      // Resultado da soma
    output Bout;          // Borrow-out (Saída)

    wire C1;  // Carry que vai para o somador de 4 bits superior

    Subtrator4Bits bit0(S[3:0], C1, A[3:0], B[3:0], Bin); 
    Subtrator4Bits bit1(S[7:4], Bout, A[7:4], B[7:4], C1);
endmodule