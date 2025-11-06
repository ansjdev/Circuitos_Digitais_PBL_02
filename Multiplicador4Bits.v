module Multiplicador (A, B, P);
    input [3:0] A, B;     // operandos de 4 bits
    output [7:0] P;       // produto de 8 bits

    wire [3:0] pp0, pp1, pp2, pp3; // produtos parciais
    wire [7:0] sum1, sum2, sum3;
    wire c1, c2, c3;

    // Produtos parciais (A * cada bit de B)
    and(pp0[0], A[0], B[0]);
    and(pp0[1], A[1], B[0]);
    and(pp0[2], A[2], B[0]);
    and(pp0[3], A[3], B[0]);

    and(pp1[0], A[0], B[1]);
    and(pp1[1], A[1], B[1]);
    and(pp1[2], A[2], B[1]);
    and(pp1[3], A[3], B[1]);

    and(pp2[0], A[0], B[2]);
    and(pp2[1], A[1], B[2]);
    and(pp2[2], A[2], B[2]);
    and(pp2[3], A[3], B[2]);

    and(pp3[0], A[0], B[3]);
    and(pp3[1], A[1], B[3]);
    and(pp3[2], A[2], B[3]);
    and(pp3[3], A[3], B[3]);

    FullAdder add1 (
        .A({3'b000, pp0}),         
        .B({2'b00, pp1, 1'b0}),    
        .Cin(1'b0),
        .S(sum1[3:0]),
        .Cout(c1)
    );

    FullAdder add2 (
        .A(sum1[3:0]),
        .B({1'b0, pp2, 2'b00}), 
        .Cin(c1),
        .S(sum2[3:0]),
        .Cout(c2)
    );

    FullAdder add3 (
        .A(sum2[3:0]),
        .B({pp3, 3'b000}),
        .Cin(c2),
        .S(sum3[3:0]),
        .Cout(c3)
    );

    buf (P[0], pp0[0]);
    buf (P[1], sum3[0]);
    buf (P[2], sum3[1]);
    buf (P[3], sum3[2]);
    buf (P[4], sum3[3]);
    buf (P[5], 1'b0);  
    buf (P[6], 1'b0);  
    buf (P[7], 1'b0);  

endmodule
