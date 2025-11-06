module OperacaoXor8Bits(
    input  wire [7:0] A,    // Entrada A de 8 bits
    input  wire [7:0] B,    // Entrada B de 8 bits
    output wire [7:0] Y     // Saída Y de 8 bits
);

    // Operação XOR para os 4 bits inferiores
    OperacaoXor4Bits Xor4Bits0(
        .A(A[3:0]),
        .B(B[3:0]),
        .Y(Y[3:0])
    );

    // Operação XOR para os 4 bits superiores
    OperacaoXor4Bits Xor4Bits1(
        .A(A[7:4]),
        .B(B[7:4]),
        .Y(Y[7:4])
    );

endmodule