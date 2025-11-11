module ConversorOctal(
    input  [7:0] Entrada, // Binário (0–255)
    output [3:0] C,       // Centenas octais (0–3)
    output [3:0] D,       // Dezenas octais (0–7)
    output [3:0] U        // Unidades octais (0–7)
);

    // ---------- Complementos ----------
    wire zero, n_fake;
    not (n_fake, Entrada[0]);
    and (zero, Entrada[0], n_fake);

    // ---------- CENTENA C[3:0] ----------
    wire n7, n6;
    not (n7, Entrada[7]);
    not (n6, Entrada[6]);

    // C[3:2] = 0
    and (C[3], zero, zero);
    and (C[2], zero, zero);

    // C[1] = Entrada[7]
    not (C[1], n7);

    // C[0] = Entrada[6]
    not (C[0], n6);

    // ---------- DEZENA D[3:0] ----------
    wire n5, n4, n3;
    not (n5, Entrada[5]);
    not (n4, Entrada[4]);
    not (n3, Entrada[3]);

    // D[3] = 0
    and (D[3], zero, zero);

    // D[2:0] = Entrada[5:3]
    not (D[2], n5);
    not (D[1], n4);
    not (D[0], n3);

    // ---------- UNIDADE U[3:0] ----------
    wire n2, n1, n0;
    not (n2, Entrada[2]);
    not (n1, Entrada[1]);
    not (n0, Entrada[0]);

    // U[3] = 0
    and (U[3], zero, zero);

    // U[2:0] = Entrada[2:0]
    not (U[2], n2);
    not (U[1], n1);
    not (U[0], n0);

endmodule
