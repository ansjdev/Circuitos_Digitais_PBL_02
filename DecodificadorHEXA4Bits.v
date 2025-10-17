module DecodificadorHEXA4Bits(
  input [3:0] entrada, // 4 bits
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);

  // ---------- COMPLEMENTOS DOS 4 LSB ----------
  wire n0, n1, n2, n3;
  not (n0, entrada[0]);
  not (n1, entrada[1]);
  not (n2, entrada[2]);
  not (n3, entrada[3]);

  // ---------- MINTERMS 1–F (hexadecimal) ----------
  wire is0, is1, is2, is3, is4, is5, is6, is7, is8;
  wire is9, isA, isB, isC, isD, isE, isF;

  // Números 1–9
  and (is0, n3, n2, n1, n0);             // 0000 → 0
  and (is1,  n3, n2, n1, entrada[0]); // 0001 → 1
  and (is2,  n3, n2, entrada[1], n0); // 0010 → 2
  and (is3,  n3, n2, entrada[1], entrada[0]); // 0011 → 3
  and (is4,  n3, entrada[2], n1, n0); // 0100 → 4
  and (is5,  n3, entrada[2], n1, entrada[0]); // 0101 → 5
  and (is6,  n3, entrada[2], entrada[1], n0); // 0110 → 6
  and (is7,  n3, entrada[2], entrada[1], entrada[0]); // 0111 → 7
  and (is8,  entrada[3], n2, n1, n0); // 1000 → 8
  and (is9,  entrada[3], n2, n1, entrada[0]); // 1001 → 9

  // Valores A–F
  and (isA,  entrada[3], n2, entrada[1], n0); // 1010 → A
  and (isB,  entrada[3], n2, entrada[1], entrada[0]); // 1011 → B
  and (isC,  entrada[3], entrada[2], n1, n0); // 1100 → C
  and (isD,  entrada[3], entrada[2], n1, entrada[0]); // 1101 → D
  and (isE,  entrada[3], entrada[2], entrada[1], n0); // 1110 → E
  and (isF,  entrada[3], entrada[2], entrada[1], entrada[0]); // 1111 → F

  // ---------- SEGMENTOS ----------
  wire a_temp, b_temp, c_temp, d_temp, e_temp, f_temp, g_temp;

  or (a_temp, is0, is2, is3, is4, is5, is6, is7, is8, is9, isA, isB, isC, isD, isE, isF);
  not (a, a_temp);

  or (b_temp, is0, is1, is2, is3, is4, is7, is8, is9, isA, isD);
  not (b, b_temp);

  or (c_temp, is0, is1, is3, is4, is5, is6, is7, is8, is9, isA, isB, isD);
  not (c, c_temp);

  or (d_temp, is0, is2, is3, is5, is6, is8, is9, isB, isC, isD, isE);
  not (d, d_temp);

  or (e_temp, is0, is2, is6, is8, is9, isA, isB, isC, isD, isE, isF);
  not (e, e_temp);

  or (f_temp, is0, is4, is5, is6, is8, is9, isA, isB, isC, isD, isE, isF);
  not (f, f_temp);

  or (g_temp, is2, is3, is4, is5, is6, is8, is9, isA, isB, isD, isE, isF);
  not (g, g_temp);

endmodule
