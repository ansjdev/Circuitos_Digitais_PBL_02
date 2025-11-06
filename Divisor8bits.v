// Módulo principal (top): Divider8
// Entradas: A[7:0] (dividendo), B[7:0] (divisor)
// Saídas: Q[7:0] (quociente), R[7:0] (resto)

module full_adder (
    input a, input b, input cin,
    output sum, output cout
);
    // sum = a ^ b ^ cin  → soma de 1 bit com transporte
    xor u_xor(sum, a, b, cin);
    // cout = maioria(a,b,cin) = (a&b) | (b&cin) | (a&cin)
    wire ab, bc, ac;
    and u_and1(ab, a, b);
    and u_and2(bc, b, cin);
    and u_and3(ac, a, cin);
    or  u_or1(cout, ab, bc, ac);
endmodule

// Somador ripple-carry de 9 bits
module ripple_adder9 (
    input  [8:0] A,
    input  [8:0] B,
    input        CIN,
    output [8:0] SUM,
    output       COUT
);
    wire c0, c1, c2, c3, c4, c5, c6, c7;
    // bit0
    full_adder fa0 (.a(A[0]), .b(B[0]), .cin(CIN), .sum(SUM[0]), .cout(c0));
    full_adder fa1 (.a(A[1]), .b(B[1]), .cin(c0), .sum(SUM[1]), .cout(c1));
    full_adder fa2 (.a(A[2]), .b(B[2]), .cin(c1), .sum(SUM[2]), .cout(c2));
    full_adder fa3 (.a(A[3]), .b(B[3]), .cin(c2), .sum(SUM[3]), .cout(c3));
    full_adder fa4 (.a(A[4]), .b(B[4]), .cin(c3), .sum(SUM[4]), .cout(c4));
    full_adder fa5 (.a(A[5]), .b(B[5]), .cin(c4), .sum(SUM[5]), .cout(c5));
    full_adder fa6 (.a(A[6]), .b(B[6]), .cin(c5), .sum(SUM[6]), .cout(c6));
    full_adder fa7 (.a(A[7]), .b(B[7]), .cin(c6), .sum(SUM[7]), .cout(c7));
    full_adder fa8 (.a(A[8]), .b(B[8]), .cin(c7), .sum(SUM[8]), .cout(COUT));
endmodule

// Concatenação com deslocamento: trial = {rem[7:0], dbit} -> trial[8]=rem[7], ... trial[1]=rem[0], trial[0]=dbit
module sh_concat (
    input  [7:0] rem,
    input        dbit,
    output [8:0] trial
);
    // usa buf para conexões estruturais
    buf b8(trial[8], rem[7]);
    buf b7(trial[7], rem[6]);
    buf b6(trial[6], rem[5]);
    buf b5(trial[5], rem[4]);
    buf b4(trial[4], rem[3]);
    buf b3(trial[3], rem[2]);
    buf b2(trial[2], rem[1]);
    buf b1(trial[1], rem[0]);
    buf b0(trial[0], dbit);
endmodule

// Multiplexador 2:1 de 1 bit usando portas lógicas: y = sel ? a : b
module mux1 (
    input sel, input a, input b, output y
);
    wire nsel, a_and, b_and;
    not u_not(nsel, sel);
    and u_and1(a_and, sel, a);
    and u_and2(b_and, nsel, b);
    or  u_or(y, a_and, b_and);
endmodule

// Multiplexador vetorial de 8 bits (seleciona entre SUM[7:0] e TRIAL[7:0] com base em sel)
module mux8_vec (
    input        sel,
    input  [7:0] a,   // quando sel=1 -> escolhe a
    input  [7:0] b,   // quando sel=0 -> escolhe b
    output [7:0] y
);
    mux1 m0 (.sel(sel), .a(a[0]), .b(b[0]), .y(y[0]));
    mux1 m1 (.sel(sel), .a(a[1]), .b(b[1]), .y(y[1]));
    mux1 m2 (.sel(sel), .a(a[2]), .b(b[2]), .y(y[2]));
    mux1 m3 (.sel(sel), .a(a[3]), .b(b[3]), .y(y[3]));
    mux1 m4 (.sel(sel), .a(a[4]), .b(b[4]), .y(y[4]));
    mux1 m5 (.sel(sel), .a(a[5]), .b(b[5]), .y(y[5]));
    mux1 m6 (.sel(sel), .a(a[6]), .b(b[6]), .y(y[6]));
    mux1 m7 (.sel(sel), .a(a[7]), .b(b[7]), .y(y[7]));
endmodule

// Estágio único da divisão:
// rem_in[7:0], dbit (um bit do dividendo), divisor[7:0]
// saídas: rem_out[7:0] e qbit
module div_stage (
    input  [7:0] rem_in,
    input        dbit,
    input  [7:0] divisor,
    output [7:0] rem_out,
    output       qbit
);
    wire [8:0] trial;
    wire [8:0] div_ext;
    wire [8:0] inv_div;
    wire [8:0] sum;
    wire cout;

    // trial = {rem_in, dbit}
    sh_concat sc (.rem(rem_in), .dbit(dbit), .trial(trial));

    // estende o divisor para 9 bits: div_ext = {1'b0, divisor}
    // conecta o MSB a 0 constante usando buf (sem assign)
    buf d8(div_ext[8], 1'b0);    // bit mais significativo = 0
    buf d7(div_ext[7], divisor[7]);
    buf d6(div_ext[6], divisor[6]);
    buf d5(div_ext[5], divisor[5]);
    buf d4(div_ext[4], divisor[4]);
    buf d3(div_ext[3], divisor[3]);
    buf d2(div_ext[2], divisor[2]);
    buf d1(div_ext[1], divisor[1]);
    buf d0(div_ext[0], divisor[0]);

    // inv_div = ~div_ext  (negação bit a bit)
    not n0(inv_div[0], div_ext[0]);
    not n1(inv_div[1], div_ext[1]);
    not n2(inv_div[2], div_ext[2]);
    not n3(inv_div[3], div_ext[3]);
    not n4(inv_div[4], div_ext[4]);
    not n5(inv_div[5], div_ext[5]);
    not n6(inv_div[6], div_ext[6]);
    not n7(inv_div[7], div_ext[7]);
    not n8(inv_div[8], div_ext[8]);

    // sum = trial + inv_div + 1  => efetivamente trial - div_ext (complemento de dois)
    ripple_adder9 ra9 (.A(trial), .B(inv_div), .CIN(1'b1), .SUM(sum), .COUT(cout));
    // cout == 1 => trial >= divisor (sem empréstimo). Define qbit = cout.

    // rem_out = cout ? sum[7:0] : trial[7:0]
    mux8_vec muxRem (.sel(cout), .a(sum[7:0]), .b(trial[7:0]), .y(rem_out));

    // bit do quociente
    buf qbuf(qbit, cout);
endmodule

// Módulo principal: encadeia 8 estágios, um para cada bit do dividendo (do mais significativo ao menos significativo)
module Divider8 (
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] Q,
    output [7:0] R
);
    // restos intermediários entre os estágios
    wire [7:0] r0, r1, r2, r3, r4, r5, r6, r7, r8;
    // bits de quociente gerados em cada estágio
    wire q0, q1, q2, q3, q4, q5, q6, q7;

    // resto inicial r0 = 0
    // conecta r0 a zero usando buf (sem assign)
    buf b0_0(r0[0], 1'b0); buf b0_1(r0[1], 1'b0); buf b0_2(r0[2], 1'b0);
    buf b0_3(r0[3], 1'b0); buf b0_4(r0[4], 1'b0); buf b0_5(r0[5], 1'b0);
    buf b0_6(r0[6], 1'b0); buf b0_7(r0[7], 1'b0);

    // estágio 0: usa A[7]
    div_stage s0 (.rem_in(r0), .dbit(A[7]), .divisor(B), .rem_out(r1), .qbit(q0));
    // estágio 1: A[6]
    div_stage s1 (.rem_in(r1), .dbit(A[6]), .divisor(B), .rem_out(r2), .qbit(q1));
    // estágio 2: A[5]
    div_stage s2 (.rem_in(r2), .dbit(A[5]), .divisor(B), .rem_out(r3), .qbit(q2));
    // estágio 3: A[4]
    div_stage s3 (.rem_in(r3), .dbit(A[4]), .divisor(B), .rem_out(r4), .qbit(q3));
    // estágio 4: A[3]
    div_stage s4 (.rem_in(r4), .dbit(A[3]), .divisor(B), .rem_out(r5), .qbit(q4));
    // estágio 5: A[2]
    div_stage s5 (.rem_in(r5), .dbit(A[2]), .divisor(B), .rem_out(r6), .qbit(q5));
    // estágio 6: A[1]
    div_stage s6 (.rem_in(r6), .dbit(A[1]), .divisor(B), .rem_out(r7), .qbit(q6));
    // estágio 7: A[0]
    div_stage s7 (.rem_in(r7), .dbit(A[0]), .divisor(B), .rem_out(r8), .qbit(q7));

    // monta os bits do quociente: q0 é o mais significativo, q7 o menos significativo
    buf qbuf7(Q[7], q0);
    buf qbuf6(Q[6], q1);
    buf qbuf5(Q[5], q2);
    buf qbuf4(Q[4], q3);
    buf qbuf3(Q[3], q4);
    buf qbuf2(Q[2], q5);
    buf qbuf1(Q[1], q6);
    buf qbuf0(Q[0], q7);

    // o resto final é r8
    buf rbuf0(R[0], r8[0]);
    buf rbuf1(R[1], r8[1]);
    buf rbuf2(R[2], r8[2]);
    buf rbuf3(R[3], r8[3]);
    buf rbuf4(R[4], r8[4]);
    buf rbuf5(R[5], r8[5]);
    buf rbuf6(R[6], r8[6]);
    buf rbuf7(R[7], r8[7]);
endmodule
