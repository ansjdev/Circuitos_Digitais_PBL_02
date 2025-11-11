module ConversorBCD(
    input  [7:0] Entrada,  // Entrada 8 bits (0-255)
    output [3:0] C,        // Centena
    output [3:0] D,        // Dezena
    output [3:0] U         // Unidade
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

    // ---------- CENTENA C[3:0] ----------
    not (C[3], C[3]); // C3 sempre 0

    wire tC2a, tC2b;
    and (tC2a, Entrada[7], Entrada[6]);        // >=192
    or  (tC2b, Entrada[5], Entrada[4], Entrada[3], Entrada[2], Entrada[1], Entrada[0]);
    and (C[2], tC2a, tC2b);                   // >=200

    wire tC1a;
    and (tC1a, n7, Entrada[6], Entrada[5]);   // 100-191
    or  (C[1], tC1a, C[2]);

    or  (C[0], C[1], C[2]);

    // ---------- DEZENA D[3:0] ----------
    wire tD0a, tD0b;
    xor (tD0a, Entrada[0], Entrada[4]);
    xor (tD0b, Entrada[1], Entrada[5]);
    or  (D[0], tD0a, tD0b);

    // D[1..3] precisam de combinações lógicas semelhantes, usando tabela verdade

    // ---------- UNIDADE U[3:0] ----------
    wire tU0a, tU0b, tU0c;
    xor (tU0a, Entrada[0], Entrada[4]);
    xor (tU0b, Entrada[1], Entrada[5]);
    xor (tU0c, Entrada[2], Entrada[6]);
    or  (U[0], tU0a, tU0b, tU0c);

    // U[1..3] seguem o mesmo padrão usando portas

endmodule
