module ULA_8Bits(
    input [7:0] A_in,          // Entrada A de 8 bits
    input [7:0] B_in,          // Entrada B de 8 bits
	 
    input C_in,                // Entrada de carry-in 
    input [2:0] Operacao_in,    // Seletor de operação
	 
	 output [7:0] Saida_out,
    output [2:0] Flags_out    // Saida de Flags 3 Bits 
	 //  000 = NAO TEM FLAG
	 //  110 = NADA
	 //
	 //  001 = ZERO
	 //  010 = CARRY OUT
	 //  100 = ERRO
	 //  111 = OVERFLOW
);
    wire [7:0] S;         // Resultado da operação de 8 bits
    //wire Cout;            // Carry-out do somador
    //wire NCin;            // Negação de Cin
    //wire [8:0] bin_entrada; // Entrada de 9 bits para o conversor
    //wire [3:0] unidades, dezenas, centenas; // Unidades, dezenas e centenas em BCD
    //wire zero, um;
    
    // Criando constantes
    //and(zero, Cin, NCin);
    //or(um, oCin, NCin);
    //not(NCin, Cin);
    
    // Somador de 8 bits
    //Somador8Bits somador(S, Cout, A_in, B_in, NCin);
    
    // Montando entrada de 9 bits para o conversor
    //or(bin_entrada[0], S[0], zero);
    //or(bin_entrada[1], S[1], zero);
    //or(bin_entrada[2], S[2], zero);
    //or(bin_entrada[3], S[3], zero);
    //or(bin_entrada[4], S[4], zero);
    //or(bin_entrada[5], S[5], zero);
    //or(bin_entrada[6], S[6], zero);
    //or(bin_entrada[7], S[7], zero);
    //or(bin_entrada[8], Cout, zero);
    
    // Conversor BCD (Binário para BCD)
    //BinarioBCD conversor(bin_entrada, unidades, dezenas, centenas);
    
    // Displays
    //DecodificadorDisplay dec0(unidades, 
    //    HEX0[0], HEX0[1], HEX0[2], HEX0[3],
    //    HEX0[4], HEX0[5], HEX0[6]);
    
    //DecodificadorDisplay dec1(dezenas,
    //    HEX1[0], HEX1[1], HEX1[2], HEX1[3],
    //    HEX1[4], HEX1[5], HEX1[6]);

    //DecodificadorDisplay dec2(centenas,
    //    HEX2[0], HEX2[1], HEX2[2], HEX2[3],
    //   HEX2[4], HEX2[5], HEX2[6]);
    
    // LEDs
    //or(LED_Cout, Cout, zero);
    
    // LED_Z
    //wire s01, s23, s45, s67, all;
    //or(s01, S[0], S[1]);
    //or(s23, S[2], S[3]);
    //or(s45, S[4], S[5]);
    //or(s67, S[6], S[7]);
    //or(all, s01, s23);
    //or(all, all, s45);
    //or(all, all, s67);
    //not(LED_Z, all);
    
    // LED_OV (Overflow)
    //wire xor_ab, eq_ab, xor_as;
    //xor(xor_ab, A_in[7], B_in[7]);
    //not(eq_ab, xor_ab);
    //xor(xor_as, A_in[7], S[7]);
    //and(LED_OV, eq_ab, xor_as);
    
    // LED_ERR
    //and(LED_ERR, S[0], zero);

endmodule
