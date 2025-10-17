module DecodificadorDECIMAL4Bits(
    input [3:0] entrada, // 4 bits
    output a,
    output b,
    output c,
    output d,
    output e,
    output f,
    output g
);

    // Setup
    wire n0, n1, n2, n3;
    not (n0, entrada[0]);
    not (n1, entrada[1]);
    not (n2, entrada[2]);
    not (n3, entrada[3]);

	 // Wires
    wire is0, is1, is2, is3, is4, is5, is6, is7, is8, is9;
	 
	 // Números 0–9
    and (is0, n3, n2, n1, n0);
    and (is1, n3, n2, n1, entrada[0]);
    and (is2, n3, n2, entrada[1], n0);
    and (is3, n3, n2, entrada[1], entrada[0]);
    and (is4, n3, entrada[2], n1, n0);
    and (is5, n3, entrada[2], n1, entrada[0]);
    and (is6, n3, entrada[2], entrada[1], n0);
    and (is7, n3, entrada[2], entrada[1], entrada[0]);
    and (is8, entrada[3], n2, n1, n0);
    and (is9, entrada[3], n2, n1, entrada[0]);

    // SEGMENTOS
    wire a_temp, b_temp, c_temp, d_temp, e_temp, f_temp, g_temp;

    or  (a_temp, is0, is2, is3, is5, is6, is7, is8, is9);
    not (a, a_temp);

    or  (b_temp, is0, is1, is2, is3, is4, is7, is8, is9);
    not (b, b_temp);

    or  (c_temp, is0, is1, is3, is4, is5, is6, is7, is8, is9);
    not (c, c_temp);

    or  (d_temp, is0, is2, is3, is5, is6, is8, is9);
    not (d, d_temp);

    or  (e_temp, is0, is4, is5, is6, is8);
    not (e, e_temp);

    or  (f_temp, is0, is1, is4, is5, is6, is7, is8, is9);
    not (f, f_temp);

    or  (g_temp, is2, is3, is4, is5, is6, is8, is9);
    not (g, g_temp);

endmodule
