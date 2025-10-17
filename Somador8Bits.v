module Somador8Bits(S, Cout, A, B, Cin);
    input [7:0] A, B;    // Array de inputs
    input Cin;            // Carry-in  (Entrada)
    output [7:0] S;      // Resultado da soma
    output Cout;          // Carry-out (Saída)

    wire C1;  // Carry que vai para o somador de 4 bits superior

    Somador4Bits bit0(S[3:0], C1, A[3:0], B[3:0], Cin); 
    Somador4Bits bit1(S[7:4], Cout, A[7:4], B[7:4], C1);
endmodule