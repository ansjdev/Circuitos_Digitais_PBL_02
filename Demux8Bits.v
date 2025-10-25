module Demux8Bits(
    input [7:0] D,
    input [2:0] sel,
    output [7:0] Y0,
    output [7:0] Y1,
    output [7:0] Y2,
    output [7:0] Y3,
    output [7:0] Y4,
    output [7:0] Y5,
    output [7:0] Y6,
    output [7:0] Y7
);

    // Complementos dos bits de seleção
    wire nS0, nS1, nS2;
    not (nS0, sel[0]);
    not (nS1, sel[1]);
    not (nS2, sel[2]);

    // -------------------
    // Saída Y0 = 000
    and (Y0[0], D[0], nS2, nS1, nS0);
    and (Y0[1], D[1], nS2, nS1, nS0);
    and (Y0[2], D[2], nS2, nS1, nS0);
    and (Y0[3], D[3], nS2, nS1, nS0);
    and (Y0[4], D[4], nS2, nS1, nS0);
    and (Y0[5], D[5], nS2, nS1, nS0);
    and (Y0[6], D[6], nS2, nS1, nS0);
    and (Y0[7], D[7], nS2, nS1, nS0);

    // Saída Y1 = 001
    and (Y1[0], D[0], nS2, nS1, sel[0]);
    and (Y1[1], D[1], nS2, nS1, sel[0]);
    and (Y1[2], D[2], nS2, nS1, sel[0]);
    and (Y1[3], D[3], nS2, nS1, sel[0]);
    and (Y1[4], D[4], nS2, nS1, sel[0]);
    and (Y1[5], D[5], nS2, nS1, sel[0]);
    and (Y1[6], D[6], nS2, nS1, sel[0]);
    and (Y1[7], D[7], nS2, nS1, sel[0]);

    // Saída Y2 = 010
    and (Y2[0], D[0], nS2, sel[1], nS0);
    and (Y2[1], D[1], nS2, sel[1], nS0);
    and (Y2[2], D[2], nS2, sel[1], nS0);
    and (Y2[3], D[3], nS2, sel[1], nS0);
    and (Y2[4], D[4], nS2, sel[1], nS0);
    and (Y2[5], D[5], nS2, sel[1], nS0);
    and (Y2[6], D[6], nS2, sel[1], nS0);
    and (Y2[7], D[7], nS2, sel[1], nS0);

    // Saída Y3 = 011
    and (Y3[0], D[0], nS2, sel[1], sel[0]);
    and (Y3[1], D[1], nS2, sel[1], sel[0]);
    and (Y3[2], D[2], nS2, sel[1], sel[0]);
    and (Y3[3], D[3], nS2, sel[1], sel[0]);
    and (Y3[4], D[4], nS2, sel[1], sel[0]);
    and (Y3[5], D[5], nS2, sel[1], sel[0]);
    and (Y3[6], D[6], nS2, sel[1], sel[0]);
    and (Y3[7], D[7], nS2, sel[1], sel[0]);

    // Saída Y4 = 100
    and (Y4[0], D[0], sel[2], nS1, nS0);
    and (Y4[1], D[1], sel[2], nS1, nS0);
    and (Y4[2], D[2], sel[2], nS1, nS0);
    and (Y4[3], D[3], sel[2], nS1, nS0);
    and (Y4[4], D[4], sel[2], nS1, nS0);
    and (Y4[5], D[5], sel[2], nS1, nS0);
    and (Y4[6], D[6], sel[2], nS1, nS0);
    and (Y4[7], D[7], sel[2], nS1, nS0);

    // Saída Y5 = 101
    and (Y5[0], D[0], sel[2], nS1, sel[0]);
    and (Y5[1], D[1], sel[2], nS1, sel[0]);
    and (Y5[2], D[2], sel[2], nS1, sel[0]);
    and (Y5[3], D[3], sel[2], nS1, sel[0]);
    and (Y5[4], D[4], sel[2], nS1, sel[0]);
    and (Y5[5], D[5], sel[2], nS1, sel[0]);
    and (Y5[6], D[6], sel[2], nS1, sel[0]);
    and (Y5[7], D[7], sel[2], nS1, sel[0]);

    // Saída Y6 = 110
    and (Y6[0], D[0], sel[2], sel[1], nS0);
    and (Y6[1], D[1], sel[2], sel[1], nS0);
    and (Y6[2], D[2], sel[2], sel[1], nS0);
    and (Y6[3], D[3], sel[2], sel[1], nS0);
    and (Y6[4], D[4], sel[2], sel[1], nS0);
    and (Y6[5], D[5], sel[2], sel[1], nS0);
    and (Y6[6], D[6], sel[2], sel[1], nS0);
    and (Y6[7], D[7], sel[2], sel[1], nS0);

    // Saída Y7 = 111
    and (Y7[0], D[0], sel[2], sel[1], sel[0]);
    and (Y7[1], D[1], sel[2], sel[1], sel[0]);
    and (Y7[2], D[2], sel[2], sel[1], sel[0]);
    and (Y7[3], D[3], sel[2], sel[1], sel[0]);
    and (Y7[4], D[4], sel[2], sel[1], sel[0]);
    and (Y7[5], D[5], sel[2], sel[1], sel[0]);
    and (Y7[6], D[6], sel[2], sel[1], sel[0]);
    and (Y7[7], D[7], sel[2], sel[1], sel[0]);

endmodule