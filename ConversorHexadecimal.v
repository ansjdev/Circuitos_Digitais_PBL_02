module ConversorHexadecimal(
    input  [7:0] Entrada, // Binário (0–255)
    output [3:0] H,       // Dígito hexadecimal alto (0–F)
    output [3:0] L        // Dígito hexadecimal baixo (0–F)
);

    // ---------- Complementos ----------
    wire n0, n1, n2, n3, n4, n5, n6, n7;
    not (n0, Entrada[0]);
    not (n1, Entrada[1]);
    not (n2, Entrada[2]);
    not (n3, Entrada[3]);
    not (n4, Entrada[4]);
    not (n5, Entrada[5]);
    not (n6, Entrada[6]);
    not (n7, Entrada[7]);

    // ---------- DIGITO ALTO H[3:0] ----------
    not (H[3], n7);
    not (H[2], n6);
    not (H[1], n5);
    not (H[0], n4);

    // ---------- DIGITO BAIXO L[3:0] ----------
    not (L[3], n3);
    not (L[2], n2);
    not (L[1], n1);
    not (L[0], n0);

endmodule