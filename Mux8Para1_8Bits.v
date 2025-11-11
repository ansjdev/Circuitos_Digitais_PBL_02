// =============================================================
// Mux8Para1_8Bits — Multiplexador que escolhe uma das 8 entradas de 8 bits
// =============================================================
module Mux8Para1_8Bits(
    input  wire [7:0] Y0,
    input  wire [7:0] Y1,
    input  wire [7:0] Y2,
    input  wire [7:0] Y3,
    input  wire [7:0] Y4,
    input  wire [7:0] Y5,
    input  wire [7:0] Y6,
    input  wire [7:0] Y7,
    input  wire [2:0] sel,
    output wire [7:0] Saida
);

    // -------------------------------------------------------------
    // Decodificacao da selecao: transforma os 3 bits em 8 sinais de controle
    // -------------------------------------------------------------
    wire n0, n1, n2;
    wire s0, s1, s2, s3, s4, s5, s6, s7;

    not (n0, sel[0]);
    not (n1, sel[1]);
    not (n2, sel[2]);

    and (s0, n2, n1, n0);       // 000
    and (s1, n2, n1, sel[0]);   // 001
    and (s2, n2, sel[1], n0);   // 010
    and (s3, n2, sel[1], sel[0]); // 011
    and (s4, sel[2], n1, n0);   // 100
    and (s5, sel[2], n1, sel[0]); // 101
    and (s6, sel[2], sel[1], n0); // 110
    and (s7, sel[2], sel[1], sel[0]); // 111

    // -------------------------------------------------------------
    // Multiplexacao: para cada bit, combina as entradas usando AND e OR
    // -------------------------------------------------------------
    // bit 0
    wire y0_0, y1_0, y2_0, y3_0, y4_0, y5_0, y6_0, y7_0;
    and (y0_0, Y0[0], s0);
    and (y1_0, Y1[0], s1);
    and (y2_0, Y2[0], s2);
    and (y3_0, Y3[0], s3);
    and (y4_0, Y4[0], s4);
    and (y5_0, Y5[0], s5);
    and (y6_0, Y6[0], s6);
    and (y7_0, Y7[0], s7);
    or  (Saida[0], y0_0, y1_0, y2_0, y3_0, y4_0, y5_0, y6_0, y7_0);

    // bit 1
    wire y0_1, y1_1, y2_1, y3_1, y4_1, y5_1, y6_1, y7_1;
    and (y0_1, Y0[1], s0);
    and (y1_1, Y1[1], s1);
    and (y2_1, Y2[1], s2);
    and (y3_1, Y3[1], s3);
    and (y4_1, Y4[1], s4);
    and (y5_1, Y5[1], s5);
    and (y6_1, Y6[1], s6);
    and (y7_1, Y7[1], s7);
    or  (Saida[1], y0_1, y1_1, y2_1, y3_1, y4_1, y5_1, y6_1, y7_1);

    // bit 2
    wire y0_2, y1_2, y2_2, y3_2, y4_2, y5_2, y6_2, y7_2;
    and (y0_2, Y0[2], s0);
    and (y1_2, Y1[2], s1);
    and (y2_2, Y2[2], s2);
    and (y3_2, Y3[2], s3);
    and (y4_2, Y4[2], s4);
    and (y5_2, Y5[2], s5);
    and (y6_2, Y6[2], s6);
    and (y7_2, Y7[2], s7);
    or  (Saida[2], y0_2, y1_2, y2_2, y3_2, y4_2, y5_2, y6_2, y7_2);

    // bit 3
    wire y0_3, y1_3, y2_3, y3_3, y4_3, y5_3, y6_3, y7_3;
    and (y0_3, Y0[3], s0);
    and (y1_3, Y1[3], s1);
    and (y2_3, Y2[3], s2);
    and (y3_3, Y3[3], s3);
    and (y4_3, Y4[3], s4);
    and (y5_3, Y5[3], s5);
    and (y6_3, Y6[3], s6);
    and (y7_3, Y7[3], s7);
    or  (Saida[3], y0_3, y1_3, y2_3, y3_3, y4_3, y5_3, y6_3, y7_3);

    // bit 4
    wire y0_4, y1_4, y2_4, y3_4, y4_4, y5_4, y6_4, y7_4;
    and (y0_4, Y0[4], s0);
    and (y1_4, Y1[4], s1);
    and (y2_4, Y2[4], s2);
    and (y3_4, Y3[4], s3);
    and (y4_4, Y4[4], s4);
    and (y5_4, Y5[4], s5);
    and (y6_4, Y6[4], s6);
    and (y7_4, Y7[4], s7);
    or  (Saida[4], y0_4, y1_4, y2_4, y3_4, y4_4, y5_4, y6_4, y7_4);

    // bit 5
    wire y0_5, y1_5, y2_5, y3_5, y4_5, y5_5, y6_5, y7_5;
    and (y0_5, Y0[5], s0);
    and (y1_5, Y1[5], s1);
    and (y2_5, Y2[5], s2);
    and (y3_5, Y3[5], s3);
    and (y4_5, Y4[5], s4);
    and (y5_5, Y5[5], s5);
    and (y6_5, Y6[5], s6);
    and (y7_5, Y7[5], s7);
    or  (Saida[5], y0_5, y1_5, y2_5, y3_5, y4_5, y5_5, y6_5, y7_5);

    // bit 6
    wire y0_6, y1_6, y2_6, y3_6, y4_6, y5_6, y6_6, y7_6;
    and (y0_6, Y0[6], s0);
    and (y1_6, Y1[6], s1);
    and (y2_6, Y2[6], s2);
    and (y3_6, Y3[6], s3);
    and (y4_6, Y4[6], s4);
    and (y5_6, Y5[6], s5);
    and (y6_6, Y6[6], s6);
    and (y7_6, Y7[6], s7);
    or  (Saida[6], y0_6, y1_6, y2_6, y3_6, y4_6, y5_6, y6_6, y7_6);

    // bit 7
    wire y0_7, y1_7, y2_7, y3_7, y4_7, y5_7, y6_7, y7_7;
    and (y0_7, Y0[7], s0);
    and (y1_7, Y1[7], s1);
    and (y2_7, Y2[7], s2);
    and (y3_7, Y3[7], s3);
    and (y4_7, Y4[7], s4);
    and (y5_7, Y5[7], s5);
    and (y6_7, Y6[7], s6);
    and (y7_7, Y7[7], s7);
    or  (Saida[7], y0_7, y1_7, y2_7, y3_7, y4_7, y5_7, y6_7, y7_7);

endmodule