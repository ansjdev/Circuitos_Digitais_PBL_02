module ULA_8Bits(
    input  wire [7:0] A_in,        // Entrada A: o primeiro valor de 8 bits
    input  wire [7:0] B_in,        // Entrada B: o segundo valor de 8 bits
    input  wire       C_in,        // Carry-in / Borrow-in: bit extra para soma ou subtracao
    input  wire [2:0] Operacao_in, // Codigo da operacao: indica qual operacao executar
    output wire [7:0] Saida_out,   // Resultado: a saida de 8 bits da operacao
    output wire [2:0] Flags_out    // Flags: indicadores como overflow, carry e zero
);

    // ======================================================
    // Fios internos: conexoes entre as partes do circuito
    // ======================================================
    wire [7:0] Y_and;
    wire [7:0] Y_or;
    wire [7:0] Y_xor;
    wire [7:0] Y_not;
    wire [7:0] Y_add;
    wire [7:0] Y_sub;

    wire Cout_add;
    wire Bout_sub;

    // ======================================================
    // Instancias das operacoes logicas: modulos para AND, OR, XOR e NOT
    // ======================================================
    OperacaoAnd8Bits op_and(.A(A_in), .B(B_in), .Y(Y_and));
    OperacaoOr8Bits  op_or (.A(A_in), .B(B_in), .Y(Y_or));
    OperacaoXor8Bits op_xor(.A(A_in), .B(B_in), .Y(Y_xor));
    OperacaoNot8Bits op_not(.A(A_in),           .Y(Y_not));

    // ======================================================
    // Instancias das operacoes aritmeticas: modulos para soma e subtracao
    // ======================================================
    Somador8Bits   op_add(.A(A_in), .B(B_in), .Cin(C_in), .S(Y_add), .Cout(Cout_add));
    Subtrator8Bits op_sub(
			 .A(A_in),
			 .B(B_in),
			 .Bin(C_in),
			 .S(Y_sub),
			 .Bout(Bout_sub)
		);

    // ======================================================
    // MUX 8→1: escolhe qual resultado enviar para a saida baseado na operacao
    // ======================================================
    Mux8Para1_8Bits mux_saida(
		 .Y0(Y_and),          // 000 - AND
		 .Y1(Y_or),           // 001 - OR
		 .Y2(Y_xor),          // 010 - XOR
		 .Y3(Y_not),          // 011 - NOT
		 .Y4(Y_add),          // 100 - ADD
		 .Y5(Y_sub),          // 101 - SUB
		 .Y6(8'b00000000),    // 110 - reservado
		 .Y7(8'b00000000),    // 111 - reservado
		 .sel(Operacao_in),
		 .Saida(Saida_out)
	);

    // ======================================================
    // Geracao das FLAGS: calcula os indicadores de estado
    // ======================================================
    GeradorFlags ger_flags(
        .resultado(Saida_out),
        .A_msb(A_in[7]),
        .B_msb(B_in[7]),
        .Cout(Cout_add),
        .operacao(Operacao_in),
        .flags(Flags_out)
    );

endmodule
