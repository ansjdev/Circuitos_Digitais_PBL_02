module OperacaoNot8Bits(
    input  wire [7:0] A,   // Entrada A de 8 bits
    output wire [7:0] Y    // Saída Y de 8 bits
);

    // Operação NOT para os 4 bits inferiores
    OperacaoNot4Bits Not4Bits0(
        .A(A[3:0]),
        .Y(Y[3:0])
    );

    // Operação NOT para os 4 bits superiores
    OperacaoNot4Bits Not4Bits1(
        .A(A[7:4]),
        .Y(Y[7:4])
    );

endmodule