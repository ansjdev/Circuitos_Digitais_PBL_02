module Latch_D_Nor (
    input  wire D,     // Entrada SET/RESET
    input  wire CLK,   // Entrada CLOCK
    output wire Q,     // Saída principal
    output wire Qn     // Saída negada
);

    // Cria a inversão para impedir SET e RESET como 11
    wire Dn;
	 not(Dn, D);

    // Fios internos para os sinais Set (S) e Reset (R)
    wire S_in, R_in;
	 
	 // Determina se o SET ou RESET podem ser usados via sinal do CLOCK
	 and(S_in, D, CLK);
	 and(R_in, Dn, CLK);
	 
	 // Lógica de Realimentação
	 nor(Qn, S_in, Q);
	 nor(Q, R_in, Qn);

endmodule