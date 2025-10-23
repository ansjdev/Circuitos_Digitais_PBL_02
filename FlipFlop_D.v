module FlipFlop_D (
	input wire D, // Entrada SET/RESET
	input wire CLK, // Entrada do CLOCK
	output wire Q, // Saída do dado setado
	output wire Qn // Inversão da Saída
);

	// Lógica de Negação do CLOCK
	wire CLKn;
	not (CLKn, CLK);
	
	// Saídas do primeiro Latch (Master)
	wire Q_Master;
	wire Qn_Master;
	
	// Conexão Entre 2 Latchs para realizar registro via Borda de Descida
	Latch_D_Nor Master(
		.D(D),
		.CLK(CLK),
		.Q(Q_Master),
		.Qn(Qn_Master)
	);
	
	Latch_D_Nor Slave(
		.D(Q_Master),
		.CLK(CLKn),
		.Q(Q),
		.Qn(Qn)
	);
	
endmodule 