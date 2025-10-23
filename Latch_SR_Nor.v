module Latch_SR_Nor (
    input  wire S,     // Entrada SET
	 input  wire R,     // Entrada RESET
    input  wire CLK,   // Entrada CLOCK
    output wire Q,     // Saída principal
    output wire Qn     // Saída negada
);

    // Fios internos para os sinais Set (S) e Reset (R)
    wire S_in, R_in;
	 
	 // Determina se o SET ou RESET podem ser usados via sinal do CLOCK
	 and(S_in, S, CLK);
	 and(R_in, R, CLK);
	 
	 // Lógica de Realimentação
	 nor(Qn, S_in, Q);
	 nor(Q, R_in, Qn);

endmodule