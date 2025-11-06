module ULA_8Bits(
    input  wire [7:0] A_in,        // Entrada A
    input  wire [7:0] B_in,        // Entrada B
    input  wire       C_in,        // Carry-in / Borrow-in para ADD/SUB
    input  wire [2:0] Operacao_in, // Seletor de operação

    output wire [7:0] Saida_out,   // Saída selecionada da ULA
    output wire [2:0] Flags_out    // Flags
);

    // Resultados individuais das operações
    wire [7:0] Y_and;
    wire [7:0] Y_or;
    wire [7:0] Y_xor;
    wire [7:0] Y_not;
    wire [7:0] Y_add;
    wire       Cout_add;
    wire [7:0] Y_sub;
    wire       Bout_sub;

    // Instâncias das operações lógicas
    OperacaoAnd8Bits op_and(.A(A_in), .B(B_in), .Y(Y_and));
    OperacaoOr8Bits  op_or (.A(A_in), .B(B_in), .Y(Y_or));
    OperacaoXor8Bits op_xor(.A(A_in), .B(B_in), .Y(Y_xor));
    OperacaoNot8Bits op_not(.A(A_in),           .Y(Y_not));

    // Instâncias das operações aritméticas
    Somador8Bits     op_add(Y_add, Cout_add, A_in, B_in, C_in);
    Subtrator8Bits   op_sub(Y_sub, Bout_sub, A_in, B_in, C_in);

    // Como o demux escolhe 1 entrada, juntamos todas em um barramento
    wire [7:0] BusIn;
    assign BusIn = Y_and | Y_or | Y_xor | Y_not | Y_add | Y_sub; 
    // (Esse valor só serve como D no Demux — o demux vai mascarar corretamente)

    // Saídas do demux (cada uma pode receber uma única operação)
    wire [7:0] Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7;

    Demux8Bits dmux(
        .D(BusIn),
        .sel(Operacao_in),
        .Y0(Y0), // AND
        .Y1(Y1), // OR
        .Y2(Y2), // XOR
        .Y3(Y3), // NOT
        .Y4(Y4), // ADD
        .Y5(Y5), // SUB
        .Y6(Y6), // (não utilizado)
        .Y7(Y7)  // (não utilizado)
    );

    // Agora ligamos cada saída correta ao resultado final
    assign Saida_out =
        (Operacao_in == 3'b000) ? Y_and :
        (Operacao_in == 3'b001) ? Y_or  :
        (Operacao_in == 3'b010) ? Y_xor :
        (Operacao_in == 3'b011) ? Y_not :
        (Operacao_in == 3'b100) ? Y_add :
        (Operacao_in == 3'b101) ? Y_sub :
        8'b00000000;

    // Flags: ZERO, CARRY, OVERFLOW (simplificado)
    wire flag_zero     = (Saida_out == 8'b00000000);
    wire flag_carry    = Cout_add;   // só vale na soma
    wire flag_overflow = (A_in[7] == B_in[7]) && (Saida_out[7] != A_in[7]);

    assign Flags_out = {flag_overflow, flag_carry, flag_zero};

endmodule

module GeradorFlags(
    input  wire [7:0] resultado,
    input  wire A_msb,
    input  wire B_msb,
    input  wire Cout,
    input  wire [2:0] operacao,
    output wire [2:0] flags
);
    wire zero, carry, overflow;
    wire is_add;
    wire xnor_signs, xor_result;
    
    // Flag ZERO: resultado == 0
    DetectorZero8Bits det_zero(.entrada(resultado), .zero(zero));
    
    // Flag CARRY: válida apenas para ADD (operacao == 100)
    and (is_add, ~operacao[2], operacao[1], ~operacao[0]); // 100 = ADD
    and (carry, Cout, is_add);
    
    // Flag OVERFLOW: A e B com mesmo sinal, resultado com sinal diferente
    xnor (xnor_signs, A_msb, B_msb);
    xor  (xor_result, resultado[7], A_msb);
    and  (overflow, xnor_signs, xor_result);
    
    // Concatenar flags: {overflow, carry, zero}
    buf (flags[0], zero);
    buf (flags[1], carry);
    buf (flags[2], overflow);
endmodule

// ==============================================================
// Detector de Zero de 8 Bits
// ==============================================================

module DetectorZero8Bits(
    input  wire [7:0] entrada,
    output wire zero
);
    wire nor1, nor2;
    
    nor (nor1, entrada[0], entrada[1], entrada[2], entrada[3]);
    nor (nor2, entrada[4], entrada[5], entrada[6], entrada[7]);
    and (zero, nor1, nor2);
endmodule