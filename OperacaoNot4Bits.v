module OperacaoNot4Bits(
    input [3:0] A,
    output [3:0] Y
);
    not Not0(Y[0], A[0]);
    not Not1(Y[1], A[1]);
    not Not2(Y[2], A[2]);
    not Not3(Y[3], A[3]);
endmodule
