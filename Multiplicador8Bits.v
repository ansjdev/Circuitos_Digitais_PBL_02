module Multiplicador (A, B, P);
    input  [7:0] A, B;       // operandos de 8 bits
    output [15:0] P;         // produto de 16 bits

    // produtos parciais (A * cada bit de B)
    wire [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;

    // somas intermediárias (cada uma 16 bits)
    wire [15:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6;
    wire c0, c1, c2, c3, c4, c5, c6;

    // Produtos parciais (A * cada bit de B)
    and(pp0[0], A[0], B[0]);
    and(pp0[1], A[1], B[0]);
    and(pp0[2], A[2], B[0]);
    and(pp0[3], A[3], B[0]);
    and(pp0[4], A[4], B[0]);
    and(pp0[5], A[5], B[0]);
    and(pp0[6], A[6], B[0]);
    and(pp0[7], A[7], B[0]);

    and(pp1[0], A[0], B[1]);
    and(pp1[1], A[1], B[1]);
    and(pp1[2], A[2], B[1]);
    and(pp1[3], A[3], B[1]);
    and(pp1[4], A[4], B[1]);
    and(pp1[5], A[5], B[1]);
    and(pp1[6], A[6], B[1]);
    and(pp1[7], A[7], B[1]);

    and(pp2[0], A[0], B[2]);
    and(pp2[1], A[1], B[2]);
    and(pp2[2], A[2], B[2]);
    and(pp2[3], A[3], B[2]);
    and(pp2[4], A[4], B[2]);
    and(pp2[5], A[5], B[2]);
    and(pp2[6], A[6], B[2]);
    and(pp2[7], A[7], B[2]);

    and(pp3[0], A[0], B[3]);
    and(pp3[1], A[1], B[3]);
    and(pp3[2], A[2], B[3]);
    and(pp3[3], A[3], B[3]);
    and(pp3[4], A[4], B[3]);
    and(pp3[5], A[5], B[3]);
    and(pp3[6], A[6], B[3]);
    and(pp3[7], A[7], B[3]);

    and(pp4[0], A[0], B[4]);
    and(pp4[1], A[1], B[4]);
    and(pp4[2], A[2], B[4]);
    and(pp4[3], A[3], B[4]);
    and(pp4[4], A[4], B[4]);
    and(pp4[5], A[5], B[4]);
    and(pp4[6], A[6], B[4]);
    and(pp4[7], A[7], B[4]);

    and(pp5[0], A[0], B[5]);
    and(pp5[1], A[1], B[5]);
    and(pp5[2], A[2], B[5]);
    and(pp5[3], A[3], B[5]);
    and(pp5[4], A[4], B[5]);
    and(pp5[5], A[5], B[5]);
    and(pp5[6], A[6], B[5]);
    and(pp5[7], A[7], B[5]);

    and(pp6[0], A[0], B[6]);
    and(pp6[1], A[1], B[6]);
    and(pp6[2], A[2], B[6]);
    and(pp6[3], A[3], B[6]);
    and(pp6[4], A[4], B[6]);
    and(pp6[5], A[5], B[6]);
    and(pp6[6], A[6], B[6]);
    and(pp6[7], A[7], B[6]);

    and(pp7[0], A[0], B[7]);
    and(pp7[1], A[1], B[7]);
    and(pp7[2], A[2], B[7]);
    and(pp7[3], A[3], B[7]);
    and(pp7[4], A[4], B[7]);
    and(pp7[5], A[5], B[7]);
    and(pp7[6], A[6], B[7]);
    and(pp7[7], A[7], B[7]);

    // Somadores: 
    FullAdder16 add0 (
        .A({8'b00000000, pp0}),
        .B({7'b0000000, pp1, 1'b0}),
        .Cin(1'b0),
        .S(sum0),
        .Cout(c0)
    );

    FullAdder16 add1 (
        .A(sum0),
        .B({6'b000000, pp2, 2'b00}),
        .Cin(1'b0),
        .S(sum1),
        .Cout(c1)
    );

    FullAdder16 add2 (
        .A(sum1),
        .B({5'b00000, pp3, 3'b000}),
        .Cin(1'b0),
        .S(sum2),
        .Cout(c2)
    );

    FullAdder16 add3 (
        .A(sum2),
        .B({4'b0000, pp4, 4'b0000}),
        .Cin(1'b0),
        .S(sum3),
        .Cout(c3)
    );

    FullAdder16 add4 (
        .A(sum3),
        .B({3'b000, pp5, 5'b00000}),
        .Cin(1'b0),
        .S(sum4),
        .Cout(c4)
    );

    FullAdder16 add5 (
        .A(sum4),
        .B({2'b00, pp6, 6'b000000}),
        .Cin(1'b0),
        .S(sum5),
        .Cout(c5)
    );

    FullAdder16 add6 (
        .A(sum5),
        .B({1'b0, pp7, 7'b0000000}),
        .Cin(1'b0),
        .S(sum6),
        .Cout(c6)
    );

    // Saída 
    buf (P[0],  pp0[0]);
    buf (P[1],  sum6[0]);
    buf (P[2],  sum6[1]);
    buf (P[3],  sum6[2]);
    buf (P[4],  sum6[3]);
    buf (P[5],  sum6[4]);
    buf (P[6],  sum6[5]);
    buf (P[7],  sum6[6]);
    buf (P[8],  sum6[7]);
    buf (P[9],  sum6[8]);
    buf (P[10], sum6[9]);
    buf (P[11], sum6[10]);
    buf (P[12], sum6[11]);
    buf (P[13], sum6[12]);
    buf (P[14], sum6[13]);
    buf (P[15], sum6[14]);

endmodule
